import 'package:flutter/material.dart';

import 'theme.dart';

class FCellGroup extends StatelessWidget {
  /// 分组标题
  final String? title;

  /// 分组插槽
  final Widget? titleSlot;

  /// 子组件
  final List<Widget> children;

  /// 是否显示外边框
  final bool border;

  /// 是否展示为圆角卡片风格
  final bool inset;
  FCellGroup(
      {Key? key,
      this.title,
      this.titleSlot,
      this.border = true,
      this.inset = false,
      this.children = const <Widget>[]})
      : super(key: key);

  /// 渲染分组 title
  Widget renderTitle(FCellGroupTheme style) {
    // 默认显示title的值
    Widget temp = Text(
      /// 其实肯定是会显示值的
      /// 存在slot就直接被替换值了
      /// 空字符串只是帽子戏法
      title ?? '',

      style: TextStyle(
          color: style.cellGroupTitleColor,
          fontSize: style.cellGroupTitleFontSize),
    );
    if (titleSlot != null) {
      temp = titleSlot!;
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: style.cellGroupTitlePadding,
      child: temp,
    );
  }

  /// 渲染父组件
  Widget renderGroup(FCellGroupTheme style) {
    return Container(
      margin: inset ? style.cellGrouInsetPadding : null,
      child: ClipRRect(
        /// 圆角形状
        borderRadius: inset
            ? BorderRadius.all(
                Radius.circular(style.cellGroupInsetBorderRadius))
            : BorderRadius.zero,
        child: Container(
          decoration: builderBorder(style),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  /// 渲染border
  BoxDecoration? builderBorder(FCellGroupTheme style) {
    if (border)
      return BoxDecoration(
        color: style.cellGroupBackgroundColor,
        border: inset
            ? null
            : Border(
                top: BorderSide(
                  color: style.cellBorderColor,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: style.cellBorderColor,
                  width: 1,
                ),
              ),
      );
  }

  @override
  Widget build(BuildContext context) {
    FCellGroupTheme theme = FCellGroupTheme();

    if (title != null || titleSlot != null) {
      return Column(
        children: [renderTitle(theme), renderGroup(theme)],
      );
    }

    /// 父组件
    return renderGroup(theme);
  }
}
