FROM debian:stretch-slim
LABEL MAINTAINER="Xijun Dai <daixijun1990@gmail.com>"

ENV VERSION=3.3.0.1492
ENV NODE_VERSION=10.15.3
ENV TZ=Asia/Shanghai

RUN apt-get update \
    && apt-get install -y curl git unzip xz-utils \
    && rm -rf /var/cache/apt/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/locatime \
    && echo "${TZ}" > /etc/timezone \
    && curl -sSL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${VERSION}-linux.zip -o sonar-scanner.zip \
    && unzip sonar-scanner.zip \
    && mv sonar-scanner-${VERSION}-linux  /usr/local/sonar-scanner \
    && rm -r sonar-scanner.zip \
    && curl -sSL https://nodejs.org/dist/v{NODE_VERSION}/node-v{NODE_VERSION}-linux-x64.tar.xz -o node-v{NODE_VERSION}-linux-x64.tar.xz \
    && tar xf node-v{NODE_VERSION}-linux-x64.tar.xz \
    && mv node-v{NODE_VERSION}-linux-x64 /usr/local/node \
    && rm -rf node-v{NODE_VERSION}-linux-x64.tar.xz

ENV SONAR_RUNNER_HOME=/usr/local/sonar-scanner/
ENV PATH=$PATH:${SONAR_RUNNER_HOME}/bin:/usr/local/node/bin

CMD ["sonar-scanner", "--version"]
