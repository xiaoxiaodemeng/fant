import 'package:flutter/material.dart';

import 'index.dart';
import 'var.dart';

class FTagTheme {
  /// 默认白色，朴素状态的背景颜色
  Color get plainBackground => tag_plain_background_color;

  /// 文本颜色
  Color get textColor => tag_text_color;

  /// tag的文字大小
  double get tagFontSize => tag_font_size;

  /// 默认的圆角大小
  double get tagBorderRadius => tag_border_radius;

  /// 大标签的圆角
  double get tagLargeBorderRadius => tag_large_border_radius;

  /// 圆形的圆角
  double get tagRoundBorderRadius => tag_round_border_radius;

  /// 边框
  double get tagBorderWidth => tag_border_width;

  /// 大标签的文字带下
  double get tagBigFontSize => tag_large_font_size;

  /// 距离差距
  double get spaceDistance => space;

  /// 获取padding--切换大小
  EdgeInsetsGeometry getSizePadding(FTagSize? size) {
    if (size == FTagSize.large) {
      return tag_large_padding;
    } else if (size == FTagSize.medium) {
      return tag_medium_padding;
    }

    return tag_padding;
  }

  /// 获取样式
  FTagStyle getTagStyle(FTagType type) {
    /// 相对应的配置 defaultType, primary, success, warning, danger
    List<Map<String, dynamic>> cfg = [
      {
        "backgroundColor": tag_default_color,
        "plainColor": tag_default_color,
      },
      {
        "plainColor": tag_primary_color,
        "backgroundColor": tag_primary_color,
      },
      {
        "plainColor": tag_success_color,
        "backgroundColor": tag_success_color,
      },
      {
        "plainColor": tag_warning_color,
        "backgroundColor": tag_warning_color,
      },
      {
        "plainColor": tag_danger_color,
        "backgroundColor": tag_danger_color,
      }
    ];

    return FTagStyle.fromJson(cfg[type.index]);
  }
}

class FTagStyle {
  /// 朴素的字体颜色
  Color plainColor;

  /// 背景颜色
  Color backgroundColor;

  FTagStyle({required this.backgroundColor, required this.plainColor});

  /// 序列化
  FTagStyle.fromJson(Map<String, dynamic> json)
      : backgroundColor = json['backgroundColor'],
        plainColor = json['plainColor'];
}
