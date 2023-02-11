package com.example.connect_bluetooth

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import android.content.pm.PackageManager
import android.os.Build
import android.os.ParcelUuid
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.example.flutter_bluetooth/connect_bluetooth"
    private lateinit var channel: MethodChannel

    private var socket: BluetoothSocket? = null
    private var device: BluetoothDevice? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_NAME)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "CONNECT_BLUETOOTH" -> {
                    val macAddress = call.argument<String>("mac_address")
                    connectBluetooth(macAddress, result)
                }

                else -> result.notImplemented()
            }
        }
    }

    @SuppressLint("MissingPermission")
    private fun connectBluetooth(macAddress: String?, result: MethodChannel.Result) {
        Thread {
            socket?.connect()
            socket = null

            device = BluetoothAdapter.getDefaultAdapter().getRemoteDevice(macAddress)

            val defaultUuid = "0000112f-0000-1000-8000-00805f9b34fb"
            val uuid: ParcelUuid = ParcelUuid.fromString(defaultUuid)

            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    if (ActivityCompat.checkSelfPermission(
                            this,
                            Manifest.permission.BLUETOOTH_CONNECT
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        result.error(
                            "912",
                            "Không thể kết nối, vui lòng khởi động lại thiết bị và thử lại",
                            null
                        )
                    }

                    if (ActivityCompat.checkSelfPermission(
                            this,
                            Manifest.permission.BLUETOOTH
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        ActivityCompat.requestPermissions(
                            this,
                            arrayOf(Manifest.permission.BLUETOOTH),
                            11111
                        )
                        result.error(
                            "913",
                            "Không thể kết nối, vui lòng khởi động lại thiết bị và thử lại",
                            null
                        )
                    }
                }

                socket = device?.createInsecureRfcommSocketToServiceRecord(uuid.uuid)
                socket?.connect()
                result.success(true)
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }.start()
    }
}
