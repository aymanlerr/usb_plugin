
# usb_plugin

An Android USB Plugin Flutter Plugin

This plugin allows Flutter code to detect USB devices connected to your Android device.

## Getting Started

Add a dependency to your pubspec.yaml

```dart
dependencies:
	usb_plugin: ^0.0.1
```

include the usbserial package at the top of your dart file.

```dart
import 'package:usb_plugin/usb_plugin.dart';
```

## Check USB device is connected

To check if any USB device is being connected to Android phone you can use the following function:

```dart
...
final _usbPlugin = UsbPlugin();
...
onPressed: () async {
	int? usbState = await _usbPlugin.checkUsbState();
	print(usbState); // 0-false or 1-true
}
...
```

## Check realtime USB device is connected

We can use Stream to check realtime USB device is connected follow by this 'stateUsbStream':

```dart

    ...
    final _usbPlugin = UsbPlugin();
    ...

    _usbPlugin.stateUsbStream().listen( (data) {
      print('The state of USB Connected: $data'); // 0-false or 1-true
    });

```

## FAQ

### You can ask questions through:
https://github.com/DinhNam99/usb_plugin/issues/


## Dependencies

This library depends on:

https://github.com/DinhNam99/usb_plugin
