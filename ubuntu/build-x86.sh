#!/usr/bin/env bash

package="system-images;android-26;google_apis_playstore;x86"
platform='platforms;android-26'
buildTools='28.0.1'
appiumVersion="1.8.1"

docker build \
    --build-arg platform=${platform} \
    --build-arg systemImage=${package} \
    --build-arg buildTools=${buildTools} \
    --build-arg appiumVersion=${appiumVersion} \
    -t pascalbe/ubuntu-android-emulator-vnc:API26 .