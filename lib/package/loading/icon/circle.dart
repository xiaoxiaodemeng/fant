import 'package:flutter/widgets.dart';
import 'dart:math';

import '../theme.dart';

class LoadingCircle extends StatefulWidget {
  const LoadingCircle({
    Key? key,
    this.color,
    this.size,
    this.duration,
    this.controller,
  }) : super(key: key);

  final Color? color;
  final double? size;
  final Duration? duration;
  final AnimationController? controller;

  @override
  _LoadingCircle createState() => _LoadingCircle();
}

class _LoadingCircle extends State<LoadingCircle>
    with SingleTickerProviderStateMixin {
  //// 定义每个阶段的延迟数值
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    /// 样式
    FLoadingTheme theme = FLoadingTheme();
    _controller = (widget.controller ??
        AnimationController(
            vsync: this, duration: widget.duration ?? theme.loadingDuration))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 样式
    FLoadingTheme theme = FLoadingTheme();

    double size = widget.size ?? theme.loadingSize;
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size ?? theme.loadingSize),
        child: Stack(
          children: List.generate(delays.length, (i) {
            final _position = size * .5;
            return Positioned.fill(
              left: _position,
              top: _position,
              child: Transform(
                /// 间隔
                transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                child: Align(
                  alignment: Alignment.center,

                  /// Size 变小
                  child: ScaleTransition(
                    /// 越来越小
                    scale: DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                        .animate(_controller),
                    child: SizedBox.fromSize(
                        size: Size.square(size * 0.15), child: _itemBuilder(i)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// 可自定义
  Widget _itemBuilder(int index) {
    /// 样式
    FLoadingTheme theme = FLoadingTheme();
    return DecoratedBox(
        decoration: BoxDecoration(
            color: widget.color ?? theme.loadingColor, shape: BoxShape.circle));
  }
}

/// 继承
///
/// 延迟动画
class DelayTween extends Tween<double> {
  /// begin 和 end 直接继承
  ///
  /// 新增delay参数
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  final double delay;

  /// 重载各个动画过程中返回相对应的数值
  ///
  /// 举个例子 -1  返回   1     1 返回  -1  这种逆向
  @override
  double lerp(double t) => super.lerp((sin((t - delay) * 2 * pi) + 1) / 2);

  /// 给定[Animation]对象的当前值。
  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
