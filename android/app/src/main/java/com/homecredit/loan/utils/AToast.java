package com.homecredit.loan.utils;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.homecredit.loan.R;

public class AToast {

    private static Toast toast;
    // Handler
    private static Handler mHandler = new Handler(Looper.getMainLooper());

    public static void shortToast(Context context,String msg) {
        try {
            View toastView = LayoutInflater.from(context).inflate(R.layout.toast_layout, null);
            TextView textView = toastView.findViewById(R.id.tv_text);
            textView.setText(msg);
            if (toast != null) {
                toast.setView(toastView);
            } else {
                toast = new Toast(context);
                toast.setView(toastView);
            }
            toast.cancel();
            toast.setDuration(Toast.LENGTH_LONG);
            toast.setGravity(Gravity.CENTER, 0, 0);
            mHandler.postDelayed(new Runnable() {
                @Override
                public void run() {
                    toast.show();
                }
            }, 300);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
