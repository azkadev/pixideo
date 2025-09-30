/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
// ignore_for_file: prefer_initializing_formals

import 'package:flutter/widgets.dart';

import 'config.dart';
import 'context_extensions.dart';
import 'providers.dart';
import 'time.dart';

/// Repeats all children animations during the given [duration].
///
/// When children are reading the configuration and current frame, they are
/// overriden to be relative to the loop iteration.
class Loop extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Loop({
    super.key,
    required this.child,
    required this.duration,
    this.name,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String? name;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time duration;

  @override
  Widget build(BuildContext context) {
    final frame = context.video.currentFrame;
    final config = context.video.config;
    final durationInFrames =
        duration.asFrames(config.durationInFrames, config.fps);
    return VideoConfigProvider(
      config: VideoConfig(
        fps: config.fps,
        durationInFrames: durationInFrames,
        width: config.width,
        height: config.height,
      ),
      child: CurrentFrameProvider(
        frame: frame % durationInFrames,
        child: child,
      ),
    );
  }
}
