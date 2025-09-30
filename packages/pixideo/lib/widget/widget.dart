/* <!-- START LICENSE -->


pixideo https://github.com/azkadev/pixideo


<!-- END LICENSE --> */
// ignore_for_file: avoid_print, use_build_context_synchronously, empty_catches

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pixideo/core/pixideo.dart';
import 'package:pixideo/dart/core/core.dart';
import 'package:pixideo/preview/preview.dart';
import 'package:pixideo/pixideo.dart';

//   image: "^4.5.4"

import "package:image/image.dart" as img;

import "package:path/path.dart" as path;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class PixideoWidget extends StatelessWidget {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String appTitle;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final PixideoController controller;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Composition composition;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer

  final Directory directoryProject;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer

  final String projectName;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const PixideoWidget({
    super.key,
    this.appTitle = "Pixideo Azkadev | Azka Axelion Gibran",
    required this.controller,
    required this.composition,
    required this.directoryProject,
    required this.projectName,
  });

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer

  static final PixideoDart pixideoDart = () {
    final PixideoDart pixideoDart = PixideoDart();
    try {
      pixideoDart.ensureInitialized();
    } catch (e) {}
    return pixideoDart;
  }();

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer

  static Widget contentByAzkadevWidget({
    required BuildContext context,
    required final PixideoController controller,
    required final Composition composition,
  }) {
    final Size newSize = Size(
      composition.config.width.toDouble(),
      composition.config.height.toDouble(),
    );
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox.fromSize(
              size: newSize,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  size: newSize,
                ),
                child: RepaintBoundary(
                  key: controller.globalKey,
                  child: Pixideo(
                    controller: controller,
                    child: composition,
                  ),
                ),
              ),
            ),
          ),
        ),
        PixideoPreview(
          timeline: true,
          panel: true,
          child: composition,
        ),
      ],
    );
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer

  static Future<File> renderVideoByAzkadev({
    required BuildContext context,
    required final PixideoController controller,
    required final Directory directoryProject,
    required final String projectName,
    required final ValueNotifier<String> loadingTextController,
    bool? isUseBuiltInVideoRendering = true,
  }) async {
    final config = controller.config!;
    final Directory directoryVideo = Directory(path.join(directoryProject.path, projectName));
    if (directoryVideo.existsSync()) {
      directoryVideo.deleteSync(recursive: true);
    }
    directoryVideo.createSync(recursive: true);

    final Directory directoryFrames = Directory(
      path.join(
        directoryVideo.path,
        "frames",
      ),
    );
    if (directoryFrames.existsSync()) {
      directoryFrames.deleteSync(recursive: true);
    }
    final bool isUseBuiltInRendering = isUseBuiltInVideoRendering ?? Platform.isAndroid || Platform.isIOS;
    final outputFile = File(
      path.join(
        directoryVideo.path,
        isUseBuiltInRendering ? 'video.avi' : 'video.webm',
      ),
    );

    if (outputFile.parent.existsSync() == false) {
      outputFile.parent.createSync(recursive: true);
    }

    final configFile = File(
      path.join(directoryVideo.path, 'config.json'),
    );
    final Map configJsonRaw = {
      'width': config.width,
      'height': config.height,
      'fps': config.fps,
      'durationInFrames': config.durationInFrames,
    };
    final configJson = jsonEncode(configJsonRaw);

    configFile.writeAsStringSync(configJson);
    loadingTextController.value = "Render menjadi gambar dahulu";

    final num pixideoControllerId = await Future(() async {
      if (isUseBuiltInRendering) {
        return await PixideoWidget.pixideoDart.createNewPixideoController(
          outputFilePath: outputFile.path,
          width: config.width,
          height: config.height,
          fps: config.fps,
        );
      }
      return 0;
    });
    for (var frame = 0; frame < config.durationInFrames; frame++) {
      loadingTextController.value = """
Render Frame ${frame}/${config.durationInFrames}
"""
          .trim();
      controller.updateFrame(frame);
      final videoContext = controller.globalKey.currentContext;
      if (videoContext == null) {
        continue;
      }
      final RenderRepaintBoundary boundary = videoContext.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        continue;
      }

      final frameFile = File(
        path.join(
          directoryFrames.path,
          isUseBuiltInRendering ? '${frame}.jpg' : '${frame}.png',
        ),
      );
      if (isUseBuiltInRendering) {
        loadingTextController.value = """
Convert Frame ${frame}/${config.durationInFrames}
"""
            .trim();
        final bytes = byteData.buffer.asUint8List();
        final frameFilePath = frameFile.path;
        final result = await Isolate.run(() async {
          final frameFile = File(frameFilePath);
          final image = img.decodePng(bytes);
          if (image == null) {
            return false;
          }
          final buffer = img.encodeJpg(image);
          try {
            await frameFile.parent.create(recursive: true);
            await frameFile.writeAsBytes(buffer, flush: true);
            return true;
          } catch (e) {}
          return false;
        });
        if (result) {
          await pixideoDart.addFrameByFilePath(
            pixideo_controller_id: pixideoControllerId,
            file_path: frameFile.path,
          );
        }
        // final image = img.decodePng(byteData.buffer.asUint8List());
        // if (image == null) {
        //   continue;
        // }
        // final buffer = img.encodeJpg(image);
        // try {
        //   await frameFile.parent.create(recursive: true);
        //   await frameFile.writeAsBytes(buffer, flush: true);
        //   await pixideoDart.addFrameByFilePath(
        //     pixideo_controller_id: pixideoControllerId,
        //     file_path: frameFile.path,
        //   );
        // } catch (e) {}
      } else {
        try {
          await frameFile.parent.create(recursive: true);
          await frameFile.writeAsBytes(byteData.buffer.asInt8List(), flush: true);
        } catch (e) {}
      }
    }
    loadingTextController.value = "Render To Video\nProcces Ini lebih lama";

    if (isUseBuiltInRendering) {
      await pixideoDart.disposeController(
        pixideo_controller_id: pixideoControllerId,
      );
      try {
        directoryFrames.deleteSync(recursive: true);
      } catch (e) {}
    } else {
      final process = await Process.start('ffmpeg', [
        '-i',
        path.join(directoryFrames.path, "%d.png"),
        '-pix_fmt',
        'yuva420p',
        '-filter:v',
        'fps=${configJsonRaw['fps']}',
        outputFile.path,
      ]);

      // process.stdout.listen((e) {
      //   try {
      //     loadingTextController.value = utf8.decode(e, allowMalformed: true);
      //   } catch (e) {}
      // });
      // process.stderr.listen((e) {
      //   try {
      //     loadingTextController.value = utf8.decode(e, allowMalformed: true);
      //   } catch (e) {}
      // });
      final exitCode = await process.exitCode;
      try {
        directoryFrames.deleteSync(recursive: true);
      } catch (e) {}
      if (exitCode != 0) {
        throw Exception();
      }
    }
    return outputFile;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appTitle,
          style: textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    "Render",
                  ),
                  onTap: () {
                    Future(() async {
                      final ValueNotifier<String> loadingTextController = ValueNotifier<String>("");
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          MediaQueryData mediaQueryData = MediaQuery.of(context);
                          return Scaffold(
                            backgroundColor: Colors.transparent,
                            body: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: mediaQueryData.size.height,
                                  minWidth: mediaQueryData.size.width,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    ListenableBuilder(
                                      listenable: loadingTextController,
                                      builder: (context, child) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: themeData.scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: 10,
                                            children: [
                                              CircularProgressIndicator(),
                                              Text(
                                                loadingTextController.value,
                                                style: themeData.textTheme.titleSmall,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      final outputFile = await PixideoWidget.renderVideoByAzkadev(
                        context: context,
                        controller: controller,
                        loadingTextController: loadingTextController,
                        directoryProject: directoryProject,
                        projectName: projectName,
                      );
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Saved: And Copied"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      await Clipboard.setData(ClipboardData(text: outputFile.path));
                    });
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: PixideoWidget.contentByAzkadevWidget(
        context: context,
        controller: controller,
        composition: composition,
      ),
    );
  }
}
