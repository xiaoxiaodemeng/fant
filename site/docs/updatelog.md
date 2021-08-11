## 更新日志

### 提示

当前文档是vant在flutter版的更新日志,非官方库,由个人维护

## 更新内容


### v0.0.1

- Bug Fixes
  - 修复`FPopup`组件显示在中间的时候关闭按钮渲染问题(利用`UnconstrainedBox`解决)
  - 修复`FOverlay`组件为重置成null的问题,导致`dispose`会再次执行`remove`而报错
  - 修复`FOverlay`使用`Overlay`api未执行`insert`(插入),就执行了`remove`的问题
  - 修复`FBadge`组件在`ListView`组件下渲染的问题
- to-do
  - 待定是否修改`FButton`的在ListView的行为(与上述`FBadge`一致)

### v0.0.1

`2021/8/9`~`2021/8/10`

- Feature
  - 新增`FButton`组件(暂不支持提供跳转链接功能类似于`vant`的`url`、`replace`以及`to`属性)
  - 新增`FCell`组件和`FcCellGroup`组件(暂不支持提供跳转链接功能类似于`vant`的`url`、`replace`以及`to`属性)

- Bug Fixes
  - 修复`FButton`按钮组件渐变状态下点击态高亮的显示问题(修改逻辑布局)
  - 修复`FCell`的`label`层距离`title`无距离的问题
  - 修复`FCell`的左边`FIcon`显示不居中的问题(新增最小高度)
  - 修复`FButton`按钮组件的text继承问题(采用`DefaultTextStyle`组件)
  - 修复`FOverlay`组件`Transform`超出可视范围内的渲染，没有进行剪切(`Container`组件的`clipBehavior`属性必须配合`decoration`才可以生效)

- Optimize
  - 优化`FOverlay`组件的透明度动画逻辑，采用自制`transition`组件(整个项目统一)
  - 优化`FPopup`组件的显示问题,去除内容部分的透明度动画
  - 优化`FPopup`组件动画问题,采用`FTransition`组件
  - 优化`FCell`组件的Text使用继承机制(`DefaultTextStyle`)
  - 修改`FCell`组件的`border`属性默认为`true`,也就是需要开发者自行去解决最后一个是否需要`border`