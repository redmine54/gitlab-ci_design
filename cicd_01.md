# 共通CI/CDリポジトリ設計方針

## 目的

GitLab CI/CDを多数のアプリケーションで共通利用できるようにするため、CI/CDロジックを共通リポジトリ化する。

本設計では以下を実現する。

- CI/CD処理の標準化
- 保守コスト削減
- 品質の均一化
- プロジェクト間の再利用
- WebSphere環境(A～E)への展開容易化
- Vue(Vite)、Spring Boot、Tomcat等への対応

---

# 基本方針

共通リポジトリには、

「HOW（どのように実行するか）」

のみを配置する。

アプリケーションリポジトリには、

「WHAT（何を実行するか）」

を配置する。

---

# 責務分離

## 共通CI/CDリポジトリ

管理対象

- GitLab CIテンプレート
- Build処理
- Test実行処理
- Security Scan処理
- Docker Build処理
- OpenShift Deploy処理
- WebSphere Deploy処理
- 共通通知処理

管理対象外

- 業務テーブル作成SQL
- マスタデータ投入SQL
- システム固有テストケース
- システム固有結合試験
- 業務ロジック

---

## アプリケーションリポジトリ

管理対象

- DDL
- DML
- テストデータ
- 業務テスト
- APIテスト
- DB作成処理
- マスタ投入処理
- システム固有設定

---

# 推奨構成

## 共通CI/CDリポジトリ

```text
common-cicd
│
├── templates
│   ├── build-java.yml
│   ├── build-node.yml
│   ├── unit-test.yml
│   ├── security.yml
│   ├── deploy-openshift.yml
│   └── deploy-websphere.yml
│
├── scripts
│   ├── java
│   │   ├── maven_build.sh
│   │   └── maven_test.sh
│   │
│   ├── node
│   │   ├── npm_build.sh
│   │   └── npm_test.sh
│   │
│   ├── docker
│   │   └── docker_build.sh
│   │
│   ├── security
│   │   └── sonarqube.sh
│   │
│   └── deploy
│       ├── deploy_openshift.sh
│       └── deploy_websphere.sh
│
└── README.md
```

---

## アプリケーションリポジトリ

```text
customer-system
│
├── .gitlab-ci.yml
│
├── frontend
│
├── backend
│
├── sql
│   ├── V001_create_tables.sql
│   ├── V002_insert_master.sql
│   └── V003_testdata.sql
│
├── tests
│   ├── api
│   ├── batch
│   └── integration
│
└── scripts
    ├── create_db.sh
    ├── insert_master.sh
    └── integration_test.sh
```

---

# GitLab CI利用方法

利用側プロジェクトは最小限の設定のみ保持する。

```yaml
include:
  - project: 'platform/common-cicd'
    ref: v1.0.0
    file:
      - '/templates/build-node.yml'
      - '/templates/build-java.yml'
      - '/templates/unit-test.yml'
      - '/templates/deploy-openshift.yml'
```

---

# Vue(Vite) + Spring Boot構成

## ディレクトリ例

```text
application
│
├── frontend
│   ├── package.json
│   └── vite.config.js
│
└── backend
    ├── pom.xml
    └── src
```

---

## 共通CIの責務

Vue Build

```bash
npm ci
npm run build
```

Spring Build

```bash
mvn clean package
```

Docker Build

```bash
docker build
```

デプロイ

```bash
oc apply
```

---

## アプリ側責務

DB作成

```bash
scripts/create_db.sh
```

データ投入

```bash
scripts/insert_master.sh
```

システム固有テスト

```bash
scripts/integration_test.sh
```

---

# データベーステスト方針

## 共通化対象

- PostgreSQL起動
- MySQL起動
- Oracle接続
- DBコンテナ起動
- DB接続処理

例

```yaml
services:
  - postgres:16
```

---

## 個別化対象

- CREATE TABLE
- INSERT
- UPDATE
- 初期データ投入
- テストデータ投入

例

```text
sql/V001_create_tables.sql
sql/V002_insert_master.sql
```

---

# アプリ固有処理呼び出し方式

共通CIは処理名のみ保持する。

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

# WebSphere環境区分との対応

| 区分 | 環境 |
|-------|-------|
| A | Traditional Base |
| B | Traditional ND |
| C | Liberty Base |
| D | Liberty ND |
| E | Liberty + Kubernetes/OpenShift |

---

# 設計原則

## 共通CI/CDリポジトリ

責務

```text
HOW
↓
どのように実行するか
```

内容

```text
Build
Test
Security
Deploy
Notification
```

---

## アプリケーションリポジトリ

責務

```text
WHAT
↓
何を実行するか
```

内容

```text
DDL
DML
TestData
BusinessTest
API Test
Configuration
```

---

# 結論

共通CI/CDリポジトリには汎用的な実行処理のみを配置する。

アプリケーション固有のDB作成処理やテストロジックはアプリケーションリポジトリに配置する。

これにより、

- Vue(Vite)
- Spring Boot
- Tomcat
- WebSphere A～E
- OpenShift

を単一のCI/CD基盤で管理できる。
