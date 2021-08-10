import 'package:flutter/material.dart';

import 'theme.dart';
import '../icon/theme.dart';
import '../icon/index.dart';

enum ArrowDirection { left, right, up, down }

class FCell extends StatelessWidget {
  /// 左侧标题
  final String? title;

  /// 右侧内容
  final String? value;

  /// 标题下方的描述信息
  final String? label;

  /// 自定义左侧 title 的内容
  ///
  /// 优先级高于title
  final Widget? titleSlot;

  /// 自定义标题下方 label 的内容
  final Widget? labelSlot;

  /// 自定义右侧 value 的内容
  final Widget? valueSlot;

  /// icon的名字
  final IconData? icon;

  /// icon的URL
  final String? url;

  /// 自定义图标
  final Widget? iconSlot;

  /// 是否使用large尺寸
  ///
  /// 增大label title 的字体长度 以及框框的上下padding
  final bool large;

  /// 上下是否居中[是否使内容垂直居中]
  ///
  /// 默认是不居中的是上对齐
  final bool center;

  /// 是否显示表单必填星号
  ///
  /// 默认 [false]
  final bool isRequired;

  /// 是否展示右侧箭头并开启点击反馈
  final bool isLink;

  /// 箭头方向，可选值为 left up down
  ///
  /// 默认right 右箭头
  final ArrowDirection arrowDirection;

  /// 自定义图标右边的图标
  ///
  /// arrowDirection与自定义图标同一方法
  final Widget? rightSlot;

  /// 是否开启点击反馈
  final bool? clickable;

  /// 自定义单元格最右侧的额外内容
  final Widget? extraSlot;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 长按
  final GestureLongPressCallback? onLongPress;

  /// 是否显示内边框
  final bool border;

  final TextStyle? titleStyle;

  FCell(
      {Key? key,
      this.title,
      this.value,
      this.label,
      this.titleSlot,
      this.labelSlot,
      this.large = false,
      this.center = false,
      this.isRequired = false,
      this.isLink = false,
      this.border = true,
      this.titleStyle,
      this.arrowDirection = ArrowDirection.right,
      this.onTap,
      this.onLongPress,
      this.clickable,
      this.rightSlot,
      this.iconSlot,
      this.extraSlot,
      this.icon,
      this.url,
      this.valueSlot})
      : super(key: key);

  /// 是否渲染Title
  bool get isTitle {
    return title != null || titleSlot != null;
  }

  /// 是否渲染value
  bool get isValue {
    return value != null || valueSlot != null;
  }

  /// 是否渲染Label
  bool get isLabel {
    return label != null || labelSlot != null;
  }

  /// 是否渲染icon
  bool get isIcon {
    return icon != null || url != null || iconSlot != null;
  }

  /// 渲染Label
  ///
  ///  需要在外部就判别掉isLabel
  Widget renderLabel(FCellTheme style) {
    // 默认显示label的值
    Widget temp = Text(
      /// 其实肯定是会显示值的
      /// 存在slot就直接被替换值了
      /// 空字符串只是帽子戏法
      label ?? '',
    );
    if (labelSlot != null) {
      temp = labelSlot!;
    }

    return Container(
      margin: EdgeInsets.only(top: style.cellLabelTop),
      child: DefaultTextStyle(
        style: TextStyle(
          color: style.cellLabelColor,
          fontSize: style.getLabelFontSize(large),
        ),
        child: temp,
      ),
    );
  }

  /// 渲染Title
  ///
  /// 需要在外部就判别掉isTitle
  Widget renderTitle(FCellTheme style) {
    // 默认显示title的值
    Widget temp = Text(
      /// 其实肯定是会显示值的
      /// 存在slot就直接被替换值了
      /// 空字符串只是帽子戏法
      title ?? '',
    );
    if (titleSlot != null) {
      temp = titleSlot!;
    }

    return Expanded(
        child: Container(
      constraints: BoxConstraints(minHeight: style.cellHeight),
      alignment: Alignment.topLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 渲染title
        DefaultTextStyle(
          style: titleStyle ??
              TextStyle(
                color: style.cellTextColor,
                fontSize: style.getFontSize(large),
              ),
          child: temp,
        ),
        // 渲染label
        if (isLabel) renderLabel(style)
      ]),
    ));
  }

  /// 渲染Value
  ///
  /// 需要在外部就判别掉isValue
  Widget renderValue(FCellTheme style) {
    // 默认显示value的值
    Widget temp = Text(
      /// 其实肯定是会显示值的
      /// 存在slot就直接被替换值了
      /// 空字符串只是帽子戏法
      value ?? '',
      textAlign: TextAlign.right,
    );
    if (valueSlot != null) {
      temp = valueSlot!;
    }

    /// 单独存在value
    ///
    /// value靠左
    return Expanded(
      child: Container(
          constraints: BoxConstraints(minHeight: style.cellHeight),
          alignment: isTitle ? Alignment.topRight : Alignment.topLeft,
          child: DefaultTextStyle(
            style: TextStyle(
                fontSize: style.getFontSize(large),
                color: isTitle ? style.cellValueColor : style.cellTextColor),
            child: temp,
          )),
    );
  }

  /// 渲染icon
  ///
  /// 需要在外部就判别掉isIcon
  Widget renderLeftIcon(FCellTheme style) {
    // 默认显示icon或者url的icon
    Widget temp = FIcon(
      name: icon,
      url: url,
      size: style.cellIconSize,
    );
    if (valueSlot != null) {
      temp = valueSlot!;
    }

    return Container(
        constraints: BoxConstraints(minHeight: style.cellHeight),
        margin: EdgeInsets.only(right: style.marginSpace),
        child: temp);
  }

  /// 渲染星号
  Widget renderStar(FCellTheme style) {
    return Container(
      constraints: BoxConstraints(minHeight: style.cellHeight),
      child: Text(
        '*',
        style: TextStyle(color: style.cellRequiredColor),
      ),
    );
  }

  /// 渲染右边按钮
  Widget renderRightIcon(FCellTheme style) {
    Map<ArrowDirection, IconData> config = {
      ArrowDirection.right: FantIcon.arrow,
      ArrowDirection.left: FantIcon.arrow_reft,
      ArrowDirection.up: FantIcon.arrow_up,
      ArrowDirection.down: FantIcon.arrow_down
    };

    Widget temp = FIcon(
      name: config[arrowDirection],
      url: url,
      size: style.cellIconSize,
      color: style.cellRightIconColor,
    );

    // 是否自定义按钮区域的插槽了
    if (rightSlot is Widget) {
      temp = rightSlot!;
    }

    return Container(
        constraints: BoxConstraints(minHeight: style.cellHeight),
        margin: EdgeInsets.only(left: style.marginSpace),
        child: temp);
  }

  @override
  Widget build(BuildContext context) {
    /// 是否高亮

    bool isHightColor = false;

    /// 主题
    FCellTheme theme = FCellTheme();
    return Material(
        color: theme.cellBackgroundcolor,

        /// 局部更新小部件
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return InkWell(
              onTap: () {
                /// 取消高亮
                if ((clickable == null && isLink) ||
                    (clickable != null && clickable!)) {
                  setState(() {
                    isHightColor = false;
                  });
                }

                if (onTap is Function()) onTap!();
              },
              onLongPress: onLongPress,
              onTapDown: (TapDownDetails details) {
                /// 高亮
                if ((clickable == null && isLink) ||
                    (clickable != null && clickable!)) {
                  setState(() {
                    isHightColor = true;
                  });
                }
              },
              onTapCancel: () {
                /// 取消高亮
                if ((clickable == null && isLink) ||
                    (clickable != null && clickable!)) {
                  setState(() {
                    isHightColor = false;
                  });
                }
              },

              /// 去除水波纹--太丑了
              splashColor: Colors.transparent,

              /// 去除hover颜色
              hoverColor: Colors.transparent,

              /// 去除高亮---此处的高亮只会在点击之后显示[与预期不符]
              highlightColor: Colors.transparent,
              child: Container(
                padding: large ? theme.cellLargePadding : theme.cellPadding,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isHightColor ? theme.baseMark : null,
                ),
                child: Container(
                  padding: large ? theme.cellLargeMargin : theme.cellMargin,
                  decoration: BoxDecoration(
                    border: border
                        ? BorderDirectional(
                            // top: BorderSide(
                            //     color: theme.cellBorderColor, width: 1),
                            bottom: BorderSide(
                                color: theme.cellBorderColor, width: 1),
                          )
                        : null,
                  ),
                  child: Row(
                    crossAxisAlignment: center
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      if (isRequired) renderStar(theme),
                      if (isIcon) renderLeftIcon(theme),
                      if (isTitle) renderTitle(theme),
                      if (isValue) renderValue(theme),
                      if (rightSlot is Widget || isLink) renderRightIcon(theme),
                      if (extraSlot is Widget) extraSlot!
                    ],
                  ),
                ),
              ));
        }));
  }
}
