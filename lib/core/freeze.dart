/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/widgets.dart';
import 'package:pixideo/core/context_extensions.dart';
import 'package:pixideo/core/time.dart';

import 'providers.dart';

/// All child animation considers the time freezed to the given [time].
class Freeze extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Freeze({
    super.key,
    required this.child,
    required this.time,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time time;

  @override
  Widget build(BuildContext context) {
    final config = context.video.config;
    final frame = time.asFrames(config.durationInFrames, config.fps);
    return CurrentFrameProvider(
      frame: frame,
      child: child,
    );
  }
}
