package com.externaldisplay;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Presentation;
import android.content.Context;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;
import android.hardware.display.DisplayManager;

import java.util.Map;
import java.util.HashMap;

import android.util.Log;

import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactApplicationContext;

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
class ExternalDisplayScreen extends Presentation {
    ExternalDisplayScreen(Context ctx, Display display) {
        super(ctx, display);
        Log.d("RNExternalDisplayEvent", "ExternalDisplayScreen init");

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d("RNExternalDisplayEvent", "ExternalDisplayScreen onCreate");

        super.onCreate(savedInstanceState);
    }
}

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
class ExternalDisplayHelper implements DisplayManager.DisplayListener {
    private static final String TAG = "RNExternalDisplayEvent";
    private static ExternalDisplayHelper instance = null;
    private DisplayManager dm = null;
    private Listener listener = null;
    private Display displays = null;

    // Private constructor to prevent direct instantiation
    private ExternalDisplayHelper(Context context, Listener listener) {
        this.listener = listener;
        dm = (DisplayManager) context.getSystemService(Context.DISPLAY_SERVICE);
        if (dm != null) {
            dm.registerDisplayListener(this, null);
        } else {
        }
    }

    // Method to initialize the singleton instance
    public static synchronized void initialize(Context context, Listener listener) {
        if (instance == null) {
            instance = new ExternalDisplayHelper(context.getApplicationContext(), listener);
        }
    }

    // Method to get the singleton instance
    public static synchronized ExternalDisplayHelper getInstance() {
        if (instance == null) {
            throw new IllegalStateException("ExternalDisplayHelper is not initialized. Call initialize() first.");
        }
        return instance;
    }

    // Method to clean up the singleton instance
    public static synchronized void destroy() {
        if (instance != null && instance.dm != null) {
            instance.dm.unregisterDisplayListener(instance);
            instance = null;
        }
    }
    public static Map<String, Object> getScreenInfo(Display[] displays) {
        HashMap<String, Object> info = new HashMap<>();
        for (Display display : displays) {
            int displayId = display.getDisplayId();
            if (
                    display.getDisplayId() == Display.DEFAULT_DISPLAY ||
                            (display.getFlags() & Display.FLAG_PRESENTATION) == 0
            ) {
                continue;
            }
            HashMap<String, Object> data = new HashMap<>();
            DisplayMetrics displayMetrics = new DisplayMetrics();
            display.getMetrics(displayMetrics);
            data.put("id", displayId);
            data.put("width", displayMetrics.widthPixels);
            data.put("height", displayMetrics.heightPixels);
            info.put(String.valueOf(display.getDisplayId()), data);
        }
        return info;
    }

    @Override
    public void onDisplayAdded(int displayId) {
        if (listener != null) {
            listener.onDisplayAdded(getDisplays(), displayId);
        }
    }

    @Override
    public void onDisplayChanged(int displayId) {
        if (listener != null) {
            listener.onDisplayChanged(getDisplays(), displayId);
        }
    }

    @Override
    public void onDisplayRemoved(int displayId) {
        if (listener != null) {
            listener.onDisplayRemoved(getDisplays(), displayId);
        }
    }

    public Display getDisplay(int displayId) {
        if (dm != null) {
            return dm.getDisplay(displayId);
        }
        return null;
    }

    public Display[] getDisplays() {
        if (dm != null) {
            return dm.getDisplays(DisplayManager.DISPLAY_CATEGORY_PRESENTATION);
        }
        return new Display[0];
    }

    public interface Listener {
        void onDisplayAdded(Display[] displays, int displayId);
        void onDisplayChanged(Display[] displays, int displayId);
        void onDisplayRemoved(Display[] displays, int displayId);
    }
}
