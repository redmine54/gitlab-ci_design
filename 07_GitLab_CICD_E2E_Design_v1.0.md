# 07_GitLab_CICD_E2E_Design_v1.0

## 1. 目的

本設計書は GitLab CI/CD 標準テンプレートにおける E2E 試験方式を定義する。

対象。

- Java Servlet/JSP (Tomcat)
- Spring Boot
- Node.js
- Python

## 2. 基本方針

実環境は利用しない。

Runner上でアプリケーションを起動し E2E を実施する。

```text
Build
 ↓
Artifact取得
 ↓
Application起動
 ↓
HealthCheck
 ↓
E2E
 ↓
証跡取得
 ↓
Application停止
 ↓
Container削除
```

## 3. 標準ツール

```text
Playwright
```

## 4. 対象ブラウザ

標準:

```text
Chromium
```

オプション:

```text
Firefox
WebKit
```

## 5. Tomcat方式

```bash
docker run -d --name e2e-app tomcat:latest
```

## 6. Spring Boot方式

```bash
java -jar target/app.jar
```

## 7. Node.js方式

```bash
npm start
```

## 8. Python方式

```bash
python app.py
```

## 9. 起動コマンド標準化

```yaml
START_CMD:
```

## 10. Health Check標準

```yaml
HEALTHCHECK_URL:
```

## 11. Playwright実行

```bash
npx playwright test
```

## 12. Screenshot取得

```javascript
use: {
  screenshot: 'only-on-failure'
}
```

## 13. Video取得

```javascript
use: {
  video: 'retain-on-failure'
}
```

## 14. Trace取得

```javascript
use: {
  trace: 'retain-on-failure'
}
```

## 15. レポート出力

HTML Report を採用する。

## 16. Artifact保存

```yaml
artifacts:
  when: always
```

保存対象:

- report
- screenshots
- videos
- trace

## 17. Branch別実施方針

| Branch | E2E |
|---------|-----|
| feature | ○ |
| master | ○ |
| tag | ○ |

## 18. 利用者Variables

```yaml
START_CMD:
HEALTHCHECK_URL:
E2E_BROWSER:
```

## 19. 次工程

- 08_GitLab_CICD_Security_Design_v1.0.md
- 09_GitLab_CICD_Performance_Design_v1.0.md
