package com.example.flutter_doubanmovie;

import android.app.AlertDialog;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), "flutter.doubanmovie/buy").setMethodCallHandler((call, result) -> {
      switch (call.method) {
        case "buyTicket":
          new AlertDialog.Builder(MainActivity.this)
                  .setTitle("买票")
                  .setMessage((String) call.arguments)
                  .create().show();

          // 返回消息
          result.success(0);
          return;
        default:
          result.notImplemented();
          return;
      }
    });
  }
}
