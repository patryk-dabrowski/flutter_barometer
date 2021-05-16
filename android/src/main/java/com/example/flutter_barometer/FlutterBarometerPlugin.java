package com.example.flutter_barometer;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

/**
 * FlutterBarometerPlugin
 */
public class FlutterBarometerPlugin implements FlutterPlugin {
    private static final String BAROMETER_CHANNEL_NAME = "sensors/barometer";
    private EventChannel barometerChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final Context context = flutterPluginBinding.getApplicationContext();
        final BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
        setupEventChannels(context, messenger);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        teardownEventChannels();
    }

    private void setupEventChannels(Context context, BinaryMessenger messenger) {
        barometerChannel = new EventChannel(messenger, BAROMETER_CHANNEL_NAME);
        final StreamHandlerImpl barometerStreamHandler = new StreamHandlerImpl(
                (SensorManager) context.getSystemService(context.SENSOR_SERVICE),
                Sensor.TYPE_PRESSURE);
        barometerChannel.setStreamHandler(barometerStreamHandler);
    }

    private void teardownEventChannels() {
        barometerChannel.setStreamHandler(null);
    }
}
