// ignore_for_file: empty_catches, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:pixideo/dart/event_emitter/event_emitter.dart' show EventEmitterAzkadevAzkadev, EventEmitterAzkadevListenerAzkadev;
import 'package:pixideo/dart/ffi/pixideo_native.dart' show PixideoNativeLibraryByAzkadev;

import 'package:pixideo/dart/uuid/uuid.dart';

/// No Doc Azkadev
class PixideoDart {
  final EventEmitterAzkadevAzkadev _eventEmitter = EventEmitterAzkadevAzkadev();

  static String _pathNativeLibrary = "";
  static PixideoNativeLibraryByAzkadev _pixideoNativeLibraryByAzkadev = PixideoNativeLibraryByAzkadev(DynamicLibrary.process());

  static NativeCallable<Void Function(Pointer<Char>)> _initializedNativeLibraryNativeCallbackFunction({
    required EventEmitterAzkadevAzkadev eventEmitter,
  }) {
    return NativeCallable<Void Function(Pointer<Char>)>.listener((Pointer<Char> raw) {
      try {
        final valueRaw = raw.cast<Utf8>();
        final value = valueRaw.toDartString();
        if (value.isNotEmpty) {
          final Map updateRaw = json.decode(value);
          eventEmitter.emit(
            eventName: () {
              if (updateRaw["@extra"] is String) {
                return "invoke";
              }
              return "update";
            }(),
            value: updateRaw,
          );
        }
        try {
          malloc.free(valueRaw);
        } catch (e) {}
      } catch (e) {}
    });
  }

  bool _isInitialized = false;

  /// No Doc Azkadev
  String getLibraryExtension() {
    if (Platform.isMacOS || Platform.isIOS) {
      return "dylib";
    }
    if (Platform.isWindows) {
      return "dll";
    }
    return "so";
  }

  /// No Doc Azkadev
  String getNativeLibraryPath({
    String pathNativeLibrary = "",
  }) {
    if (pathNativeLibrary.isEmpty) {
      return "libpixideo.${getLibraryExtension()}";
    }
    return pathNativeLibrary;
  }

  /// No Doc Azkadev
  void ensureInitialized({
    String pathNativeLibrary = "",
  }) {
    _pathNativeLibrary = getNativeLibraryPath(pathNativeLibrary: pathNativeLibrary);
    PixideoDart._pixideoNativeLibraryByAzkadev = PixideoNativeLibraryByAzkadev(DynamicLibrary.open(_pathNativeLibrary));
    final nativeCallback = Pointer.fromAddress(
      PixideoDart._initializedNativeLibraryNativeCallbackFunction(
        eventEmitter: _eventEmitter,
      ).nativeFunction.address,
    );
    PixideoDart._pixideoNativeLibraryByAzkadev.InitializedPixideoByAzkadevNativeCallbackFunction(nativeCallback.cast());
    return;
  }

  /// No Doc Azkadev

  Future<void> initialized() async {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;
  }

  /// No Doc Azkadev
  Map nativeLibraryInvokeRaw(Map parameters) {
    final parametersNative = json.encode(parameters).toNativeUtf8().cast<Char>();
    final resultNative = PixideoDart._pixideoNativeLibraryByAzkadev.InvokePixideoByAzkadevNativeFunction(parametersNative);
    return json.decode(resultNative.cast<Utf8>().toDartString());
  }

  /// No Doc Azkadev
  EventEmitterAzkadevListenerAzkadev on(String eventName, FutureOr<dynamic> Function(Map update) onCallback) {
    return _eventEmitter.on(
      eventName: eventName,
      onCallback: (update) async {
        try {
          if (update is Map) {
            await onCallback(update);
          }
        } catch (e) {}
      },
    );
  }

  /// untuk membuat client nativeLibrary
  ///
  /// hasil akan urut mulai dari 1,2,3,4 seterusnya
  int createClient() {
    final result = nativeLibraryInvokeRaw({
      "@type": "createClient",
    });
    return result["client_id"];
  }

  /// untuk invoke nativeLibrary sync
  /// tidak semua method bisa hanya beberapa method
  Map invokeSync(Map parameters) {
    parameters["@is_sync"] = true;
    return nativeLibraryInvokeRaw(parameters);
  }

  /// untuk invoke nativeLibrary sync
  /// memanggil segala jenis api ini inti program
  /// sehingga kamu tidak perlu menunggu saya update karena kamu hanya perlu compile
  /// nativeLibrary jadi semua method bisa di panggil seperti biasa
  Future<Map> invoke(Map parameters) async {
    final String extra = switch (parameters["@extra"]) {
      String value => value,
      Object() => "1759205137778_${generateUuidAzkadev(10)}",
      null => "1759205137778_${generateUuidAzkadev(10)}",
    };
    parameters["@extra"] = extra;
    final Completer<Map> completer = Completer<Map>();
    final listener = on(
      "invoke",
      (update) async {
        if (!completer.isCompleted && update["@extra"] == extra) {
          completer.complete(update);
        }
      },
    );
    parameters["@is_async"] = true;
    nativeLibraryInvokeRaw(parameters);
    final result = await completer.future;
    try {
      listener.dispose();
    } catch (e) {}
    return result;
  }
  // PixideoByAzkadevNative

  Future<num> createNewPixideoController({
    required String outputFilePath,
    required num width,
    required num height,
    required num fps,
  }) async {
    final File outputFile = File(outputFilePath);
    if (outputFile.parent.existsSync() == false) {
      outputFile.parent.createSync(recursive: true);
    }
    final result = await invoke({
      "@type": "createNewPixideoControllerPixideoByAzkadevNative",
      "output_file_path": outputFile.path,
      "width": width.toInt(),
      "height": height.toInt(),
      "fps": fps.toInt(),
    });

    return switch (result["pixideo_controller_id"]) {
      num value => value.toInt(),
      // TODO: Handle this case.
      Object() => 0,
      // TODO: Handle this case.
      null => 0,
    };
  }

  Future<bool> addFrameByFilePath({
    required num pixideo_controller_id,
    required String file_path,
  }) async {
    final result = await invoke({
      "@type": "addFrameByFilePathPixideoByAzkadevNative",
      "pixideo_controller_id": pixideo_controller_id,
      "file_path": file_path,
    });
    return result["@type"] == "ok";
  }

  Future<void> disposeController({
    required num pixideo_controller_id,
  }) async {
   await invoke({
      "@type": "disposePixideoByAzkadevNative",
      "pixideo_controller_id": pixideo_controller_id,
    });
    return;
  }
}
