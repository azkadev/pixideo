/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:flutter/widgets.dart';
import 'package:pixideo/core/sequence.dart';
import 'package:pixideo/core/time.dart';

import 'context_extensions.dart';
import 'markers.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class Series extends StatelessWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Series({
    super.key,
    required this.children,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final List<SeriesSequence> children;

  @override
  Widget build(BuildContext context) {
    final frame = context.video.currentFrame;
    final config = context.video.config;

    Widget? result;
    final markers = <Marker>[];

    var from = 0;
    for (var child in children) {
      final childDurationInFrames =
          child.duration.asFrames(config.durationInFrames, config.fps);
      from += child.offset.asFrames(config.durationInFrames, config.fps);
      if (frame >= from && (from + childDurationInFrames > frame)) {
        final sequence = Sequence(
          name: child.name,
          from: Time.frames(from),
          duration: Time.frames(childDurationInFrames),
          freezeAfter: child.freezeAfter,
          freezeBefore: child.freezeBefore,
          child: child.child,
        );

        result = sequence;
      }
      final marker = child.marker;
      if (marker != null) {
        markers.add(
          marker.toMarker(Time.frames(from)),
        );
      }
      from += childDurationInFrames;
    }

    if (markers.isNotEmpty) {
      return Markers(
        markers: markers,
        child: result ?? const SizedBox(),
      );
    }

    return result ?? const SizedBox();
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class SeriesSequence {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const SeriesSequence({
    required this.child,
    required this.duration,
    this.offset = const Time.frames(0),
    this.marker,
    this.name,
    this.freezeBefore = false,
    this.freezeAfter = false,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String? name;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time offset;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time duration;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool freezeAfter;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final bool freezeBefore;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final SeriesMarker? marker;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class SeriesMarker {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const SeriesMarker(
    this.name, {
    this.color = Marker.defaultColor,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String name;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Color color;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Marker toMarker(Time at) {
    return Marker(
      at,
      name,
      color: color,
    );
  }
}
