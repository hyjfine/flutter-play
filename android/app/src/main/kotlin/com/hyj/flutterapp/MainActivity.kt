package com.hyj.flutterapp

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel.EventSink
import android.content.BroadcastReceiver
import io.flutter.plugin.common.EventChannel.StreamHandler


class MainActivity(): FlutterActivity() {
  private val CHANNEL_BATTERY = "com.hyj.flutter/battery"
  private val CHANNEL_CHARGING = "com.hyj.flutter/charging"
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL_BATTERY).setMethodCallHandler { methodCall, result ->
      if (methodCall.method == "getBatteryLevel") {
        val batteryLevel = getBatteryLevel()

        if (batteryLevel != -1) {
          result.success(batteryLevel)
        } else {
          result.error("UNAVAILABLE", "Battery level not available.", null)
        }
      } else {
        result.notImplemented()
      }
    }


    val handlerStream: StreamHandler = object : StreamHandler {
      private var chargingStateChangeReceiver: BroadcastReceiver? = null
      override fun onListen(arguments: Any?, events: EventSink) {
        chargingStateChangeReceiver = createChargingStateChangeReceiver(events)
        registerReceiver(
                chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      }

      override fun onCancel(arguments: Any?) {
        unregisterReceiver(chargingStateChangeReceiver)
        chargingStateChangeReceiver = null
      }
    }

    EventChannel(flutterView, CHANNEL_CHARGING).setStreamHandler(handlerStream)
  }

  private fun createChargingStateChangeReceiver(events: EventSink): BroadcastReceiver {
    return object : BroadcastReceiver() {
      override fun onReceive(context: Context, intent: Intent) {
        val status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)

        if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
          events.error("UNAVAILABLE", "Charging status unavailable", null)
        } else {
          val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL
          events.success(if (isCharging) "charging" else "discharging")
        }
      }
    }
  }

  private fun getBatteryLevel(): Int {
    val batteryLevel: Int
    batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    } else {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    }

    return batteryLevel
  }
}
