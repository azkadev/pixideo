/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/material.dart';

import 'config.dart';
import 'providers.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension VideoExtension on BuildContext {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  VideoContext get video => VideoContext._(this);
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class VideoContext {
  const VideoContext._(this.context);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final BuildContext context;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get currentFrame {
    final frame = context.dependOnInheritedWidgetOfExactType<CurrentFrameProvider>()?.frame;
    assert(frame != null, 'No Composition found in the widget tree');
    return frame!;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  VideoConfig get config {
    final config = context.dependOnInheritedWidgetOfExactType<VideoConfigProvider>()?.config;
    assert(config != null, 'No Composition found in the widget tree');
    return config!;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  double time([int fromFrame = 0, int? toFrame]) {
    final currentFrame = this.currentFrame;
    final config = this.config;
    final effectiveToFrame = toFrame ?? config.durationInFrames - 1;
    if (currentFrame <= fromFrame) return 0;
    if (currentFrame >= effectiveToFrame) return 1;
    return (currentFrame - fromFrame) / (effectiveToFrame - fromFrame);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Animation<double> timeAnimation([int fromFrame = 0, int? toFrame]) {
    return AlwaysStoppedAnimation(time(fromFrame, toFrame));
  }
}
