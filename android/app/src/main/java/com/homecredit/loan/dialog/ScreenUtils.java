package com.homecredit.loan.dialog;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.util.DisplayMetrics;

/**
 *  
 * @author liys
 * @version 1.0  2017/07/29
 */
class ScreenUtils {
    /** 1.(px) */
    public static int getWidthPixels(Context context){
        return context.getResources().getDisplayMetrics().widthPixels;
    }
    /** 2.(px) */
    public static int getHeightPixels(Context context){
        return context.getResources().getDisplayMetrics().heightPixels;
    }
    /** 3. （0.75 / 1.0 / 1.5） ;http://blog.sina.com.cn/s/blog_74c22b210100s0kw.html */
    public static float getHeightPixels(Activity activity){
        DisplayMetrics metric = new DisplayMetrics();
        activity.getWindowManager().getDefaultDisplay().getMetrics(metric);
        return metric.density;
    }
    /** 4.  (px)*/
    public static int getStatusBarHeight(Context context) {
        int result = 0;
        int resourceId = context.getResources().getIdentifier("status_bar_height", "dimen","android");
        if (resourceId > 0) {
            result = context.getResources().getDimensionPixelSize(resourceId);
        }
        return result;
    }

    /**
     * 
     * @param context
     * @return
     */
    public static boolean isPortrait(Context context) {
        Configuration mConfiguration = context.getResources().getConfiguration(); //
        return mConfiguration.orientation == mConfiguration.ORIENTATION_PORTRAIT;
    }

    /**
     * 
     * @param context
     * @return
     */
    public static boolean isLandscape(Context context) {
        Configuration mConfiguration = context.getResources().getConfiguration(); //
        return mConfiguration.orientation == mConfiguration.ORIENTATION_LANDSCAPE;
    }

    /**
     * 
     * @param activity
     */
    public static void setPortrait(Activity activity) {
        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
    }

    /**
     * 
     * @param activity
     */
    public static void setLandscape(Activity activity) {
        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
    }

    /**
     * ， Google I/O App for Android
     * @param context
     * @return  True， False
     */
    public static boolean isPad(Context context) {
        return (context.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK)
                >= Configuration.SCREENLAYOUT_SIZE_LARGE;
    }

}
