FROM openjdk:8-jdk-alpine

ENV WORK_DIR=/app
WORKDIR ${WORK_DIR}

COPY target/*.jar ${WORK_DIR}/app.jar

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar ${WORK_DIR}/app.jar ${0} ${@}"]
