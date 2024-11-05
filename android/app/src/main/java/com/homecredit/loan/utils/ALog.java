package com.homecredit.loan.utils;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.facebook.appevents.AppEventsLogger;
import com.google.firebase.analytics.FirebaseAnalytics;

import io.branch.referral.util.BranchEvent;

public class ALog {
    public static void branchAndFirebaseEvent(Context context, String eventName) {
        Log.e("ALog_bf", eventName);
        try {
            FirebaseAnalytics.getInstance(context).logEvent(eventName, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            BranchEvent be = new BranchEvent(eventName);
            be.logEvent(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void facebookEvent(Context context, @NonNull String eventName) {
        Log.e("ALog_f", eventName);
        try {
            AppEventsLogger.newLogger(context).logEvent(eventName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
