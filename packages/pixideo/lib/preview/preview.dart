/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pixideo/core/pixideo.dart';

import 'actions.dart';
import 'controller.dart';
import 'tools/tool_panel.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PixideoPreview extends StatefulWidget {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool timeline;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool panel;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PixideoPreview({
    super.key,
    required this.timeline,
    required this.panel,
    required this.child,
  });

  @override
  State<PixideoPreview> createState() => _PixideoPreviewState();
}

class _PixideoPreviewState extends State<PixideoPreview> with TickerProviderStateMixin {
  late final controller = PreviewPixideoController(
    vsync: this,
  );

  final FocusNode focus = FocusNode();

  final videoKey = GlobalKey();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newSize = Size(
      (controller.config?.width ?? 1920).toDouble(),
      (controller.config?.height ?? 1080).toDouble(),
    );
    return PreviewActions(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff000000),
                  Color(0xff222222),
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
              ),
              child: FittedBox(
                child: Container(
                  color: const Color(0xbb000000),
                  width: (controller.config?.width ?? 1920).toDouble(),
                  height: (controller.config?.height ?? 1080).toDouble(),
                  child: ClipRect(
                    child: Pixideo(
                      controller: controller,
                      child: KeyedSubtree(
                        key: videoKey,
                        child: SizedBox.fromSize(
                          size: newSize,
                          child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              size: newSize,
                            ),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.panel) ...[
            PreviewToolPanel(
              videoKey: videoKey,
              controller: controller,
              timeline: widget.timeline,
            ),
          ],
        ],
      ),
    );
  }
}
