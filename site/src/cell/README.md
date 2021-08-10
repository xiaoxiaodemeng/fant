# Cell 单元格

### 介绍

单元格为列表中的单个展示项。

### 引入

```dart
import 'package:fant/package/cell/index.dart';
import 'package:fant/package/cell_group/index.dart';
```


## 注意事项

### 布局

- `FCell`组件无法做到判断自己是不是最后一个兄弟组件(也就是代表了,开发者需要自己`border`的判断)

## 代码演示

### 基础用法

`FCell` 可以单独使用，也可以与 `FCellGroup` 搭配使用，`FCellGroup` 可以为 `FCell` 提供上下外边框。

```dart
FCellGroup(
  children: [
        FCell(title: "单元格", value: '内容'),
        FCell(title: "单元格", value: '内容', label: "描述信息",border: false)
    ]
)
```

### 卡片风格

通过 `FCellGroup` 的 `inset` 属性，可以将单元格转换为圆角卡片风格。

```dart
FCellGroup(
  inset: true,
  children: [
        FCell(title: "单元格", value: '内容'),
        FCell(title: "单元格", value: '内容', label: "描述信息",border: false)
    ]
)
```

### 单元格大小

通过 `size` 属性可以控制单元格的大小。

```dart
FCell(title: "单元格", value: '内容', large: true),
FCell(title: "单元格", value: '内容', large: true, label: "描述信息",border: false)
```

### 展示图标

通过 `icon` 属性在标题左侧展示图标。

```dart
FCell(title: "单元格",icon: FantIcon.location_o,value: '内容',border: false)
```

### 只设置 value

只设置 `value` 时，内容会靠左对齐。

```dart
FCell(value: '内容',border: false)
```

### 展示箭头

设置 `isLink` 属性后会在单元格右侧显示箭头，并且可以通过 `arrowDirection` 属性控制箭头方向。

```dart
FCell(title: "单元格",isLink: true),
FCell(title: "单元格",isLink: true,value: '内容'),
FCell(title: "单元格",isLink: true,arrowDirection: ArrowDirection.down,value: '内容',border: false)
```

### 分组标题

通过 `FCellGroup` 的 `title` 属性可以指定分组标题。

```dart
FCellGroup(
    title: '分组1', 
    children: [
        FCell(title: "单元格",value: '内容',border: false)
    ]),
FCellGroup(
    title: '分组2', 
    children: [
        FCell(title: "单元格",value: '内容',border: false),
    ])
```

### 使用插槽

如以上用法不能满足你的需求，可以使用插槽来自定义内容。

```dart
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
)
```

### 垂直居中

通过 `center` 属性可以让 `FCell` 的左右内容都垂直居中。

```dart
FCell(title: "单元格",value: '内容',label: "描述信息",center: true,border: false)
```

## API

### FCellGroup Props

| 参数   | 说明                   | 类型     | 默认值  |
| ------ | ---------------------- | -------- | ------- |
| title  | 分组标题               | _String_ | `-`     |
| inset  | 是否展示为圆角卡片风格 | _bool_   | `false` |
| border | 是否显示外边框         | _bool_   | `true`  |

### FCell Props

| 参数           | 说明                                          | 类型                  | 默认值                 |
| -------------- | --------------------------------------------- | --------------------- | ---------------------- |
| title          | 左侧标题                                      | _String_              | `-`                    |
| value          | 右侧内容                                      | _String_              | `-`                    |
| label          | 标题下方的描述信息                            | _String_              | `-`                    |
| size           | 单元格大小，可选值为 large                    | _String_              | `-`                    |
| icon           | 左侧图标名称,FantIcon提供了Icon组件的所有图标 | _IconData_ _FantIcon_ | -                      |
| url            | 左侧图标提供url链接**支持本地**               | _String_              | -                      |
| border         | 是否显示内边框                                | _bool_                | `true`                 |
| clickable      | 是否开启点击反馈                              | _boool_               | `null`                 |
| isLink         | 是否展示右侧箭头并开启点击反馈                | _bool_                | `false`                |
| required       | 是否显示表单必填星号                          | _bool_                | `false`                |
| center         | 是否使内容垂直居中                            | _bool_                | `false`                |
| arrowDirection | 箭头方向，可选值为 left up down               | _ArrowDirection_      | `ArrowDirection.right` |
| titleStyle     | 左侧标题额外样式                              | _TextStyle_           | `-`                    |


### FCell Events


| 事件名      | 说明             | 回调参数                   |
| ----------- | ---------------- | -------------------------- |
| onTap       | 点击单元格时触发 | _GestureTapCallback_       |
| onLongPress | 长按单元格时触发 | _GestureLongPressCallback_ |


### CellGroup Slots

| 事件名    | 说明           |
| --------- | -------------- |
| titleSlot | 自定义分组标题 |

### Cell Slots

| 事件名    | 说明                         |
| --------- | ---------------------------- |
| titleSlot | 自定义左侧标题               |
| valueSlot | 自定义右侧内容               |
| labelSlot | 自定义标题下方的描述信息     |
| iconSlot  | 自定义左侧图标               |
| rightSlot | 自定义右侧图标               |
| extraSlot | 自定义单元格最右侧的额外内容 |

