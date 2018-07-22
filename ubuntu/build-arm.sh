#!/usr/bin/env bash

package="system-images;android-25;google_apis;armeabi-v7a"
platform='platforms;android-25'

docker build \
    --build-arg platform=${platform} \
    --build-arg systemImage=${package} \
    -t pascalbe/ubuntu-android-emulator-vnc:API25_ARM .