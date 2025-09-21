/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
import 'package:equatable/equatable.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class VideoConfig extends Equatable {
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const VideoConfig({
    required this.durationInFrames,
    required this.fps,
    required this.width,
    required this.height,
  });
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int durationInFrames;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int fps;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int width;
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int height;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  int framesForDuration(Duration duration) {
    return duration.inSeconds * fps;
  }

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Duration durationForFrames(int durationInFrames) {
    return Duration(seconds: (durationInFrames / fps).floor());
  }

  @override
  List<Object?> get props => [
        durationInFrames,
        fps,
        width,
        height,
      ];
}
