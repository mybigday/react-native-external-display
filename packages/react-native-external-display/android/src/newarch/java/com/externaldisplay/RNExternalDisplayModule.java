package com.externaldisplay;

import android.content.Context;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;

import android.view.Display;
import android.hardware.display.DisplayManager;

import java.util.Map;
import java.util.HashMap;

public class RNExternalDisplayModule extends NativeRNExternalDisplayEventSpec {
  public static final String REACT_CLASS = "RNExternalDisplayEvent";
  private ReactApplicationContext reactContext = null;
  private DisplayManager dm = null;
  
  public RNExternalDisplayModule(ReactApplicationContext context) {
    super(context);
    reactContext = context;
    dm = (DisplayManager) context.getSystemService(Context.DISPLAY_SERVICE);
  }

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  public WritableMap getInitialScreens() {
    WritableMap map = Arguments.createMap();
    map.putMap("SCREEN_INFO", Arguments.makeNativeMap(ExternalDisplayHelper.getScreenInfo(dm.getDisplays())));
    return map;
  }

  @Override
  public void init() {}
}