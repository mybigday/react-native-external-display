package com.reactlibrary;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import com.facebook.react.views.view.ReactViewGroup;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactContext;
import android.widget.LinearLayout;
import com.facebook.common.logging.FLog;
import com.facebook.react.common.ReactConstants;

import android.view.Display;
import android.util.DisplayMetrics;

public class RNExternalDisplayView extends ReactViewGroup implements LifecycleEventListener {
  Context context;
  private boolean fallbackInMainScreen = false;
  private ExternalDisplayHelper helper;
  private ExternalDisplayScreen displayScreen;
  private int screen = -1;
  private View subview;

  public RNExternalDisplayView(Context context, ExternalDisplayHelper helper) {
    super(context);
    ((ReactContext) context).addLifecycleEventListener(this);
    this.context = context;
    this.helper = helper;
  }

  @Override
  public void addView(View child, int index) {
    if (index > 0) {
      FLog.e(ReactConstants.TAG, "RNExternalDisplayView only allowed one child view.");
      return;
    }
    subview = child;
    updateScreen();
  }

  @Override
  protected void onLayout(boolean changed, int l, int t, int r, int b) {
  }

  @Override
  public int getChildCount() {
    return subview != null ? 1 : 0;
  }

  @Override
  public View getChildAt(int index) {
    return subview;
  }

  @Override
  public void removeView(View view) {
    super.removeView(view);
  }

  @Override
  public void removeViewAt(int index) {
    if (index > 0) return;
    View child = getChildAt(index);
    super.removeView(child);
  }

  public void onDropInstance() {
    if (subview != null) {
      ViewGroup parent = (ViewGroup) subview.getParent();
      if (parent != null) {
        parent.removeView(subview);
      }
      subview = null;
    }
    if (displayScreen != null) {
      displayScreen.hide();
      displayScreen = null;
    }
  }

  @Override
  public void onHostResume() {
  }

  @Override
  public void onHostPause() {
    onDropInstance();
  }

  @Override
  public void onHostDestroy() {
    onDropInstance();
  }

  public void updateScreen() {
    if (subview == null) return;
    if (screen > 0) {
      Display display = helper.getDisplay(screen);
      if (display != null) {
        if (displayScreen == null) {
          displayScreen = new ExternalDisplayScreen(context, display);
        }
        ReactViewGroup wrap = new ReactViewGroup(context);
        wrap.addView(subview, 0);
        displayScreen.setContentView(wrap);
        displayScreen.show();
        return;
      }
    }
    if (fallbackInMainScreen == true) {
      super.addView(subview, 0);
    }
  }

  public void setScreen(String screen) {
    if (subview != null) {
      ViewGroup parent = (ViewGroup) subview.getParent();
      if (parent != null) {
        parent.removeView(subview);
      }
    }
    try {
      int nextScreen = Integer.parseInt(screen);
      if (nextScreen != this.screen && displayScreen != null) {
        displayScreen.hide();
        displayScreen = null;
      }
      this.screen = nextScreen;
    } catch (NumberFormatException e) {
      if (displayScreen != null) {
        displayScreen.hide();
        displayScreen = null;
      }
      this.screen = -1;
    }
    updateScreen();
  }

  public void setFallbackInMainScreen(boolean value) {
    this.fallbackInMainScreen = value;
  }
}