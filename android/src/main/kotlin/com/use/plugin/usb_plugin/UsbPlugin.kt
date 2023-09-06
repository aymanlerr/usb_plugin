package com.use.plugin.usb_plugin

import android.app.Application
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.usb.UsbManager
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.logging.StreamHandler

/** UsbPlugin */
class UsbPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private var TAG = "USB_PLUGIN";
    private val NAMESPACE = "usb_plugin"
    private lateinit var channel: MethodChannel
    private lateinit var stateUsbEventChannel: EventChannel
    private var applicationContext: Context? = null
    private var usbEventSink: EventChannel.EventSink? = null
    private var mUSBManager: UsbManager? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.applicationContext = flutterPluginBinding.applicationContext;
        mUSBManager = this.applicationContext?.getSystemService(Context.USB_SERVICE) as UsbManager
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "$NAMESPACE/methods")
        channel.setMethodCallHandler(this)
        stateUsbEventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, "$NAMESPACE/state_usb")

        val filterUsbAdapter = IntentFilter()
        filterUsbAdapter.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED)
        filterUsbAdapter.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED)
        this.applicationContext?.registerReceiver(mUsbAdapterStateReceiver, filterUsbAdapter)

        stateUsbEventChannel.setStreamHandler(
            object : StreamHandler(), EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    usbEventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    usbEventSink = null
                }

            }
        )
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "checkStateUsb") {
            val check = mUSBManager?.deviceList?.isEmpty()
            if (check == true) {
                result.success(0)
            } else {
                result.success(1)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        mUSBManager = null
        this.applicationContext?.unregisterReceiver(mUsbAdapterStateReceiver)
        applicationContext = null
    }

    private val mUsbAdapterStateReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            val action = intent?.action
            if (action == UsbManager.ACTION_USB_DEVICE_DETACHED) {
                Log.d(TAG, "Usb State: Off")
                usbEventSink?.success(0)
            } else if (action == UsbManager.ACTION_USB_DEVICE_ATTACHED) {
                Log.d(TAG, "Usb State: On")
                usbEventSink?.success(1)
            }
        }

    }
}
