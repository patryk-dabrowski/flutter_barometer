#import "FlutterBarometerPlugin.h"
#import <CoreMotion/CoreMotion.h>

@implementation FlutterBarometerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    BarometerStreamHandler* barometerStreamHandler =
        [[BarometerStreamHandler alloc] init];
    FlutterEventChannel* barometerChannel =
        [FlutterEventChannel eventChannelWithName:@"sensors/barometer"
                                  binaryMessenger:[registrar messenger]];
    [barometerChannel setStreamHandler:barometerStreamHandler];
}

@end

CMAltimeter* _altimeterManager;


@implementation BarometerStreamHandler

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    if (!_altimeterManager) {
      _altimeterManager = [[CMAltimeter alloc] init];
    }
  [_altimeterManager
      startRelativeAltitudeUpdatesToQueue:[[NSOperationQueue alloc] init]
      withHandler:^(CMAltitudeData* _Nullable barometerData, NSError* _Nullable error) {
      Float64 value = barometerData.pressure.floatValue * 10;
      NSMutableData* event = [NSMutableData dataWithCapacity:sizeof(Float64)];
      [event appendBytes:&value length:sizeof(Float64)];
      eventSink([FlutterStandardTypedData typedDataWithFloat64:event]);
  }];
  return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
  [_altimeterManager stopRelativeAltitudeUpdates];
  return nil;
}

@end
