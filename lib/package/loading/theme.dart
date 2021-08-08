import 'package:flutter/material.dart';

import 'var.dart';

import '../../theme/var.dart';

/// Loading 样式
class FLoadingTheme {
  /// 加载Icon的大小
  double get loadingSize => loading_spinner_size;

  /// 加载的是线条---宽度
  double get loadingLineWidth => loading_line_Width;

  /// loading颜色
  Color get loadingColor => loading_spinner_color;

  /// loading动画时间(速度)
  Duration get loadingDuration => loading_spinner_animation_duration;

  /// 文本颜色
  Color get textColor => loading_text_color;

  /// 文字大小
  double get textSize => loading_text_font_size;

  /// 文本间距
  double get margin => padding_xs;
}
