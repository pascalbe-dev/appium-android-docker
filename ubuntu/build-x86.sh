#!/usr/bin/env bash

package="system-images;android-26;google_apis_playstore;x86"
platform='platforms;android-26'

docker build \
    --build-arg platform=${platform} \
    --build-arg systemImage=${package} \
    -t pascalbe/ubuntu-android-emulator-vnc:API26 .