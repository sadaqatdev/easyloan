package com.homecredit.loan.utils;

import android.app.Activity;
import android.graphics.Color;
import android.os.Build;
import android.view.View;
import android.view.WindowInsetsController;

public class StatusBar {

    /**
     * Activity
     *
     * @param activity  aty
     */
    public static void setWindowStatusBarBlackColor(Activity activity) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                WindowInsetsController controller = activity.getWindow().getInsetsController();
                controller.setSystemBarsAppearance(WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS,
                        WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS);
            }else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
                activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            }else {
                activity.getWindow().setStatusBarColor(Color.parseColor("#26000000"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
