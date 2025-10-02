package com.externaldisplay;

import android.content.Context;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;

import android.view.Display;
import android.hardware.display.DisplayManager;
import android.util.Log;

import java.util.Map;
import java.util.HashMap;

import com.facebook.react.modules.core.DeviceEventManagerModule;

public class RNExternalDisplayModule extends NativeRNExternalDisplayEventSpec implements ExternalDisplayHelper.Listener {
  public static final String REACT_CLASS = "RNExternalDisplayEvent";
  private static final String TAG = "RNExternalDisplayEvent";

  private ReactApplicationContext reactContext = null;

  public RNExternalDisplayModule(ReactApplicationContext context) {
    super(context);
    this.reactContext = context;
    // Initialize ExternalDisplayHelper singleton
    ExternalDisplayHelper.initialize(context, this);
  }

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  public WritableMap getInitialScreens() {
    WritableMap map = Arguments.createMap();
    try {
      map.putMap("SCREEN_INFO", Arguments.makeNativeMap(ExternalDisplayHelper.getScreenInfo(ExternalDisplayHelper.getInstance().getDisplays())));
    } catch (IllegalStateException e) {
      map.putMap("SCREEN_INFO", Arguments.createMap());
    }
    return map;
  }

  @Override
  public void init() {}

  // --- Mock methods (from iOS) ---

  @Override
  public boolean requestScene(ReadableMap options) { return false; }

  @Override
  public boolean closeScene(String sceneId) { return false; }

  @Override
  public boolean isMainSceneActive() { return false; }

  @Override
  public boolean resumeMainScene() { return false; }

  private void sendEvent(String eventName, WritableMap params) {
    reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit(eventName, params);
  }

  @Override
  public void onDisplayAdded(Display[] displays, int displayId) {
    sendEvent(
      "@RNExternalDisplay_screenDidConnect",
      Arguments.makeNativeMap(ExternalDisplayHelper.getScreenInfo(displays))
    );
  }

  @Override
  public void onDisplayChanged(Display[] displays, int displayId) {
    sendEvent(
      "@RNExternalDisplay_screenDidChange",
      Arguments.makeNativeMap(ExternalDisplayHelper.getScreenInfo(displays))
    );
  }

  @Override
  public void onDisplayRemoved(Display[] displays, int displayId) {
    sendEvent(
      "@RNExternalDisplay_screenDidDisconnect",
      Arguments.makeNativeMap(ExternalDisplayHelper.getScreenInfo(displays))
    );
  }

  @Override
  public void onCatalystInstanceDestroy() {
    super.onCatalystInstanceDestroy();
    // Clean up the ExternalDisplayHelper singleton
    ExternalDisplayHelper.destroy();
  }

  // Optional: Provide a getter for ExternalDisplayHelper
  public ExternalDisplayHelper getExternalDisplayHelper() {
    try {
      return ExternalDisplayHelper.getInstance();
    } catch (IllegalStateException e) {
      return null;
    }
  }
}