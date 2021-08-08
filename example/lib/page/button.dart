import 'package:example/components/title.dart';
import 'package:fant/package/button/index.dart';
import 'package:fant/package/icon/theme.dart';
import 'package:fant/package/loading/index.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  @override
  _Button createState() => _Button();
}

class _Button extends State<Button> {
  /// 间隔
  Widget spaceWidget({required Widget child}) {
    return Container(
        margin: EdgeInsets.only(right: 16, bottom: 16), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Button'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TitleBar('按钮类型'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "主要按钮",
                  type: FButtonType.primary,
                )),
                spaceWidget(child: FButton("成功按钮", type: FButtonType.success)),
                spaceWidget(
                    child: FButton("默认按钮", type: FButtonType.defaultType)),
                spaceWidget(child: FButton("警告按钮", type: FButtonType.warning)),
                spaceWidget(child: FButton("危险按钮", type: FButtonType.danger)),
              ],
            ),
            TitleBar('朴素按钮'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "朴素按钮",
                  plain: true,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton("朴素按钮",
                        plain: true, type: FButtonType.success)),
              ],
            ),
            TitleBar('细边框'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "细边框按钮",
                  hairline: true,
                  plain: true,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton("细边框按钮",
                        hairline: true,
                        plain: true,
                        type: FButtonType.success)),
              ],
            ),
            TitleBar('禁用状态'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "禁用状态",
                  disabled: true,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton("禁用状态",
                        disabled: true, type: FButtonType.success)),
              ],
            ),
            TitleBar('加载状态'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "加载状态",
                  loading: true,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton("加载状态",
                        loadingType: LoadingType.spinner,
                        loading: true,
                        type: FButtonType.primary)),
                spaceWidget(
                    child: FButton("加载状态",
                        loading: true,
                        loadingText: "加载中...",
                        type: FButtonType.success)),
              ],
            ),
            TitleBar('按钮形状'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "方形按钮",
                  square: true,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton("圆形状态",
                        round: true, type: FButtonType.success)),
              ],
            ),
            TitleBar('图标按钮'),
            Wrap(
              children: [
                spaceWidget(
                    child: FButton(
                  "",
                  icon: FantIcon.plus,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton(
                  "按钮",
                  icon: FantIcon.plus,
                  type: FButtonType.primary,
                )),
                spaceWidget(
                    child: FButton("状态",
                        plain: true,
                        url: 'https://img.yzcdn.cn/vant/user-active.png',
                        type: FButtonType.primary)),
              ],
            ),
            TitleBar('按钮尺寸'),
            Wrap(children: [
              spaceWidget(
                  child: FButton("大号按钮",
                      size: FButtonSize.large, type: FButtonType.primary)),
              spaceWidget(
                  child: FButton("普通按钮",
                      size: FButtonSize.normal, type: FButtonType.primary)),
              spaceWidget(
                  child: FButton("小型按钮",
                      size: FButtonSize.small, type: FButtonType.primary)),
              spaceWidget(
                  child: FButton("迷你按钮",
                      size: FButtonSize.mini, type: FButtonType.primary)),
            ]),
            TitleBar('块级元素'),
            Wrap(children: [
              spaceWidget(
                  child:
                      FButton("块级元素", block: true, type: FButtonType.primary))
            ]),
            TitleBar('自定义颜色'),
            Wrap(children: [
              spaceWidget(child: FButton("单色元素", color: Color(0xFF7232dd))),
              spaceWidget(
                  child:
                      FButton("单色元素", plain: true, color: Color(0xFF7232dd))),
              spaceWidget(
                  child: FButton("渐变色元素",
                      color: Color(0xFF7232dd),
                      gradient: LinearGradient(
                          //渐变位置
                          begin: Alignment.centerLeft, // 左边
                          end: Alignment.centerRight, // 右边
                          stops: [0.0, 1.0], // [渐变起始点, 渐变结束点]
                          //渐变颜色[始点颜色, 结束颜色]
                          colors: [Color(0xFFff6034), Color(0xFFee0a24)])))
            ]),
          ],
        ));
  }
}
