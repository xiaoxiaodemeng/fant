import 'package:flutter/material.dart';
import '../../theme/var.dart';

import 'index.dart';
import 'var.dart';

/// 定义按钮基本的样式
///
/// 背景  边框  字体颜色
class FButtonStyle {
  /// 朴素的字体颜色
  Color? plainColor;

  /// 朴素的背景颜色
  Color? plainBackgroundColor;

  /// 背景颜色
  Color backgroundColor;

  /// 字体颜色
  Color color;

  /// 边框颜色
  Color borderColor;

  /// 边框宽度
  double borderWidth;

  FButtonStyle({
    required this.backgroundColor,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    this.plainColor,
    this.plainBackgroundColor,
  });

  /// 克隆
  FButtonStyle copyWith(
      {Color? backgroundColor,
      Color? plainBackgroundColor,
      Color? plainColor,
      Color? color,
      Color? borderColor,
      double? borderWidth}) {
    return FButtonStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        plainBackgroundColor: plainBackgroundColor ?? this.plainBackgroundColor,
        plainColor: plainColor ?? this.plainColor,
        color: color ?? this.color,
        borderColor: borderColor ?? this.borderColor,
        borderWidth: borderWidth ?? this.borderWidth);
  }

  Map<String, dynamic> toJson() => {
        "plainColor": plainColor,
        "backgroundColor": backgroundColor,
        "color": color,
        "borderColor": borderColor,
        "borderWidth": borderWidth
      };

  /// 序列化
  FButtonStyle.fromJson(Map<String, dynamic> json)
      : backgroundColor = json['backgroundColor'],
        color = json['color'],
        borderColor = json['borderColor'],
        plainColor = json['plainColor'],
        borderWidth = json['borderWidth'],
        plainBackgroundColor =
            json['plainBackgroundColor'] ?? button_plain_background_color;
}

/// 定义按钮基本样式
///
/// 高度  padding  文字大小
class FButtonShape {
  /// 高度
  double? height;

  /// padding
  EdgeInsetsGeometry? padding;

  /// 文字大小
  double? fontSize;

  FButtonShape({
    this.height = button_default_height,
    this.padding,
    this.fontSize,
  });

  /// 序列化
  FButtonShape.fromJson(Map<String, dynamic> json)
      : height = json['height'] ?? button_default_height,
        padding = json['padding'],
        fontSize = json['fontSize'] ?? button_default_font_size;
}

class FButtonTheme {
  /// 获取普通圆角--小的
  double get borderRadius => button_border_radius;

  /// 获取圆的圆角--大的
  double get borderRoundRadius => button_round_border_radius;

  /// 禁用按钮的opacity
  double get disabledOpacity => button_disabled_opacity;

  /// space间距
  double get baseSpace => padding_base;

  /// 获取遮罩颜色层
  Color get baseMark => mark;

  /// 获取按钮的 文字大小 padding 高度
  ///
  /// - index==0 large [toString]==FButtonSize.large
  ///
  /// - index==1 normal [toString]==FButtonSize.normal
  ///
  /// - index==2 small [toString]==FButtonSize.small
  ///
  /// - index==3 mini [toString]==FButtonSize.mini
  FButtonShape shapeStyle(FButtonSize size) {
    /// 相对应的配置
    List<Map<String, dynamic>> cfg = [
      {"height": button_large_height},
      {"padding": button_normal_padding, "fontSize": button_normal_font_size},
      {
        "height": button_small_height,
        "padding": button_small_padding,
        "fontSize": button_small_font_size
      },
      {
        "height": button_mini_height,
        "padding": button_mini_padding,
        "fontSize": button_mini_font_size
      },
    ];

    return FButtonShape.fromJson(cfg[size.index]);
  }

  /// 获取按钮背景颜色+字体颜色+边框颜色
  ///
  /// - index==0 defaultType [toString]==FButtonType.defaultType
  ///
  /// - index==1 primary [toString]==FButtonType.primary
  ///
  /// - index==2 success [toString]==FButtonType.success
  ///
  /// - index==3 warning [toString]==FButtonType.warning
  ///
  /// - index==4 danger [toString]==FButtonType.danger
  FButtonStyle getButtonStyle(FButtonType type) {
    /// 相对应的配置
    List<Map<String, dynamic>> cfg = [
      {
        "backgroundColor": button_default_background_color,
        "color": button_default_color,
        "borderColor": button_default_border_color,
        "borderWidth": button_border_width
      },
      {
        "plainColor": button_primary_background_color,
        "backgroundColor": button_primary_background_color,
        "color": button_primary_color,
        "borderColor": button_primary_border_color,
        "borderWidth": button_border_width
      },
      {
        "plainColor": button_success_background_color,
        "backgroundColor": button_success_background_color,
        "color": button_success_color,
        "borderColor": button_success_border_color,
        "borderWidth": button_border_width
      },
      {
        "plainColor": button_warning_background_color,
        "backgroundColor": button_warning_background_color,
        "color": button_warning_color,
        "borderColor": button_warning_border_color,
        "borderWidth": button_border_width
      },
      {
        "plainColor": button_danger_background_color,
        "backgroundColor": button_danger_background_color,
        "color": button_danger_color,
        "borderColor": button_danger_border_color,
        "borderWidth": button_border_width
      }
    ];

    return FButtonStyle.fromJson(cfg[type.index]);
  }
}
