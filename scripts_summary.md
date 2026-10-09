# Build

| ファイル | 用途 | 入力 | 出力 |
|----------|------|------|------|
| 71_lang_tomcat_build.sh | Tomcat WAR作成 | pom.xml | target/*.war |
| 72_lang_springboot_build.sh | Spring Boot JAR作成 | pom.xml | target/*.jar |
| 73_lang_nodejs_build.sh | Node.js Build | package.json | dist/ |
| 74_lang_python_build.sh | Python Package Build | requirements.txt | dist/ |
| 75_lang_was_build.sh | WAS EAR/WAR Build | pom.xml | target/*.ear |
| 76_lang_liberty_build.sh | Liberty Build | pom.xml | target/*.war |

## 共通処理

```text
依存解決
↓
Build
↓
Artifact確認
↓
build-outputへ格納
```

---

# Test

| ファイル | 用途 | テストツール | 出力 |
|----------|------|------|------|
| 81_lang_tomcat_test.sh | Tomcat UnitTest | Maven/JUnit | 
