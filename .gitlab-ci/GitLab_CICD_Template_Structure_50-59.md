```text
.gitlab-ci/
│
├─ includes/
│   │
│   ├─ 50_pipeline_standard.yml                 # Pipeline全体定義(Workflow / Stages / Variables / Include)
│   │
│   └─ stages/
│       │
│       ├─ build/
│       │   └─ 51_stage_build_common.yml        # 共通Build・Package処理
│       │
│       ├─ test/
│       │   └─ 52_stage_test_common.yml         # 共通Validate・UnitTest処理
│       │
│       ├─ e2e/
│       │   └─ 53_stage_e2e_common.yml          # アプリ起動・HealthCheck・Playwright E2E
│       │
│       ├─ security/
│       │   └─ 54_stage_security_common.yml     # Dependency/Trivy/ZAP/Secret Scan・Security Gate
│       │
│       ├─ performance/
│       │   └─ 55_stage_performance_common.yml  # k6性能試験・Performance Gate
│       │
│       ├─ deploy/
│       │   └─ 56_stage_deploy_common.yml       # 配置処理・配置後疎通確認
│       │
│       ├─ release/
│       │   └─ 57_stage_release_common.yml      # リリース情報生成・リリース公開
│       │
│       ├─ cleanup/
│       │   └─ 58_stage_cleanup_common.yml      # 後片付け・Pipeline専有リソース削除
│       │
│       └─ notify/
│           └─ 59_stage_notify_common.yml       # 成功/失敗通知・Teams/メール通知
│
├─ scripts/
│   │
│   ├─ build/
│   │   ├─ java/
│   │   │   ├─ 71_lang_tomcat_build.sh         # Tomcat WAR Build
│   │   │   └─ 72_lang_springboot_build.sh     # SpringBoot JAR Build
│   │   │
│   │   ├─ nodejs/
│   │   │   └─ 73_lang_nodejs_build.sh         # Node.js Build
│   │   │
│   │   ├─ python/
│   │   │   └─ 74_lang_python_build.sh         # Python Build
│   │   │
│   │   └─ was/
│   │       ├─ 75_lang_was_build.sh            # WAS Traditional Build
│   │       └─ 76_lang_liberty_build.sh        # Liberty Build
│   │
│   ├─ test/
│   │   ├─ java/
│   │   │   ├─ 81_lang_tomcat_test.sh          # Tomcat UnitTest
│   │   │   └─ 82_lang_springboot_test.sh      # SpringBoot UnitTest
│   │   │
│   │   ├─ nodejs/
│   │   │   └─ 83_lang_nodejs_test.sh          # Node.js Test
│   │   │
│   │   ├─ python/
│   │   │   └─ 84_lang_python_test.sh          # Python Test
│   │   │
│   │   └─ was/
│   │       ├─ 85_lang_was_test.sh             # WAS Test
│   │       └─ 86_lang_liberty_test.sh         # Liberty Test
│   │
│   ├─ startup/
│   │   ├─ java/
│   │   │   ├─ 91_start_tomcat.sh              # Tomcat起動
│   │   │   └─ 92_start_springboot.sh          # SpringBoot起動
│   │   │
│   │   ├─ nodejs/
│   │   │   └─ 93_start_nodejs.sh              # Node.js起動
│   │   │
│   │   ├─ python/
│   │   │   └─ 94_start_python.sh              # Python起動
│   │   │
│   │   └─ was/
│   │       ├─ 95_start_was.sh                 # WAS起動
│   │       └─ 96_start_liberty.sh             # Liberty起動
│   │
│   ├─ e2e/
│   │   └─ 97_run_playwright.sh                # Playwright実行
│   │
│   ├─ performance/
│   │   └─ 99_k6_smoke.js                      # k6スモーク性能試験
│   │
│   ├─ deploy/
│   │   ├─ java/
│   │   │   ├─ 101_deploy_tomcat.sh           # Tomcatデプロイ
│   │   │   └─ 102_deploy_springboot.sh       # SpringBootデプロイ
│   │   │
│   │   ├─ nodejs/
│   │   │   └─ 103_deploy_nodejs.sh           # Node.jsデプロイ
│   │   │
│   │   ├─ python/
│   │   │   └─ 104_deploy_python.sh           # Pythonデプロイ
│   │   │
│   │   └─ was/
│   │       ├─ 105_deploy_was.sh              # WASデプロイ
│   │       └─ 106_deploy_liberty.sh          # Liberty
```
