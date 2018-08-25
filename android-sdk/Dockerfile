FROM ubuntu:18.04

# VERSION NUMBER OF THE ANDROID SDK DOWNLOAD PACKAGE
ARG sdkTools=4333796

WORKDIR /root
LABEL maintainer="Pascal Betting, pascal.betting@intive.com"

# INSTALL REQUIRED PACKAGES
RUN apt-get update && apt-get install -y \
    openjdk-8-jre-headless \
    wget \
    unzip

# JAVA HOME FOR MORE DIFFERENT TOOLS WHICH USE JAVA
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
# ANDROID HOME FOR TOOLS THAT REQUIRE THE ANDROID SDK
ENV ANDROID_HOME=/usr/local/android/sdk
# ADD ANDROID SDK TOOLS TO THE PATH
ENV PATH="${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools/${buildTools}:${PATH}"

# ANDROID SDK
# SDK TOOLS VERSION SHOULD BE KEPT UP TO DATE
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${sdkTools}.zip \
    && mkdir -p /usr/local/android/sdk \
    && unzip -d /usr/local/android/sdk sdk-tools-linux-${sdkTools}.zip \
    && rm sdk-tools-linux-${sdkTools}.zip \
    && mkdir -p $HOME/.android \
    && touch $HOME/.android/repositories.cfg