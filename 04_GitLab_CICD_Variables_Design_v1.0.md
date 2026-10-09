# 04_GitLab_CICD_Variables_Design_v1.0

## 1. 目的

本設計書は GitLab CI/CD 標準テンプレートで利用する Variables の設計方針を定義する。

目的は以下とする。

- 開発者ごとの差異を最小化する
- カスタマイズポイントを明確化する
- Secret情報を安全に管理する
- Tomcat / Spring Boot / Node.js / Python を共通運用する
- 将来のWAS対応を考慮する

---

## 2. Variables分類

Variablesは以下の3分類とする。

### 利用者設定

利用者が設定可能。

### 管理者設定

CI/CD管理者のみ変更可能。

### Secret設定

GitLab Variablesで管理する。

---

## 3. 利用者設定Variables

```yaml
variables:
  APP_NAME:
  APP_TYPE:

  BUILD_CMD:
  TEST_CMD:

  PACKAGE_TYPE:
  PACKAGE_PATH:

  START_CMD:
  HEALTHCHECK_URL:
```

### APP_NAME

アプリケーション名。

例

```yaml
APP_NAME: sample-web
```

### APP_TYPE

対象アプリ種別。

```yaml
APP_TYPE: tomcat
```

利用可能値。

```text
tomcat
springboot
nodejs
python
```

将来追加。

```text
was
liberty
```

### BUILD_CMD

ビルドコマンド。

例

```yaml
BUILD_CMD: mvn clean package
```

### TEST_CMD

単体試験コマンド。

```yaml
TEST_CMD: mvn test
```

### PACKAGE_TYPE

成果物種別。

```text
WAR
JAR
ZIP
```

### PACKAGE_PATH

成果物パス。

```yaml
PACKAGE_PATH: target/*.war
```

### START_CMD

E2E実行時の起動コマンド。

例

```yaml
START_CMD: java -jar target/app.jar
```

### HEALTHCHECK_URL

起動確認URL。

```yaml
HEALTHCHECK_URL: http://localhost:8080/health
```

---

## 4. 管理者設定Variables

利用者変更禁止。

```yaml
PIPELINE_VERSION
SECURITY_POLICY
PERFORMANCE_POLICY
DEFAULT_TIMEOUT
DEFAULT_RETRY
```

例

```yaml
PIPELINE_VERSION: v1.0
DEFAULT_TIMEOUT: 20m
DEFAULT_RETRY: 2
```

---

## 5. Secret Variables

GitLab Variables利用を必須とする。

### 禁止例

```yaml
TOKEN: abcde
PASSWORD: secret
```

### 推奨

```yaml
TOKEN: $APP_TOKEN
```

---

## 6. Secret一覧

### Protected + Masked

```text
PROD_TOKEN
PROD_PASSWORD
PROD_API_KEY
SSH_PRIVATE_KEY
```

### Masked

```text
APP_TOKEN
DEV_TOKEN
STG_TOKEN
```

---

## 7. 環境別Variables

将来利用を想定。

```yaml
DEV_URL
STG_URL
PROD_URL
```

ただし今回のCI/CD範囲では本番Deployは対象外。

---

## 8. APP_TYPE別サンプル

### Tomcat

```yaml
APP_TYPE: tomcat
BUILD_CMD: mvn clean package
TEST_CMD: mvn test
PACKAGE_TYPE: WAR
PACKAGE_PATH: target/*.war
```

### Spring Boot

```yaml
APP_TYPE: springboot
BUILD_CMD: mvn clean package
TEST_CMD: mvn test
PACKAGE_TYPE: JAR
PACKAGE_PATH: target/*.jar
```

### Node.js

```yaml
APP_TYPE: nodejs
BUILD_CMD: npm run build
TEST_CMD: npm test
PACKAGE_TYPE: ZIP
PACKAGE_PATH: dist/*
```

### Python

```yaml
APP_TYPE: python
BUILD_CMD: pip install -r requirements.txt
TEST_CMD: pytest
PACKAGE_TYPE: ZIP
PACKAGE_PATH: dist/*
```

---

## 9. Variables設計原則

1. SecretはGitLab Variables管理
2. 利用者変更可能項目は最小化
3. APP_TYPEでアプリ種別管理
4. PACKAGE_TYPEで成果物管理
5. 環境依存情報をハードコードしない
6. 本番用情報はProtected化する

---

## 10. 次工程

- 05_GitLab_CICD_Rules_Design_v1.0.md
- 06_GitLab_CICD_Runner_Design_v1.0.md
- 07_GitLab_CICD_E2E_Design_v1.0.md
