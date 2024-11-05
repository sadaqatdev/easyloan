package com.homecredit.loan.utils;

import android.annotation.SuppressLint;
import android.os.Build;

import java.util.UUID;

public class PhoneId {

    @SuppressLint({"MissingPermission", "HardwareIds"})
    public static String getUniqueID() {
        String m_szDevIDShort = "35" +
                (Build.BOARD.length() % 10)
                + (Build.BRAND.length() % 10)
                + (Build.CPU_ABI.length() % 10)
                + (Build.DEVICE.length() % 10)
                + (Build.MANUFACTURER.length() % 10)
                + (Build.MODEL.length() % 10)
                + (Build.PRODUCT.length() % 10);
        String serial = "serial";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            try {
                serial = Build.getSerial();
            } catch (Exception e) {
            }
        } else {
            serial = Build.SERIAL;
        }
        return new UUID(m_szDevIDShort.hashCode(), serial.hashCode()).toString();
    }
}
