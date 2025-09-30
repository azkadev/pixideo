/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pixideo/pixideo.dart';
import 'package:pixideo/core/providers.dart';

/// Markers allows to indicate important key frames in order to navigate
/// more easily when in preview mode.
class Markers extends StatefulWidget {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Markers({
    super.key,
    required this.markers,
    required this.child,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final List<Marker> markers;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Widget child;

  @override
  State<Markers> createState() => _MarkersState();
}

class _MarkersState extends State<Markers> {
  PixideoController? controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controller == null) {
      final controller = PixideoControllerProvider.of(context);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller.addMarkers(widget.markers);
      });
      this.controller = controller;
    }
  }

  @override
  void didUpdateWidget(covariant Markers oldWidget) {
    if (!const ListEquality().equals(oldWidget.markers, widget.markers)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller?.removeMarkers(oldWidget.markers);
        controller?.addMarkers(widget.markers);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller?.removeMarkers(widget.markers);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class Marker extends Equatable {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Marker(
    this.at,
    this.name, {
    this.color = defaultColor,
  });

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String name;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Time at;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Color color;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static const defaultColor = Colors.orange;

  @override
  List<Object?> get props => [name, at, color];
}
