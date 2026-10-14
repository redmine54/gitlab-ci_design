# アプリケーション側の雛形

このディレクトリは、共通CIを利用するアプリケーションリポジトリの構成例です。アプリ仕様が未確定の項目はプレースホルダーのままにしています。

## 構成

- `backend/`: Spring Bootアプリケーション。Maven設定とJavaコードは未作成です。
- `frontend/`: VueまたはReactを選択予定です。選択後に`package.json`とソースを整備してください。
- `scripts/`: DB作成、データ投入、API／結合テスト、ローカル起動のアプリ固有処理を置きます。
- `sql/`: DDL、マスタデータ、テストデータをアプリ側で管理します。
- `tests/`: API、結合、E2E、性能テストを置きます。テスト内容は未作成です。
- `openshift/`: アプリ固有のDeployment、Service、Route定義を置きます。
- `Dockerfile`: アプリのコンテナ化定義を置きます。

空のプレースホルダーファイルは、先頭行のコメントで未作成であることを示しています。`package.json`はJSONにコメント構文がないため、有効な最小JSONとして置いています。
`Dockerfile`の`FROM scratch`は構文確認用の仮置きです。実際にコンテナをBuildする前に、アプリに適したベースイメージへ置き換えてください。

## CI設定

`.gitlab-ci.yml`ではBackendとFrontendのイメージ、Build／Testコマンド、成果物パスを分けています。Build／Testコマンドが空の間は雛形であり、Pipelineは完了しません。アプリ仕様が決まったら各`TODO`とコマンドを設定してください。

includeのプロジェクトパスとリリースrefは、実際のGitLab環境に合わせて変更してください。
