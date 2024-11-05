package com.homecredit.loan;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.Application;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.Network;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.facebook.FacebookSdk;
import com.facebook.LoggingBehavior;
import com.facebook.appevents.AppEventsLogger;
import com.homecredit.loan.dialog.HAnimationsType;
import com.homecredit.loan.dialog.HDialog;
import com.homecredit.loan.hcjson.CommonUtil;
import com.homecredit.loan.hcjson.DeviceUtils;
import com.homecredit.loan.hcjson.HcContext;
import com.homecredit.loan.utils.AppSignatureHashHelper;
import com.homecredit.loan.utils.SpUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import im.crisp.client.Crisp;
import io.branch.referral.Branch;
import io.flutter.plugin.common.MethodChannel;

public class AppApplication extends Application {

    private static Application instance;
    private Activity app_activity = null;
    private HDialog dialog;

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        SpUtils.getInstance().initSp(this);
        HcContext.init(this);
        getGaid();
        Branch.enableLogging();
        Branch.getAutoInstance(this);
        Crisp.configure(getApplicationContext(), "6be98828-d745-49bc-9dd9-883556480647");
        AppEventsLogger.activateApp(this);
//        FacebookSdk.setIsDebugEnabled(true);
//        FacebookSdk.addLoggingBehavior(LoggingBehavior.APP_EVENTS);

//        AppSignatureHashHelper appSignatureHashHelper = new AppSignatureHashHelper(this);
//        ArrayList<String> arrayList = appSignatureHashHelper.getAppSignatures();
//        if(arrayList != null && arrayList.size() > 0){
//            for (int i = 0; i < arrayList.size(); i++) {
//                Log.e("AppApplication",arrayList.get(i));
//            }
//        }
    }

    private void getGaid() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    String gaid = CommonUtil.getNonNullText(DeviceUtils.getGAID());
                    if (!TextUtils.isEmpty(gaid)) {
                        HcContext.setGAID(gaid);
                        SpUtils.getInstance().putString("musicalMistFlatGlobe", gaid);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    public static Application getInstance() {
        return instance;
    }
}
