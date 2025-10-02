package com.externaldisplay;

import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactApplicationContext;

import com.facebook.common.logging.FLog;
import com.facebook.react.common.ReactConstants;

import android.util.DisplayMetrics;
import android.view.Display;
import android.graphics.Rect;
import android.util.Log;
import com.externaldisplay.RNExternalDisplayModule;
import javax.annotation.Nullable;

import java.util.Map;
import java.util.HashMap;

public class RNExternalDisplayManager extends ViewGroupManager<RNExternalDisplayView> {
    public static final String REACT_CLASS = "RNExternalDisplay";
    private static final String TAG = "RNExternalDisplayEvent";
    private ReactApplicationContext reactContext;
    //private Map<RNExternalDisplayView, RNExternalDisplayView> views = new HashMap<RNExternalDisplayView, RNExternalDisplayView>();

    public RNExternalDisplayManager(ReactApplicationContext reactContext) {
        super();
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public RNExternalDisplayView createViewInstance(ThemedReactContext context) {
        // Retrieve the module to access the helper
        RNExternalDisplayModule module = context.getNativeModule(RNExternalDisplayModule.class);
        ExternalDisplayHelper helper = null;
        if (module != null) {
            helper = module.getExternalDisplayHelper();
        } else {
        }

        RNExternalDisplayView view = new RNExternalDisplayView(context, helper);
        return view;
    }

    @Override
    public void onDropViewInstance(RNExternalDisplayView view) {
        //views.remove(view);
        super.onDropViewInstance(view);
        view.onDropInstance();
    }
/*
    private void checkScreen() {
        Log.d("RNExternalDisplayEvent", "RNExternalDisplayManager checkScreen");

        int screenId = -1;
        for (RNExternalDisplayView view : views.values()) {
            int viewScreenId = view.getScreen();
            if (viewScreenId > 0 && screenId == viewScreenId) {
                // TODO: Log to console
                FLog.e(ReactConstants.TAG, "Detected two or more RNExternalDisplayView to register the same screen id: " + screenId);
            }
            if (viewScreenId > 0) {
                screenId = viewScreenId;
            }
        }
    }

 */

    @ReactProp(name = "screen")
    public void setScreen(RNExternalDisplayView view, String screen) {
        view.setScreen(screen);
        //checkScreen();
    }

    @ReactProp(name = "fallbackInMainScreen", defaultBoolean = false)
    public void setFallbackInMainScreen(RNExternalDisplayView view, boolean fallbackInMainScreen) {
        view.setFallbackInMainScreen(fallbackInMainScreen);
    }
}
