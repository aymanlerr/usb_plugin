import 'package:flutter_test/flutter_test.dart';
import 'package:usb_plugin/usb_plugin.dart';
import 'package:usb_plugin/usb_plugin_platform_interface.dart';
import 'package:usb_plugin/usb_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUsbPluginPlatform
    with MockPlatformInterfaceMixin
    implements UsbPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UsbPluginPlatform initialPlatform = UsbPluginPlatform.instance;

  test('$MethodChannelUsbPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUsbPlugin>());
  });

  test('getPlatformVersion', () async {
    UsbPlugin usbPlugin = UsbPlugin();
    MockUsbPluginPlatform fakePlatform = MockUsbPluginPlatform();
    UsbPluginPlatform.instance = fakePlatform;

    expect(await usbPlugin.getPlatformVersion(), '42');
  });
}
