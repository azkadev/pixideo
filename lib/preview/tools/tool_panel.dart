/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/material.dart';
import 'package:pixideo/preview/controller.dart';
import 'base.dart';
import 'timeline.dart';
import 'toolbar.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PreviewToolPanel extends StatefulWidget {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool timeline;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final GlobalKey videoKey;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final PreviewPixideoController controller;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PreviewToolPanel({
    super.key,
    required this.timeline,
    required this.videoKey,
    required this.controller,
  });

  @override
  State<PreviewToolPanel> createState() => _PreviewToolPanelState();
}

class _PreviewToolPanelState extends State<PreviewToolPanel> {
  late final ValueNotifier<bool> isTimelineVisible = ValueNotifier(widget.timeline);

  @override
  void didUpdateWidget(covariant PreviewToolPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timeline != oldWidget.timeline) {
      if (!widget.timeline) {
        isTimelineVisible.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Material(
      color: themeData.scaffoldBackgroundColor,
      // color: const Color(0xff111111),
      child: PreviewToolBase(
        height: isTimelineVisible.value ? 300 + 40 : 40,
        // height: double.infinity,
        child: AnimatedBuilder(
          animation: isTimelineVisible,
          builder: (context, child) {
            return contentWidget(context: context);
          },
        ),
      ),
    );
  }

  Widget contentWidget({
    required BuildContext context,
  }) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final videoContext = widget.videoKey.currentContext;
        final config = widget.controller.config;
        final bool isShowTimeLine = widget.timeline && videoContext is Element && config != null && isTimelineVisible.value;
        final Widget child = PreviewToolbar(
          canUpdateTimelineVisibility: widget.timeline,
          controller: widget.controller,
          isTimelineVisible: isTimelineVisible.value,
          onTimelineVisibleChanged: () {
            setState(() {
              isTimelineVisible.value = !isTimelineVisible.value;
            });
          },
        );
        if (isShowTimeLine == false) {
          return child;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            if (isShowTimeLine) ...[
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: TimelinePreview(
                    key: const Key('Timeline'),
                    videoElement: videoContext,
                    durationInFrames: config.durationInFrames,
                    fps: config.fps,
                    controller: widget.controller,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
