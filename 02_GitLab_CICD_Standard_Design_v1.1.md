# 02_GitLab_CICD_Standard_Design_v1.1

## 設計原則
- 全案件共通利用
- 開発者変更箇所最小化
- Variables中心でカスタマイズ
- Artifactで成果物受け渡し
- Runner上でE2E完結
- 将来WAS拡張可能な構造

## 標準ステージ
```yaml
stages:
  - validate
  - build
  - unit_test
  - package
  - staging
  - e2e
  - performance
  - security
```

## feature/*
- validate
- build
- unit_test
- staging
- e2e

## master
- validate
- build
- unit_test
- package
- staging
- e2e
- performance
- security

## tag
- validate
- build
- unit_test
- package
- staging
- e2e
- performance
- security

## 開発者向けVariables
```yaml
variables:
  APP_TYPE:
  BUILD_CMD:
  TEST_CMD:
  PACKAGE_PATH:
  START_CMD:
```

## セキュリティ
- Token直書き禁止
- Password直書き禁止
- Protected Variables利用
- Masked Variables利用

## 実装ファイル体系
- 50_standard-ci.yml
- 51_common-build.yml
- 52_common-test.yml
- 53_common-e2e.yml
- 54_common-security.yml
- 55_common-performance.yml

## 次工程
- 03_GitLab_CICD_Template_Architecture_v1.0.md
- 04_GitLab_CICD_Variables_Design_v1.0.md
- 05_GitLab_CICD_Rules_Design_v1.0.md
