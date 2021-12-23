import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class ImageItem {
  double postionX; // 坐标X
  double postionY; // 坐标 Y
  double width;
  double height;
  String imagePath; //图片
  ui.Image? imageData; //图片数据

  ImageItem({
    required this.postionX,
    required this.postionY,
    required this.width,
    required this.height,
    required this.imagePath,
    this.imageData,
  });

  //加载网络图片
  Future<ui.Image> loadImage() async {
    ImageStream stream =
        NetworkImage(imagePath).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer<ui.Image>();
    void listener(ImageInfo frame, bool synchronousCall) {
      imageData = frame.image;
      stream.removeListener(ImageStreamListener(listener));
    }

    stream.addListener(ImageStreamListener(listener));
    return completer.future;
  }
}
