FROM debian
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk wget unzip tar xz-utils git lib32stdc++6 && \
    rm -rf /var/lib/apt/lists/*
ENV ANDROID_HOME /opt/android-sdk-linux

RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O android_tools.zip && \
    unzip android_tools.zip && \
    rm android_tools.zip
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN yes | sdkmanager 'platform-tools'
RUN yes | sdkmanager 'build-tools;29.0.0'

RUN yes | sdkmanager 'platforms;android-29'


RUN wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.5.4-hotfix.2-stable.tar.xz
RUN tar xf flutter_linux_v1.5.4-hotfix.2-stable.tar.xz && rm flutter_linux_v1.5.4-hotfix.2-stable.tar.xz

ENV PATH="/flutter/bin:{$PATH}"

RUN /opt/android-sdk-linux/tools/bin/sdkmanager --update
RUN yes | flutter doctor --android-licenses

