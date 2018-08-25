FROM pascalbe/android-sdk:latest

ARG buildTools=28.0.1
ARG systemImage=system-images;android-28;google_apis_playstore;x86_64
ARG deviceModelName="Nexus 5"
ARG avdDeviceName="emulator"

LABEL maintainer="Pascal Betting, pascal.betting@intive.com"

WORKDIR /root
USER root

# INSTALL REQUIRED SDK PACKAGES + VIRTUAL DEVICE
RUN echo 'y' | sdkmanager 'emulator' && echo 'y' | sdkmanager $systemImage
RUN avdmanager create avd --name "$avdDeviceName" --device "$deviceModelName" --package "$systemImage"
RUN mkdir $ANDROID_HOME/platform-tools && \
    mkdir $ANDROID_HOME/platforms
    # && echo 'y' | sdkmanager 'platform-tools' \
    # && echo 'y' | sdkmanager "build-tools;${buildTools}" \
    # && echo 'y' | sdkmanager $systemImage \
    # && avdmanager create avd --name $avdDeviceName --device $deviceModelName --package $systemImage

# INSTAL REQUIRED PACKAGES FOR THE EMULATOR RUN
RUN apt-get install -y libglu1 libpulse0 tightvncserver i3

# ADD CONFIGURATION AND SERVICE FOR VNC SERVER
COPY vncserver ~/.vnc/xstartup
COPY xstartup /etc/init.d/vncserver

# SETUP VNC
# SOMEHOW THE FILE NEEDS 600 PERMISSIONS TO BE RECOGNIZED BY THE vncserver executable
RUN mkdir ~/.vnc \
    && echo "abcdef" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 $HOME/.vnc/passwd

ENV DISPLAY=:0
ENV USER=root