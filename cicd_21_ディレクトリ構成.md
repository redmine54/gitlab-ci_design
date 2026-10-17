# 責任分界を考慮した標準構成

この構成では、

- 共通CI/CD基盤 = 別リポジトリで管理
- 各アプリ = 共通CI/CDを取り込み利用
- 共通化可能なものは共通側へ集約
- 業務仕様に依存するものはアプリ側へ配置

という考え方を採用する。

---

# ① 共通CI/CDリポジトリ

```text
gitlab-cicd-template/

├─ README.md                                    # 利用手順

├─ docs/                                        # 設計資料
│  ├─ architecture/
│  │  ├─ APP_TYPE_MASTER.md                     # APP_TYPE定義
│  │  ├─ VARIABLE_MASTER.md                     # CI/CD変数一覧
│  │  ├─ STAGE_MASTER.md                        # Stage一覧
│  │  ├─ SCRIPT_MASTER.md                       # Script一覧
│  │  ├─ DIRECTORY_STRUCTURE.md                 # ディレクトリ説明
│  │  └─ QUALITY_POLICY.md                      # Quality Policy説明
│  │
│  └─ examples/                                # 利用例
│      ├─ gitlab-ci-vue-springboot.yml
│      ├─ gitlab-ci-react-springboot.yml
│      ├─ gitlab-ci-python.yml
│      └─ gitlab-ci-liberty.yml
│
├─ gitlab_cicd_templates/                      # 利用側へ展開される本体
│
│  ├─ includes/
│  │  ├─ 10_pipeline_standard.yml              # Pipeline定義＋デフォルト変数
│  │  ├─ 40_stage_pre_common.yml               # Pre
│  │  ├─ 51_stage_build_common.yml             # Build
│  │  ├─ 52_stage_test_common.yml              # Test
│  │  ├─ 53_stage_e2e_common.yml               # E2E
│  │  ├─ 54_stage_security_common.yml          # Security
│  │  ├─ 55_stage_performance_common.yml       # Performance
│  │  ├─ 56_stage_deploy_common.yml            # Deploy
│  │  ├─ 57_stage_release_common.yml           # Release
│  │  ├─ 58_stage_cleanup_common.yml           # Cleanup
│  │  └─ 59_stage_notify_common.yml            # Notify
│  │
│  ├─ scripts/
│  │  ├─ common/
│  │  │  ├─ pre/
│  │  │  │  └─ common_pre.sh                   # Quality Policy実行
│  │  │  ├─ common_logging.sh                  # ログ
│  │  │  ├─ common_report.sh                   # レポート集約
│  │  │  └─ common_healthcheck.sh              # HealthCheck
│  │  │
│  │  ├─ build/
│  │  ├─ test/
│  │  ├─ startup/
│  │  ├─ e2e/
│  │  ├─ performance/
│  │  ├─ deploy/
│  │  ├─ release/
│  │  └─ notify/
│  │
│  ├─ reports/
│  │  ├─ pre/.gitkeep                          # 初期ディレクトリ
│  │  ├─ test/.gitkeep
│  │  ├─ security/.gitkeep
│  │  ├─ performance/.gitkeep
│  │  ├─ deploy/.gitkeep
│  │  ├─ release/.gitkeep
│  │  ├─ notify/.gitkeep
│  │  └─ summary/.gitkeep
│  │
│  └─ tests/
│      ├─ build/                               # 共通CI/CDテスト
│      ├─ test/
│      ├─ startup/
│      ├─ e2e/
│      ├─ performance/
│      ├─ deploy/
│      ├─ release/
│      └─ notify/
│
└─ sample-projects/
   ├─ vue-springboot-h2/                       # サンプルプロジェクト
   ├─ react-springboot-h2/
   ├─ python/
   └─ liberty/
```

---

# ② アプリ側標準構成

事例

```text
APP_TYPE=vue-springboot
DB=H2
```

---

```text
customer-portal/

├─ .gitlab-ci.yml                              # プロジェクトCI定義
│
├─ gitlab_cicd_templates/                      # 共通CI/CD取り込み領域
│   └─ (共通リポジトリから取得)
│
├─ frontend/                                   # Vue(Vite)
│  ├─ package.json
│  ├─ vite.config.ts
│  ├─ src/
│  ├─ public/
│  └─ tests/                                   # Frontend Unit Test
│
├─ backend/                                    # Spring Boot
│  ├─ pom.xml
│  ├─ src/
│  │  ├─ main/
│  │  └─ test/                                 # Backend Unit Test
│  │
│  └─ target/
│
├─ playwright/                                 # E2E
│  ├─ tests/
│  ├─ fixtures/
│  └─ playwright.config.ts
│
├─ sql/                                        # DB定義
│  ├─ ddl/
│  │   ├─ V001_create_table.sql
│  │   └─ V002_create_index.sql
│  │
│  ├─ dml/
│  │   ├─ init_data.sql
│  │   └─ test_data.sql
│  │
│  └─ migration/
│
├─ config/                                     # 環境設定
│  ├─ application-dev.yml
│  ├─ application-stg.yml
│  └─ application-prod.yml
│
├─ docs/                                       # 業務ドキュメント
│  ├─ architecture.md
│  ├─ api-spec.md
│  └─ release-note.md
│
├─ scripts/                                    # アプリ独自処理
│  ├─ db/
│  │   ├─ create-db.sh
│  │   └─ initialize-db.sh
│  │
│  └─ custom/
│      └─ custom-test.sh
│
├─ testdata/                                   # テストデータ
│  ├─ csv/
│  ├─ json/
│  └─ xml/
│
├─ reports/                                    # ローカル確認用
│  └─ .gitkeep
│
└─ build-output/                               # Build成果物
    └─ .gitkeep
```

---

# 責任分界

## 共通CI/CD側

```text
Pipeline

Quality Policy

Build

Test

E2E

Security

Performance

Deploy

Release

Notify

共通Script

共通YAML

共通レポート形式
```

---

## アプリ側

```text
frontend/

backend/

sql/

playwright/

src/test/

frontend/tests/

testdata/

config/

業務ロジック

業務DB定義

業務テスト
```

---

# 結論

共通リポジトリに置くべきもの

```text
gitlab_cicd_templates/

docs/

sample-projects/
```

アプリ側に置くべきもの

```text
frontend/

backend/

playwright/

sql/

testdata/

config/

業務用scripts/
```

と分離するのが、今回の共通CI/CD基盤の責任分界として最も自然です。
