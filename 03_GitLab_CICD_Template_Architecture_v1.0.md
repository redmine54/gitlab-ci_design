# 03_GitLab_CICD_Template_Architecture_v1.0

## 1. 目的

本設計書は GitLab CI/CD の標準テンプレート構造を定義する。

対象:
- Java Servlet/JSP (Tomcat)
- Spring Boot
- Node.js
- Python

将来的に WAS Traditional / Liberty を追加可能な構造とする。

---

## 2. 設計方針

### 共通化優先

各プロジェクトで .gitlab-ci.yml を個別実装しない。

利用者側は以下のみを記載する。

```yaml
include:
  - project: cicd/template
    file:
      - 50_standard-ci.yml

variables:
  APP_TYPE: tomcat
  BUILD_CMD: mvn clean package
  TEST_CMD: mvn test
  PACKAGE_PATH: target/*.war
```

---

## 3. テンプレート構成

```text
50_standard-ci.yml
│
├─51_common-build.yml
├─52_common-test.yml
├─53_common-e2e.yml
├─54_common-security.yml
└─55_common-performance.yml
```

---

## 4. 各ファイルの責務

### 50_standard-ci.yml

役割:
- stages定義
- 共通variables
- 共通workflow
- include定義

サンプル:

```yaml
include:
  - local: '51_common-build.yml'
  - local: '52_common-test.yml'
  - local: '53_common-e2e.yml'
  - local: '54_common-security.yml'
  - local: '55_common-performance.yml'
```

### 51_common-build.yml

役割:
- buildジョブ
- packageジョブ
- artifact作成

### 52_common-test.yml

役割:
- validate
- unit test
- test report生成

### 53_common-e2e.yml

役割:
- staging起動
- health check
- Playwright実行
- レポート出力

### 54_common-security.yml

役割:
- dependency scan
- trivy
- OWASP ZAP

### 55_common-performance.yml

役割:
- k6実行
- 性能レポート出力

---

## 5. 標準ステージ構成

```yaml
stages:
  - validate
  - build
  - unit_test
  - package
  - staging
  - e2e
  - performance
  - security
```

---

## 6. ブランチ別実行方針

### feature/*

```text
validate
build
unit_test
staging
e2e
```

### master

```text
validate
build
unit_test
package
staging
e2e
performance
security
```

### tag

```text
validate
build
unit_test
package
staging
e2e
performance
security
```

---

## 7. extends構造

共通設定をテンプレート化する。

```yaml
.base-job:
  retry: 2
  timeout: 20m
```

利用例

```yaml
build:
  extends:
    - .base-job
```

---

## 8. Variables責任分離

利用者変更可能

```yaml
APP_TYPE
BUILD_CMD
TEST_CMD
PACKAGE_PATH
START_CMD
HEALTHCHECK_URL
```

テンプレート管理者専用

```yaml
stages
rules
security policy
performance policy
```

---

## 9. 将来拡張

追加予定

```text
56_common-was.yml
57_common-release.yml
58_common-report.yml
```

WAS対応時も既存構造を変更せず追加方式とする。

---

## 10. 次工程

次に作成する設計書。

- 04_GitLab_CICD_Variables_Design_v1.0.md
- 05_GitLab_CICD_Rules_Design_v1.0.md
- 06_GitLab_CICD_Runner_Design_v1.0.md
