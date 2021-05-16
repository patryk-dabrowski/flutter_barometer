import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_barometer/flutter_barometer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<double> _barometerValues = [0.0];

  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String> barometer =
    _barometerValues.map((double v) => v.toStringAsFixed(1)).toList();
    final String pressure = barometer.elementAt(0);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Pressure: $pressure'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(flutterBarometerEvents.listen((FlutterBarometerEvent event) {
      setState(() {
        _barometerValues = <double>[event.pressure];
      });
    }));
  }
}
