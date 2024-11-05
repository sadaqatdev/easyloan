package com.homecredit.loan.hcjson;

import android.content.Context;

import org.json.JSONObject;

public class HcContext {
    private static Context mContext;
    private static String ImeIValue = "";
    private static JSONObject locationValue;
    private static String gaidValue = "";

    public HcContext() {
    }

    public static void init(Context context) {
        mContext = context;
    }

    static Context getApplication() {
        return mContext;
    }

    public static void setImeIValue(String value) {
        ImeIValue = value;
    }

    static String getImeIValue() {
        return ImeIValue;
    }

    public static void setLocationInfo(JSONObject location) {
        locationValue = location;
    }

    public static void setGAID(String value) {
        gaidValue = value;
    }

    static String getGaidValue() {
        return gaidValue;
    }
}