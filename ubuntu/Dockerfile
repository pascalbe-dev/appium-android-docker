# USE UBUNTU TO HAVE SAME ENVIRONMENT LIKE ON COMPANY SLAVES
FROM ubuntu

# BUILD ARGUMENTS
ARG sdkTools=4333796
ARG systemImage
ARG platform
ARG buildTools=28.0.1
ARG appiumVersion=1.8.1

WORKDIR /root
LABEL maintainer="Pascal Betting, pascal.betting@intive.com"

# PACKAGE DEPENDENCIES
RUN apt-get update && apt-get -y install \
    wget \
    curl \
    unzip \
    openjdk-8-jre-headless \
    libglu1 \
    libpulse0 \
    make \
    g++ \
    gnupg \
    gnupg1 \
    gnupg2 \
    tightvncserver

# JAVA REQUIRED BY ANDROID SDK
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
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

# INSTALL NODEJS + NPM AFTER ADDING THE APT REPOSITORY
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g --unsafe-perm=true --only=production appium@${appiumVersion}


# SETUP VNC
# SOMEHOW THE FILE NEEDS 600 PERMISSIONS TO BE RECOGNIZED BY THE vncserver executable
RUN mkdir ~/.vnc \
    && echo "abcdef" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 $HOME/.vnc/passwd

# EXPOSE APPIUM PORT
EXPOSE 4723
# EXPOSE VNC PORT
EXPOSE 5900

RUN apt-get install -y git \
    && git clone https://github.com/novnc/noVNC.git

# EXPOSE NOVNC PORT
EXPOSE 6080

COPY ./entrypoint.sh /root/entrypoint.sh
# RUN STARTUP SCRIPT
ENTRYPOINT [ "./entrypoint.sh" ]