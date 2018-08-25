FROM pascalbe/android-sdk:latest

ARG buildTools=28.0.1
ARG systemImage=system-images;android-28;google_apis_playstore;x86_64
ARG deviceModelName="Nexus 5"
ARG avdDeviceName="emulator"

WORKDIR /root
LABEL maintainer="Pascal Betting, pascal.betting@intive.com"

# INSTALL REQUIRED SDK PACKAGES + VIRTUAL DEVICE
RUN echo 'y' | sdkmanager 'emulator' && echo 'y' | sdkmanager $systemImage
RUN avdmanager create avd --name "$avdDeviceName" --device "$deviceModelName" --package "$systemImage"
RUN mkdir $ANDROID_HOME/platform-tools && \
    mkdir $ANDROID_HOME/platforms
    # && echo 'y' | sdkmanager 'platform-tools' \
    # && echo 'y' | sdkmanager "build-tools;${buildTools}" \
    # && echo 'y' | sdkmanager $systemImage \
    # && avdmanager create avd --name $avdDeviceName --device $deviceModelName --package $systemImage

RUN apt-get install -y libglu1 libpulse0