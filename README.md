# flutter_barometer

A flutter plugin to access the barometer sensor.

## Usage

To use this plugin, add `flutter_barometer` as a [dependency in your pubspec.yaml 
file](https://flutter.dev/docs/development/platform-integration/platform-channels).

This will expose the class of sensor events.

- `FlutterBarometerEvent`s describe the pressure of the device.


### Example

``` dart
import 'package:flutter_barometer/flutter_barometer.dart';

flutterBarometerEvents.listen((FlutterBarometerEvent event) {
  print(event);
})
// [FlutterBarometerEvent (pressure: 1000.0)]

```

Also see the `example` subdirectory for an example application that uses the
sensor data.
