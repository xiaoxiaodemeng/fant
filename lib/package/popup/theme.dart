import 'package:flutter/material.dart';

import 'var.dart';

class FPopupTheme {
  /// 获取弹出层背景颜色
  Color get popupBackgroundColor => popup_background_color;

  /// 获取透明度
  double get overlayOpacity => overlay_opacity;

  /// icon的大小
  double get iconSize => popup_close_icon_size;

  /// icon的颜色
  Color get iconColor => popup_close_icon_color;

  /// 高亮icon 颜色
  Color get iconActiveColor => popup_close_icon_active_color;

  /// icon margin
  double get iconMargin => popup_close_icon_margin;

  /// popup 圆角
  Radius get popupRadius => Radius.circular(popup_round_border_radius);

  /// PopupPosition left, right, top, bottom, center
  FPositioned getPosition(int index) {
    /// 相对应的配置
    List<Map<String, dynamic>> cfg = [
      {
        "top": 0.0,
        "bottom": 0.0,
        "left": 0.0,
        "height": double.infinity,
        "topRightRound": popupRadius,
        "bottomRightRound": popupRadius
      },
      {
        "top": 0.0,
        "bottom": 0.0,
        "right": 0.0,
        "height": double.infinity,
        "topLeftRound": popupRadius,
        "bottomLeftRound": popupRadius
      },
      {
        "top": 0.0,
        "left": 0.0,
        "right": 0.0,
        "width": double.infinity,
        "bottomLeftRound": popupRadius,
        "bottomRightRound": popupRadius
      },
      {
        "bottom": 0.0,
        "left": 0.0,
        "right": 0.0,
        "width": double.infinity,
        "topLeftRound": popupRadius,
        "topRightRound": popupRadius
      },
      {
        "top": 0.0,
        "left": 0.0,
        "right": 0.0,
        "bottom": 0.0,
        "topLeftRound": popupRadius,
        "topRightRound": popupRadius,
        "bottomLeftRound": popupRadius,
        "bottomRightRound": popupRadius
      }
    ];

    return FPositioned.fromJson(cfg[index]);
  }

  /// 获取icon位置
  FPositioned getIconMargin(int index) {
    /// 相对应的配置 top_left, top_right, bottom_left, bottom_right
    List<Map<String, dynamic>> cfg = [
      {"top": iconMargin, "left": iconMargin},
      {
        "top": iconMargin,
        "right": iconMargin,
      },
      {"bottom": iconMargin, "left": iconMargin},
      {"right": iconMargin, "bottom": iconMargin}
    ];

    return FPositioned.fromJson(cfg[index]);
  }
}

class FPositioned {
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final double? width;
  final double? height;
  final Radius topLeftRound;
  final Radius topRightRound;
  final Radius bottomLeftRound;
  final Radius bottomRightRound;
  FPositioned(
      {this.top,
      this.bottom,
      this.left,
      this.right,
      this.height,
      this.width,
      this.topLeftRound = Radius.zero,
      this.topRightRound = Radius.zero,
      this.bottomLeftRound = Radius.zero,
      this.bottomRightRound = Radius.zero});

  /// 序列化
  FPositioned.fromJson(Map<String, dynamic> json)
      : top = json['top'],
        bottom = json['bottom'],
        right = json['right'],
        left = json['left'],
        width = json['width'],
        height = json['height'],
        topLeftRound = json['topLeftRound'] ??= Radius.zero,
        topRightRound = json['topRightRound'] ??= Radius.zero,
        bottomLeftRound = json['bottomLeftRound'] ??= Radius.zero,
        bottomRightRound = json['bottomRightRound'] ??= Radius.zero;
}
