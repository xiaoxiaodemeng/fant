import 'package:fant/theme/var.dart';
import 'package:flutter/material.dart';

import 'var.dart';

class FBadgeTheme {
  /// 最小宽度
  double get badgeSize => badge_size;

  /// 文字颜色
  Color get badgeColor => badge_color;

  /// padding
  EdgeInsets get badgePadding => badge_padding;

  /// 文字大小
  double get badgeFontSize => badge_font_size;

  /// 文字weight
  FontWeight get badgeFontWeight => badge_font_weight;

  /// border 宽度
  double get badgeBorderWidth => badge_border_width;

  /// 背景颜色
  Color get badgeBackgroundColor => badge_background_color;

  /// 徽标圆角
  double get borderRoundRadius => border_radius_max;

  /// 红点颜色
  Color get badgeDotColor => badge_dot_color;

  /// 红点大小
  double get badgeDotSize => badge_dot_size;
}
