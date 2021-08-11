import 'package:flutter/material.dart';

import 'theme.dart';

class FBadge extends StatefulWidget {
  /// 自定义徽标内容
  final Widget? content;

  /// 子组件 角标就是挂在子组件上的
  final Widget? child;

  /// 角标的内容类型是字符串
  ///
  /// 优先级高于 number
  final String? text;

  /// 角标的内容的int类型
  ///
  /// 优先级低于text
  ///
  /// dart不存在联合类型所以这一块逻辑拆分
  final int? number;

  /// 角标包括红点的颜色
  final Color? color;

  /// 是否显示红点
  ///
  /// 优先级高于内容的显示
  final bool dot;

  /// 当存在number的时候[可显示number]
  ///
  /// 比较number,数值大于max将显示{max}+
  final int? max;

  /// 当 number 为数字 0 时，是否展示徽标
  final bool showZero;

  /// 偏移
  ///
  /// 设置徽标的偏移量，数组的两项分别对应水平和垂直方向的偏移量
  final List<num?> offset;

  /// child 布局类型
  ///
  /// 此参数决定如何去对齐没有定位（没有使用Positioned）或部分定位的子组件
  final AlignmentGeometry? alignment;

  FBadge(
      {Key? key,
      this.content,
      this.child,
      this.text,
      this.number,
      this.color,
      this.dot = false,
      this.max,
      this.showZero = true,
      this.alignment,
      this.offset = const [0, 0]})
      : super(key: key);

  @override
  _FBadge createState() => _FBadge();
}

class _FBadge extends State<FBadge> {
  /// 可以获取子组件或者徽标的宽度
  final GlobalKey widgetKey = GlobalKey();

  late double widgetWidth = 0;

  /// 判断是否需要显示内容
  bool get hasContent {
    /// 自定义的content存在---就直接显示
    if (widget.content is Widget) {
      return true;
    }

    /// 首先text存在  且不为空的时候
    ///
    /// 中间的逻辑是或者---存在一个合理就可以显示
    ///
    /// 然后number存在 可显示0 或者number不是0的时候
    return isText || isNumber;
  }

  /// 当前是否可显示text角标内容
  bool get isText {
    return widget.text != null && widget.text != '';
  }

  /// 当前是否可显示number角标内容
  bool get isNumber {
    return (widget.number != null && (widget.showZero || widget.number != 0));
  }

  /// 渲染内容
  ///
  /// text + number
  Widget _renderContent(FBadgeTheme style) {
    String temp = '';
    // 红点优先级高
    // 不显示红点的时候以及存在内容
    if (!widget.dot && hasContent) {
      // 先判断child是否存在
      if (widget.content is Widget) {
        // 断言一下
        return widget.content!;
      }

      if (isNumber) {
        temp = widget.number.toString();
        if (widget.max != null && !isText && widget.number! > widget.max!) {
          temp = '${widget.max}+';
        }
      }

      if (isText) {
        temp = widget.text!;
      }

      return Center(
          child: Text(temp,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: style.badgeColor,
                  fontSize: style.badgeFontSize,
                  fontWeight: style.badgeFontWeight)));
    }

    return Container();
  }

  /// 这一块判断dot渲染
  ///
  /// 或者 text 或者 number渲染
  Widget renderBadge(FBadgeTheme style) {
    if (hasContent && !widget.dot) {
      return Container(
        key: widgetKey,
        padding: style.badgePadding,
        constraints: BoxConstraints(
          minWidth: style.badgeSize,
          minHeight: style.badgeSize,
        ),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(style.borderRoundRadius)),
            color: widget.color ?? style.badgeBackgroundColor),
        child: _renderContent(style),
      );
    }

    return Container(width: 0, height: 0);
  }

  /// 渲染红点
  Widget renderDot(FBadgeTheme style) {
    if (widget.dot) {
      return Container(
          width: style.badgeDotSize,
          height: style.badgeDotSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(style.badgeDotSize)),
            color: style.badgeDotColor,
          ));
    }
    return Container();
  }

  void refresh() {
    /// 获取宽度
    if (!widget.dot && hasContent) {
      Future.delayed(Duration.zero, () {
        if (mounted)
          setState(() {
            widgetWidth = widgetKey.currentContext!.size!.width;
          });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  void didUpdateWidget(FBadge oldWidget) {
    super.didUpdateWidget(oldWidget);

    refresh();
  }

  /// 水平偏移量
  num get offsetX {
    return widget.offset.length == 1 ? widget.offset[0]! : 0;
  }

  /// 垂直偏移量
  num get offsetY {
    return widget.offset.length == 2 ? widget.offset[1]! : 0;
  }

  @override
  Widget build(BuildContext context) {
    FBadgeTheme theme = FBadgeTheme();

    // 层叠组件

    /// wrap column 可自阻止Container 宽度撑满
    return UnconstrainedBox(
        child: Stack(
      clipBehavior: Clip.none,
      alignment: widget.alignment ?? AlignmentDirectional.center,
      children: <Widget>[
        /// 子组件
        widget.child ?? Container(width: 0, height: 0),
        // dot 红点
        Positioned(
            right: (-theme.badgeDotSize / 2) + offsetX,
            top: -theme.badgeDotSize / 2 + offsetY,
            child: renderDot(theme)),

        /// 徽标
        Positioned(
            right: -widgetWidth / 2 + offsetX,
            top: -theme.badgeSize / 2 + offsetY,
            child: renderBadge(theme))
      ],
    ));
  }
}
