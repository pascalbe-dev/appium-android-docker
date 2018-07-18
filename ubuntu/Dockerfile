# derive from linux ubuntu to mimic our company's environment
FROM ubuntu

# install android SDK requirements
RUN apt-get update && apt-get -y install \
    wget \
    unzip \
    openjdk-8-jre-headless
#    g++ \
             ##    make \
             ##    python \
             ##    nodejs \

## add python path to env variable because appium requires that
#ENV PYTHON=/usr/bin/python

# add java home which is required for appium android
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

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

# create empty file to avoid warning
RUN touch $HOME/.android/repositories.cfg

# emulator dependencies
RUN apt-get install -y \
    libglu1 \
    libpulse0

# install android SDK packages
RUN echo 'y' | sdkmanager 'platform-tools'
RUN echo 'y' | sdkmanager 'emulator'
RUN echo 'y' | sdkmanager 'platforms;android-25'
RUN echo 'y' | sdkmanager 'system-images;android-25;google_apis;armeabi-v7a'

## vnc access
#RUN apt-get install -y x11vnc xvfb
## store vnc password
#RUN mkdir ~/.vnc/ && x11vnc -storepasswd 1234 ~/.vnc/passwd

# create AVD
RUN avdmanager create avd --name Nexus5_OS7.1_ARM --device "Nexus 5" --package "system-images;android-25;google_apis;armeabi-v7a"

# install appium via node package manager
# additional flags are needed to install further software which comes with appium
#RUN npm install -g appium --unsafe-perm=true --allow-root

# expose vnc port
EXPOSE 5900

# start appium on container start
# ENTRYPOINT [ "appium", "-g ~/appium.log" ]

#ENTRYPOINT ["x11vnc -forever -usepw -create"]