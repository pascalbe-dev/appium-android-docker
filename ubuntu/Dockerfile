# derive from linux ubuntu to mimic our company's environment
FROM ubuntu

ARG systemImage
ARG platform
ARG buildTools
ARG appiumVersion

# GENERAL REQUIREMENTS
RUN apt-get update && apt-get -y install \
    wget \
    curl \
    unzip \
    openjdk-8-jre-headless

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# ANDROID SDK
# download android sdk and unzip it to an appropriate folder
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && mkdir -p /usr/local/android/sdk \
    && unzip -d /usr/local/android/sdk sdk-tools-linux-4333796.zip \
    && rm sdk-tools-linux-4333796.zip

# set android home env variable because appium requires that
ENV ANDROID_HOME=/usr/local/android/sdk/
# add sdk manager to path, so it can be used from everywhere
ENV PATH="/usr/local/android/sdk/tools/bin:${PATH}"
ENV PATH="/usr/local/android/sdk/emulator:${PATH}"
ENV PATH="/usr/local/android/sdk/platform-tools:${PATH}"
ENV PATH="/usr/local/android/sdk/build-tools/${buildTools}:${PATH}"
# create empty file to avoid warning
RUN mkdir $HOME/.android
RUN touch $HOME/.android/repositories.cfg
# emulator dependencies
RUN apt-get install -y \
    libglu1 \
    libpulse0
# install android SDK packages
RUN echo 'y' | sdkmanager 'platform-tools'
RUN echo 'y' | sdkmanager 'emulator'
RUN echo 'y' | sdkmanager $platform
RUN echo 'y' | sdkmanager $systemImage
RUN echo 'y' | sdkmanager "build-tools;${buildTools}"
# create AVD
RUN avdmanager create avd --name Nexus5_OS8.0.0 --device "Nexus 5" --package $systemImage
# make sure the UI is shared over display 0
ENV DISPLAY=:0

# VNC
# install server
RUN apt-get install -y tightvncserver
# set user which is required for starting server
ENV USER=root
# set password
RUN mkdir ~/.vnc && \
    echo "abcdefgh" | vncpasswd -f > ~/.vnc/passwd
# copy VNC settings
COPY xstartup /root/.vnc/xstartup
# make executable
RUN chmod +x /root/.vnc/xstartup
## start VNC server
#RUN vncserver :0
# expose vnc port
EXPOSE 5900

# APPIUM
# node dependencies
RUN apt-get install -y gnupg \
    gnupg2 \
    gnupg1
# add node-source to apt-get
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
# install appium dependencies
RUN apt-get install -y make \
    g++
# install nodejs
RUN apt-get install -y nodejs
# move to home folder
WORKDIR /root
# install appium locally (globally produces an error)
RUN npm i appium@$appiumVersion
# expose appium port
EXPOSE 4723

# start appium on container startup
#ENTRYPOINT [ "/root/node_modules/.bin/appium " ]