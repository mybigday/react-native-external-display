package com.externaldisplay;

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
  private ReactViewGroup wrap;

  public RNExternalDisplayView(Context context, ExternalDisplayHelper helper) {
    super(context);
    ((ReactContext) context).addLifecycleEventListener(this);
    this.context = context;
    this.helper = helper;
  }

  @Override
  public void addView(View child, int index) {
    if (index > 0) {
      // TODO: Log to console
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
    if (wrap != null && wrap.getChildCount() > 0) {
      wrap.removeViewAt(0);
    }
  }

  public void onDropInstance() {
    if (subview != null) {
      if (wrap != null && wrap.getChildCount() > 0) {
        wrap.removeViewAt(0);
      }
      subview = null;
    }
    destroyScreen();
  }

  @Override
  public void onHostResume() {
    updateScreen();
  }

  @Override
  public void onHostPause() {
    if (subview != null) {
      if (wrap != null && wrap.getChildCount() > 0) {
        wrap.removeViewAt(0);
      }
    }
    destroyScreen();
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
          wrap = new ReactViewGroup(context);
        } else if (wrap.getChildCount() > 0) {
          wrap.removeViewAt(0);
        }
        wrap.addView(subview, 0);
        displayScreen.setContentView(wrap);
        displayScreen.show();
        return;
      }
    }
    if (fallbackInMainScreen == true) {
      if (wrap != null && wrap.getChildCount() > 0) {
        wrap.removeViewAt(0);
      }
      super.addView(subview, 0);
    }
  }

  private void destroyScreen() {
    if (displayScreen != null) {
      displayScreen.hide();
      displayScreen = null;
      wrap = null;
    }
  }

  public void setScreen(String screen) {
    if (subview != null && wrap != null && wrap.getChildCount() > 0) {
      wrap.removeViewAt(0);
    } else {
      removeViewAt(0);
    }
    try {
      int nextScreen = Integer.parseInt(screen);
      if (nextScreen != this.screen) {
        destroyScreen();
      }
      this.screen = nextScreen;
    } catch (NumberFormatException e) {
      destroyScreen();
      this.screen = -1;
    }
    updateScreen();
  }

  public int getScreen() {
    return this.screen;
  }

  public void setFallbackInMainScreen(boolean value) {
    this.fallbackInMainScreen = value;
  }
}