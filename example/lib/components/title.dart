import 'package:flutter/widgets.dart';

class TitleBar extends StatelessWidget {
  /// 标题
  final String title;

  TitleBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, right: 16, bottom: 16),
        child: Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(69, 90, 100, 0.6),
          ),
        ));
  }
}
