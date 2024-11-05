package com.homecredit.loan.hcjson;

import android.content.Context;
import android.text.TextUtils;

import androidx.core.app.ActivityCompat;

public class CommonUtil {

    public static String getNonNullText(String text) {
        return TextUtils.isEmpty(text) ? "" : text;
    }

    public static boolean haveSelfPermission(Context paramContext, String paramString) {
        return ActivityCompat.checkSelfPermission(paramContext, paramString) == 0;
    }

}
