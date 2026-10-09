# 06_GitLab_CICD_Runner_Design_v1.0

## 1. 目的
Runnerの標準運用方針を定義する。

## 2. 前提
- GitLab SaaS
- Shared Runner
- Docker Executor
- DooD構成
- Job終了後コンテナ削除

## 3. Runner方針
- Shared Runner利用
- 1 Job = 1 Container
- Container Registry未使用
- Artifact利用

## 4. DooD方針
```text
Runner Container
 ↓
Host Docker Engine
```

## 5. 許可コマンド
```bash
docker build
docker pull
docker run
docker ps
docker logs
docker stop
docker rm
```

## 6. 禁止コマンド
```bash
docker system prune
docker volume prune
docker network prune
docker image prune
```

## 7. キャッシュ
- Maven .m2
- node_modules
- pip cache

## 8. Artifact方針
- WAR
- JAR
- ZIP

## 9. E2E方針
Runner上で起動しPlaywright実行。

## 10. ログ方針
- 30日保持
- 障害時はArtifact保存

## 11. セキュリティ
- Secret直書き禁止
- GitLab Variables利用
- Protected / Masked利用

## 12. 次工程
- 07_GitLab_CICD_E2E_Design_v1.0.md
- 08_GitLab_CICD_Security_Design_v1.0.md
- 09_GitLab_CICD_Performance_Design_v1.0.md
