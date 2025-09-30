/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'config.dart';
import 'markers.dart';
 
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PixideoController extends ChangeNotifier {

  final GlobalKey globalKey = GlobalKey();
  int _frame = 0;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int get frame => _frame;

  @protected
  set frame(int frame) {
    if (_frame != frame) {
      _frame = frame;
      notifyListeners();
    }
  }

  VideoConfig? _config;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  VideoConfig? get config => _config;

  set config(VideoConfig? config) {
    final oldConfig = _config;
    if (oldConfig != null && config != null) {
      final newConfig = VideoConfig(
        durationInFrames: max(
          oldConfig.durationInFrames,
          config.durationInFrames,
        ),
        fps: max(
          oldConfig.fps,
          config.fps,
        ),
        width: max(
          oldConfig.width,
          config.width,
        ),
        height: max(
          oldConfig.height,
          config.height,
        ),
      );

      if (newConfig != oldConfig) {
        _config = newConfig;
        notifyListeners();
      }
    } else if (oldConfig != config) {
      _config = config;
      notifyListeners();
    }
  }

  final List<Marker> _markers = <Marker>[];
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  List<Marker> get markers => _markers;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void addMarkers(List<Marker> markers) {
    _markers.addAll(markers);
    notifyListeners();
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void removeMarkers(List<Marker> markers) {
    bool deleted = false;
    for (var marker in markers) {
      deleted = _markers.remove(marker) || deleted;
    }
    if (deleted) notifyListeners();
  }


/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void updateFrame(int frame) => this.frame = frame;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
enum FrameStatus {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  delayed,
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ready,
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  rendered,
}
