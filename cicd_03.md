# アプリ側が提供すべき資材一覧

## 概要

GitLab CI/CDでは、共通CIリポジトリが提供するYAMLやShellだけでは処理は成立しない。

共通CIは主に

```text
HOW
どのように実行するか
```

を提供する。

一方で、アプリケーションリポジトリは

```text
WHAT
何を実行するか
```

を提供する必要がある。

そのため、CI/CD設計では

- 共通CIが実行するコマンド
- アプリ側が提供する資材

を明確に分離することが重要である。

---

# 提供資材一覧

| 共通CIの処理 | 共通CIが提供 | アプリ側が提供 |
|------------|------------|------------|
| Maven Build | mvn clean package | pom.xml、Javaソース |
| Maven Test | mvn test | *Test.java |
| Vue Build | npm run build | package.json、Vueソース |
| Playwright | npx playwright test | *.spec.ts |
| k6 | k6 run xxx.js | 負荷試験シナリオ |
| SonarQube | sonar-scanner | sonar-project.properties |
| Docker Build | docker build | Dockerfile |
| Docker Push | docker push | イメージ名設定 |
| DB作成 | psql/mysql/sqlplus実行 | DDL |
| テストデータ投入 | psql/mysql実行 | DML |
| API試験 | curl実行 | 試験定義 |
| OpenShift Deploy | oc apply | deployment.yaml |
| WebSphere Deploy | wsadmin | EAR/WAR |

---

# Maven Build

## 共通CI

```yaml
script:
  - mvn clean package
```

## アプリ側資材

```text
backend/
├── pom.xml
└── src/
```

---

# Maven Unit Test

## 共通CI

```yaml
script:
  - mvn test
```

## アプリ側資材

```text
src/test/java/

LoginTest.java
CustomerServiceTest.java
OrderServiceTest.java
```

### ポイント

```text
mvn test
```

だけではテストは存在しない。

テストクラスをアプリ側が提供して初めて実行できる。

---

# Vue(Vite) Build

## 共通CI

```yaml
script:
  - npm ci
  - npm run build
```

## アプリ側資材

```text
frontend/

package.json
vite.config.js
src/
```

---

# Playwright

## 共通CI

```yaml
script:
  - npx playwright test
```

## アプリ側資材

```text
tests/e2e/

login.spec.ts
order.spec.ts
purchase.spec.ts
```

### ポイント

```text
npx playwright test
```

はテスト実行エンジン起動コマンドである。

実際のテスト内容は

```typescript
import { test, expect } from '@playwright/test';
```

から始まるテストコードをアプリ側が提供する。

---

# k6

## 共通CI

```yaml
script:
  - k6 run tests/performance/customer.js
```

## アプリ側資材

```text
tests/performance/

customer.js
order.js
```

### ポイント

k6は負荷試験ツールであり、シナリオファイルが必要となる。

例

```javascript
import http from 'k6/http';

export default function () {
  http.get(
    'https://example.com/api/customers'
  );
}
```

---

# SonarQube

## 共通CI

```yaml
script:
  - sonar-scanner
```

## アプリ側資材

```text
sonar-project.properties
```

または

```text
pom.xml
```

内のSonar設定

---

# Docker Build

## 共通CI

```yaml
script:
  - docker build
```

## アプリ側資材

```text
Dockerfile
```

例

```dockerfile
FROM eclipse-temurin:21

COPY app.jar /app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
```

---

# OpenShift Deploy

## 共通CI

```yaml
script:
  - oc apply -f openshift/
```

## アプリ側資材

```text
openshift/

deployment.yaml
service.yaml
route.yaml
```

---

# WebSphere Deploy

## 共通CI

```yaml
script:
  - wsadmin
```

## アプリ側資材

```text
target/*.ear

または

target/*.war
```

---

# DB関連資材

DB資材はCIのためだけではなく、システムそのものに必要な資材でもある。

そのため、アプリケーションリポジトリで管理する。

---

## DDL

### アプリ側資材

```text
sql/

V001_create_tables.sql
```

例

```sql
CREATE TABLE CUSTOMER (
    ID BIGINT
);
```

---

## マスタデータ

### アプリ側資材

```text
sql/

V002_insert_master.sql
```

例

```sql
INSERT INTO M_AREA VALUES (...);
```

---

## テストデータ

### アプリ側資材

```text
sql/

V003_testdata.sql
```

例

```sql
INSERT INTO CUSTOMER VALUES (...);
```

---

# API試験

## 共通CI

```yaml
script:
  - ./scripts/api_test.sh
```

## アプリ側資材

```text
tests/api/

customer_test.json
order_test.json
```

または

```text
Postman Collection
```

---

# アプリ固有Shell

## 共通CI

```yaml
script:
  - ./scripts/create_db.sh
```

## アプリ側資材

```text
scripts/

create_db.sh
insert_master.sh
integration_test.sh
api_test.sh
```

---

# 推奨アプリケーション構成

Vue(Vite) + Spring Boot プロジェクト例

```text
sample-app
│
├── frontend
│
├── backend
│
├── sql
│   ├── ddl
│   ├── master
│   └── testdata
│
├── scripts
│   ├── create_db.sh
│   ├── api_test.sh
│   └── integration_test.sh
│
├── tests
│   ├── unit
│   ├── api
│   ├── integration
│   ├── e2e
│   └── performance
│
├── Dockerfile
│
└── openshift
    ├── deployment.yaml
    ├── service.yaml
    └── route.yaml
```

---

# 資材分類

アプリ側が提供する資材は大きく以下の5分類となる。

| 分類 | 内容 |
|--------|--------|
| ソースコード | Java、Vue、TypeScript |
| テストコード | JUnit、Playwright、k6 |
| DB資材 | DDL、DML、テストデータ |
| インフラ定義 | Dockerfile、OpenShift YAML |
| 実行補助 | scripts/*.sh |

---

# 設計原則

## 共通CI/CDリポジトリ

```text
HOW
どのように実行するか
```

提供するもの

```text
Build
Test
Security Scan
Docker Build
Deploy
Notification
```

---

## アプリケーションリポジトリ

```text
WHAT
何を実行するか
```

提供するもの

```text
ソースコード
テストコード
DDL
DML
テストデータ
Docker定義
OpenShift定義
アプリ固有Shell
```

---

# 結論

共通CI/CDリポジトリは実行方法(HOW)のみを提供する。

アプリケーションリポジトリは実行対象(WHAT)を提供する。

CI/CD全体は、

```text
共通CI(HOW)
+
アプリ資材(WHAT)
```

によって成立する。

そのため、YAMLやShellだけでなく、

- ソースコード
- テストコード
- DB資材
- Docker定義
- OpenShift定義
- アプリ固有スクリプト

をアプリ側が提供する前提で共通CI/CD基盤を設計する。
