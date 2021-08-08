import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../utils/common/index.dart';
import '../badge/index.dart';

import 'theme.dart';

class FIcon extends StatelessWidget {
  /// 图标名称
  ///
  /// FantIcon集成了vant的绝大部分的图标
  ///
  /// 也可自定义的图标pubspec.yaml需要引入ttf包
  ///
  /// 例如:[FantIcon.add]
  final IconData? name;

  /// 可使用链接
  ///
  /// name参数的优先级高于url
  final String? url;

  /// 图标颜色
  final Color? color;

  /// 图标大小
  ///
  /// 默认16
  final double? size;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 角标的内容类型是字符串
  ///
  /// 优先级高于 number
  final String? text;

  FIcon(
      {Key? key,
      this.name,
      this.url,
      this.text,
      this.color,
      this.size,
      this.dot = false})
      : assert(name != null || url != null, '图标name 和 图标链接必须选其一'),
        super(key: key);

  Widget renderImage(FIconTheme style) {
    if (name != null) {
      return Icon(
        name,
        size: size ?? style.iconSize,
        color: color,
      );
    } else if (url != null) {
      if (isNetWorkImg(this.url!)) {
        return ExtendedImage.network(this.url!,
            width: size ?? style.iconSize, height: size ?? style.iconSize);
      } else if (isAssetsImg(this.url!)) {
        return Image.asset(this.url!,
            width: size ?? style.iconSize, height: size ?? style.iconSize);
      }
      throw new Exception('图片只支持网络图片以及本地图片');
    }
    return Container(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    // 主题
    FIconTheme theme = FIconTheme();
    return FBadge(dot: dot, text: text, child: renderImage(theme));
  }
}
