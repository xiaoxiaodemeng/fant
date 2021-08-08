import 'package:flutter/widgets.dart';

class FImage extends StatefulWidget {
  /// 图片链接
  final String data;

  FImage(this.data, {Key? key}) : super(key: key);

  @override
  _FImage createState() => _FImage();
}

class _FImage extends State<FImage> {
  @override
  Widget build(BuildContext context) {
    return Text('99');
  }
}
