import 'package:flutter/services.dart';

const EventChannel _flutterBarometerEventsChannel =
    EventChannel('sensors/barometer');

class FlutterBarometerEvent {
  FlutterBarometerEvent(this.pressure);

  final double pressure;

  @override
  String toString() => '[FlutterBarometerEvent (pressure: $pressure)]';
}

FlutterBarometerEvent _listToBarometerEvent(List<double> list) {
  return FlutterBarometerEvent(list[0]);
}

Stream<FlutterBarometerEvent>? _flutterBarometerEventss;

/// A broadcast stream of events from the device barometer.
Stream<FlutterBarometerEvent> get flutterBarometerEvents {
  Stream<FlutterBarometerEvent>? flutterBarometerEventss =
      _flutterBarometerEventss;
  if (flutterBarometerEventss == null) {
    flutterBarometerEventss =
        _flutterBarometerEventsChannel.receiveBroadcastStream().map(
              (dynamic event) => _listToBarometerEvent(event.cast<double>()),
            );
    _flutterBarometerEventss = flutterBarometerEventss;
  }

  return flutterBarometerEventss;
}
