# FButton 按钮

### 介绍

按钮用于触发一个操作，如提交表单。

### 引入

```dart
import 'package:fant/package/button/index.dart';
```

## 注意事项

### 布局

- `type` ===`large`且父组件是`Row`容器，将会存在得不到最大宽度的问题[导致按钮的宽度出现文本宽的情况]，因此需要开发者手动加一层`Expanded`或者指定宽度
- `FButton`组件必须按钮文本的参数[设计的包袱],可传入空字符串
- `FButton`的渐变属性优先级高于单色
- `ListView` 包裹`FButton`组件,宽度占满逻辑是正常的,可以看自带组件`ElevatedButton` 按钮行为

## 代码演示

### 按钮类型

按钮支持 `defaultType` 、`primary`、`success`、`warning`、`danger` 五种类型，默认为 `defaultType`。

```dart
FButton("主要按钮", type: FButtonType.primary)
FButton("成功按钮", type: FButtonType.success)
FButton("默认按钮", type: FButtonType.defaultType)
FButton("警告按钮", type: FButtonType.warning)
FButton("危险按钮", type: FButtonType.danger)
```

### 朴素按钮

通过` plain `属性将按钮设置为朴素按钮，朴素按钮的文字为按钮颜色，背景为白色。

```dart
FButton("朴素按钮",plain: true, type: FButtonType.primary)
FButton("朴素按钮",plain: true, type: FButtonType.success)
```

### 细边框

设置` hairline `属性可以展示` 0.5px `的细边框。

```dart
FButton("细边框按钮", hairline: true, plain: true, type: FButtonType.primary)
FButton("细边框按钮", hairline: true, plain: true, type: FButtonType.success)
```

### 禁用状态

通过` disabled `属性来禁用按钮，禁用状态下按钮不可点击。

```dart
FButton("禁用状态", disabled: true, type: FButtonType.primary)
FButton("禁用状态", disabled: true, type: FButtonType.success)
```

### 加载状态

通过` loading `属性设置按钮为加载状态，加载状态下默认会隐藏按钮文字，可以通过` loadingText `设置加载状态下的文字。

> **loadingType** 可以选择加载的类型[提供俩种]

```dart
FButton("加载状态", loading: true, type: FButtonType.primary,)
FButton("加载状态", loadingType: LoadingType.spinner,loading: true,type: FButtonType.primary)
FButton("加载状态", loading: true, loadingText: "加载中...",type: FButtonType.success)
```

### 按钮形状

通过` square `设置方形按钮，通过` round `设置圆形按钮。

```dart
FButton("方形按钮", square: true, type: FButtonType.primary)
FButton("圆形状态", round: true, type: FButtonType.success)
```

### 图标按钮

通过` icon `属性设置按钮图标，支持` Icon `组件里的所有图标，也可以传入图标` URL `。

- 支持 `Icon` 图标 需要传入`icon` 属性
- 链接[包括本地,需要在pubspec.yaml加载本地资源]的话需要传入`url`,**icon属性的优先级高于url**

> 因为最开始设计按钮的缘故,暂不可不传入按钮的文本值**实在不需要文本可以穿入空字符串**,**flutter**的**Text**的文本是必填项，内部如果要做处理也是只是置空串或者不渲染**Text**，这一块如果心智负担大的话，<span style="color:red">有需要后期可能会做处理</span>

```dart
FButton("",icon: FantIcon.plus,type: FButtonType.primary)
FButton("按钮",icon: FantIcon.plus,type: FButtonType.primary)
FButton("状态",plain: true,url: 'https://img.yzcdn.cn/vant/user-active.png',type: FButtonType.primary)
```

### 按钮尺寸

支持 `large`、`normal`、`small`、`mini` 四种尺寸，默认为 `normal`。

```dart
FButton("大号按钮",size: FButtonSize.large, type: FButtonType.primary)
FButton("普通按钮",size: FButtonSize.normal, type: FButtonType.primary)
FButton("小型按钮",size: FButtonSize.small, type: FButtonType.primary)
FButton("迷你按钮",size: FButtonSize.mini, type: FButtonType.primary)
```

### 块级元素

按钮在默认情况下为行内块级元素，通过 `block` 属性可以将按钮的元素类型设置为块级元素。

```dart
FButton("块级元素", block: true, type: FButtonType.primary)
```

### 自定义颜色

通过`color`属性以及`gradient`属性自定义按钮的颜色。

```dart
FButton("单色元素", color: Color(0xFF7232dd))
FButton("单色元素", plain: true, color: Color(0xFF7232dd))
FButton("渐变色元素",
    gradient: LinearGradient(
    /// 渐变位置
    begin: Alignment.centerLeft, // 左边
    end: Alignment.centerRight, // 右边
    stops: [0.0, 1.0], // [渐变起始点, 渐变结束点]
    /// 渐变颜色[始点颜色, 结束颜色]
    colors: [Color(0xFFff6034), Color(0xFFee0a24)]))
```

## API

### Props

| 参数         | 说明                                                  | 类型                  | 默认值        |
| ------------ | ----------------------------------------------------- | --------------------- | ------------- |
| type         | 类型，可选值为 `primary` `success` `warning` `danger` | _FButtonType_         | `defaultType` |
| size         | 尺寸，可选值为 `large` `small` `mini`                 | _FButtonSize_         | `normal`      |
| color        | 按钮颜色                                              | _Color_               | -             |
| gradient     | 支持传入该属性实现渐变色,优先级高于`color`            | _Gradient_            | -             |
| icon         | 左侧图标名称,FantIcon提供了Icon组件的所有图标         | _IconData_ _FantIcon_ | -             |
| url          | 左侧图标提供url链接**支持本地**                       | _String_              | -             |
| iconPosition | 图标展示位置，可选值为 `right`                        | _IconPosition_        | `left`        |
| block        | 是否为块级组件[占据整行]                              | _bool_                | `false`       |
| plain        | 是否为朴素按钮                                        | _bool_                | `false`       |
| square       | 是否为方形按钮                                        | _bool_                | `false`       |
| round        | 是否为圆形按钮                                        | _bool_                | `false`       |
| disabled     | 是否禁用按钮                                          | _bool_                | `false`       |
| hairline     | 是否使用 0.5px 边框                                   | _bool_                | `false`       |
| loading      | 是否显示为加载状态                                    | _bool_                | `false`       |
| loadingText  | 加载状态提示文字                                      | _bool_                | `false`       |
| loadingType  | 加载图标类型，可选值为 `spinner`                      | _LoadingType_         | `circular`    |
| loadingSize  | 加载图标大小                                          | _double_              | `20`          |
| switchActive | 水波纹[飞溅] 与  高亮切换[自制]                       | _FTapState_           | `highlighted` |
| elevation    | 阴影                                                  | _double_              | `0.0`         |

### Events

| 事件名      | 说明           | 类型                       |
| ----------- | -------------- | -------------------------- |
| onTap       | 点击时触发     | _GestureTapCallback_       |
| onDoubleTap | 双击时触发     | _GestureLongPressCallback_ |
| onLongPress | 长按时触发     | _GestureLongPressCallback_ |
| onTapDown   | 触摸按下时触发 | _GestureTapDownCallback_   |
| onTapCancel | 点击取消时触发 | _GestureTapCancelCallback_ |


### 类似于Slots

| 名称        | 说明                     |
| ----------- | ------------------------ |
| child       | 自定义中间文本`Text`组件 |
| iconSlot    | `icon`插槽,自定义`Icon`  |
| loadingSlot | 自定义`loading`加载      |