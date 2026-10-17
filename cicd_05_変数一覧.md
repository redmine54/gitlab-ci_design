# CI/CD Variable Master

| APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|-----------|-----------|------|-----------|-----------|-----------|
| ALL | APP_NAME | ○ | | Repository | アプリケーション名 |
| ALL | APP_TYPE | ○ | | Repository | システム種別 |
| ALL | DEPLOY_ENV | ○ | | Repository | dev/stg/prod |
| ALL | DEPLOY_TARGET | ○ | | Repository | 配置先 |
| ALL | HEALTHCHECK_URL | ○ | | Repository | 起動確認URL |
| ALL | DEPLOY_HEALTHCHECK_URL | ○ | | Repository | 配置後確認URL |
| ALL | RELEASE_VERSION | ○ | | Repository | リリースバージョン |
| ALL | BUILD_PROFILE | - | standard | Repository | Buildプロファイル |
| ALL | MAVEN_OPTS | - | -B | Repository | Mavenオプション |
| ALL | NODE_VERSION | - | 22 | Repository | Node.jsバージョン |
| ALL | PYTHON_VERSION | - | 3.12 | Repository | Pythonバージョン |
| ALL | SECURITY_GATE_ENABLED | - | true | Repository | Security Gate有効化 |
| ALL | TRIVY_SEVERITY | - | HIGH,CRITICAL | Repository | Trivy判定基準 |
| ALL | PERFORMANCE_GATE_ENABLED | - | true | Repository | Performance Gate有効化 |
| ALL | K6_VUS | - | 10 | Repository | k6仮想ユーザー数 |
| ALL | K6_DURATION | - | 1m | Repository | k6実行時間 |
| ALL | CLEANUP_ENABLED | - | true | Repository | Cleanup有効化 |
| ALL | NOTIFY_ENABLED | - | true | Repository | 通知有効化 |
| tomcat | TOMCAT_HOME | ○ | | GitLab Variable | Tomcatホーム |
| springboot | DEPLOY_DIR | ○ | | GitLab Variable | Spring Boot配置先 |
| springboot | SPRING_PROFILE | - | prod | Repository | Spring Profile |
| vue-springboot | FRONTEND_DIR | - | frontend | Repository | Vueソース配置先 |
| vue-springboot | BACKEND_DIR | - | backend | Repository | Spring Boot配置先 |
| vue-springboot | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |
| vue-springboot | VITE_MODE | - | production | Repository | Viteモード |
| vue-springboot | SPRING_PROFILE | - | prod | Repository | Spring Profile |
| react-springboot | FRONTEND_DIR | - | frontend | Repository | Reactソース配置先 |
| react-springboot | BACKEND_DIR | - | backend | Repository | Spring Boot配置先 |
| react-springboot | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |
| react-springboot | VITE_MODE | - | production | Repository | Viteモード |
| react-springboot | SPRING_PROFILE | - | prod | Repository | Spring Profile |
| python | APP_FILE | - | app.py | Repository | Pythonエントリポイント |
| python | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |
| was | WAS_PROFILE | ○ | | GitLab Variable | WASプロファイル |
| was | WAS_USER | ○ | | GitLab Variable | WAS管理ユーザー |
| was | WAS_PASSWORD | ○ | | Secret Variable | WAS管理パスワード |
| liberty | WLP_HOME | ○ | | GitLab Variable | Libertyホーム |
| liberty | LIBERTY_SERVER_NAME | - | defaultServer | GitLab Variable | Libertyサーバ名 |
| liberty | OPENSHIFT_PROJECT | - | | GitLab Variable | OpenShift Project（E環境のみ） |
| liberty | OPENSHIFT_APP | - | | GitLab Variable | OpenShift App（E環境のみ） |
| liberty | OPENSHIFT_TOKEN | - | | Secret Variable | OpenShift Token（E環境のみ） |
| ALL | SMTP_HOST | - | | Secret Variable | SMTPサーバ |
| ALL | SMTP_PORT | - | 587 | Secret Variable | SMTPポート |
| ALL | SMTP_USER | - | | Secret Variable | SMTPユーザー |
| ALL | SMTP_PASSWORD | - | | Secret Variable | SMTPパスワード |
| ALL | REGISTRY_URL | - | | Secret Variable | Docker Registry |
| ALL | REGISTRY_USER | - | | Secret Variable | Registryユーザー |
| ALL | REGISTRY_PASSWORD | - | | Secret Variable | Registryパスワード |
| ALL | NEXUS_URL | - | | Secret Variable | Nexus URL |
| ALL | NEXUS_USER | - | | Secret Variable | Nexusユーザー |
| ALL | NEXUS_PASSWORD | - | | Secret Variable | Nexusパスワード |
| ALL | ARTIFACTORY_URL | - | | Secret Variable | Artifactory URL |
| ALL | ARTIFACTORY_USER | - | | Secret Variable | Artifactoryユーザー |
| ALL | ARTIFACTORY_PASSWORD | - | | Secret Variable | Artifactoryパスワード |
| ALL | NOTIFY_MAIL_TO | - | | Repository | 通知メールアドレス |
| ALL | NOTIFY_TEAMS_WEBHOOK | - | | Secret Variable | Teams通知Webhook |

---

## APP_TYPE一覧

| APP_TYPE | 対象システム | 構成 |
|-----------|-----------|-----------|
| tomcat | Tomcatアプリケーション | Servlet/JSP + H2 |
| springboot | Spring Bootアプリケーション | Spring Boot + H2 |
| vue-springboot | Vueフロントエンド + Spring Boot | Vue(Vite) + Spring Boot + H2 |
| react-springboot | Reactフロントエンド + Spring Boot | React(Vite) + Spring Boot + H2 |
| python | Pythonアプリケーション | FastAPI / Flask / Django |
| was | WebSphere Traditional | A:Traditional Base / B:Traditional ND |
| liberty | WebSphere Liberty | C:Liberty Base / D:Liberty ND / E:Liberty + OpenShift |

---

## 必須設定例

### Tomcat

```yaml
APP_NAME: sample-web
APP_TYPE: tomcat

DEPLOY_ENV: dev
DEPLOY_TARGET: dev

HEALTHCHECK_URL: http://localhost:8080/

DEPLOY_HEALTHCHECK_URL: https://dev.example.com/

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
TOMCAT_HOME=/opt/tomcat
```

---

### Spring Boot

```yaml
APP_NAME: customer-api
APP_TYPE: springboot

DEPLOY_ENV: dev
DEPLOY_TARGET: dev

HEALTHCHECK_URL: http://localhost:8080/actuator/health

DEPLOY_HEALTHCHECK_URL: https://dev.example.com/actuator/health

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
DEPLOY_DIR=/opt/apps/customer-api
```

---

### Vue + Spring Boot

```yaml
APP_NAME: customer-portal
APP_TYPE: vue-springboot

DEPLOY_ENV: dev
DEPLOY_TARGET: dev

HEALTHCHECK_URL: http://localhost:8080/actuator/health

DEPLOY_HEALTHCHECK_URL: https://dev.example.com/actuator/health

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
DEPLOY_DIR=/opt/apps/customer-portal
```

---

### React + Spring Boot

```yaml
APP_NAME: customer-portal
APP_TYPE: react-springboot

DEPLOY_ENV: dev
DEPLOY_TARGET: dev

HEALTHCHECK_URL: http://localhost:8080/actuator/health

DEPLOY_HEALTHCHECK_URL: https://dev.example.com/actuator/health

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
DEPLOY_DIR=/opt/apps/customer-portal
```

---

### Python

```yaml
APP_NAME: sample-python
APP_TYPE: python

DEPLOY_ENV: dev
DEPLOY_TARGET: dev

HEALTHCHECK_URL: http://localhost:8000/health

DEPLOY_HEALTHCHECK_URL: https://dev.example.com/health

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
DEPLOY_DIR=/opt/apps/sample-python
```

---

### WebSphere Traditional

```yaml
APP_NAME: sample-was
APP_TYPE: was

DEPLOY_ENV: stg
DEPLOY_TARGET: stg

HEALTHCHECK_URL: https://was.example.com/health

DEPLOY_HEALTHCHECK_URL: https://was.example.com/health

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
WAS_PROFILE=/opt/IBM/WebSphere/AppServer/profiles/AppSrv01
WAS_USER=wasadmin
```

Secret Variable

```text
WAS_PASSWORD=********
```

---

### Liberty

```yaml
APP_NAME: sample-liberty
APP_TYPE: liberty

DEPLOY_ENV: stg
DEPLOY_TARGET: stg

HEALTHCHECK_URL: https://liberty.example.com/health

DEPLOY_HEALTHCHECK_URL: https://liberty.example.com/health

RELEASE_VERSION: 1.0.0
```

GitLab Variable

```text
WLP_HOME=/opt/ol/wlp
```
