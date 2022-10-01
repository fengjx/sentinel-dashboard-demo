#! /bin/bash

# set -ex

DIST_DIR=.dist
LOG_DIR=logs
SENTINEL_DASHBOARD=1.8.5

package() {
  if [ ! -f "${DIST_DIR}/app.jar" ]; then
    echo '应用打包开始'
    mkdir -p ${DIST_DIR}
    mvn clean package -U -DskipTests=true
    cp target/sentinel-dashboard-demo-0.0.1-SNAPSHOT.jar ${DIST_DIR}/app.jar
    echo '应用打包结束'
  fi
}

start_dashboard() {
  package
  if [ ! -f "${DIST_DIR}/sentinel-dashboard.jar" ]; then
    echo '下载官方 sentinel-dashboard jar 包'
    curl -L https://github.com/alibaba/Sentinel/releases/download/1.8.5/sentinel-dashboard-${SENTINEL_DASHBOARD}.jar \
      -o ${DIST_DIR}/sentinel-dashboard.jar
  fi
  mkdir -p "${LOG_DIR}"
  kill $(ps aux | grep 'sentinel-dashboard.jar' | grep -v grep | awk '{print $2}') || true
  # 启动 sentinel-dashboard
  nohup java -Dserver.port=6080 -Dproject.name=sentinel-dashboard -jar ${DIST_DIR}/sentinel-dashboard.jar \
    >${LOG_DIR}/dashboard.log 2>&1 &
  echo '启动 demo server'
  # 启动 demo 服务
  java -jar ${DIST_DIR}/app.jar --spring.profiles.active=official
}

start_dashboard_apollo() {
  package
  export DOCKER_SCAN_SUGGEST=false
  sudo docker build -t sentinel-demo-server .
  sudo docker compose up -d
}

case_opt=$1
shift

case ${case_opt} in
start_dashboard)
  start_dashboard "$@"
  ;;
start_dashboard_apollo)
  start_dashboard_apollo "$@"
  ;;
esac
