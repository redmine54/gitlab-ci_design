# YAML 一覧

| No | YAML | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|
| 40 | 40_stage_validate_common.yml | ソースコード, pom.xml, package.json, requirements.txt, *.yml, *.yaml, *.sh | reports/validate/* | Lint・構文チェック |
| 41 | 41_stage_secret_scan_common.yml | ソースコード, 設定ファイル, Git管理対象ファイル | reports/secrets/* | Secret検査 |
| 42 | 42_stage_dependency_scan_common.yml | pom.xml, package.json, requirements.txt | reports/dependency/* | OSS依存関係・CVE検査 |
| 43 | 43_stage_sbom_common.yml | pom.xml, package.json, requirements.txt | reports/sbom/* | SBOM生成 |
| 44 | 44_stage_license_check_common.yml | pom.xml, package.json, requirements.txt, reports/sbom/* | reports/license/* | OSSライセンス検査 |
| 45 | 45_stage_sast_common.yml | ソースコード一式 | reports/sast/* | 静的解析 |
| 46 | 46_stage_policy_gate_common.yml | reports/validate/*, reports/secrets/*, reports/dependency/*, reports/sbom/*, reports/license/*, reports/sast/* | reports/gate/policy-gate-summary.txt | 品質ゲート判定 |
| 50 | 50_pipeline_standard.yml | APP_TYPE, 各種変数設定, include設定 | パイプライン定義 | パイプラインエントリポイント |
| 51 | 51_stage_build_common.yml | APP_TYPE, ソースコード | build-output/* | Build実行 |
| 52 | 52_stage_test_common.yml | Build成果物, テストコード | reports/test/*, coverage/* | Unit Test実行 |
| 53 | 53_stage_e2e_common.yml | 起動済アプリ, Playwrightテスト | playwright-report/*, test-results/* | E2E実行 |
| 54 | 54_stage_security_common.yml | Build成果物, コンテナイメージ, ソースコード | reports/security/* | Security Gate |
| 55 | 55_stage_performance_common.yml | 起動済アプリ | reports/k6/* | パフォーマンステスト |
| 56 | 56_stage_deploy_common.yml | build-output/* | reports/deploy/* | Deploy |
| 57 | 57_stage_release_common.yml | release-notes.md, CI Tag | reports/release/* | Release |
| 58 | 58_stage_cleanup_common.yml | build-output/*, reports/* | cleanup-log.txt | Cleanup |
| 59 | 59_stage_notify_common.yml | reports/*, CI情報 | reports/notify/* | 通知処理 |

---

# YAML と Script の対応表

| YAML | 呼び出しScript |
|---------|---------|
| 40_stage_validate_common.yml | 61_common_validate.sh |
| 41_stage_secret_scan_common.yml | 62_common_secret_scan.sh |
| 42_stage_dependency_scan_common.yml | 63_common_dependency_scan.sh |
| 43_stage_sbom_common.yml | 64_common_sbom.sh |
| 44_stage_license_check_common.yml | 65_common_license_check.sh |
| 45_stage_sast_common.yml | 66_common_sast.sh |
| 46_stage_policy_gate_common.yml | 67_common_policy_gate.sh |
| 51_stage_build_common.yml | 71～77 |
| 52_stage_test_common.yml | 81～87 |
| 53_stage_e2e_common.yml | 91～97, 101 |
| 54_stage_security_common.yml | 61～67再利用 + Securityツール |
| 55_stage_performance_common.yml | 111 |
| 56_stage_deploy_common.yml | 121～127 |
| 57_stage_release_common.yml | 131 |
| 58_stage_cleanup_common.yml | 69_common_report.sh |
| 59_stage_notify_common.yml | 141～145 |

---

# Stage実行フロー

```text
40 Validate
 ↓
41 Secret Scan
 ↓
42 Dependency Scan
 ↓
43 SBOM
 ↓
44 License Check
 ↓
45 SAST
 ↓
46 Policy Gate
 ↓
51 Build
 ↓
52 Test
 ↓
53 E2E
 ↓
54 Security
 ↓
55 Performance
 ↓
56 Deploy
 ↓
57 Release
 ↓
58 Cleanup
 ↓
59 Notify
```
