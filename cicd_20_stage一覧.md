
以下は Stage一覧（最新版設計） を Markdown 化したものです。

# Stage 一覧

| Stage | No | YAML | 呼び出しScript | 主な役割 | 入力データ | 出力データ |
|---------|----:|---------|---------|---------|---------|---------|
| Pre | 40 | 40_stage_pre_common.yml | scripts/common/pre/common_pre.sh | Build前品質チェック | ソースコード, pom.xml, package.json, requirements.txt, QUALITY_POLICY | reports/pre/* |
| Build | 51 | 51_stage_build_common.yml | 71～77 | 成果物生成 | ソースコード | build-output/* |
| Test | 52 | 52_stage_test_common.yml | 81～87 | Unit Test | Build成果物, テストコード | reports/test/*, coverage/* |
| E2E | 53 | 53_stage_e2e_common.yml | 91～97, 101 | End-to-End Test | 起動済みアプリ, Playwrightシナリオ | playwright-report/* |
| Security | 54 | 54_stage_security_common.yml | Security Tool群 | Build成果物セキュリティ検査 | build-output/*, コンテナイメージ | reports/security/* |
| Performance | 55 | 55_stage_performance_common.yml | 111 | 負荷試験 | 起動済みアプリ | reports/k6/* |
| Deploy | 56 | 56_stage_deploy_common.yml | 121～127 | デプロイ | Build成果物 | reports/deploy/* |
| Release | 57 | 57_stage_release_common.yml | 131 | リリース公開 | release-notes.md, Git Tag | reports/release/* |
| Cleanup | 58 | 58_stage_cleanup_common.yml | common_report.sh等 | 後処理 | build-output/*, reports/* | cleanup-log.txt |
| Notify | 59 | 59_stage_notify_common.yml | 141～145 | 通知 | CI実行結果, reports/* | reports/notify/* |

---

# Pre Stage 詳細

| 実行順 | QUALITY POLICY | 処理内容 | 出力 |
|---------|---------|---------|---------|
| 1 | PRE_VALIDATE_ENABLED | Validate | reports/pre/validate-summary.txt |
| 2 | PRE_SECRET_SCAN_ENABLED | Secret Scan | reports/pre/secret-summary.txt |
| 3 | PRE_DEPENDENCY_SCAN_ENABLED | Dependency/CVE Scan | reports/pre/dependency-summary.txt |
| 4 | PRE_SBOM_ENABLED | SBOM生成 | reports/pre/sbom.json |
| 5 | PRE_LICENSE_ENABLED | License Check | reports/pre/license-summary.txt |
| 6 | PRE_SAST_ENABLED | SAST | reports/pre/sast-summary.txt |
| 7 | PRE_POLICY_GATE_ENABLED | Policy Gate | reports/pre/policy-gate-summary.txt |
| 8 | - | Summary生成 | reports/pre/pre-summary.txt |

---

# Stage実行順

40 Pre
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


この設計だと、

APP_TYPE = アプリ構成（tomcat / springboot / vue-springboot / react-springboot / python / was / liberty）
QUALITY POLICY = 品質検査ポリシー
Stage = CI/CD実行工程

がきれいに分離されています。
