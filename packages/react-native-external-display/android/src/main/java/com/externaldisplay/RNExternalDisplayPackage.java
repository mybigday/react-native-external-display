package com.externaldisplay;

import androidx.annotation.Nullable;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.module.model.ReactModuleInfo;
import com.facebook.react.module.model.ReactModuleInfoProvider;
import com.facebook.react.TurboReactPackage;
import com.facebook.react.uimanager.ViewManager;

import android.util.Log;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.externaldisplay.RNExternalDisplayManager;
import com.externaldisplay.RNExternalDisplayModule;

public class RNExternalDisplayPackage extends TurboReactPackage {
    private static final String TAG = "RNExternalDisplayEvent";


    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        List<ViewManager> viewManagers = new ArrayList<>();
        viewManagers.add(new RNExternalDisplayManager(reactContext));
        return viewManagers;
    }

    @Nullable
    @Override
    public NativeModule getModule(String name, ReactApplicationContext reactContext) {
        if (name.equals(RNExternalDisplayModule.REACT_CLASS)) {
            return new RNExternalDisplayModule(reactContext);
        } else {
            return null;
        }
    }

    @Override
    public ReactModuleInfoProvider getReactModuleInfoProvider() {
        return () -> {
            final Map<String, ReactModuleInfo> moduleInfos = new HashMap<>();
            boolean isTurboModule = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED;
            moduleInfos.put(
                    RNExternalDisplayModule.REACT_CLASS,
                    new ReactModuleInfo(
                            RNExternalDisplayModule.REACT_CLASS,
                            RNExternalDisplayModule.REACT_CLASS,
                            false, // canOverrideExistingModule
                            false, // needsEagerInit
                            true, // hasConstants
                            false, // isCxxModule
                            isTurboModule // isTurboModule
                    )
            );
            moduleInfos.put(
                    RNExternalDisplayManager.REACT_CLASS,
                    new ReactModuleInfo(
                            RNExternalDisplayManager.REACT_CLASS,
                            RNExternalDisplayManager.REACT_CLASS,
                            false, // canOverrideExistingModule
                            false, // needsEagerInit
                            true, // hasConstants
                            false, // isCxxModule
                            isTurboModule // isTurboModule
                    )
            );
            return moduleInfos;
        };
    }
}
