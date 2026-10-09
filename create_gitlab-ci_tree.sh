#!/bin/bash

mkdir -p .gitlab-ci/includes/stages/{build,test,e2e,security,performance,deploy,release,cleanup,notify}

mkdir -p .gitlab-ci/scripts/build/{java,nodejs,python,was}
mkdir -p .gitlab-ci/scripts/test/{java,nodejs,python,was}
mkdir -p .gitlab-ci/scripts/startup/{java,nodejs,python,was}
mkdir -p .gitlab-ci/scripts/e2e
mkdir -p .gitlab-ci/scripts/performance
mkdir -p .gitlab-ci/scripts/deploy/{java,nodejs,python,was}
mkdir -p .gitlab-ci/scripts/release
mkdir -p .gitlab-ci/scripts/notify

mkdir -p .gitlab-ci/reports/{security,performance,deploy,release,cleanup,notify}
mkdir -p .gitlab-ci/playwright/tests

cat <<EOF > .gitlab-ci/includes/50_pipeline_standard.yml
# .gitlab-ci/includes/50_pipeline_standard.yml # Pipeline全体定義(Workflow / Stages / Variables / Include)
EOF

cat <<EOF > .gitlab-ci/includes/stages/build/51_stage_build_common.yml
# .gitlab-ci/includes/stages/build/51_stage_build_common.yml # 共通Build・Package処理
EOF

cat <<EOF > .gitlab-ci/includes/stages/test/52_stage_test_common.yml
# .gitlab-ci/includes/stages/test/52_stage_test_common.yml # 共通Validate・UnitTest処理
EOF

cat <<EOF > .gitlab-ci/includes/stages/e2e/53_stage_e2e_common.yml
# .gitlab-ci/includes/stages/e2e/53_stage_e2e_common.yml # アプリ起動・HealthCheck・Playwright E2E
EOF

cat <<EOF > .gitlab-ci/includes/stages/security/54_stage_security_common.yml
# .gitlab-ci/includes/stages/security/54_stage_security_common.yml # Dependency/Trivy/ZAP/Secret Scan・Security Gate
EOF

cat <<EOF > .gitlab-ci/includes/stages/performance/55_stage_performance_common.yml
# .gitlab-ci/includes/stages/performance/55_stage_performance_common.yml # k6性能試験・Performance Gate
EOF

cat <<EOF > .gitlab-ci/includes/stages/deploy/56_stage_deploy_common.yml
# .gitlab-ci/includes/stages/deploy/56_stage_deploy_common.yml # 配置処理・配置後疎通確認
EOF

cat <<EOF > .gitlab-ci/includes/stages/release/57_stage_release_common.yml
# .gitlab-ci/includes/stages/release/57_stage_release_common.yml # リリース情報生成・リリース公開
EOF

cat <<EOF > .gitlab-ci/includes/stages/cleanup/58_stage_cleanup_common.yml
# .gitlab-ci/includes/stages/cleanup/58_stage_cleanup_common.yml # 後片付け・Pipeline専有リソース削除
EOF

cat <<EOF > .gitlab-ci/includes/stages/notify/59_stage_notify_common.yml
# .gitlab-ci/includes/stages/notify/59_stage_notify_common.yml # 成功/失敗通知・Teams/メール通知
EOF

cat <<EOF > .gitlab-ci/scripts/build/java/71_lang_tomcat_build.sh
# .gitlab-ci/scripts/build/java/71_lang_tomcat_build.sh # Tomcat WAR Build
EOF

cat <<EOF > .gitlab-ci/scripts/build/java/72_lang_springboot_build.sh
# .gitlab-ci/scripts/build/java/72_lang_springboot_build.sh # SpringBoot JAR Build
EOF

cat <<EOF > .gitlab-ci/scripts/build/nodejs/73_lang_nodejs_build.sh
# .gitlab-ci/scripts/build/nodejs/73_lang_nodejs_build.sh # Node.js Build
EOF

cat <<EOF > .gitlab-ci/scripts/build/python/74_lang_python_build.sh
# .gitlab-ci/scripts/build/python/74_lang_python_build.sh # Python Build
EOF

cat <<EOF > .gitlab-ci/scripts/build/was/75_lang_was_build.sh
# .gitlab-ci/scripts/build/was/75_lang_was_build.sh # WAS Traditional Build
EOF

cat <<EOF > .gitlab-ci/scripts/build/was/76_lang_liberty_build.sh
# .gitlab-ci/scripts/build/was/76_lang_liberty_build.sh # Liberty Build
EOF

cat <<EOF > .gitlab-ci/scripts/test/java/81_lang_tomcat_test.sh
# .gitlab-ci/scripts/test/java/81_lang_tomcat_test.sh # Tomcat UnitTest
EOF

cat <<EOF > .gitlab-ci/scripts/test/java/82_lang_springboot_test.sh
# .gitlab-ci/scripts/test/java/82_lang_springboot_test.sh # SpringBoot UnitTest
EOF

cat <<EOF > .gitlab-ci/scripts/test/nodejs/83_lang_nodejs_test.sh
# .gitlab-ci/scripts/test/nodejs/83_lang_nodejs_test.sh # Node.js Test
EOF

cat <<EOF > .gitlab-ci/scripts/test/python/84_lang_python_test.sh
# .gitlab-ci/scripts/test/python/84_lang_python_test.sh # Python Test
EOF

cat <<EOF > .gitlab-ci/scripts/test/was/85_lang_was_test.sh
# .gitlab-ci/scripts/test/was/85_lang_was_test.sh # WAS Test
EOF

cat <<EOF > .gitlab-ci/scripts/test/was/86_lang_liberty_test.sh
# .gitlab-ci/scripts/test/was/86_lang_liberty_test.sh # Liberty Test
EOF

cat <<EOF > .gitlab-ci/scripts/startup/java/91_start_tomcat.sh
# .gitlab-ci/scripts/startup/java/91_start_tomcat.sh # Tomcat起動
EOF

cat <<EOF > .gitlab-ci/scripts/startup/java/92_start_springboot.sh
# .gitlab-ci/scripts/startup/java/92_start_springboot.sh # SpringBoot起動
EOF

cat <<EOF > .gitlab-ci/scripts/startup/nodejs/93_start_nodejs.sh
# .gitlab-ci/scripts/startup/nodejs/93_start_nodejs.sh # Node.js起動
EOF

cat <<EOF > .gitlab-ci/scripts/startup/python/94_start_python.sh
# .gitlab-ci/scripts/startup/python/94_start_python.sh # Python起動
EOF

cat <<EOF > .gitlab-ci/scripts/startup/was/95_start_was.sh
# .gitlab-ci/scripts/startup/was/95_start_was.sh # WAS起動
EOF

cat <<EOF > .gitlab-ci/scripts/startup/was/96_start_liberty.sh
# .gitlab-ci/scripts/startup/was/96_start_liberty.sh # Liberty起動
EOF

cat <<EOF > .gitlab-ci/scripts/e2e/97_run_playwright.sh
# .gitlab-ci/scripts/e2e/97_run_playwright.sh # Playwright実行
EOF

cat <<EOF > .gitlab-ci/scripts/performance/99_k6_smoke.js
// .gitlab-ci/scripts/performance/99_k6_smoke.js # k6スモーク性能試験
EOF

cat <<EOF > .gitlab-ci/scripts/deploy/java/101_deploy_tomcat.sh
# .gitlab-ci/scripts/deploy/java/101_deploy_tomcat.sh # Tomcatデプロイ
EOF

cat <<EOF > .gitlab-ci/scripts/deploy/java/102_deploy_springboot.sh
# .gitlab-ci/scripts/deploy/java/102_deploy_springboot.sh # SpringBootデプロイ
EOF

cat <<EOF > .gitlab-ci/scripts/deploy/nodejs/103_deploy_nodejs.sh
# .gitlab-ci/scripts/deploy/nodejs/103_deploy_nodejs.sh # Node.jsデプロイ
EOF

cat <<EOF > .gitlab-ci/scripts/deploy/python/104_deploy_python.sh
# .gitlab-ci/scripts/deploy/python/104_deploy_python.sh # Pythonデプロイ
EOF

cat <<EOF > .gitlab-ci/scripts/deploy/was/105_deploy_was.sh
# .gitlab-ci/scripts/deploy/was/105_deploy_was.sh # WASデプロイ
EOF

cat <<EOF > .gitlab-ci/scripts/deploy/was/106_deploy_liberty.sh
# .gitlab-ci/scripts/deploy/was/106_deploy_liberty.sh # Libertyデプロイ
EOF

cat <<EOF > .gitlab-ci/scripts/release/111_release_publish.sh
# .gitlab-ci/scripts/release/111_release_publish.sh # リリース公開処理
EOF

cat <<EOF > .gitlab-ci/scripts/notify/121_notify_success.sh
# .gitlab-ci/scripts/notify/121_notify_success.sh # 成功通知
EOF

cat <<EOF > .gitlab-ci/scripts/notify/122_notify_failure.sh
# .gitlab-ci/scripts/notify/122_notify_failure.sh # 失敗通知
EOF

cat <<EOF > .gitlab-ci/scripts/notify/123_notify_mail.sh
# .gitlab-ci/scripts/notify/123_notify_mail.sh # メール通知
EOF

cat <<EOF > .gitlab-ci/scripts/notify/124_notify_teams.sh
# .gitlab-ci/scripts/notify/124_notify_teams.sh # Teams通知
EOF

cat <<EOF > .gitlab-ci/scripts/notify/125_notify_release.sh
# .gitlab-ci/scripts/notify/125_notify_release.sh # リリース通知
EOF

cat <<EOF > .gitlab-ci/playwright/playwright.config.ts
// .gitlab-ci/playwright/playwright.config.ts # Playwright設定
EOF

echo "GitLab CI/CD template structure created."
