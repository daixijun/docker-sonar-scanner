FROM debian:stretch-slim
LABEL MAINTAINER="Xijun Dai <daixijun1990@gmail.com>"

ENV VERSION=3.3.0.1492
ENV TZ=Asia/Shanghai

RUN apt-get update \
    && apt-get install -y curl git unzip nodejs \
    && rm -rf /var/cache/apt/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/locatime \
    && echo "${TZ}" > /etc/timezone \
    && curl -sSL https://verystar.oss-cn-hangzhou.aliyuncs.com/software/SonarQube/sonar-scanner-cli-${VERSION}-linux.zip -o sonar-scanner.zip \
    && unzip sonar-scanner.zip \
    && mv sonar-scanner-${VERSION}-linux  /usr/local/sonar-scanner \
    && rm -r sonar-scanner.zip

ENV SONAR_RUNNER_HOME=/usr/local/sonar-scanner/
ENV PATH=$PATH:${SONAR_RUNNER_HOME}/bin

CMD ["sonar-scanner", "--version"]
