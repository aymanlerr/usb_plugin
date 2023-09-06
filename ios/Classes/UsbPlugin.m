#import "UsbPlugin.h"
#if __has_include(<usb_plugin/usb_plugin-Swift.h>)
#import <usb_plugin/usb_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "usb_plugin-Swift.h"
#endif

@implementation UsbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUsbPlugin registerWithRegistrar:registrar];
}
@end
