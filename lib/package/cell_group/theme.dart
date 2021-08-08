import 'package:flutter/material.dart';

import '../../theme/var.dart';
import 'var.dart';

class FCellGroupTheme {
  /// 容器颜色
  Color get cellGroupBackgroundColor => cell_group_background_color;

  /// 标题padding 间距
  EdgeInsets get cellGroupTitlePadding => cell_group_title_padding;

  /// 标题颜色
  Color get cellGroupTitleColor => cell_group_title_color;

  /// 标题字体大小
  double get cellGroupTitleFontSize => cell_group_title_font_size;

  /// 边框颜色
  Color get cellBorderColor => border_color;

  /// 卡片模式下新增左右padding
  EdgeInsets get cellGrouInsetPadding => cell_group_inset_padding;

  /// 卡片模式下的圆角
  double get cellGroupInsetBorderRadius => cell_group_inset_border_radius;
}
