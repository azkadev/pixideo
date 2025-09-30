// ignore_for_file: avoid_print

 import 'dart:io';

import 'package:pixideo/dart/core/core.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  print("start");
  PixideoDart pixideoDart = PixideoDart();
  pixideoDart.ensureInitialized(
    pathNativeLibrary: "../pixideo_flutter/linux/lib/libpixideo.so",
  );
  pixideoDart.on("invoke", (update) {
    print(update);
  });
  pixideoDart.on("update", (update) {
    print(update);
  });
  Directory directory = Directory("path_to_video_generated_frame");
  final files = directory.listSync().whereType<File>().toList();

  files.sort((a, b) {
    final aNum = num.parse(path.basenameWithoutExtension(a.path)).toInt();
    final bNum = num.parse(path.basenameWithoutExtension(b.path)).toInt();
    return aNum.compareTo(bNum);
  });
  {
    final pixideoControllerId = await pixideoDart.createNewPixideoController(
      outputFilePath: "tmp/video/pixideo/dev.avi",
      width: 1920,
      height: 1080,
      fps: 30,
    );
    print(pixideoControllerId);
    for (var file in files) {
      await pixideoDart.addFrameByFilePath(
        pixideo_controller_id: pixideoControllerId,
        file_path: file.path,
      );
    }
    await pixideoDart.disposeController(
      pixideo_controller_id: pixideoControllerId,
    );
    print("done");
  }
  print("end");
  exit(0);
}
