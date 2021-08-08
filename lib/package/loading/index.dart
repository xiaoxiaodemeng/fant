import 'package:flutter/material.dart';

import 'icon/circle.dart';
import 'icon/ring.dart';
import 'theme.dart';

/// Loading 类型
enum LoadingType {
  circular,
  spinner,
}

/// http://blog.luckly-mjw.cn/tool-show/index.html解码ttf
class FLoading extends StatelessWidget {
  /// loading加载的颜色
  final Color? color;

  /// loading加载的类型
  ///
  /// circular
  ///
  /// spinner
  final LoadingType? type;

  /// loading的大小
  final double? size;

  /// 文本大小
  final double? textSize;

  /// 文本字体颜色
  final Color? textColor;

  /// 是否垂直排列图标和文字内容
  final bool vertical;

  /// 文本
  final String? text;

  // 构造器
  FLoading(
      {Key? key,
      this.color,
      this.size,
      this.text,
      this.textColor,
      this.textSize,
      this.vertical = false,
      this.type = LoadingType.circular})
      : super(key: key);

  /// 渲染文本
  Widget renderText() {
    /// 样式
    FLoadingTheme theme = FLoadingTheme();
    return Container(
        margin: vertical
            ? EdgeInsets.only(top: theme.margin)
            : EdgeInsets.only(left: theme.margin),
        child: Text(text!,
            style: TextStyle(
                fontSize: textSize ?? theme.textSize,
                color: textColor ?? color ?? theme.textColor)));
  }

  /// 判断渲染loading
  Widget renderLoading() {
    if (type.toString() == 'LoadingType.circular') {
      return LoadingSpring(color: color, size: size);
    } else {
      return LoadingCircle(color: color, size: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Flex(
            direction: vertical ? Axis.vertical : Axis.horizontal,
            children: [renderLoading(), if (text != null) renderText()]));
  }
}
