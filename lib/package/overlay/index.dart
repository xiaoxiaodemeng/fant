import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';

import '../transition/index.dart';

/// 提供Overlay 模式
///
/// 也提供覆盖widget模式, 但是必须提供container容器[存在尺寸]----会渲染container组件在原地
/// 他不像H5那样div--fixed撑达到relative组件下的尺寸,以至于flutterb必须提供相对应的组件告诉自定义的overlay他需要撑多大
///
/// 对于自定义的做不到禁止页面滚动的需求，需要开发者通过判断show赋值滚动组件不同的类型
class FOverlay extends StatefulWidget {
  FOverlay(this.context,
      {Key? key,
      required this.show,
      this.color,
      this.colorOpacity,
      this.child,
      this.alignment = Alignment.center,
      this.duration = const Duration(milliseconds: 300),
      this.isCustom = false,
      this.container,
      this.onBackdropPress})
      : assert(!isCustom || (isCustom && container != null),
            '自定义组件container必须不能为空'),
        super(key: key);

  /// 当前组件的context
  ///
  /// 必要的
  final BuildContext context;

  /// 是否显示遮罩
  final bool show;

  /// 背景颜色
  final Color? color;

  /// 颜色透明度
  final double? colorOpacity;

  /// 子组件
  ///
  /// 可以使用Positioned组件
  final Widget? child;

  /// 组件对齐方式
  ///
  /// 默认居中Alignment.center
  final AlignmentGeometry alignment;

  /// 点击遮罩的回调事件
  ///
  /// 需要点击遮罩关闭弹框，可以在这里调用关闭
  final PointerUpEventListener? onBackdropPress;

  /// 不采用Overlay模块---不放置到所有widget顶层
  ///
  /// 默认是false--[放置到所有widget顶层]
  final bool isCustom;

  /// 操作的部分组件
  ///
  /// ---吧Overlay当做一个容器
  ///
  /// 可以使用Positioned组件
  final Widget? container;

  /// 动画时间
  final Duration duration;

  @override
  _FOverlay createState() => _FOverlay();
}

class _FOverlay extends State<FOverlay> with SingleTickerProviderStateMixin {
  bool _show = false;

  /// 操作对象
  OverlayEntry? holder;

  @override
  void initState() {
    super.initState();

    if (widget.show) {
      /// setState() or markNeedsBuild() called during build.错误解决办法
      ///
      /// 延时加载Future.delayed(Duration(milliseconds: 0), () => {open()});
      ///
      Future.delayed(Duration.zero, () => {open()});
    }
    if (widget.isCustom) {
      _show = widget.show;
      return;
    }
  }

  @override
  void didUpdateWidget(FOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show && !oldWidget.show) {
      // 当前为true , 老状态为false
      open();
    } else if (!widget.show && oldWidget.show) {
      // 新状态false , 老状态为true
      close();
    }

    if (widget.isCustom) {
      return;
    }

    /// 底下是顶层Overlay判断

    /// 单纯就修改文本这种方法不行
    if (widget.child.runtimeType != oldWidget.child.runtimeType ||
        (oldWidget.child?.key == widget.child?.key)) {
      refresh();
    }
  }

  /// [builder]的输出发生变化，可以调用这个函数。
  ///
  /// 刷新child组件
  void refresh() {
    if (holder != null)
      Future.delayed(Duration.zero, () => {holder!.markNeedsBuild()});
  }

  void open() {
    if (widget.isCustom && !_show) {
      setState(() {
        _show = true;
      });
    }

    /// 不自定义的时候
    if (!widget.isCustom && holder == null) {
      /// 底下是顶层Overlay判断

      init();
    }

    /// 不启用自定义的时候
    if (holder != null && !widget.isCustom)
      Future.delayed(
          Duration.zero, () => {Overlay.of(context)!.insert(holder!)});
  }

  void close() {
    if (widget.isCustom && _show) {
      Future.delayed(
          widget.duration,
          () => {
                /// 比喵被dispose
                if (this.mounted)
                  {
                    setState(() {
                      _show = false;
                    })
                  }
              });
    }

    /// 不启用自定义的时候
    if (holder != null && !widget.isCustom) {
      Future.delayed(widget.duration, () {
        holder!.remove();
        holder = null;
      });
    }
  }

  /// 遮罩组件
  Widget overlay() {
    FOverlayTheme theme = FOverlayTheme();
    return Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: Stack(
            // alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              /// 不需要pointEvent
              /// IgnorePointer：此节点和其子节点都惊忽略点击事件
              /// AbsorbPointer：这个控件本身是能够响应点击事件的，他做的是阻止事件传递到他的子节点上
              ///
              /// AbsorbPointer 是一种禁止用户输入的控件，比如按钮的点击、输入框的输入、ListView的滚动等，你可能说将按钮的onPressed设置为null，一样也可以实现，是的，但AbsorbPointer可以提供多组件的统一控制，而不需要你单独为每一个组件设置
              /// 限制大小
              ///
              Positioned(
                  child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerUp: widget.onBackdropPress,
                child: FTransition(
                  name: TransitionType.fade,
                  duration: widget.duration,
                  show: widget.show,
                  child: Container(
                    alignment: widget.alignment,
                    color: theme.overlayBackgroundColor(
                        backgroundColor: widget.color,
                        opacity: widget.colorOpacity),
                  ),
                ),
              )),
              if (widget.child is Widget) widget.child!,
            ]));
  }

  void init() {
    /// 创建一个OverlayEntry对象,初始化
    holder = new OverlayEntry(builder: (context) {
      return overlay();
    });
  }

  @override
  void dispose() {
    /// 清除自身
    close();

    super.dispose();
  }

  /// 渲染遮罩组件
  Widget get renderOverlay {
    Widget current = Overlay(initialEntries: [
      OverlayEntry(builder: (BuildContext context) {
        return overlay();
      })
    ]);

    if (!_show) {
      current = LimitedBox();
    }

    return current;
  }

  @override
  Widget build(BuildContext context) {
    /// 1. 判断是否自定义遮罩层
    /// 自定义遮罩的话会渲染一个Container的容器以及Stack的的重叠
    Widget? current = LimitedBox();

    /// 开发者需要自定义的遮罩
    ///
    /// 自定义不存在container将无意义
    if (widget.isCustom && widget.container != null) {
      current = Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(),
          child: Stack(children: [
            /// 这一块肯定需要渲染的
            widget.container!,

            /// 渲染遮罩层
            ///
            /// 交给renderOverlay去判断显示
            Positioned(
                left: 0, right: 0, top: 0, bottom: 0, child: renderOverlay),
          ]));
    }

    return current;
  }
}
