import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 学习https://github.com/luckysmg/flutter_swipe_action_cell
///
/// 以及Dismissible组件

/// 0.4~1.0阶段执行变慢运动
const Curve hideTimeCurve = Interval(0.4, 1.0, curve: Curves.ease);

///  Used by [FSwiperCell.onDismissed].
typedef DismissCallback = void Function();

/// Used by [FSwiperCell.confirmDismiss].
typedef ConfirmDismissCallback = Future<bool?> Function();

class FSwiperCell extends StatefulWidget {
  const FSwiperCell(
      {Key? key,
      required this.child,
      this.hideDuration = const Duration(milliseconds: 1000),
      this.moveDuration = const Duration(milliseconds: 1000),
      this.dragStartBehavior = DragStartBehavior.start,
      this.behavior = HitTestBehavior.opaque,
      this.crossAxisEndOffset = 0.0,
      this.closeWhenScrolling = true,
      this.onDismissed,
      this.onResize,
      this.confirmDismiss})
      : super(key: key);

  /// 子组件
  final Widget child;

  /// 被删除的状态下隐藏的动画时间
  final Duration hideDuration;

  /// move移动的动画时间
  final Duration moveDuration;

  /// 最顶最后会停在什么位置
  final double crossAxisEndOffset;

  /// 当你滚动（比如ListView之类的时候，这个item将会关闭拉出的actions，默认为true
  final bool closeWhenScrolling;

  /// 开始拖拽的行为
  ///
  ///  [DragStartBehavior.start]的时候动画是平滑的,开始拖动的时候[不操作down就可以直接拖动起来]
  ///
  ///  [DragStartBehavior.down]需要检测到Down的时候,才开始,拖动行为有点阻力(被动)
  ///
  ///  默认[DragStartBehavior.start]
  final DragStartBehavior dragStartBehavior;

  /// 这个手势检测器在命中测试中应该如何表现。
  final HitTestBehavior behavior;

  /// 当组件被删除,隐藏动画结束后被调用
  final DismissCallback? onDismissed;

  /// 让开发者有机会确认或否决悬而未决的隐藏该widget。
  ///
  /// 如果返回的Future<bool>完成true，则此小部件将被删除
  /// 否则它将被移回原来的位置。
  ///
  /// 如果返回Future<bool?>完成到false或null
  /// [onResize]和[onDismissed]回调函数将不会运行。
  final ConfirmDismissCallback? confirmDismiss;

  /// 当widget改变自身尺寸时调用,其实就是隐藏的过程中
  final VoidCallback? onResize;
  @override
  _FSwiperCell createState() => _FSwiperCell();
}

/// AutomaticKeepAliveClientMixin 保持状态
class _FSwiperCell extends State<FSwiperCell>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// 隐藏的控制器
  AnimationController? _hideController;

  /// 隐藏动画
  Animation<double>? _hideAnimation;

  /// 移动的动画控制器
  AnimationController? _moveController;

  /// 偏移动画
  late Animation<Offset> _moveAnimation;

  /// 标记拖拽开始了没有
  bool _dragUnderway = false;

  /// 拖拽距离
  double _dragExtent = 0.0;

  /// 当前页面滚动位置
  ScrollPosition? scrollPosition;

  @override
  void initState() {
    super.initState();
    _moveController =
        AnimationController(duration: widget.moveDuration, vsync: this)
          ..addStatusListener(_handleDismissStatusChanged);

    /// 更新动画
    _updateMoveAnimation();
  }

  /// 回执开发者选择后续执行方式
  Future<void> _handleDismissStatusChanged(AnimationStatus status) async {
    /// 动画完成以及拖拽结束
    if (status == AnimationStatus.completed && !_dragUnderway) {
      /// 判断用户确认是否关闭隐藏
      ///
      /// 开发者widget.confirmDismiss返回true挥着不存在这个方法就会直接关闭
      if (await _confirmStartHideAnimation() == true)

        /// 执行隐藏动画
        _startHideAnimation();
      else

        /// 回退动画
        _moveController!.reverse();
    }

    /// 更新状态
    updateKeepAlive();
  }

  /// 移除判断是否完成隐藏m
  Future<bool?> _confirmStartHideAnimation() async {
    /// 存在确认关闭的时间
    if (widget.confirmDismiss != null) {
      return widget.confirmDismiss!();
    }

    /// 默认为关闭
    return true;
  }

  /// 更新动画
  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    _moveAnimation = _moveController!.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset(end, widget.crossAxisEndOffset),
      ),
    );
  }

  /// 获取宽度
  double get _overallDragAxisExtent {
    final Size size = context.size!;
    return size.width;
  }

  /// 开始消失动画
  void _startHideAnimation() {
    /// 创建动画
    _hideController =
        AnimationController(duration: widget.hideDuration, vsync: this)
          ..addListener(_handleHideProgressChanged)

          /// 判断 wantKeepAlive可能会改变，调用updateKeepAlive更新一下要保持的状态
          ..addStatusListener((AnimationStatus status) => updateKeepAlive());

    /// 执行隐藏动画
    _hideController!.forward();
    setState(() {
      /// 这是创建动画的一种方式
      _hideAnimation = _hideController!
          .drive(
            CurveTween(
              curve: hideTimeCurve,
            ),
          )
          .drive(
            Tween<double>(
              begin: 1.0,
              end: 0.0,
            ),
          );
    });
  }

  /// 拖拽开始
  void _handleDragStart(DragStartDetails details) {
    print(details);

    /// 标记拖拽
    _dragUnderway = true;

    /// 判断动画开始了没有
    if (_moveController!.isAnimating) {
      print(12312);

      /// 标记拖拽的信息
      ///
      /// 动画的系数*宽度*根据_dragExtent的正负来返回+1/-1==>保证最后的正的
      _dragExtent =
          _moveController!.value * _overallDragAxisExtent * _dragExtent.sign;

      /// 暂停动画
      _moveController!.stop();
    } else {
      _dragExtent = 0.0;
      _moveController!.value = 0.0;
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  /// 拖动过程中
  void _handleDragUpdate(DragUpdateDetails details) {
    print(3123);

    /// 自上次更新以来，指针在事件接收者的坐标空间中沿主轴移动的量
    final double delta = details.primaryDelta!;

    /// 上一次的距离
    final double oldDragExtent = _dragExtent;

    /// 标记结束的位置
    _dragExtent += delta;

    /// 判断上一次的和这一次相同
    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
      });
    }

    /// 移动动画状态下
    if (!_moveController!.isAnimating) {
      /// 直接复制动画
      _moveController!.value = _dragExtent.abs() / _overallDragAxisExtent;
    }
  }

  /// 拖动结束
  void _handleDragEnd(DragEndDetails details) async {}

  /// 监听隐藏动画的进度变化回调
  void _handleHideProgressChanged() {
    if (_hideController!.isCompleted) {
      /// 关闭时触发回调
      widget.onDismissed?.call();
    } else {
      widget.onResize?.call();
    }
  }

  /// 监听滚动
  void _addScrollListener() {
    /// 滚动需要关闭action的时候
    if (widget.closeWhenScrolling) {
      /// 标记当前的滚动位置
      ///
      /// 这个[滚动]widget的视口位置的管理器。
      scrollPosition = Scrollable.of(context)?.position;
      scrollPosition?.isScrollingNotifier.addListener(_scrollListener);
    }
  }

  /// 滚动监听的事件--还需要那这个取消监听
  void _scrollListener() {
    /// 滚动的时候
    ///
    /// 如果滚动正在进行，则该isScrollingNotifier的值为true;如果滚动位置为空闲，则该通知符的值为false。
    ///
    /// [State.dispose] 记得移除
    if ((scrollPosition?.isScrollingNotifier.value ?? false)) {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.

    /// _hideAnimation不等于null的时候代表删除动画被触发
    if (_hideAnimation != null) {
      /// 尺寸控制
      ///
      /// 当被删除之后组件高度会变小
      return SizeTransition(
        sizeFactor: _hideAnimation!,
        child: widget.child,
      );
    }

    Widget content = SlideTransition(
      position: _moveAnimation,
      child: widget.child,
    );

    /// 拖拽手势
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: widget.behavior,
      child: content,

      /// 拖拽行为
      dragStartBehavior: widget.dragStartBehavior,
    );
  }

  /// 动画状态下保持状态
  @override
  bool get wantKeepAlive => true;
}
