以下の章を既存Markdownへ追記することをおすすめします。

---

# GitLab CI設定例

## 共通CI/CDリポジトリ構成

```text
common-cicd
│
├── templates
│   ├── build-java.yml
│   ├── build-node.yml
│   ├── test.yml
│   ├── security.yml
│   ├── package.yml
│   ├── deploy-openshift.yml
│   └── deploy-websphere.yml
│
└── scripts
    ├── maven_build.sh
    ├── npm_build.sh
    ├── sonar_scan.sh
    ├── docker_build.sh
    └── deploy.sh
```

---

# 利用プロジェクト構成例

```text
sample-application
│
├── .gitlab-ci.yml
│
├── frontend
│   ├── package.json
│   └── src
│
├── backend
│   ├── pom.xml
│   └── src
│
├── sql
│   ├── V001_create_tables.sql
│   └── V002_insert_master.sql
│
└── scripts
    ├── create_db.sh
    ├── integration_test.sh
    └── deploy_custom.sh
```

---

# 最小構成の.gitlab-ci.yml

```yaml
include:
  - project: 'platform/common-cicd'
    ref: v1.0.0
    file:
      - '/templates/build-node.yml'
      - '/templates/build-java.yml'
      - '/templates/test.yml'
      - '/templates/deploy-openshift.yml'

variables:
  BUILD_TYPE: "SPRINGBOOT_VUE"
```

利用側プロジェクトには最低限の設定だけを記載する。

---

# 共通build-node.yml

```yaml
frontend-build:
  stage: build
  image: node:20

  script:
    - chmod +x scripts/npm_build.sh
    - scripts/npm_build.sh

  artifacts:
    paths:
      - frontend/dist/
```

---

# 共通build-java.yml

```yaml
backend-build:
  stage: build
  image: maven:3.9-eclipse-temurin-21

  script:
    - chmod +x scripts/maven_build.sh
    - scripts/maven_build.sh

  artifacts:
    paths:
      - backend/target/*.jar
```

---

# 共通test.yml

```yaml
unit-test:
  stage: test

  script:
    - mvn test
```

---

# アプリ固有の結合テスト

利用側リポジトリが提供する。

```yaml
integration-test:
  stage: test

  script:
    - ./scripts/create_db.sh
    - ./scripts/integration_test.sh
```

---

# Vue(Vite)ビルドスクリプト例

common-cicd/scripts/npm_build.sh

```bash
#!/bin/bash

set -e

cd frontend

npm ci

npm run build
```

---

# Spring Bootビルドスクリプト例

common-cicd/scripts/maven_build.sh

```bash
#!/bin/bash

set -e

cd backend

mvn clean package
```

---

# テスト用DB生成例

sample-application/scripts/create_db.sh

```bash
#!/bin/bash

psql -U postgres -f sql/V001_create_tables.sql

psql -U postgres -f sql/V002_insert_master.sql
```

---

# 変数でアプリ固有処理を切り替える例

共通CI

```yaml
integration-test:
  stage: test

  script:
    - ${APP_TEST_SCRIPT}
```

---

アプリA

```yaml
variables:
  APP_TEST_SCRIPT: "./scripts/customer_test.sh"
```

---

アプリB

```yaml
variables:
  APP_TEST_SCRIPT: "./scripts/order_test.sh"
```

---

# タグリリース時のみデプロイ

```yaml
deploy-prod:
  stage: deploy

  rules:
    - if: '$CI_COMMIT_TAG'

  script:
    - ./scripts/deploy.sh
```

タグ

```text
v1.0.0
```

でパイプライン実行時

```text
CI_COMMIT_TAG=v1.0.0
```

が設定され、本番デプロイが実行される。

---

# WebSphere環境対応例

```yaml
deploy-websphere:
  stage: deploy

  rules:
    - if: '$DEPLOY_TARGET == "A"'
    - if: '$DEPLOY_TARGET == "B"'
    - if: '$DEPLOY_TARGET == "C"'
    - if: '$DEPLOY_TARGET == "D"'

  script:
    - ./scripts/deploy_websphere.sh
```

---

# OpenShift環境対応例

```yaml
deploy-openshift:
  stage: deploy

  rules:
    - if: '$DEPLOY_TARGET == "E"'

  script:
    - ./scripts/deploy_openshift.sh
```

---

# 推奨運用

共通CI/CDリポジトリ

```text
責務
↓
HOW

Build
Test
Security
Deploy
Notification
```

アプリケーションリポジトリ

```text
責務
↓
WHAT

DDL
DML
DB作成
データ投入
業務テスト
APIテスト
業務設定
```

これにより、

- Vue(Vite)
- Spring Boot
- Tomcat
- Docker
- WebSphere A～D
- OpenShift(E)

を単一の共通CI/CD基盤で管理できる。


さらに実運用を意識するなら、次の章も追加すると良いです。

GitFlow運用（feature/develop/release/main）
MR時Pipeline
SonarQube連携
Trivy脆弱性スキャン
Docker Build/Push
OpenShift Deploy
WebSphere Deploy
共通CIリポジトリのバージョニング戦略（v1.0.0, v1.1.0, v2.0.0）
