/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pixideo/preview/actions.dart';
import 'package:pixideo/preview/controller.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PreviewToolbar extends StatelessWidget {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PreviewToolbar({
    super.key,
    required this.controller,
    required this.isTimelineVisible,
    required this.onTimelineVisibleChanged,
    required this.canUpdateTimelineVisibility,
  });

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final PreviewPixideoController controller;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool canUpdateTimelineVisibility;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool isTimelineVisible;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final VoidCallback onTimelineVisibleChanged;

  @override
  Widget build(BuildContext context) {
    final frame = controller.frame;
    final config = controller.config;
    if (config == null) {
      return const SizedBox();
    }
    final orderedMarkers = [...controller.markers].toList()..sort((x, y) => x.at.asFrames(config.durationInFrames, config.fps).compareTo(y.at.asFrames(config.durationInFrames, config.fps)));
    final previousMarker = orderedMarkers.lastWhereOrNull(
      (x) => x.at.asFrames(config.durationInFrames, config.fps) <= frame,
    );
    ThemeData themeData = Theme.of(context);
    final iconColor = themeData.iconTheme.color;
    final textTheme = themeData.textTheme;
    final bodySmall = textTheme.bodySmall ?? TextStyle();
    return Stack(
      children: [
        Container(
          color: themeData.scaffoldBackgroundColor,
          // color: const Color(0xff101010),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.fast_rewind_sharp),
                      onPressed: () => GoToPreviousMarkerActionIntent.invoke(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () => PreviousFrameActionIntent.invoke(context),
                    ),
                    IconButton(
                      icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () => PreviewActionIntent.invoke(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: () => NextFrameActionIntent.invoke(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.fast_forward_sharp),
                      onPressed: () => GoToNextMarkerActionIntent.invoke(context),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 0.5,
                            children: [
                              if (previousMarker != null) ...[
                                Text(
                                  previousMarker.name,
                                  // style: TextStyle(
                                  //   color: previousMarker.color,
                                  //   fontWeight: FontWeight.bold,
                                  //   fontSize: 10,
                                  // ),
                                  style: bodySmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                              Text(
                                '${_formatDuration(config.durationForFrames(frame))}/'
                                '${_formatDuration(config.durationForFrames(config.durationInFrames))}',
                                // style: const TextStyle(
                                //   color: Colors.white,
                                //   fontSize: 10,
                                // ),
                                style: bodySmall.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Text(
                              '$frame/${config.durationInFrames - 1}',
                              // style: const TextStyle(
                              //   color: Colors.white54,
                              //   fontSize: 10,
                              // ),
                              
                                style: bodySmall.copyWith(
                                  fontSize: 10,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (canUpdateTimelineVisibility) ...[
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        transformAlignment: Alignment.center,
                        transform: Matrix4.rotationZ(isTimelineVisible ? -pi / 2 : pi / 2),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () => onTimelineVisibleChanged(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 2,
          child: FractionallySizedBox(
            alignment: Alignment.topLeft,
            widthFactor: controller.frame / (config.durationInFrames - 1),
            child: Container(
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }
}

String _formatDuration(Duration duration) {
  return '${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.toString().padLeft(2, '0')}';
}
