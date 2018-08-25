# derive from linux alpine as it is small and does not contain unneccessary content
FROM alpine

LABEL maintainer="Pascal Betting, pascal.betting@intive.com"

ARG sdkTools=4333796
ARG systemImage=system-images;android-28;google_apis_playstore;x86_64
ARG platform=28
ARG buildTools=28.0.1
ARG appiumVersion=1.8.1

WORKDIR /root

# INSTALL REQUIRED NATIVE PACKAGES
RUN apk update && apk add --no-cache \
    g++ \
    make \
    nodejs-npm \
    openbox \
    openjdk8-jre \
    x11vnc \
    xvfb

# JAVA HOME REQUIRED BY ANDROID SDK
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/
# ANDROID HOME REQUIRED BY APPIUM (WITH PATHS)
ENV ANDROID_HOME=/usr/local/android/sdk/
ENV PATH="${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platform-tools${PATH}"
ENV PATH="${ANDROID_HOME}/build-tools/${buildTools}:${PATH}"
# USER & DISPLAY REQUIRED BY VNC
ENV USER=root
ENV DISPLAY=:0

# ANDROID SDK
#   SDK TOOLS VERSION SHOULD BE KEPT UP TO DATE
#   CREATE EMPTY REPOSITORIES.CFG FILE TO AVOID WARNING
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${sdkTools}.zip \
    && mkdir -p /usr/local/android/sdk \
    && unzip -d /usr/local/android/sdk sdk-tools-linux-${sdkTools}.zip \
    && rm sdk-tools-linux-${sdkTools}.zip \
    && mkdir -p $HOME/.android \
    && touch $HOME/.android/repositories.cfg

# SDK PACKAGES (PIPE IN "Y" TO AVOID DIALOG PROMPT)
#   LATEST VERSIONS FOR PLATFORM-TOOLS & EMULATOR
#   OTHER PACKAGES DEPEND ON PARAMETERS
RUN echo 'y' | sdkmanager 'platform-tools' \
    && echo 'y' | sdkmanager 'emulator'
RUN echo 'y' | sdkmanager "platforms;android-${platform}" \
    && echo 'y' | sdkmanager "build-tools;${buildTools}" \
    && echo 'y' | sdkmanager $systemImage \
    && avdmanager create avd --name "emulator" --device "Nexus 5" --package $systemImage
    

# INSTALLATION OF APPIUM
#   AVOID INSTALLING DEV DEPENDENCIES
#   ALLOW ROOT ACCESS TO MAKE SURE FURTHER INSTALL SCRIPTS FROM NPM WORK
RUN npm install -g --unsafe-perm=true --only=production appium@${appiumVersion}

# EXPOSE PORTS
#   APPIUM
#   VNC
EXPOSE 4723
EXPOSE 5900

# COPY AND RUN STARTUP SCRIPT
COPY ./entrypoint.sh /root/entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]