import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'image_item.dart';

class AutoScrollView extends StatefulWidget {
  final double? gapSpace;
  final double aspectRatio;
  final double perferSise;
  final List<String> covers;
  final double speed;
  final Color placeHolderColor;

  const AutoScrollView({
    Key? key,
    this.gapSpace,
    this.aspectRatio = 1.6,
    this.perferSise = 100,
    this.speed = 0.6,
    this.placeHolderColor = const Color(0xFF505050),
    required this.covers,
  }) : super(key: key);

  @override
  _AutoScrollViewState createState() => _AutoScrollViewState();
}

class _AutoScrollViewState extends State<AutoScrollView> {
  //图片的列表
  List<List<ImageItem>> imgList = List.empty(growable: true);

  int coverIndex = 0;

  double rootHeight = 0;
  double rootWidth = 0;

  double itemWidth = 0;
  double itemHeight = 0;

  int heightCount = 0;
  int widthCount = 0;

  // Timer? _timer;
  Ticker? _ticker;

  Orientation? currentOrientation;

  @override
  void initState() {
    // _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) async {
    //   await _updateList();
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _timer?.cancel();
    _ticker?.dispose();
    super.dispose();
  }

  _getCOver() {
    // coverIndex = Random().nextInt(randomCover.length);
    coverIndex++;
    coverIndex = coverIndex % widget.covers.length;
    debugPrint("totle --->$coverIndex --->" + widget.covers.length.toString());
    return widget.covers[coverIndex];
  }

  _initList(context, contransnts) {
    var newOrientation = MediaQuery.of(context).orientation;
    if (rootHeight != 0 || currentOrientation == newOrientation) {
      return;
    }
    rootHeight = contransnts.maxHeight;
    rootWidth = contransnts.maxWidth;
    widthCount = rootWidth ~/ widget.perferSise;

    itemWidth =
        (rootWidth - (widthCount * (widget.gapSpace ?? 0))) / widthCount;
    itemHeight = itemWidth * widget.aspectRatio;
    heightCount =
        (rootHeight / (itemHeight + (widget.gapSpace ?? 0))).round() + 2;
    imgList.clear();
    for (var j = 0; j < widthCount; j++) {
      List<ImageItem> itemList = List.empty(growable: true);
      for (var i = 0; i < heightCount; i++) {
        var postionY = i * (itemHeight + (widget.gapSpace ?? 0));
        if (j % 2 == 0) {
          postionY -= itemHeight / 2;
        }
        var postionX = j * (itemWidth + (widget.gapSpace ?? 0));

        var image = ImageItem(
          postionX: postionX,
          postionY: postionY,
          imagePath: _getCOver(),
          height: itemHeight,
          width: itemWidth,
        );
        image.loadImage();
        itemList.add(image);
      }
      imgList.add(itemList);
    }

    _ticker = Ticker(_handleStarTick)..start();
  }

  _handleStarTick(Duration elapsed) {
    if (rootHeight == 0) {
      return;
    }
    setState(() {
      _updateList();
    });
  }

  _updateList() {
    for (var j = 0; j < imgList.length; j++) {
      List<ImageItem> itemList = imgList[j];

      for (var i = 0; i < itemList.length; i++) {
        itemList[i].postionY -= widget.speed;
      }

      if (itemList.first.postionY + (itemHeight + (widget.gapSpace ?? 0)) <=
          0) {
        var postionY =
            itemList.last.postionY + (itemHeight + (widget.gapSpace ?? 0));
        var postionX = j * (itemWidth + (widget.gapSpace ?? 0));
        var image = ImageItem(
          postionX: postionX,
          postionY: postionY,
          imagePath: _getCOver(),
          height: itemHeight,
          width: itemWidth,
        );
        image.loadImage();
        itemList.removeAt(0);
        itemList.add(image);
        debugPrint("Add Image");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contransnts) {
      _initList(context, contransnts);
      // debugPrint("rootHeight---->$rootHeight,rootWidth--->$rootWidth");
      return Center(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            CustomPaint(
              painter: CoverPainter(imgList, widget.placeHolderColor),
              size: Size(rootWidth, rootHeight),
            ),
          ],
        ),
      );
    });
  }

  // List<Widget> _buildList() {
  //   List<Widget> resultList = List<Widget>.empty(growable: true);
  //   for (var itemList in imgList) {
  //     for (var item in itemList) {
  //       resultList.add(Positioned(
  //         top: item.postionY,
  //         left: item.postionX,
  //         height: itemHeight,
  //         width: itemWidth,
  //         child: CachedNetworkImage(
  //           fit: BoxFit.cover,
  //           imageUrl: item.imagePath,
  //         ),
  //       ));
  //     }
  //   }
  //   return resultList;
  // }
}

class CoverPainter extends CustomPainter {
  final List<List<ImageItem>> imgList;
  final Color placeHolderColor;

  CoverPainter(
    this.imgList,
    this.placeHolderColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    for (var itemList in imgList) {
      for (var item in itemList) {
        if (item.imageData != null) {
          canvas.drawImageRect(
              item.imageData!,
              Rect.fromLTWH(0, 0, item.imageData!.width.toDouble(),
                  item.imageData!.height.toDouble()),
              Rect.fromLTWH(
                  item.postionX, item.postionY, item.width, item.height),
              Paint());
        } else {
          Rect darwRect = Rect.fromLTWH(
              item.postionX, item.postionY, item.width, item.height);
          RRect rrect =
              RRect.fromRectAndRadius(darwRect, const Radius.circular(0.0));
          //canvas.clipRRect(rrect);
          canvas.drawRRect(rrect, Paint()..color = placeHolderColor);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
