import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../theme.dart';

/// https://github.com/jogboms/flutter_spinkit/blob/master/lib/src/ring.dart
class LoadingSpring extends StatefulWidget {
  const LoadingSpring({
    Key? key,
    this.color,
    this.size,
    this.duration,
    this.controller,
  }) : super(key: key);

  /// 颜色
  ///
  /// 默认#c9c9c9
  final Color? color;

  /// 加载图标大小
  ///
  /// 默认30
  final double? size;

  /// 旋转速度
  final Duration? duration;

  /// 修改旋转动画
  final AnimationController? controller;

  @override
  _LoadingSpring createState() => _LoadingSpring();
}

class _LoadingSpring extends State<LoadingSpring>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    /// 样式
    FLoadingTheme theme = FLoadingTheme();
    _controller = (widget.controller ??
        AnimationController(
            vsync: this, duration: widget.duration ?? theme.loadingDuration)
      ..addListener(() => setState(() {}))
      ..repeat());

    /// 有一种动画类型叫 Tween
    /// 它主要是弥补 AnimationController 动画值只能为 double 类型的不足
    /// 所以需要不同类型的变化值，那么就可以使用 Tween

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    /// 旋转角度的长度
    _animation2 = Tween(begin: -2 / 3, end: 1 / 2).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.linear)));

    /// 长度从百分之15到百分之83
    _animation3 = Tween(begin: 0.10, end: 5 / 6).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: SpinKitRingCurve())));
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
    return Center(
      /// 旋转
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ((_animation1.value) * 5 * pi / 6),
        alignment: FractionalOffset.center,
        child: SizedBox.fromSize(
          /// size大小
          size: Size.square(widget.size ?? theme.loadingSize),

          /// 绘制圆
          child: CustomPaint(
            foregroundPainter: RingPainter(
              paintWidth: theme.loadingLineWidth,
              trackColor: widget.color ?? theme.loadingColor,

              /// 全程的不封闭圆长度可变
              progressPercent: _animation3.value,

              /// 角度可变
              startAngle: pi * _animation2.value,
            ),
          ),
        ),
      ),
    );
  }
}

///
/// desc:圆环
///
/// CustomPaint是Flutter中用于自由绘制的一个widget。它与android原生的绘制规则基本一致，以当前Canves(画布)的左上角为原点进行绘制
class RingPainter extends CustomPainter {
  RingPainter({
    required this.paintWidth,
    this.progressPercent,
    this.startAngle,
    required this.trackColor,
  }) : trackPaint = Paint()

          /// 初始化配置 颜色 宽度
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = paintWidth
          ..strokeCap = StrokeCap.round;

  final double paintWidth;
  final Paint trackPaint;

  /// 绘制之言
  final Color trackColor;

  /// 长度
  final double? progressPercent;

  /// 开始的弧度
  final double? startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    /// 获取中心
    final center = Offset(size.width / 2, size.height / 2);

    /// 获取半径
    final radius = (min(size.width, size.height) - paintWidth) / 2;

    /// 绘制一个缩放到适合于给定矩形的弧
    ///
    /// 它从startAngle弧度开始，围绕椭圆一直到[startAngle + sweepAngle环绕椭圆的弧度，弧度为零]
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle!,
      //// 绘制的长度
      2 * pi * progressPercent!,
      //// 如果useCenter为真，弧向中心封闭，形成一个圆形扇形
      ///否则，弧为不闭合，形成一个圆段。
      false,
      trackPaint,
    );
  }

  //// 重载
  ///
  /// 不比较直接进行重新绘制
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// 动画曲线
///
/// 重载transform
class SpinKitRingCurve extends Curve {
  const SpinKitRingCurve();

  @override
  double transform(double t) => (t <= 0.5) ? 2 * t : 2 * (1 - t);
}
