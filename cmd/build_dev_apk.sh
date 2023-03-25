#!/bin/bash

flutter build apk lib/main_dev.dart --flavor dev --release --verbose   

now=$(date +"%Y%m%d-%H%M%S")

mv build/app/outputs/flutter-apk/app-dev-release.apk build/app/outputs/flutter-apk/driver-dev-new-$now.apk

# Tìm tệp APK mới nhất được tạo ra
open build/app/outputs/flutter-apk

