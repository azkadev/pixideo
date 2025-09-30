

// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';

import 'package:pixideo/dart/uuid/uuid.dart' show generateUuidAzkadev;

/// Code By Azkadev
class EventEmitterAzkadevAzkadev {
  /// Code By Azkadev
  final Map<String, Map<String, EventEmitterAzkadevListenerAzkadev>> events = {};

  /// Code By Azkadev
  EventEmitterAzkadevAzkadev();

  /// Code By Azkadev
  void emit({
    required String eventName,
    required dynamic value,
  }) {
    for (final element in events.putIfAbsent(eventName, () {
      return {};
    }).values) {
      if (element.is_pause) {
        continue;
      }
      element.onUpdate(value);
    }
  }

  /// Code By Azkadev
  EventEmitterAzkadevListenerAzkadev on({
    required String eventName,
    required FutureOr<dynamic> Function(dynamic update) onCallback,
  }) {
    final Map<String, EventEmitterAzkadevListenerAzkadev> event_datas = events.putIfAbsent(eventName, () {
      return {};
    });

    final EventEmitterAzkadevListenerAzkadev eventEmitterListenerGeneralUniverse = EventEmitterAzkadevListenerAzkadev();
    eventEmitterListenerGeneralUniverse.ensureInitiaLized(
      eventName: eventName,
      eventUniqueId: generateNewUniqueId(event_datas: event_datas),
      onUpdate: onCallback,
      onCancel: (event) {
        event_datas.remove(event.event_unique_id);
        remove(eventName: eventName, uniqueId: event.event_unique_id);
        if (event.isDisposed) {
          return;
        }
        event.isDisposed = true;
        event.dispose();
      },
    );
    event_datas[eventEmitterListenerGeneralUniverse.event_unique_id] = eventEmitterListenerGeneralUniverse;
    return eventEmitterListenerGeneralUniverse;
  }

  /// Code By Azkadev
  void remove({
    required String eventName,
    required String uniqueId,
  }) {
    final Map<String, EventEmitterAzkadevListenerAzkadev> event_datas = events.putIfAbsent(eventName, () {
      return {};
    });
    event_datas.remove(uniqueId);
  }

  /// Code By Azkadev

  String generateNewUniqueId({
    required Map<String, EventEmitterAzkadevListenerAzkadev> event_datas,
  }) {
    while (true) {
      final String new_unique_id = generateUuidAzkadev(Random().nextInt(10) + 10, text: "0123456789abcdefghijklmnopqrstuvwxyz-_");
      if (event_datas.containsKey(new_unique_id) == false) {
        return new_unique_id;
      }
    }
  }
}

/// Code By Azkadev
class EventEmitterAzkadevListenerAzkadev {
  /// Code By Azkadev
  late final String event_name;

  /// Code By Azkadev
  late final String event_unique_id;

  /// Code By Azkadev
  late final Function(EventEmitterAzkadevListenerAzkadev event) onCancel;

  /// Code By Azkadev
  late final Function(dynamic data) onUpdate;

  /// Code By Azkadev
  bool is_initialized = false;

  /// Code By Azkadev
  bool is_cancel = false;

  /// Code By Azkadev
  bool is_pause = false;

  /// GeneralUnivetse
  bool isDisposed = false;

  /// Code By Azkadev
  EventEmitterAzkadevListenerAzkadev();

  /// Code By Azkadev
  void ensureInitiaLized({
    required String eventName,
    required String eventUniqueId,
    required Function(dynamic data) onUpdate,
    required Function(EventEmitterAzkadevListenerAzkadev event) onCancel,
  }) {
    if (is_initialized) {
      return;
    }
    event_name = eventName;
    event_unique_id = eventUniqueId;
    this.onUpdate = onUpdate;
    this.onCancel = onCancel;
    is_initialized = true;
  }

  /// Code By Azkadev
  void resume() {
    is_pause = false;
  }

  /// Code By Azkadev
  void pause() {
    is_pause = true;
  }

  // @override
  //
  /// Code By Azkadev
  void dispose() {
    if (isDisposed) {
      return;
    }
    isDisposed = true;
    close();
  }

  /// Code By Azkadev
  void close() {
    isDisposed = true;
    cancel();
    return;
  }

  /// Code By Azkadev
  bool cancel() {
    if (is_initialized == false) {
      return false;
    }
    isDisposed = true;
    is_cancel = true;
    is_pause = true;
    onCancel(this);
    return true;
  }

  @override
  String toString() {
    return "$event_name $event_unique_id";
  }
}

