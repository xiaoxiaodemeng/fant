import 'package:flutter/material.dart';

import 'var.dart';
import '../../theme/var.dart';

class FCellTheme {
  /// Cell的padding值
  EdgeInsetsGeometry get cellPadding => EdgeInsets.symmetric(
        horizontal: cell_horizontal_padding,
      );

  /// Cell的Large状态下的 padding值
  EdgeInsetsGeometry get cellLargePadding => EdgeInsets.symmetric(
        horizontal: cell_horizontal_padding,
      );

  /// Cell的margin值
  EdgeInsetsGeometry get cellMargin =>
      EdgeInsets.symmetric(vertical: cell_vertical_padding);

  /// Cell的Large状态下的 margin值
  EdgeInsetsGeometry get cellLargeMargin =>
      EdgeInsets.symmetric(vertical: cell_large_vertical_padding);

  /// cell 的背景颜色
  Color get cellBackgroundcolor => cell_background_color;

  /// cell 文字主颜色
  Color get cellTextColor => cell_text_color;

  /// cell 右边的文字颜色
  Color get cellValueColor => cell_value_color;

  /// cell 描述的文字颜色
  Color get cellLabelColor => cell_label_color;

  /// cell 主文字大小
  double get cellFontSize => cell_font_size;

  /// cell label文字大小
  double get cellLabelFontSize => cell_label_font_size;

  /// cell label具体title的距离
  double get cellLabelTop => cell_label_margin_top;

  /// cell 主文字大小  大号
  double get cellLargeFontSize => cell_large_title_font_size;

  /// cell label文字大小  大号
  double get cellLargeLabelFontSize => cell_large_label_font_size;

  /// 设定获取大号还是小号的文字
  double getFontSize(bool large) {
    return large ? cellLargeFontSize : cellFontSize;
  }

  /// 设定获取大号还是小号的label
  double getLabelFontSize(bool large) {
    return large ? cellLargeLabelFontSize : cellLabelFontSize;
  }

  /// 高度
  double get cellHeight => cell_height;

  /// ICON的尺寸
  double get cellIconSize => cell_icon_size;

  /// 左边icon和右边icon与其他的间隔
  double get marginSpace => padding_base;

  /// 表单必填星号的颜色
  Color get cellRequiredColor => cell_required_color;

  /// 箭头icon颜色
  Color get cellRightIconColor => cell_right_icon_color;

  /// 获取遮罩颜色层
  Color get baseMark => mark;

  /// 边框颜色
  Color get cellBorderColor => cell_border_color;
}
