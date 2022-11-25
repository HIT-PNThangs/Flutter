package com.vietapps.airlive;

import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.wearable.Asset;
import com.google.android.gms.wearable.DataItem;
import com.google.android.gms.wearable.PutDataMapRequest;
import com.google.android.gms.wearable.PutDataRequest;
import com.google.android.gms.wearable.Wearable;

import java.io.ByteArrayOutputStream;

import iamutkarshtiwari.github.io.ananas.editimage.ImageEditorIntentBuilder;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private MethodChannel.Result resultChannel;
    private final int PHOTO_EDITOR_REQUEST_CODE = 231;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.vietapps.airlive/framework").setMethodCallHandler((call, result) -> {
            resultChannel = result;
            if ("editPhoto".equals(call.method)) {
                editPhoto(call.argument("inPath"), call.argument("outPath"));
            } else if ("sendImageToWatch".equals(call.method)) {
                sendImageToWatch(call.argument("path"));
            } else if ("checkIfWatchAvailable".equals(call.method)) {
                checkIfWatchAvailable();
            }
        });
    }

    public void editPhoto(String inPath, String outPath) {
        try {
            Intent intent = new ImageEditorIntentBuilder(this, inPath, outPath)
                    .withAddText() // Add the features you need
                    .withPaintFeature()
                    .withFilterFeature()
                    .withRotateFeature()
                    .withCropFeature()
                    .withBrightnessFeature()
                    .withSaturationFeature()
                    .withBeautyFeature()
                    .withStickerFeature()
                    .forcePortrait(true)  // Add this to force portrait mode (It's set to false by default)
                    .setSupportActionBarVisibility(false) // To hide app's default action bar
                    .build();

            startActivityForResult(intent, PHOTO_EDITOR_REQUEST_CODE);
        } catch (Exception e) {
            Log.e("EDIT IMAGE", e.getMessage());
            if (resultChannel != null) {
                resultChannel.error("", e.getMessage(), null);
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == PHOTO_EDITOR_REQUEST_CODE && data != null) {
            String newFilePath = data.getStringExtra(ImageEditorIntentBuilder.OUTPUT_PATH);
            if (resultChannel != null) {
                resultChannel.success(newFilePath);
            }
        }
    }

    public void checkIfWatchAvailable() {
        BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter != null && mBluetoothAdapter.isEnabled()) {
            try {
                getPackageManager().getPackageInfo("com.vietapps.airlive", PackageManager.GET_META_DATA);
                if (resultChannel != null) {
                    resultChannel.success("OK");
                }
            } catch (PackageManager.NameNotFoundException e) {
                if (resultChannel != null) {
                    resultChannel.error("", "The Android Wear App is NOT installed", null);
                }
            }
        } else {
            if (resultChannel != null) {
                resultChannel.error("", "Bluetooth not enable", null);
            }
        }
    }

    public void sendImageToWatch(String path) {
        if (TextUtils.isEmpty(path)) resultChannel.error("", "Empty image", null);
        Bitmap bitmap = BitmapFactory.decodeFile(path);
        Asset asset = createAssetFromBitmap(bitmap);
        PutDataMapRequest putDataMapReq = PutDataMapRequest.create("/background_image_change_wf");
        putDataMapReq.getDataMap().putAsset("image", asset);
        PutDataRequest putDataReq = putDataMapReq.asPutDataRequest();
        Task<DataItem> putTask = Wearable.getDataClient(this).putDataItem(putDataReq);
        putTask.addOnSuccessListener(
                dataItem -> {
                    if (resultChannel != null) {
                        resultChannel.success("OK");
                    }
                });
        putTask.addOnFailureListener(e -> {
            if (resultChannel != null) {
                resultChannel.success(e.getMessage());
            }
        });
    }

    private static Asset createAssetFromBitmap(Bitmap bitmap) {
        final ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteStream);
        return Asset.createFromBytes(byteStream.toByteArray());
    }
}
