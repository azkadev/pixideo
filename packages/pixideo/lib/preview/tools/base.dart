/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/material.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PreviewToolBase extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PreviewToolBase({
    super.key,
    required this.child,
    required this.height,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final double height;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryData.fromView(View.of(context));
    return MediaQuery(
      data: mediaQuery,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            width: mediaQuery.size.width,
            height: height,
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  maintainState: true,
                  opaque: true,
                  builder: (context) {
                    return Material(
                      color: Colors.transparent,
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
