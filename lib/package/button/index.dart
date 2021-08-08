import 'package:flutter/material.dart';
import 'theme.dart';
import '../icon/index.dart';
import '../loading/index.dart';

enum IconPosition { left, right }

/// 按钮类型
enum FButtonType { defaultType, primary, success, warning, danger }

/// 按钮大小
enum FButtonSize { large, normal, small, mini }

/// 点击态
enum FTapState { splash, highlighted }

/// 存在问题 type==="large"且父组件是Row容器，将会存在得不到最大宽度的问题，
/// 因此需要开发者手动加一层Expanded或者指定宽度
class FButton extends StatelessWidget {
  /// 按钮需要显示的文本
  final String data;

  /// 按钮类型
  ///
  /// - primary
  ///
  /// - success
  ///
  /// - warning
  ///
  /// - danger
  ///
  /// - defaultType
  ///
  /// 默认 [default]
  final FButtonType type;

  /// 按钮大小
  ///
  /// - large
  ///
  /// - normal
  ///
  /// - small
  ///
  /// - mini
  ///
  /// 默认 [normal]
  final FButtonSize size;

  /// 按钮颜色
  final Color? color;

  /// 渐变颜色
  final Gradient? gradient;

  /// 阴影
  final double elevation;

  /// 是否显示为加载状态
  ///
  /// 默认false
  final bool loading;

  /// 是否显示为加载状态
  final String loadingText;

  /// 是否为朴素按钮
  ///
  /// 默认false
  final bool plain;

  /// 子组件--会覆盖的this.data文本显示
  final Widget? child;

  /// 是否为块级元素
  ///
  /// 默认false
  final bool block;

  /// 是否为方形按钮
  ///
  /// 默认false
  final bool square;

  /// 是否为圆形按钮
  ///
  /// 默认false
  final bool round;

  /// 是否禁用
  final bool disabled;

  /// 是否使用 0.5 边框[其实就是一半]
  final bool hairline;

  /// loading的插槽
  final Widget? loadingSlot;

  /// loading的类型
  final LoadingType loadingType;

  /// loading的加载图标大小
  final double loadingSize;

  /// icon的名字
  final IconData? icon;

  /// icon的URL
  final String? url;

  /// icon 的位置
  ///
  /// [left]  以及  [right]
  final IconPosition iconPosition;

  /// 自定义icon插槽
  final Widget? iconSlot;

  /// 水波纹[飞溅] 与  高亮切换[自制]
  final FTapState switchActive;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 双击
  final GestureTapCallback? onDoubleTap;

  /// 长按
  final GestureLongPressCallback? onLongPress;

  /// 按下
  final GestureTapDownCallback? onTapDown;

  /// 按下被取消
  final GestureTapCancelCallback? onTapCancel;
  FButton(this.data,
      {Key? key,
      this.type = FButtonType.defaultType,
      this.size = FButtonSize.normal,
      this.loading = false,
      this.loadingText = "",
      this.color,
      this.onTap,
      this.onDoubleTap,
      this.onLongPress,
      this.onTapDown,
      this.onTapCancel,
      this.block = false,
      this.plain = false,
      this.square = false,
      this.round = false,
      this.disabled = false,
      this.loadingSize = 20,
      this.loadingType = LoadingType.circular,
      this.iconPosition = IconPosition.left,
      this.switchActive = FTapState.highlighted,
      this.elevation = 0.0,
      this.icon,
      this.iconSlot,
      this.url,
      this.gradient,
      this.hairline = false,
      this.loadingSlot,
      this.child})
      : super(key: key);

  /// 渲染文本
  Widget _renderText(FButtonTheme style) {
    /// 文本
    dynamic textTemp = "";
    if (loading) {
      /// 显示loading
      ///
      /// loadingText默认空
      textTemp = loadingText;
    } else {
      /// 这边存在一个区别
      ///
      /// web端css 颜色会继承父元素---flutter不存在这个概念
      textTemp = child is Widget ? child : this.data;
    }

    /// 判断赋值之后的textTemp类型
    if (textTemp is String) {
      return Container(
          margin: textSpace(style),
          child: Text(
            textTemp,
            style: TextStyle(
                height: null,
                fontSize: style.shapeStyle(size).fontSize,

                /// 存在color颜色代表 背景被替换
                color:
                    plain ? getStyle(style).plainColor : getStyle(style).color),
          ));
    } else {
      return Container(margin: textSpace(style), child: textTemp);
    }
  }

  /// plain 属性 修改了属性
  FButtonStyle getStyle(FButtonTheme style) {
    FButtonStyle theme = style.getButtonStyle(type);

    if (color is Color) {
      Map<String, dynamic> style = theme
          .copyWith(

              /// 字体颜色 存在自定义颜色
              ///
              /// 判断是朴素的---就把字体颜色被自定义颜色替换 否则就就白色
              ///
              /// 不能是渐变颜色
              color: plain ? color : Colors.white)
          .toJson();

      /// 不是朴素的类型
      ///
      /// 自定义颜色直接替换背景颜色
      if (!plain) {
        // 使用背景色而不是背景色来进行线性渐变
        style['backgroundColor'] = color;
      } else {
        /// 朴素
        style['plainColor'] = color;
      }

      // 当颜色是渐变就隐藏border
      if (gradient is Gradient) {
        style['borderWidth'] = 0.0;
      } else {
        style['borderColor'] = color;
      }

      return FButtonStyle.fromJson(style);
    }

    if (gradient is Gradient && color == null) {
      Map<String, dynamic> style = theme
          .copyWith(

              /// 不能是渐变颜色
              color: Colors.white)
          .toJson();

      style['borderWidth'] = 0.0;

      return FButtonStyle.fromJson(style);
    }

    return theme;
  }

  /// 渲染loading 图标
  Widget _renderLoadingIcon(FButtonTheme style) {
    if (loadingSlot is Widget) {
      return loadingSlot!;
    }

    return FLoading(
        size: loadingSize,
        type: loadingType,
        color: plain ? getStyle(style).plainColor : getStyle(style).color);
  }

  /// 渲染图标
  Widget _renderIcon(FButtonTheme style) {
    if (loading) {
      return _renderLoadingIcon(style);
    }

    if (iconSlot is Widget) {
      return iconSlot!;
    }

    if (icon is IconData || url is String) {
      return FIcon(
        name: icon,
        url: url,
        color: plain ? getStyle(style).plainColor : getStyle(style).color,
      );
    }

    return Container();
  }

  /// 存在icon 或者 loading
  ///
  /// 左边 以及 右边的条件给margin left  right
  ///
  /// 样式提供给text
  EdgeInsetsGeometry? textSpace(FButtonTheme style) {
    /// 存在icon  或者loading
    if (isIcon) {
      if (iconPosition == IconPosition.left) {
        // 提供左边的margin
        return EdgeInsets.only(left: style.baseSpace);
      } else {
        return EdgeInsets.only(right: style.baseSpace);
      }
    }
  }

  /// 判断是否存在icon
  bool get isIcon {
    if (loading) {
      if (loadingText.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }

    if ((icon != null || url != null) && (data.isNotEmpty || child is Widget)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    /// 是否高亮

    bool isHightColor = false;

    /// 样式
    FButtonTheme theme = FButtonTheme();

    // 禁用利用 Opacity
    // ListView 宽度占满逻辑是正常的--可以看自带的ElevatedButton 按钮组件
    return Opacity(
        opacity: disabled ? theme.disabledOpacity : 1,

        /// 点击
        child: Material(
            elevation: elevation,

            /// 朴素的时候使用 plainBackgroundColor
            color: plain
                ? getStyle(theme).plainBackgroundColor
                : getStyle(theme).backgroundColor,

            /// 设置形状
            shape: RoundedRectangleBorder(
                side: BorderSide.none,

                /// 圆角形状
                borderRadius: square
                    ? BorderRadius.zero
                    : BorderRadius.all(Radius.circular(
                        round ? theme.borderRoundRadius : theme.borderRadius))),
            type: plain ? MaterialType.transparency : MaterialType.button,

            /// 剪切掉shape以外的部分
            clipBehavior: Clip.hardEdge,

            /// 局部更新小部件
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return InkWell(
                onTap: () {
                  /// 取消高亮
                  if (switchActive == FTapState.highlighted) {
                    setState(() {
                      isHightColor = false;
                    });
                  }

                  if (loading) {
                    return;
                  } else if (!disabled) {
                    if (onTap is Function()) onTap!();
                  }
                },
                onLongPress: onLongPress,
                onTapDown: (TapDownDetails details) {
                  /// 高亮
                  if (switchActive == FTapState.highlighted) {
                    setState(() {
                      isHightColor = true;
                    });
                  }
                  if (onTapDown is Function(TapDownDetails))
                    onTapDown!(details);
                },

                onTapCancel: () {
                  /// 取消高亮
                  if (switchActive == FTapState.highlighted) {
                    setState(() {
                      isHightColor = false;
                    });
                  }
                  if (onTapCancel is Function()) onTapCancel!();
                },

                /// 禁用状态下也不显示
                splashColor: switchActive == FTapState.splash && !disabled
                    ? null
                    : Colors.transparent,

                /// 去除hover颜色
                hoverColor: Colors.transparent,

                /// 去除高亮---此处的高亮只会在点击之后显示[与预期不符]
                highlightColor: Colors.transparent,
                splashFactory: InkRipple.splashFactory,

                /// 形体 + 样式
                child: Container(
                  height: theme.shapeStyle(size).height,
                  padding: theme.shapeStyle(size).padding,

                  /// 边框 + 渐变
                  ///
                  /// 装饰容器DecoratedBox
                  decoration: BoxDecoration(
                      color: switchActive == FTapState.highlighted &&
                              isHightColor &&
                              !disabled
                          ? theme.baseMark
                          : null,
                      gradient: gradient,
                      borderRadius: square
                          ? BorderRadius.zero
                          : BorderRadius.all(Radius.circular(round
                              ? theme.borderRoundRadius
                              : theme.borderRadius)),
                      border: Border.all(
                          color: getStyle(theme).borderColor,
                          width: hairline
                              ? getStyle(theme).borderWidth / 2
                              : getStyle(theme).borderWidth)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    /// MainAxisSize.max 占满主轴
                    mainAxisSize:
                        size.toString() == 'FButtonSize.large' || block
                            ? MainAxisSize.max
                            : MainAxisSize.min,
                    children: <Widget>[
                      if (iconPosition == IconPosition.left) _renderIcon(theme),
                      _renderText(theme),
                      if (iconPosition == IconPosition.right)
                        _renderIcon(theme),
                    ],
                  ),
                ),
              );
            })));
  }
}
// 0xFF000000
// 00%=FF（不透明）
// 5%=F2
// 10%=E5
// 15%=D8
// 20%=CC
// 25%=BF
// 30%=B2
// 35%=A5
// 40%=99
// 45%=8c
// 50%=7F
// 55%=72
// 60%=66
// 65%=59
// 70%=4c
// 75%=3F
// 80%=33
// 85%=21
// 90%=19
// 95%=0c
// 100%=00（全透明）
