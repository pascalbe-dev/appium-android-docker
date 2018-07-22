# derive from linux alpine as it is small and does not contain unneccessary content
FROM alpine

ARG sdkTools=4333796
ARG systemImage
ARG platform
ARG buildTools=28.0.1
ARG appiumVersion=1.8.1

WORKDIR /root
LABEL maintainer="Pascal Betting, pascal.betting@intive.com"

# install appium requirements
RUN apk update && apk add --no-cache \
    g++ \
    make \
    nodejs \
    openjdk8-jre

# JAVA REQUIRED BY ANDROID SDK
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/
# ANDROID HOME REQUIRED BY APPIUM (WITH PATHS)
ENV ANDROID_HOME=/usr/local/android/sdk/
ENV PATH="${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platform-tools${PATH}"
ENV PATH="${ANDROID_HOME}/build-tools/${buildTools}:${PATH}"
# USER & DISPLAY REQUIRED BY VNC
ENV USER=root
ENV DISPLAY=:0

# ANDROID SDK
# SDK TOOLS VERSION SHOULD BE KEPT UP TO DATE
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${sdkTools}.zip \
    && mkdir -p /usr/local/android/sdk \
    && unzip -d /usr/local/android/sdk sdk-tools-linux-${sdkTools}.zip \
    && rm sdk-tools-linux-${sdkTools}.zip \
    && mkdir -p $HOME/.android \
    && touch $HOME/.android/repositories.cfg

# SDK PACKAGES (PIPE IN "Y" TO AVOID DIALOG PROMPT)
# LATEST VERSIONS FOR PLATFORM-TOOLS & EMULATOR
RUN echo 'y' | sdkmanager 'platform-tools' \
    && echo 'y' | sdkmanager 'emulator'
# OTHER PACKAGES DEPEND ON PARAMETERS
RUN echo 'y' | sdkmanager $platform
RUN echo 'y' | sdkmanager "build-tools;${buildTools}"
RUN echo 'y' | sdkmanager $systemImage \
    && avdmanager create avd --name "emulator" --device "Nexus 5" --package $systemImage

# INSTALLATION OF APPIUM
# avoid installing dev dependencies
# allow root access for further install scripts of the packages
RUN npm install -g --unsafe-perm=true --only=production appium@${appiumVersion}

# expose default appium port
EXPOSE 4723

# start appium on container start
# ENTRYPOINT [ "appium", "-g ~/appium.log" ]