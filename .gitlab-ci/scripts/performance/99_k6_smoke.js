// .gitlab-ci/scripts/performance/99_k6_smoke.js # k6スモーク性能試験
import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  vus: Number(__ENV.K6_VUS || 10),

  duration: __ENV.K6_DURATION || "1m",

  thresholds: {
    http_req_failed: ["rate<0.01"],

    http_req_duration: ["p(95)<2000"],

    checks: ["rate>0.99"],
  },
};

const TARGET_URL = __ENV.TARGET_URL;

if (!TARGET_URL) {
  throw new Error("TARGET_URL is required");
}

export default function () {
  const response = http.get(TARGET_URL, {
    headers: {
      "User-Agent": "GitLab-CI-k6-Smoke-Test",
    },
    timeout: "30s",
  });

  check(response, {
    "status is 200": (r) => r.status === 200,

    "response time < 2000ms": (r) => r.timings.duration < 2000,
  });

  sleep(1);
}

