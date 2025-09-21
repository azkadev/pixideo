/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/widgets.dart';
import 'package:pixideo/pixideo.dart';

import 'providers.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class Pixideo extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final TextDirection textDirection;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final PixideoController controller;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Pixideo({
    super.key,
    required this.controller,
    required this.child,
    this.textDirection = TextDirection.ltr,
  });


/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  VideoContext of(BuildContext context) => context.video;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: PixideoControllerProvider(
        controller: controller,
        child: AnimatedBuilder(
          animation: controller,
          child: child,
          builder: (context, child) { 
            return CurrentFrameProvider(
              frame: controller.frame,
              child: child ?? const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
