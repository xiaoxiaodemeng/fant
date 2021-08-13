import 'package:fant/package/badge/index.dart';
import 'package:fant/package/button/index.dart';
import 'package:fant/package/button/theme.dart';
import 'package:fant/package/cell/index.dart';
import 'package:fant/package/cell_group/index.dart';
import 'package:fant/package/icon/index.dart';
import 'package:fant/package/icon/theme.dart';
import 'package:fant/package/loading/icon/circle.dart';
import 'package:fant/package/loading/index.dart';
import 'package:fant/package/swiper_cell/index.dart';
import 'package:flutter/material.dart';

import 'package/loading/icon/ring.dart';
import 'package/overlay/index.dart';
import 'package/popup/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool a = false;
  bool b = false;
  bool c = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey key = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          children: <Widget>[
            Material(
                child: Center(
              child: ElevatedButton(
                  onPressed: () => {
                        setState(() {
                          c = !c;
                        })
                      },
                  child: Text('2222')),
            )),
            FOverlay(
              context,
              show: c,
              // isCustom: true,
              color: Colors.brown,
              child: Container(
                width: 100,
                height: 100,
                // color: Colors.cyan.withAlpha(127),
                child: ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            c = !c;
                          })
                        },
                    child: Text('2222')),
              ),
              container: Container(
                width: 200,
                height: 200,
                color: Colors.brown,
                child: ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            c = !c;
                          })
                        },
                    child: Text('222222222')),
              ),
            ),

            FPopup(
              context,
              show: b,
              round: true,
              useSafeArea: true,
              closeable: true,
              position: PopupPosition.center,
              // type: CoverScreen.overlay,
              onBackButtonPress: () {
                setState(() {
                  b = !b;
                });
              },
              onBackdropPress: (PointerUpEvent w) {
                setState(() {
                  b = !b;
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 200,
                  color: Colors.white,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () => {
                              setState(() {
                                b = !b;
                              })
                            },
                        child: Text('222222222')),
                  )),
              container: Container(
                height: 300,
                color: Colors.deepPurple,
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                color: Colors.white,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () => {
                            setState(() {
                              b = !b;
                            })
                          },
                      child: Text('222222222')),
                )),
            // Container(
            //   height: 500,
            // ),
            // Container(
            //   // width: ,
            //   child: FButton(
            //     '大号按钮',
            //     size: FButtonSize.large,
            //     type: FButtonType.primary,
            //     color: Colors.brown,
            //     hairline: true,
            //     plain: true,
            //   ),
            //   margin: EdgeInsets.only(right: 16, top: 16),
            // ),
            Container(
              child: FButton(
                '3123',
                // child: Text('9999'),
                onTap: () => {
                  // FPopup(
                  //   context,
                  //   show: false,
                  // )
                },
                round: true,
                // disabled: true,
                // loading: true,
                icon: FantIcon.add,
                // loadingText: "321312",
                iconPosition: IconPosition.right,
                loadingType: LoadingType.spinner,
                size: FButtonSize.normal,
                type: FButtonType.primary,
                // plain: true,
                // color: Colors.cyanAccent,
              ),
              // margin: EdgeInsets.only(right: 16, top: 16),
            ),

            FPopup(
              context,
              // isCustom: true,
              // position: PopupPosition.left,
              closeable: true,
              useSafeArea: true,
              show: a,
              child: Container(
                  color: Colors.blue,
                  // width: double.infinity,
                  // alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  child: Text('内容')),
              onBackdropPress: (PointerUpEvent event) => {
                setState(() => {a = false})
              },
            ),
            // WillPopScope(
            //     onWillPop: () async {
            //       print("返回键点击了");
            //       // Navigator.pop(context);
            //       return false;
            //     },
            //     child: Text('牛逼')),
            // Container(
            //   child: FButton(
            //     '小型按钮',
            //     size: FButtonSize.small,
            //     type: FButtonType.primary,
            //     // color: Colors.cyanAccent,
            //   ),
            //   margin: EdgeInsets.only(right: 16, top: 16),
            // ),
            // Container(
            //   child: FButton(
            //     '迷你按钮',
            //     size: FButtonSize.mini,
            //     type: FButtonType.primary,
            //     // color: Colors.cyanAccent,
            //   ),
            //   margin: EdgeInsets.only(right: 16, top: 16),
            // ),
            // FLoading(),
            // FLoading(type: LoadingType.spinner),
            // FLoading(color: Color(0xFF1989fa)),
            // FLoading(color: Color(0xFF1989fa), type: LoadingType.spinner),
            // FLoading(size: 24),
            // FLoading(size: 24, type: LoadingType.spinner),
            // FLoading(
            //   size: 24,
            //   text: '加载中...',
            // ),
            FCell(
              key: key,
              icon: FantIcon.add,
              // center: true,
              isRequired: true,
              // rightSlot: Text('8h'),
              // extraSlot: Text('8h'),
              // isLink: true,
              onTap: () {
                // print((key.currentContext!.findRenderObject() as RenderBox)
                //     .localToGlobal(Offset.zero));
                // TestOverLay.show(
                //     context: context,
                //     view: Material(
                //         child: Container(
                //       width: MediaQuery.of(context).size.width,
                //       height: MediaQuery.of(context).size.height,
                //       color: Colors.deepPurple.withAlpha(50),
                //       child: Text('1111'),
                //     )));
              },
              arrowDirection: ArrowDirection.down,
              // clickable: false,
              title:
                  '1212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212',
              value: '98',
              // large: true,
              label: "hhih",
            ),

            Container(
              height: 30,
            ),

            FCellGroup(
              title: '31231',

              // inset: true,
              children: [
                FCell(
                  title: "单元格",
                  onTap: () => {
                    setState(() => {a = !a})
                  },
                  value: "内容",
                  clickable: true,
                  border: true,
                ),
                FCell(
                  title: "单元格",
                  value: "内容",
                )
              ],
            ),
            Container(
              height: 30,
            ),
            FIcon(
                url:
                    'https://upload.jianshu.io/users/upload_avatars/9955565/de8ad3b1-f660-4f5b-b44f-0d6925832dc7?imageMogr2/auto-orient/strip|imageView2/1/w/90/h/90/format/webp',
                text: 'hot'),
            Container(
                margin: EdgeInsets.all(100),
                child: FBadge(
                  // dot: true,
                  color: Colors.green,
                  // text: '21312312',
                  alignment: Alignment.bottomRight,
                  number: 234324121,
                  max: 101110,
                  content: Text('7872'),
                  offset: [10],
                  child: Container(
                    color: Colors.grey,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Text('111'),
                    ),
                  ),
                )),
            Container(
              height: 500,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TestOverLay {
  static OverlayEntry? _holder;

  static Widget? view;

  static void remove() {
    if (_holder != null) {
      _holder!.remove();
      _holder = null;
    }
  }

  static void show({required BuildContext context, required Widget view}) {
    TestOverLay.view = view;

    remove();
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(top: 163, child: _buildDraggable(context));
    });

    //往Overlay中插入插入OverlayEntry
    Overlay.of(context)!.insert(overlayEntry);

    _holder = overlayEntry;
  }

  static _buildDraggable(context) {
    return new Draggable(
      child: view!,
      feedback: view!,
      onDragStarted: () {
        print('onDragStarted:');
      },
      onDragEnd: (detail) {
        print('onDragEnd:${detail.offset}');
        createDragTarget(offset: detail.offset, context: context);
      },
      childWhenDragging: Container(),
    );
  }

  static void refresh() {
    _holder!.markNeedsBuild();
  }

  static void createDragTarget({Offset? offset, BuildContext? context}) {
    if (_holder != null) {
      _holder!.remove();
    }

    _holder = new OverlayEntry(builder: (context) {
      bool isLeft = true;
      if (offset!.dx + 100 > MediaQuery.of(context).size.width / 2) {
        isLeft = false;
      }

      double maxY = MediaQuery.of(context).size.height - 100;

      return new Positioned(
          top: offset.dy < 50
              ? 50
              : offset.dy < maxY
                  ? offset.dy
                  : maxY,
          left: isLeft ? 0 : null,
          right: isLeft ? null : 0,
          child: DragTarget(
            onWillAccept: (data) {
              print('onWillAccept: $data');
              return true;
            },
            onAccept: (data) {
              print('onAccept: $data');
              // refresh();
            },
            onLeave: (data) {
              print('onLeave');
            },
            builder: (BuildContext context, List incoming, List rejected) {
              return _buildDraggable(context);
            },
          ));
    });
    Overlay.of(context!)!.insert(_holder!);
  }
}
