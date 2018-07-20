#!/usr/bin/env bash

package="system-images;android-25;google_apis;armeabi-v7a"
platform='platforms;android-25'
buildTools='28.0.1'
appiumVersion="1.8.1"

docker build \
    --build-arg platform=${platform} \
    --build-arg systemImage=${package} \
    --build-arg buildTools=${buildTools} \
    --build-arg appiumVersion=${appiumVersion} \
    -t pascalbe/ubuntu-android-emulator-vnc:API25_ARM .