/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/widgets.dart';
import 'package:pixideo/core/time.dart';

import 'config.dart';
import 'context_extensions.dart';
import 'providers.dart';

/// Sequences are small sections in finite time that make up your video clip. By
/// using a sequence, you can time-shift the display of your children.
///
/// When children are reading the configuration and current frame, they are
/// overriden to be relative to this sequence.
class Sequence extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Sequence({
    super.key,
    required this.child,
    required this.from,
    this.name,
    this.duration,
    this.freezeBefore = false,
    this.freezeAfter = false,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String? name;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time from;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time? duration;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool freezeAfter;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool freezeBefore;

  @override
  Widget build(BuildContext context) {
    final frame = context.video.currentFrame;
    final config = context.video.config;
    final fromInFrames = from.asFrames(config.durationInFrames, config.fps);
    final durationInFrames =
        duration?.asFrames(config.durationInFrames, config.fps) ??
            config.durationInFrames - fromInFrames;
    final childConfig = VideoConfig(
      fps: config.fps,
      durationInFrames: durationInFrames,
      width: config.width,
      height: config.height,
    );
    if (frame < fromInFrames && freezeBefore) {
      return VideoConfigProvider(
        config: childConfig,
        child: CurrentFrameProvider(
          frame: 0,
          child: child,
        ),
      );
    }

    if (frame >= fromInFrames + durationInFrames && freezeAfter) {
      return VideoConfigProvider(
        config: childConfig,
        child: CurrentFrameProvider(
          frame: durationInFrames - fromInFrames,
          child: child,
        ),
      );
    }

    if (frame >= fromInFrames && frame < fromInFrames + durationInFrames) {
      return VideoConfigProvider(
        config: childConfig,
        child: CurrentFrameProvider(
          frame: (frame - fromInFrames).clamp(0, durationInFrames),
          child: child,
        ),
      );
    }

    return const SizedBox();
  }
}
