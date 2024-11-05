package com.homecredit.loan.dialog;

import android.content.Context;
import android.util.TypedValue;

class DensityUtils {
    /** dppx */
    public static int dp2px(Context context, float dpVal){
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,dpVal, context.getResources().getDisplayMetrics());
    }
    public static int sp2px(Context context, float spVal){
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_SP,spVal, context.getResources().getDisplayMetrics());
    }
    public static float px2dp(Context context, float pxVal){
        return (pxVal/context.getResources().getDisplayMetrics().density);
    }
    public static float px2sp(Context context, float pxVal){
        return (pxVal / context.getResources().getDisplayMetrics().scaledDensity);
    }
}
