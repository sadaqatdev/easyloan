package com.homecredit.loan.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.auth.api.phone.SmsRetriever;
import com.google.android.gms.common.api.CommonStatusCodes;
import com.google.android.gms.common.api.Status;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class OTPReceiver extends BroadcastReceiver {

    private OTPReceiveListener otpListener;

    public void setOTPListener(OTPReceiveListener otpListener) {
        this.otpListener = otpListener;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (SmsRetriever.SMS_RETRIEVED_ACTION.equals(intent.getAction())) {
            Bundle extras = intent.getExtras();
            Status status = (Status) extras.get(SmsRetriever.EXTRA_STATUS);
            Log.d("OTPReceiver-status", status.getStatusCode()+"");
            switch (status.getStatusCode()) {
                case CommonStatusCodes.SUCCESS:
                    String message = (String) extras.get(SmsRetriever.EXTRA_SMS_MESSAGE);
                    Log.d("OTPReceiver-SMS_MESSAGE", message);
                    Pattern pattern = Pattern.compile("\\b(\\d{4})\\b");
                    Matcher matcher = pattern.matcher(message);
                    if (matcher.find()) {
                        String verificationCode = matcher.group(1);
                        System.out.println("Verification Code: " + verificationCode);
                        if (otpListener != null) {
                            otpListener.onOTPReceived(verificationCode);
                        }
                    } else {
                        Log.d("OTPReceiver-SMS_MESSAGE", "No verification code found.");
                    }
//                    if (message.contains("VT-OTPUy9c3j")) {
//                        // 
//                        Pattern pattern = Pattern.compile("\\b(\\d{4})\\b");
//                        Matcher matcher = pattern.matcher(message);
//                        if (matcher.find()) {
//                            String verificationCode = matcher.group(1);
//                            System.out.println("Verification Code: " + verificationCode);
//                            if (otpListener != null) {
//                                otpListener.onOTPReceived(verificationCode);
//                            }
//                        } else {
//                            System.out.println("No verification code found.");
//                        }
//                    } else if (message.contains("EasyLoan")) {
//                        Pattern pattern = Pattern.compile("\\b(\\d{4})\\b");
//                        Matcher matcher = pattern.matcher(message);
//                        if (matcher.find()) {
//                            String verificationCode = matcher.group(1);
//                            System.out.println("Verification Code: " + verificationCode);
//                            if (otpListener != null) {
//                                otpListener.onOTPReceived(verificationCode);
//                            }
//                        } else {
//                            System.out.println("No verification code found.");
//                        }
//                    }
                    break;
                case CommonStatusCodes.TIMEOUT:
                    if (otpListener != null) {
                        otpListener.onOTPTimeOut();
                    }
                    break;
                case CommonStatusCodes.API_NOT_CONNECTED:
                    if (otpListener != null) {
                        otpListener.onOTPReceivedError("API NOT CONNECTED");
                    }
                    break;
                case CommonStatusCodes.NETWORK_ERROR:
                    if (otpListener != null) {
                        otpListener.onOTPReceivedError("NETWORK ERROR");
                    }
                    break;
                case CommonStatusCodes.ERROR:
                    if (otpListener != null) {
                        otpListener.onOTPReceivedError("SOME THING WENT WRONG");
                    }
                    break;
                default:
                    break;
            }
        }
    }

    public interface OTPReceiveListener {

        void onOTPReceived(String otp);

        void onOTPTimeOut();

        void onOTPReceivedError(String error);
    }


}
