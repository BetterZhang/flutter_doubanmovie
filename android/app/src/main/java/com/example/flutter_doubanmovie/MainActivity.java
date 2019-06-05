package com.example.flutter_doubanmovie;

import android.app.AlertDialog;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import java.util.HashMap;
import java.util.Map;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  MethodChannel mMethodChannel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    mMethodChannel = new MethodChannel(getFlutterView(), "samples.flutter.io/message");

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

    new MethodChannel(getFlutterView(), "samples.flutter.io/toast").setMethodCallHandler((call, result) -> {
      if ("toast".equals(call.method)) {
        if (call.hasArgument("content")) {
          Toast.makeText(getBaseContext(), call.argument("content"), Toast.LENGTH_SHORT).show();
          result.success("success");
        } else {
          result.error("-1", "toast fail", "content is null");
        }
      } else {
        result.notImplemented();
      }
    });
  }

  @Override
  protected void onResume() {
    super.onResume();
    Map map = new HashMap<>();
    map.put("content", "Android Message");
    mMethodChannel.invokeMethod("showText", map, new MethodChannel.Result() {
      @Override
      public void success(Object o) {
        Log.d("MainActivity", (String) o);
      }

      @Override
      public void error(String s, String s1, Object o) {
        Log.d("MainActivity", "errorCode: " + s + " errorMessage: " + s1 + " errorDetail: " + o);
      }

      @Override
      public void notImplemented() {
        Log.d("MainActivity", "notImplemented");
      }
    });
  }
}
