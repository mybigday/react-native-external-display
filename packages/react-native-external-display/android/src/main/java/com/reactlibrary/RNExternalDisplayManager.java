package com.reactlibrary;

import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactApplicationContext;

import android.util.DisplayMetrics;
import android.view.Display;
import android.graphics.Rect;

import javax.annotation.Nullable;
import java.util.Map;
import java.util.HashMap;

public class RNExternalDisplayManager extends ViewGroupManager<RNExternalDisplayView> implements ExternalDisplayHelper.Listener {
  public static final String REACT_CLASS = "RNExternalDisplay";
  private ExternalDisplayHelper helper;
  private ReactApplicationContext reactContext;

  public RNExternalDisplayManager(ReactApplicationContext reactContext) {
    super();
    this.reactContext = reactContext;
    this.helper = new ExternalDisplayHelper(reactContext, this);
  }

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  public RNExternalDisplayView createViewInstance(ThemedReactContext context) {
    return new RNExternalDisplayView(context, this.helper);
  }

  @Override
  public void onDropViewInstance(RNExternalDisplayView view) {
    super.onDropViewInstance(view);
    view.onDropInstance();
  }

  @ReactProp(name = "screen")
  public void setScreen(RNExternalDisplayView view, @Nullable String screen) {
    view.setScreen(screen);
  }

  @ReactProp(name = "fallbackInMainScreen", defaultBoolean = false)
  public void setFallbackInMainScreen(RNExternalDisplayView view, boolean fallbackInMainScreen) {
    view.setFallbackInMainScreen(fallbackInMainScreen);
  }

  private void sendEvent(String eventName, @Nullable WritableMap params) {
    reactContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit(eventName, params);
  }

  public void onDisplayAdded(Display[] displays, int displayId) {
    sendEvent(
      "@RNExternalDisplay_screenDidConnect",
      Arguments.makeNativeMap(
        ExternalDisplayHelper.getScreenInfo(displays)
      )
    );
  }
  public void onDisplayChanged(Display[] displays, int displayId) {
    sendEvent(
      "@RNExternalDisplay_screenDidChange",
      Arguments.makeNativeMap(
        ExternalDisplayHelper.getScreenInfo(displays)
      )
    );
  }
  public void onDisplayRemoved(Display[] displays, int displayId) {
    sendEvent(
      "@RNExternalDisplay_screenDidDisconnect",
      Arguments.makeNativeMap(
        ExternalDisplayHelper.getScreenInfo(displays)
      )
    );
  }
}
