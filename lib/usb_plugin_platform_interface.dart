import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'usb_plugin_method_channel.dart';

abstract class UsbPluginPlatform extends PlatformInterface {
  /// Constructs a UsbPluginPlatform.
  UsbPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static UsbPluginPlatform _instance = MethodChannelUsbPlugin();

  /// The default instance of [UsbPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelUsbPlugin].
  static UsbPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UsbPluginPlatform] when
  /// they register themselves.
  static set instance(UsbPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> checkUsbState() {
    throw UnimplementedError("Check usb state has not been implemented.");
  }

  Stream<int> stateUsbStream() {
    throw UnimplementedError("State Usb stram has not been implemented.");
  }
}
