import 'usb_plugin_platform_interface.dart';

const NAMESPACE = 'usb_plugin';

class UsbPlugin {

  Future<int?> checkUsbState() {
    return UsbPluginPlatform.instance.checkUsbState();
  }

  Stream<int> stateUsbStream() {
    return UsbPluginPlatform.instance.stateUsbStream();
  }
}
