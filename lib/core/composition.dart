/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/widgets.dart';
import 'package:pixideo/core/time.dart';

import 'config.dart';
import 'providers.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class Composition extends StatefulWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time duration;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int fps;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int width;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int height;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  VideoConfig get config => VideoConfig(
        fps: fps,
        durationInFrames: duration.asFrames(0, fps),
        width: width,
        height: height,
      );
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Composition({
    super.key,
    required this.child,
    required this.duration,
    this.fps = 30,
    this.width = 1920,
    this.height = 1080,
  }) : assert(
          duration.map(
            (frames) => true,
            (percent) => false,
            (duration) => true,
          ),
          'The duration can\'t be relative',
        );

  @override
  State<Composition> createState() => _CompositionState();
}

class _CompositionState extends State<Composition> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = PixideoControllerProvider.of(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.config = widget.config;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigProvider(
      config: widget.config,
      child: widget.child,
    );
  }
}
