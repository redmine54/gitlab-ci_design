# CI/CD Variable Master

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| System | ALL | APP_NAME | ○ | | Repository | アプリケーション名 |
| System | ALL | APP_TYPE | ○ | | Repository | システム種別 |
| System | ALL | DEPLOY_ENV | ○ | | Repository | dev/stg/prod |
| System | ALL | DEPLOY_TARGET | ○ | | Repository | 配置先環境 |
| System | ALL | HEALTHCHECK_URL | ○ | | Repository | 起動確認URL |
| System | ALL | DEPLOY_HEALTHCHECK_URL | ○ | | Repository | デプロイ後確認URL |
| System | ALL | RELEASE_VERSION | ○ | | Repository | リリースバージョン |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Quality Policy | ALL | PRE_VALIDATE_ENABLED | - | true | Repository | Validate実施 |
| Quality Policy | ALL | PRE_SECRET_SCAN_ENABLED | - | true | Repository | Secret Scan実施 |
| Quality Policy | ALL | PRE_DEPENDENCY_SCAN_ENABLED | - | true | Repository | Dependency/CVE Scan実施 |
| Quality Policy | ALL | PRE_SBOM_ENABLED | - | true | Repository | SBOM生成 |
| Quality Policy | ALL | PRE_LICENSE_ENABLED | - | true | Repository | License Check実施 |
| Quality Policy | ALL | PRE_SAST_ENABLED | - | true | Repository | SAST実施 |
| Quality Policy | ALL | PRE_POLICY_GATE_ENABLED | - | true | Repository | Policy Gate実施 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Build | ALL | BUILD_PROFILE | - | standard | Repository | Buildプロファイル |
| Build | ALL | MAVEN_OPTS | - | -B | Repository | Maven実行オプション |
| Build | ALL | NODE_VERSION | - | 22 | Repository | Node.jsバージョン |
| Build | ALL | PYTHON_VERSION | - | 3.12 | Repository | Pythonバージョン |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Test | ALL | UNIT_TEST_ENABLED | - | true | Repository | Unit Test実施 |
| Test | ALL | UNIT_TEST_REQUIRED | - | false | Repository | Unit Test未実装時Fail判定 |
| Test | ALL | TEST_COVERAGE_MIN | - | 0 | Repository | 最低カバレッジ閾値 |
| Test | ALL | E2E_ENABLED | - | true | Repository | E2E実施 |
| Test | ALL | E2E_REQUIRED | - | true | Repository | E2E必須 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Frontend | vue-springboot | FRONTEND_DIR | - | frontend | Repository | Vueプロジェクト配置先 |
| Frontend | vue-springboot | VITE_MODE | - | production | Repository | Vite実行モード |
| Frontend | react-springboot | FRONTEND_DIR | - | frontend | Repository | Reactプロジェクト配置先 |
| Frontend | react-springboot | VITE_MODE | - | production | Repository | Vite実行モード |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Backend | springboot | SPRING_PROFILE | - | prod | Repository | Spring Profile |
| Backend | springboot | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |
| Backend | vue-springboot | BACKEND_DIR | - | backend | Repository | Spring Boot配置先 |
| Backend | vue-springboot | SPRING_PROFILE | - | prod | Repository | Spring Profile |
| Backend | vue-springboot | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |
| Backend | react-springboot | BACKEND_DIR | - | backend | Repository | Spring Boot配置先 |
| Backend | react-springboot | SPRING_PROFILE | - | prod | Repository | Spring Profile |
| Backend | react-springboot | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Tomcat | tomcat | TOMCAT_HOME | ○ | | GitLab Variable | Tomcatホーム |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Python | python | APP_FILE | - | app.py | Repository | Pythonエントリポイント |
| Python | python | DEPLOY_DIR | ○ | | GitLab Variable | 配置先 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| WAS | was | WAS_PROFILE | ○ | | GitLab Variable | WASプロファイル |
| WAS | was | WAS_USER | ○ | | GitLab Variable | WAS管理ユーザー |
| WAS | was | WAS_PASSWORD | ○ | | Secret Variable | WAS管理パスワード |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Liberty | liberty | WLP_HOME | ○ | | GitLab Variable | Libertyホーム |
| Liberty | liberty | LIBERTY_SERVER_NAME | - | defaultServer | GitLab Variable | Libertyサーバー名 |
| Liberty(OpenShift) | liberty | OPENSHIFT_PROJECT | - | | GitLab Variable | OpenShift Project |
| Liberty(OpenShift) | liberty | OPENSHIFT_APP | - | | GitLab Variable | OpenShift Application |
| Liberty(OpenShift) | liberty | OPENSHIFT_TOKEN | - | | Secret Variable | OpenShift Token |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Security | ALL | SECURITY_GATE_ENABLED | - | true | Repository | Security Gate有効化 |
| Security | ALL | TRIVY_SEVERITY | - | HIGH,CRITICAL | Repository | Trivy判定レベル |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Performance | ALL | PERFORMANCE_GATE_ENABLED | - | true | Repository | Performance Gate有効化 |
| Performance | ALL | K6_VUS | - | 10 | Repository | k6仮想ユーザー数 |
| Performance | ALL | K6_DURATION | - | 1m | Repository | k6実行時間 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Release | ALL | RELEASE_PUBLISH_COMMAND | - | | Repository | リリース追加処理 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Notify | ALL | NOTIFY_ENABLED | - | true | Repository | 通知有効化 |
| Notify | ALL | NOTIFY_MAIL_TO | - | | Repository | 通知先メール |
| Notify | ALL | NOTIFY_TEAMS_WEBHOOK | - | | Secret Variable | Teams Webhook |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Cleanup | ALL | CLEANUP_ENABLED | - | true | Repository | Cleanup実施 |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Notification | ALL | SMTP_HOST | - | | Secret Variable | SMTPサーバー |
| Notification | ALL | SMTP_PORT | - | 587 | Secret Variable | SMTPポート |
| Notification | ALL | SMTP_USER | - | | Secret Variable | SMTPユーザー |
| Notification | ALL | SMTP_PASSWORD | - | | Secret Variable | SMTPパスワード |

| カテゴリ | APP_TYPE | 変数名 | 必須 | デフォルト | 管理場所 | 説明 |
|----------|----------|----------|----------|----------|----------|----------|
| Artifact | ALL | REGISTRY_URL | - | | Secret Variable | Docker Registry |
| Artifact | ALL | REGISTRY_USER | - | | Secret Variable | Registryユーザー |
| Artifact | ALL | REGISTRY_PASSWORD | - | | Secret Variable | Registryパスワード |
| Artifact | ALL | NEXUS_URL | - | | Secret Variable | Nexus URL |
| Artifact | ALL | NEXUS_USER | - | | Secret Variable | Nexusユーザー |
| Artifact | ALL | NEXUS_PASSWORD | - | | Secret Variable | Nexusパスワード |
| Artifact | ALL | ARTIFACTORY_URL | - | | Secret Variable | Artifactory URL |
| Artifact | ALL | ARTIFACTORY_USER | - | | Secret Variable | Artifactoryユーザー |
| Artifact | ALL | ARTIFACTORY_PASSWORD | - | | Secret Variable | Artifactoryパスワード |
