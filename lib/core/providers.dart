/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/material.dart';
import 'package:pixideo/core/controller.dart';

import 'config.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PixideoControllerProvider extends InheritedWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PixideoControllerProvider({
    super.key,
    required super.child,
    required this.controller,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final PixideoController controller;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static PixideoController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PixideoControllerProvider>()!
        .controller;
  }

  @override
  bool updateShouldNotify(covariant PixideoControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class CurrentFrameProvider extends InheritedWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const CurrentFrameProvider({
    super.key,
    required super.child,
    required this.frame,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int frame;

  @override
  bool updateShouldNotify(covariant CurrentFrameProvider oldWidget) {
    return oldWidget.frame != frame;
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class VideoConfigProvider extends InheritedWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const VideoConfigProvider({
    super.key,
    required super.child,
    required this.config,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final VideoConfig config;

  @override
  bool updateShouldNotify(covariant VideoConfigProvider oldWidget) {
    return oldWidget.config != config;
  }
}
