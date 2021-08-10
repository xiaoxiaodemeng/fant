import 'package:fant/package/icon/index.dart';
import 'package:fant/package/icon/theme.dart';

import 'package:flutter/material.dart';

import 'theme.dart';
import '../transition/index.dart';

/// 标签的类型
enum FTagType { defaultType, primary, success, warning, danger }

/// 标签的大小
enum FTagSize { large, medium }

/// 标记是在左边还是右边
enum FMaskPosition { left, right }

class FTag extends StatelessWidget {
  const FTag(
      {Key? key,
      this.data,
      this.type = FTagType.defaultType,
      this.size,
      this.color,
      this.show,
      this.plain = false,
      this.round = false,
      this.mark = false,
      this.textColor,
      this.closeable = false,
      this.onClick,
      this.onClose,
      this.child,
      this.maskPosition = FMaskPosition.left})
      : assert(data != null || child != null, 'data和child不能同时为null,这是无意义的'),
        super(key: key);

  /// 文本
  final String? data;

  /// tag标签的类型
  final FTagType type;

  /// tag标签的大小
  final FTagSize? size;

  /// tag标签颜色
  ///
  /// 背景颜色---不支持渐变
  final Color? color;

  /// tag标签控制是否隐藏显示标签
  final bool? show;

  /// tag标签是否为空心样式
  final bool plain;

  /// tag标签是否为圆角样式
  final bool round;

  /// tag标签是否为标记样式
  ///
  /// 左部分的不是圆角是直角
  final bool mark;

  /// 文本颜色，优先级高于 color 属性
  ///
  /// 默认白色
  final Color? textColor;

  /// 是否为可关闭标签
  ///
  /// closeable开启会出现一个×的icon以及onClose回调
  final bool closeable;

  /// 标记是在左边还是右边
  ///
  /// 默认左边
  final FMaskPosition maskPosition;

  /// 点击关闭按钮的回调方法
  final Function()? onClose;

  /// 点击标签
  final Function()? onClick;

  /// 默认替换文本的插槽
  final Widget? child;

  /// 获取圆角
  BorderRadiusGeometry get borderRadius {
    FTagTheme theme = FTagTheme();
    double tagRadius = 0;

    /// 获取mask左右边的圆角
    BorderRadius getOnlyRadius(double radius, FMaskPosition position) {
      if (position == FMaskPosition.left) {
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      }

      return BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      );
    }

    /// 圆的--优先级高于大标签的
    if (round) {
      tagRadius = theme.tagRoundBorderRadius;
    }

    /// 大标签
    if (size == FTagSize.large) {
      tagRadius = theme.tagLargeBorderRadius;
    }

    /// 默认
    tagRadius = theme.tagBorderRadius;

    return mark
        ? getOnlyRadius(theme.tagRoundBorderRadius, maskPosition)
        : BorderRadius.all(Radius.circular(tagRadius));
  }

  /// 文字颜色
  ///
  /// textColor
  Color? getFontColor(FTagTheme style) {
    Color? txtColor = style.textColor;

    /// textColor高于朴素状态下颜色调整
    ///
    /// color不能修改plain状态下的颜色
    ///
    /// 不是朴素状态下都是白色
    if (plain) {
      txtColor = style.getTagStyle(type).plainColor;

      /// 朴素--颜色可改
      ///
      /// 高于系统默认的类型下的颜色
      if (color is Color) {
        txtColor = color;
      }
    }

    /// 文本颜色，优先级高于 color 属性
    if (textColor is Color) {
      txtColor = textColor!;
    }

    return txtColor;
  }

  /// 获取边框颜色
  Color getBorderColor(FTagTheme style) {
    Color borderColor = style.textColor;

    /// 朴素状态下系统颜色
    ///
    /// 否者是不存在边框的
    if (plain) {
      borderColor = style.getTagStyle(type).backgroundColor;
    }

    /// 文本颜色,不存在color会进行覆盖
    if (textColor is Color) {
      borderColor = textColor!;
    }

    if (color is Color) {
      borderColor = color!;
    }

    return borderColor;
  }

  Widget renderTag(FTagTheme style) {
    Widget closeIcon() {
      return GestureDetector(
          onTap: onClose,
          child: Container(
            margin: EdgeInsets.only(left: style.spaceDistance),
            child: FIcon(
              name: FantIcon.cross,
              color: getFontColor(style),
            ),
          ));
    }

    return DefaultTextStyle(
      style: TextStyle(
          fontSize:
              size == FTagSize.large ? style.tagBigFontSize : style.tagFontSize,
          color: getFontColor(style)),
      child: Row(
        children: [
          Container(
            padding: style.getSizePadding(size),
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: plain
                    ? style.plainBackground
                    : color is Color
                        ? color
                        : style.getTagStyle(type).backgroundColor,
                border: Border.all(
                    color: getBorderColor(style), width: style.tagBorderWidth)),
            child: Row(
              children: [
                /// 往左扩充点
                if (mark && maskPosition == FMaskPosition.right)
                  Container(width: style.spaceDistance),

                data is String
                    ? Text(
                        data!,
                      )
                    : child!,
                if (closeable) closeIcon(),

                /// 往右扩充点
                if (mark && maskPosition == FMaskPosition.left)
                  Container(width: style.spaceDistance)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FTagTheme theme = FTagTheme();

    Widget temp = GestureDetector(onTap: onClick, child: renderTag(theme));

    return show != null
        ? FTransition(
            show: show!,
            duration: Duration(milliseconds: 200),
            name: TransitionType.fade,
            child: temp,
          )
        : temp;
  }
}
