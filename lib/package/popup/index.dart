import 'package:flutter/material.dart';

import 'theme.dart';
import '../icon/index.dart';
import '../icon/theme.dart';
import '../overlay/index.dart';
import '../transition/index.dart';

enum PopupPosition { left, right, top, bottom, center }

enum CoverScreen {
  /// 继承Dialog[PopupRoute]
  dialog,

  /// 采用了Overlay
  overlay
}

enum CloseIconPosition { top_left, top_right, bottom_left, bottom_right }

class FPopup extends StatefulWidget {
  FPopup(
    this.context, {
    Key? key,
    required this.show,
    this.overlay = true,
    this.type = CoverScreen.dialog,
    this.position = PopupPosition.center,
    this.constraints = const BoxConstraints(),
    this.duration = const Duration(milliseconds: 300),
    this.onBackdropPress,
    this.onBackButtonPress,
    this.alignment = Alignment.center,
    this.useSafeArea = false,
    this.transition = Curves.easeInOut,
    this.closeable = false,
    this.closeIconPosition = CloseIconPosition.top_right,
    this.closeIcon,
    this.closeUrl,
    this.round = false,
    this.child,
    this.container,
  })  : assert(closeable && onBackdropPress != null || !closeable,
            '存在关闭Icon的时候不挂上onBackdropPress点击事件是无意义的'),
        assert(
            type == CoverScreen.dialog ||
                (type == CoverScreen.overlay && container != null),
            '使用CoverScreen.overlay,Container不能为null'),
        super(key: key);

  /// 当前组件的context
  ///
  /// 必要的
  final BuildContext context;

  /// 标记是否显示展出popup
  final bool show;

  /// 覆盖屏幕的方式
  ///
  /// dialog会直接覆盖整了屏幕
  ///
  /// overlay会根据提供context来设置距离屏幕top+height的Y轴位置
  final CoverScreen type;

  /// 弹出方向位置
  ///
  /// 默认中间
  final PopupPosition position;

  /// 是否显示遮罩层
  final bool overlay;

  /// 可限制自定义模块的宽高
  ///
  /// 默认父组件的宽高
  final BoxConstraints constraints;

  /// 组件对齐方式
  final AlignmentGeometry alignment;

  /// 是否使用底部安全
  final bool useSafeArea;

  /// 点击遮罩的回调事件
  ///
  /// 需要点击遮罩关闭弹框，可以在这里调用关闭
  final PointerUpEventListener? onBackdropPress;

  /// 内容
  ///
  /// 不能直接Positioned组件
  final Widget? child;

  /// 过渡动画
  final Cubic transition;

  /// 动画时间
  final Duration duration;

  /// 操作的部分组件
  ///
  /// ---类似于Overlay
  final Widget? container;

  /// 当按下Android后退按钮时调用
  ///
  /// 当没给给该值的时候代表该弹框暂时无法被返回的操作--关闭
  final VoidCallback? onBackButtonPress;

  /// 是否显示关闭图标
  ///
  /// 默认为false
  final bool closeable;

  /// icon的名字
  final IconData? closeIcon;

  /// icon的URL
  final String? closeUrl;

  /// icon的位置
  /// 关闭图标位置，可选值为top_left bottom_left bottom_right
  /// 默认top_right
  final CloseIconPosition closeIconPosition;

  /// 是否显示圆角
  final bool round;

  @override
  _FPopup createState() => _FPopup();
}

class _FPopup extends State<FPopup> with SingleTickerProviderStateMixin {
  /// icon是否高亮
  bool isHightColor = false;

  /// 渲染内容
  Widget renderContent(bool hideOverlay) {
    FPopupTheme theme = FPopupTheme();

    /// 获取安全距离--设置关闭按钮位置
    final MediaQueryData data = MediaQuery.of(widget.context);
    Widget child = Container(
        width: theme.getPosition(widget.position.index).width,
        height: theme.getPosition(widget.position.index).height,
        constraints: widget.constraints,
        alignment: widget.alignment,
        child: SingleChildScrollView(
          child: widget.child,
        ));

    if (widget.useSafeArea) {
      child = SafeArea(
          top: widget.position == PopupPosition.top,
          bottom: widget.position == PopupPosition.bottom,
          child: child);
    }
    return Material(
        color: Colors.transparent,
        child: Stack(children: [
          /// 遮罩
          ///
          /// CoverScreen.Coverlay的时候需要隐藏
          FOverlay(
            widget.context,
            colorOpacity: 0,
            onBackdropPress: widget.onBackdropPress,
            duration: widget.duration,
            show: widget.show,
            isCustom: true,
            container: Container(),
          ),

          /// 自定义遮罩
          // Positioned(
          //     child: Listener(
          //   behavior: HitTestBehavior.translucent,
          //   onPointerUp: widget.onBackdropPress,
          // )),
          Positioned(
              top: theme.getPosition(widget.position.index).top,
              bottom: theme.getPosition(widget.position.index).bottom,
              left: theme.getPosition(widget.position.index).left,
              right: theme.getPosition(widget.position.index).right,
              child: Stack(children: [
                Material(
                    borderRadius: !widget.round
                        ? BorderRadius.zero
                        : BorderRadius.only(
                            topLeft: theme
                                .getPosition(widget.position.index)
                                .topLeftRound,
                            topRight: theme
                                .getPosition(widget.position.index)
                                .topRightRound,
                            bottomLeft: theme
                                .getPosition(widget.position.index)
                                .bottomLeftRound,
                            bottomRight: theme
                                .getPosition(widget.position.index)
                                .bottomRightRound),
                    type: widget.position == PopupPosition.center
                        ? MaterialType.transparency
                        : MaterialType.canvas,
                    color: widget.position == PopupPosition.center
                        ? Colors.transparent
                        : theme.popupBackgroundColor,
                    child: child),
                if (widget.closeable)
                  Positioned(
                      right: theme
                          .getIconMargin(widget.closeIconPosition.index)
                          .right,

                      /// 准确渲染关闭icon的位置
                      top: widget.type == CoverScreen.dialog &&
                              widget.position != PopupPosition.bottom &&
                              widget.position != PopupPosition.center &&
                              widget.useSafeArea
                          ? data.padding.top
                          : theme
                              .getIconMargin(widget.closeIconPosition.index)
                              .top,
                      bottom: theme
                          .getIconMargin(widget.closeIconPosition.index)
                          .bottom,
                      left: theme
                          .getIconMargin(widget.closeIconPosition.index)
                          .left,
                      child: renderCloseIcon()),
              ]))
        ]));
  }

  @override
  void initState() {
    super.initState();

    if (widget.type == CoverScreen.overlay) return;

    if (widget.show) {
      /// setState() or markNeedsBuild() called during build.错误解决办法
      ///
      /// 延时加载Future.delayed(Duration(milliseconds: 0), () => {open()});
      ///
      Future.delayed(Duration.zero, () => {open()});
    }
  }

  /// 获取配置
  Map<PopupPosition, TransitionType> config = {
    PopupPosition.bottom: TransitionType.slideDown,
    PopupPosition.top: TransitionType.slideUp,
    PopupPosition.left: TransitionType.slideLeft,
    PopupPosition.right: TransitionType.slideRight,
    PopupPosition.center: TransitionType.scale,
  };

  @override
  void dispose() {
    /// 销毁
    close();

    super.dispose();
  }

  @override
  void didUpdateWidget(FPopup oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 当前为true , 老状态为false
    if (widget.show && !oldWidget.show) {
      Future.delayed(Duration.zero, () => {open()});
    } else if (!widget.show && oldWidget.show) {
      // 新状态false , 老状态为true
      Future.delayed(Duration.zero, () => {close()});
    }
  }

  /// rootNavigator:true 会把底部Tab也跳了,false 则不会
  ///
  /// 打开popup 弹出层
  Future<bool?> open() async {
    if (widget.type == CoverScreen.overlay) {
      /// https://stackoverflow.com/questions/62726872/flutter-delayed-animation-code-error-animationcontroller-forward-called-afte
      if (mounted) {
        ///
      }
    } else {
      return await Navigator.of(widget.context, rootNavigator: false)
          .push(popupBuilder());
    }
  }

  /// 关闭弹出层
  Future<void> close() async {
    if (widget.type == CoverScreen.overlay) {
      ///
    } else {
      //// 本来是使用pop
      ///
      /// 但是看了ModalRoute后面的源码看到是使用了maybePop
      /// 会自动进行判断,如果当前页面 pop后,会显示其他页面,不会出现问题,则将执行当前页面的pop操作 否则将不执行
      Navigator.of(widget.context, rootNavigator: false).maybePop();
    }
  }

  /// 构建器
  FPopupRoute<bool> popupBuilder() {
    FPopupTheme theme = FPopupTheme();
    return FPopupRoute(
        opacity: theme.overlayOpacity,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          Widget popup = renderContent(true);

          return popup;
        },
        transitionDuration: widget.duration,
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FTransition(
            /// 居中不使用缩放动画
            ///
            /// 而是直接显示就好
            name: config[widget.position] == TransitionType.scale
                ? null
                : config[widget.position],
            show: widget.show,
            transition: widget.transition,
            duration: widget.duration,
            child: child,
          );
        });
  }

  /// 渲染
  Widget renderCloseIcon() {
    FPopupTheme theme = FPopupTheme();
    // 默认显示icon或者url的icon
    Widget temp = FIcon(
      name: widget.closeIcon != null
          ? widget.closeIcon
          : widget.closeUrl != null
              ? null
              : FantIcon.cross,
      url: widget.closeUrl,
      size: theme.iconSize,
      color: isHightColor ? theme.iconActiveColor : theme.iconColor,
    );

    return InkWell(
      child: temp,
      onTap: () {
        /// 取消高亮
        setState(() {
          isHightColor = false;
        });
        if (widget.onBackButtonPress != null) widget.onBackButtonPress!();
      },
      onTapDown: (TapDownDetails details) {
        /// 高亮
        setState(() {
          isHightColor = true;
        });
      },
      onTapCancel: () {
        /// 取消高亮
        setState(() {
          isHightColor = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 判断是否不使用Naviagte
    Widget? current = LimitedBox();

    if (widget.type == CoverScreen.overlay) {
      FPopupTheme theme = FPopupTheme();
      current = FOverlay(
        widget.context,
        show: widget.show,
        isCustom: true,
        colorOpacity: theme.overlayOpacity,
        onBackdropPress: widget.onBackdropPress,
        child: FTransition(
          /// 居中不使用缩放动画
          ///
          /// 而是直接显示就好
          name: config[widget.position] == TransitionType.scale
              ? null
              : config[widget.position],
          show: widget.show,
          transition: widget.transition,
          duration: widget.duration,

          /// 去除透明度
          child: WillPopScope(
            onWillPop: () async {
              /// 如果是false，就不会出栈，如果true就会出栈
              if (widget.onBackButtonPress != null && widget.show) {
                widget.onBackButtonPress!();
              }

              /// 这种状态下根本就不存在栈给我出
              return false;
            },
            child: renderContent(false),
          ),
        ),
        container: widget.container,
      );
    }

    return current;
  }
}

// 内置实际中`show`的弹框
// showDialog:用于弹出Material风格对话框
// showCupertinoDialog:用于弹出ios风格对话框
// showGeneralDialog:自定义提示框
// showAboutDialog:用于描述当前App信息，底部提供2个按钮：查看许可按钮和关闭按钮
// showLicensePage:描述当前App许可信息
// showBottomSheet:展示一个material风格的bottom sheet
// showModalBottomSheet:从底部弹出，通常和BottomSheet配合
// showCupertinoModalPopup:展示ios的风格弹出框
// showMenu:弹出一个Menu菜单
// showSearch:直接跳转到搜索页面

/// 重写RawDialogRoute
///
/// 也可以用showGeneralDialog,这个api就是利用RawDialogRoute封了一层

class FPopupRoute<T> extends RawDialogRoute<T> {
  //// 路由的小部件(其实就是return布局)
  final RoutePageBuilder pageBuilder;

  /// 过渡动画时间
  static const Duration _duration = Duration(milliseconds: 300);

  FPopupRoute({
    required this.pageBuilder,
    bool barrierDismissible = false,
    Color? barrierColor,
    Duration transitionDuration = _duration,
    String? barrierLabel,
    double opacity = 0.7,
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
  })  

  /// 内部存储值
  : assert(opacity >= 0.0 && opacity <= 1.0),
        _barrierColor = barrierColor,
        _opacity = opacity,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _transitionDuration = transitionDuration,
        super(
            pageBuilder: pageBuilder,
            settings: settings,
            transitionBuilder: transitionBuilder);

  /// 用于模态遮罩的颜色。如果这是空值，将是透明的。
  ///
  /// 模态障碍是呈现在后，它通常会阻止用户与当前后面的的页面进行交互。
  ///
  /// null则为透明[默认参数 `Color(0x80000000)`]
  ///
  /// 1--255  0---0
  ///
  /// ui.Color.withOpacity(_opacity)---Color 类的静态方法，作用就是(0~1 的 opacity)将颜色转化成有透明度的颜色
  @override
  Color? get barrierColor =>
      _barrierColor ?? Colors.black.withOpacity(_opacity);
  final Color? _barrierColor;

  /// 传递透明度
  ///
  /// 默认黑色进行透明度
  final double _opacity;

  /// 用于确定该路由是否可以通过点击模态遮罩关闭
  ///
  /// 默认为false
  ///
  /// 如果`barrierDismissible`为true，则不是null的`barrierLabel`必须为true
  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  /// 这是一个被`dismissible`使用的语义标签
  @override
  String? get barrierLabel => _barrierLabel ?? "弹出层";
  final String? _barrierLabel;

  /// route到达或离开屏幕需要的时间
  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;
}
