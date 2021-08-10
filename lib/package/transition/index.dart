import 'package:flutter/widgets.dart';

import 'theme.dart';

enum TransitionType { fade, slideUp, slideDown, slideLeft, slideRight, scale }

/// 内部官方的动画组件
/// - AnimatedPhysicalModel AnimatedDefaultTextStyle SliverAnimatedOpacity
/// - AnimatedOpacity AnimatedPositionedDirectional AnimatedPositioned
/// - AnimatedAlign AnimatedPadding AnimatedContainer
/// 内部官方过渡组价
/// - AnimatedBuilder PositionedTransition DefaultTextStyleTransition
/// - AlignTransition DecoratedBoxTransition RelativePositionedTransition
/// - SliverFadeTransition FadeTransition SizeTransition
/// - RotationTransition ScaleTransition SlideTransition
///
/// 这里是过渡动画
class FTransition extends StatefulWidget {
  FTransition(
      {Key? key,
      required this.child,
      this.name,
      this.show = true,
      this.transition,
      this.duration})
      : super(key: key);

  /// 过渡的类型
  ///
  /// 可以是null
  final TransitionType? name;

  /// 子组件
  final Widget child;

  /// 显示隐藏
  final bool show;

  /// 动画的时间
  final Duration? duration;

  /// 过渡动画
  final Cubic? transition;

  @override
  _FTransition createState() => _FTransition();
}

class _FTransition extends State<FTransition> with TickerProviderStateMixin {
  /// 逻辑动画控制器
  late AnimationController _controller;

  /// 动画的载体--进入
  late Animation<double> enter;

  /// 动画的载体--出去
  late Animation<double> leave;

  /// 标记比较
  bool _show = false;

  @override
  void initState() {
    super.initState();

    /// 不需要动画
    if (widget.name == null) {
      _show = widget.show;
      return;
    }
    initTransition();
  }

  /// 初始话
  void initTransition() {
    FTransitionTheme theme = FTransitionTheme();

    /// 控制器
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? theme.duration);

    /// 新增进入动画曲线
    final CurvedAnimation curveEnter = new CurvedAnimation(
        parent: _controller, curve: widget.transition ?? theme.enter);

    /// 新增离开动画曲线
    final CurvedAnimation curveLeave = new CurvedAnimation(
        parent: _controller, curve: widget.transition ?? theme.leave);

    leave = Tween(begin: 0.0, end: 1.0).animate(curveEnter)
      ..addListener(() {
        if (this.mounted)
          setState(() {
            // the state that has changed here is the animation object’s value
          });
      });

    enter = Tween(begin: 0.0, end: 1.0).animate(curveLeave)
      ..addListener(() {
        if (this.mounted)
          setState(() {
            // the state that has changed here is the animation object’s value
          });
      });
  }

  @override
  void didUpdateWidget(covariant FTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    /// 存在动画
    if (widget.name != null) {
      _controller.dispose();
    }

    super.dispose();
  }

  /// translationValues 平移量
  ///
  /// https://www.imooc.com/article/286924
  Matrix4 getTranslation(double value) {
    /// 数值其实可以代表速度 大代表需要更快的速度才能到达  小的话就可以慢点
    switch (widget.name) {
      case TransitionType.slideDown:
        return Matrix4.translationValues(0.0, -value * 300, 0.0);
      case TransitionType.slideUp:
        return Matrix4.translationValues(0.0, value * 300, 0.0);
      case TransitionType.slideLeft:
        return Matrix4.translationValues(value * 300, 0.0, 0.0);
      case TransitionType.slideRight:
        return Matrix4.translationValues(-value * 300, 0.0, 0.0);
      case TransitionType.scale:
        return Matrix4.identity()..scale(value + 1, value + 1, 1.0);
      default:

        /// 直接显示
        return Matrix4.diagonal3Values(1.0, 1.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name == null) {
      return widget.child;
    } else {
      /// 控制显示还是隐藏
      ///
      /// 这一套逻辑对整个不同的动画都生效
      if (widget.show && !_show) {
        _controller.forward();
        _show = true;
      } else if (!widget.show && _show) {
        _controller.reverse();
        _show = false;
      }
    }

    FTransitionTheme theme = FTransitionTheme();

    Widget child = widget.child;

    if (widget.name != TransitionType.fade) {
      Cubic transition =
          widget.transition ?? (widget.show ? theme.enter : theme.leave);

      /// 动画
      final curvedValue =
          transition.transform((widget.show ? enter : leave).value) - 1.0;
      child = Transform(
        alignment: Alignment.center,
        transform: getTranslation(curvedValue),
        child: widget.child,
      );
    } else if (widget.name == TransitionType.fade) {
      child = FadeTransition(
        opacity: widget.show ? enter : leave,
        child: widget.child,
      );
    }

    /// 渲染
    return child;
  }
}
