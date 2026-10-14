# 05_GitLab_CICD_Rules_Design_v1.0

## 1. 目的

本設計書は GitLab CI/CD 標準テンプレートで利用する Rules の設計方針を定義する。

目的は以下とする。

- 不要なPipeline実行を防止する
- feature/master/tagで適切な試験を実行する
- Runnerリソース消費を最適化する
- 品質保証と実行時間のバランスを取る
- 将来のWAS対応に耐えられる構造とする

---

## 2. Rules設計方針

Rulesは以下の優先順位で設計する。

```text
workflow
 ↓
stage実行可否
 ↓
job実行可否
 ↓
手動実行判定
```

- featureは高速フィードバック重視
- masterは品質重視
- tagはリリース候補品質重視
- security/performanceは高負荷処理として扱う

---

## 3. workflow:rules標準

```yaml
workflow:
  rules:
    - if: '$CI_COMMIT_TAG == "release"'
    - if: "$CI_COMMIT_TAG"
    - if: '$CI_COMMIT_BRANCH == "master"'
    - if: '$CI_COMMIT_BRANCH =~ /^feature\/.*/'
    - when: never
```

---

## 4. Branch別実行方針

### feature/\*

- validate
- build
- unit_test
- staging
- e2e

### master

- validate
- build
- unit_test
- package
- staging
- e2e
- performance
- security

### tag

- validate
- build
- unit_test
- package
- staging
- e2e
- performance
- security

タグ名が完全一致で`release`の場合も、masterと同じジョブ条件で実行する。他のタグも従来どおりタグPipelineとして受け付ける。

---

## 5. Merge Request Rules

```yaml
rules:
  - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
```

実施:

- validate
- build
- unit_test

---

## 6. Manual Job Rules

```yaml
performance:
  when: manual
```

---

## 7. allow_failure方針

許可:

- performance
- security

```yaml
allow_failure: true
```

禁止:

- build
- unit_test
- e2e

---

## 8. retry方針

```yaml
retry: 2
```

---

## 9. timeout方針

```yaml
timeout: 20m
```

性能試験:

```yaml
timeout: 60m
```

---

## 10. Branch別ジョブマトリクス

| Job         | feature | master | tag |
| ----------- | ------- | ------ | --- |
| validate    | ○       | ○      | ○   |
| build       | ○       | ○      | ○   |
| unit_test   | ○       | ○      | ○   |
| package     | -       | ○      | ○   |
| staging     | ○       | ○      | ○   |
| e2e         | ○       | ○      | ○   |
| performance | -       | ○      | ○   |
| security    | -       | ○      | ○   |

---

## 11. 次工程

- 06_GitLab_CICD_Runner_Design_v1.0.md
- 07_GitLab_CICD_E2E_Design_v1.0.md
- 08_GitLab_CICD_Security_Design_v1.0.md
