package com.externaldisplay;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import com.facebook.react.ReactRootView;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactContext;
import android.widget.LinearLayout;
import com.facebook.common.logging.FLog;
import com.facebook.react.common.ReactConstants;

import android.view.Display;
import android.util.DisplayMetrics;

import java.util.ArrayList;

public class RNExternalDisplayView extends ReactRootView implements LifecycleEventListener {
  Context context;
  private boolean fallbackInMainScreen = false;
  private ExternalDisplayHelper helper;
  private ExternalDisplayScreen displayScreen;
  private int screen = -1;
  private ArrayList<View> subviews = new ArrayList<View>();
  private ReactRootView wrap;
  private boolean pausedWithDisplayScreen = false;

  public RNExternalDisplayView(Context context, ExternalDisplayHelper helper) {
    super(context);
    ((ReactContext) context).addLifecycleEventListener(this);
    this.context = context;
    this.helper = helper;
  }

  @Override
  public void addView(View child, int index) {
    subviews.add(index, child);
    updateScreen();
  }

  @Override
  protected void onLayout(boolean changed, int l, int t, int r, int b) {
  }

  @Override
  public int getChildCount() {
    return subviews.size();
  }

  @Override
  public View getChildAt(int index) {
    return subviews.get(index);
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
    subviews.remove(index);
    if (wrap != null && wrap.getChildCount() > 0) {
      for (int i = 0; i < wrap.getChildCount(); i++) {
        wrap.removeViewAt(i);
      }
    }
  }

  public void onDropInstance() {
    ((ReactContext) getContext()).removeLifecycleEventListener(this);
    if (wrap != null && wrap.getChildCount() > 0) {
      for (int i = 0; i < wrap.getChildCount(); i++) {
        wrap.removeViewAt(i);
      }
    }
    destroyScreen();
  }

  @Override
  public void addChildrenForAccessibility(ArrayList<View> outChildren) {
          // This solves an accessibility bug originally addressed in RN
          // Reference: https://github.com/mybigday/react-native-external-display/issues/211
  }

  @Override
  public void onHostResume() {
    if (displayScreen == null && !pausedWithDisplayScreen) {
      return;
    }
    pausedWithDisplayScreen = false;
    updateScreen();
  }

  @Override
  public void onHostPause() {
    if (displayScreen == null) {
      return;
    }
    pausedWithDisplayScreen = true;
    if (wrap != null) {
      for (int i = 0; i < wrap.getChildCount(); i++) {
        wrap.removeViewAt(i);
      }
    }
    destroyScreen();
  }

  @Override
  public void onHostDestroy() {
    onDropInstance();
  }

  public void updateScreen() {
    if (getChildCount() == 0) return;
    if (screen > 0) {
      Display display = helper.getDisplay(screen);
      if (display != null) {
        if (displayScreen == null) {
          displayScreen = new ExternalDisplayScreen(context, display);
          wrap = new ReactRootView(context);
        } else if (wrap.getChildCount() > 0) {
          for (int i = 0; i < wrap.getChildCount(); i++) {
            wrap.removeViewAt(i);
          }
        }
        for (int i = 0; i < subviews.size(); i++) {
        View subview = subviews.get(i);
          if (subview.getParent() != null) {
            // Make sure removed from parent
            ((ViewGroup) subview.getParent()).removeView(subview);
          }
          wrap.addView(subview, i);
        }
        displayScreen.setContentView(wrap);
        displayScreen.show();
        return;
      }
    }
    if (fallbackInMainScreen == true) {
      if (wrap != null) {
        for (int i = 0; i < wrap.getChildCount(); i++) {
          wrap.removeViewAt(i);
        }
      }
      for (int i = 0; i < subviews.size(); i++) {
        View subview = subviews.get(i);
        if (subview.getParent() != null) {
          // Make sure removed from parent
          ((ViewGroup) subview.getParent()).removeView(subview);
        }
        super.addView(subview, i);
      }
    }
  }

  private void destroyScreen() {
    if (displayScreen != null) {
      displayScreen.hide();
      displayScreen.dismiss();
      displayScreen = null;
      wrap = null;
    }
  }

  public void setScreen(String screen) {
    if (getChildCount() > 0 && wrap != null && wrap.getChildCount() > 0) {
      for (int i = 0; i < wrap.getChildCount(); i++) {
        wrap.removeViewAt(i);
      }
    } else {
      for (View subview : subviews) {
        removeView(subview);
      }
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
