import 'package:flutter/widgets.dart';

class TitleBar extends StatelessWidget {
  /// 标题
  final String title;

  /// 是否需要左边边距
  final bool isLeft;

  TitleBar(this.title, {this.isLeft = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 20, right: 16, bottom: 16, left: isLeft ? 16 : 0.0),
        child: Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(69, 90, 100, 0.6),
          ),
        ));
  }
}
