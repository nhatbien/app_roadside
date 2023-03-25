#!/bin/bash

# Thiết lập các biến cho các thông tin cần thiết
flutterPath="/Users/bie/development/flutter"
appPath="/Users/bie/VILL/villship-driver-flutter/"

# Di chuyển đến thư mục ứng dụng và build ứng dụng Flutter
cd "$appPath"
"$flutterPath/bin/flutter" build apk lib/main.dart --flavor prod --release --verbose   

now=$(date +"%Y%m%d-%H%M%S")




mv build/app/outputs/flutter-apk/app-prod-release.apk build/app/outputs/flutter-apk/driver-prod-new-$now.apk

# Tìm tệp APK mới nhất được tạo ra
open build/app/outputs/flutter-apk

