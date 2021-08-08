import 'package:flutter/material.dart';

import 'var.dart';

class FOverlayTheme {
  Color overlayBackgroundColor({Color? backgroundColor, double? opacity}) {
    return (backgroundColor ?? overlay_background_color)
        .withOpacity(opacity ?? overlayOpacity);
  }
}
