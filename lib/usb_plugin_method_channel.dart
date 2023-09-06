import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:usb_plugin/usb_plugin.dart';

import 'usb_plugin_platform_interface.dart';

/// An implementation of [UsbPluginPlatform] that uses method channels.
class MethodChannelUsbPlugin extends UsbPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('$NAMESPACE/methods');

  final EventChannel _stateUsbBleChannel =
      const EventChannel("$NAMESPACE/state_usb");

  @override
  Future<int?> checkUsbState() async {
    return await methodChannel.invokeMethod<int>("checkStateUsb");
  }

  @override
  Stream<int> stateUsbStream() {
    return _stateUsbBleChannel.receiveBroadcastStream().map((event) {
      return int.parse(event.toString());
    });
  }
}
