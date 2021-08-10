import 'package:example/components/title.dart';
import 'package:fant/package/cell/index.dart';
import 'package:fant/package/cell_group/index.dart';
import 'package:fant/package/icon/index.dart';
import 'package:fant/package/icon/theme.dart';
import 'package:fant/package/tag/index.dart';
import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  @override
  _Cell createState() => _Cell();
}

class _Cell extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cell'),
        ),
        body: ListView(children: [
          TitleBar(
            '基础用法',
            isLeft: true,
          ),
          FCellGroup(children: [
            FCell(
              title: "单元格",
              value: '内容',
            ),
            FCell(
              title: "单元格",
              value: '内容',
              label: "描述信息",
              border: false,
            )
          ]),
          TitleBar(
            '卡片风格',
            isLeft: true,
          ),
          FCellGroup(inset: true, children: [
            FCell(
              title: "单元格",
              value: '内容',
            ),
            FCell(
              title: "单元格",
              value: '内容',
              label: "描述信息",
              border: false,
            )
          ]),
          TitleBar(
            '单元格大小',
            isLeft: true,
          ),
          FCell(
            title: "单元格",
            value: '内容',
            icon: FantIcon.location_o,
            large: true,
          ),
          FCell(
            title: "单元格",
            value: '内容',
            large: true,
            label: "描述信息",
            border: false,
          ),
          TitleBar(
            '展示图标',
            isLeft: true,
          ),
          FCell(
            title: "单元格",
            icon: FantIcon.location_o,
            value: '内容',
            border: false,
          ),
          TitleBar(
            '只设置 value',
            isLeft: true,
          ),
          FCell(
            value: '内容',
            border: false,
          ),
          TitleBar(
            '展示箭头',
            isLeft: true,
          ),
          FCell(
            title: "单元格",
            isLink: true,
          ),
          FCell(
            title: "单元格",
            isLink: true,
            value: '内容',
          ),
          FCell(
            title: "单元格",
            isLink: true,
            arrowDirection: ArrowDirection.down,
            value: '内容',
            border: false,
          ),
          TitleBar(
            '分组标题',
            isLeft: true,
          ),
          FCellGroup(title: '分组1', children: [
            FCell(
              title: "单元格",
              value: '内容',
              border: false,
            ),
          ]),
          FCellGroup(title: '分组2', children: [
            FCell(
              title: "单元格",
              value: '内容',
              border: false,
            ),
          ]),
          TitleBar(
            '使用插槽',
            isLeft: true,
          ),
          FCell(
            titleSlot: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Text('单元格'),
                ),
                FTag(
                  data: '标签',
                  type: FTagType.danger,
                )
              ],
            ),
            value: '内容',
            border: true,
            isLink: true,
          ),
          FCell(
            icon: FantIcon.shop_o,
            title: '单元格',
            rightSlot: FIcon(
              name: FantIcon.search,
              size: 16,
            ),
            border: false,
          ),
          TitleBar(
            '垂直居中',
            isLeft: true,
          ),
          FCell(
            title: "单元格",
            value: '内容',
            label: "描述信息",
            center: true,
            border: false,
          )
        ]));
  }
}
