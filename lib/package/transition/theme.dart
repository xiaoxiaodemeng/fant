import 'package:flutter/material.dart';

import '../../theme/var.dart';

class FTransitionTheme {
  /// 进入动画曲线
  Cubic get enter => animation_timing_function_enter;

  /// 退出动画曲线
  Cubic get leave => animation_timing_function_leave;

  /// 动画的时间
  Duration get duration =>
      const Duration(milliseconds: animation_duration_base);
}

