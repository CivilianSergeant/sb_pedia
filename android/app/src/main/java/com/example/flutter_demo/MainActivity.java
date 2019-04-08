package com.example.flutter_demo;
import io.flutter.plugin.common.*;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity{
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),"android_app_retain").setMethodCallHandler(new MethodChannel.MethodCallHandler(){
        public void onMethodCall(MethodCall call,MethodChannel.Result result){
        switch (call.method) {
            case "sendAppToBackground":
                moveTaskToBack(true);
                break;
        }
    }
    });

  }


}
