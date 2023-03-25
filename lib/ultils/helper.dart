import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class Helper {
  // for mapping data retrieved form json array

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static String orderStatusToText(int status) {
    switch (status) {
      case 0:
        return 'Lỗi';
      case 1:
        return 'Chờ xác nhận';
      case 2:
        return 'Chờ xác nhận';
      case 3:
        return 'Đang tới';
      case 4:
        return 'Hoàn thành';
      case 5:
        return 'Đã Hủy';

      default:
        return 'Unknown';
    }
  }

  static String orderStatusToTextDes(int status) {
    switch (status) {
      case 0:
        return 'Lỗi, vui lòng thử lại';
      case 1:
        return 'BieTru sẽ báo cho bạn khi có đơn vị cứu hộ nhận đơn';
      case 2:
        return 'Đã có đơn vị cứu hộ nhận đơn, vui lòng đợi cuộc gọi';
      case 3:
        return 'Tài xế đang trên đường đến cứu bạn, vui lòng chờ';
      case 4:
        return 'Hoàn thành';
      case 5:
        return 'Đã Hủy';

      default:
        return 'Unknown';
    }
  }
}
