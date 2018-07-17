# derive from linux alpine as it is small and does not contain unneccessary content
FROM alpine

# install appium requirements
RUN apk update && apk add --no-cache \
    g++ \
    make \
    python2 \
    nodejs \
    openjdk8-jre

# add python path to env variable because appium requires that
ENV PYTHON=/usr/bin/python
# add java home which is required for appium android
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/

# download android sdk and unzip it to an appropriate folder
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
    && mkdir -p /usr/local/android/sdk \
    && unzip -d /usr/local/android/sdk sdk-tools-linux-3859397.zip

# set android home env variable because appium requires that
ENV ANDROID_HOME=/usr/local/android/sdk/
# add sdk manager to path, so it can be used from everywhere
ENV PATH="/usr/local/android/sdk/tools/bin:${PATH}"
ENV PATH="/usr/local/android/sdk/emulator:${PATH}"
ENV PATH="/usr/local/android/sdk/platform-tools:${PATH}"

# skip the terminal interaction
# install platform-tools, emulator, emulator-image
RUN echo 'y' | sdkmanager 'platform-tools'
RUN echo 'y' | sdkmanager 'emulator'
RUN echo 'y' | sdkmanager 'system-images;android-26;google_apis_playstore;x86'

# install appium via node package manager
# additional flags are needed to install further software which comes with appium
#RUN npm install -g appium --unsafe-perm=true --allow-root

# expose default appium port
EXPOSE 4723

# start appium on container start
# ENTRYPOINT [ "appium", "-g ~/appium.log" ]