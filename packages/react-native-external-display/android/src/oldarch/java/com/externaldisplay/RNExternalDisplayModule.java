package com.externaldisplay;

import android.content.Context;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import android.view.Display;
import android.hardware.display.DisplayManager;

import java.util.Map;
import java.util.HashMap;

public class RNExternalDisplayModule extends ReactContextBaseJavaModule {
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
  public Map<String, Object> getConstants() {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("SCREEN_INFO", ExternalDisplayHelper.getScreenInfo(dm.getDisplays()));
    return map;
  }
}