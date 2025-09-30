/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pixideo/preview/controller.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PreviewActions extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PreviewActions({
    super.key,
    required this.child,
    required this.controller,
  });
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final PreviewPixideoController controller;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowLeft):
            const PreviousFrameActionIntent(),
        LogicalKeySet(LogicalKeyboardKey.space): const PreviewActionIntent(),
        LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowRight):
            const NextFrameActionIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            const GoToPreviousMarkerActionIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight):
            const GoToNextMarkerActionIntent(),
      },
      child: Actions(
        actions: {
          PreviewActionIntent: CallbackAction<PreviewActionIntent>(
            onInvoke: (intent) => controller.togglePlay(),
          ),
          NextFrameActionIntent: CallbackAction<NextFrameActionIntent>(
            onInvoke: (intent) => controller.nextFrame(),
          ),
          PreviousFrameActionIntent: CallbackAction<PreviousFrameActionIntent>(
            onInvoke: (intent) => controller.previousFrame(),
          ),
          GoToPreviousMarkerActionIntent:
              CallbackAction<GoToPreviousMarkerActionIntent>(
            onInvoke: (intent) => controller.goToPreviousMarker(),
          ),
          GoToNextMarkerActionIntent:
              CallbackAction<GoToNextMarkerActionIntent>(
            onInvoke: (intent) => controller.goToNextMarker(),
          ),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PreviewActionIntent extends Intent {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PreviewActionIntent();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static void invoke(BuildContext context) {
    Actions.maybeInvoke<PreviewActionIntent>(
      context,
      const PreviewActionIntent(),
    );
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class NextFrameActionIntent extends Intent {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const NextFrameActionIntent();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static void invoke(BuildContext context) {
    Actions.maybeInvoke<NextFrameActionIntent>(
      context,
      const NextFrameActionIntent(),
    );
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PreviousFrameActionIntent extends Intent {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PreviousFrameActionIntent();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static void invoke(BuildContext context) {
    Actions.maybeInvoke<PreviousFrameActionIntent>(
      context,
      const PreviousFrameActionIntent(),
    );
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class GoToNextMarkerActionIntent extends Intent {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const GoToNextMarkerActionIntent();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static void invoke(BuildContext context) {
    Actions.maybeInvoke<GoToNextMarkerActionIntent>(
      context,
      const GoToNextMarkerActionIntent(),
    );
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class GoToPreviousMarkerActionIntent extends Intent {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const GoToPreviousMarkerActionIntent();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static void invoke(BuildContext context) {
    Actions.maybeInvoke<GoToPreviousMarkerActionIntent>(
      context,
      const GoToPreviousMarkerActionIntent(),
    );
  }
}
