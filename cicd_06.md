できます。ただし、ここで実際に common_cicd/ 配下へ 50〜59 や 71〜125 を完全生成するとかなり大規模になります。

現時点の議論を踏まえると、まずは 共通CI/CDリポジトリの最終ディレクトリ設計 を固定するのがよいと思います。

以下が私なら採用する v1.0 の構成です。

common_cicd/
│
├── README.md
├── CHANGELOG.md
├── VERSION
│
├── templates
│   │
│   ├── build
│   │   ├── build-java.yml
│   │   ├── build-node.yml
│   │   ├── build-docker.yml
│   │   └── build-all.yml
│   │
│   ├── test
│   │   ├── unit-test.yml
│   │   ├── integration-test.yml
│   │   ├── playwright-test.yml
│   │   ├── api-test.yml
│   │   └── k6-test.yml
│   │
│   ├── security
│   │   ├── sast.yml
│   │   ├── sca.yml
│   │   ├── sbom.yml
│   │   ├── cve.yml
│   │   ├── secret-scan.yml
│   │   ├── license-check.yml
│   │   ├── container-scan.yml
│   │   └── iac-scan.yml
│   │
│   ├── package
│   │   ├── package-jar.yml
│   │   ├── package-war.yml
│   │   └── package-container.yml
│   │
│   ├── deploy
│   │   ├── deploy-websphere-traditional.yml
│   │   ├── deploy-liberty.yml
│   │   ├── deploy-openshift.yml
│   │   └── deploy-kubernetes.yml
│   │
│   ├── notify
│   │   ├── notify-success.yml
│   │   ├── notify-failure.yml
│   │   └── notify-teams.yml
│   │
│   └── pipeline
│       ├── java-standard.yml
│       ├── springboot-standard.yml
│       ├── vue-springboot.yml
│       └── openshift-standard.yml
│
├── scripts
│   │
│   ├── build
│   │   ├── maven_build.sh
│   │   ├── gradle_build.sh
│   │   ├── npm_build.sh
│   │   └── docker_build.sh
│   │
│   ├── test
│   │   ├── maven_test.sh
│   │   ├── playwright_test.sh
│   │   ├── api_test.sh
│   │   └── k6_test.sh
│   │
│   ├── security
│   │   ├── run_sonar.sh
│   │   ├── run_dependency_check.sh
│   │   ├── run_syft.sh
│   │   ├── run_trivy.sh
│   │   ├── run_gitleaks.sh
│   │   ├── run_license_check.sh
│   │   └── run_checkov.sh
│   │
│   ├── package
│   │   ├── package_jar.sh
│   │   ├── package_war.sh
│   │   └── package_container.sh
│   │
│   ├── deploy
│   │   ├── deploy_websphere.sh
│   │   ├── deploy_liberty.sh
│   │   ├── deploy_openshift.sh
│   │   └── deploy_k8s.sh
│   │
│   └── notify
│       ├── notify_success.sh
│       ├── notify_failure.sh
│       └── notify_teams.sh
│
├── docs
│   │
│   ├── architecture.md
│   ├── onboarding.md
│   ├── supported-frameworks.md
│   ├── security-policy.md
│   └── versioning-policy.md
│
├── examples
│   │
│   ├── springboot
│   │   └── .gitlab-ci.yml
│   │
│   ├── vue-vite
│   │   └── .gitlab-ci.yml
│   │
│   └── vue-springboot
│       └── .gitlab-ci.yml
│
└── schemas
    │
    ├── sbom
    │   └── cyclonedx.schema.json
    │
    └── openshift
        └── deployment.schema.json


利用側アプリは極小化できます。

include:
  - project: 'platform/common_cicd'
    ref: v1.0.0
    file:
      - '/templates/pipeline/vue-springboot.yml'

variables:
  DEPLOY_TARGET: "E"


そしてアプリ側は次の資材だけを持つ設計です。

app-repo
│
├── frontend
├── backend
│
├── tests
│   ├── unit
│   ├── api
│   ├── e2e
│   └── performance
│
├── sql
│   ├── ddl
│   ├── master
│   └── testdata
│
├── scripts
│   ├── create_db.sh
│   ├── integration_test.sh
│   └── batch_test.sh
│
├── Dockerfile
│
└── openshift
    ├── deployment.yaml
    ├── service.yaml
    └── route.yaml


この構成なら、以前整理した WebSphere の A〜E 区分、

A: Traditional Base
B: Traditional ND
C: Liberty Base
D: Liberty ND
E: Liberty + K8S/OpenShift

すべてを 1 つの共通CI/CD基盤で扱えます。さらに Vue(Vite)+Spring Boot、純Spring Boot、Tomcat WAR、Liberty、OpenShift まで同一フレームワークで統一できます。
