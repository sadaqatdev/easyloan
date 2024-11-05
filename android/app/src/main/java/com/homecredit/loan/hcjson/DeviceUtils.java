package com.homecredit.loan.hcjson;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.NetworkInfo.State;
import android.net.Proxy;
import android.net.Uri;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Environment;
import android.os.SystemClock;
import android.os.storage.StorageManager;
import android.provider.ContactsContract.Groups;
import android.provider.MediaStore.Audio.Media;
import android.provider.Settings;
import android.provider.Settings.Secure;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.CellInfoGsm;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.CellSignalStrengthCdma;
import android.telephony.CellSignalStrengthGsm;
import android.telephony.CellSignalStrengthLte;
import android.telephony.CellSignalStrengthWcdma;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.WindowManager;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.homecredit.loan.MainActivity;
import com.homecredit.loan.hcjson.config.ConfigValues;
import com.homecredit.loan.utils.SpUtils;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.NetworkInterface;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;


public class DeviceUtils {

    private static Context context = HcContext.getApplication();

    DeviceUtils() {
    }

    public static JSONObject getLocation() throws JSONException {
        JSONObject locationData = new JSONObject();

        SharedPreferences sp1 = context.getSharedPreferences(SpUtils.SP_NAME, Context.MODE_PRIVATE);
        String latitude = sp1.getString(ConfigValues.latitude, "");
        String longitude = sp1.getString(ConfigValues.longitude, "");

        Log.e("location", "latitude=" + latitude + ",longitude" + longitude);

        JSONObject gps = new JSONObject();
        gps.put("latitude", latitude);
        gps.put("longitude", longitude);
        locationData.put("gps", gps);
        String text = "";
        if (!TextUtils.isEmpty(latitude) && !TextUtils.isEmpty(longitude)) {
            text = latitude + "," + longitude;
        }
        locationData.put("gps_address_province", text);
        locationData.put("gps_address_city", text);
        locationData.put("gps_address_street", text);

        return locationData;
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public static JSONObject getHardWareInfo() {

        JSONObject hardWareData = new JSONObject();
        try {
            hardWareData.put("device_name", CommonUtil.getNonNullText(getDriverBrand()));
            hardWareData.put("brand", CommonUtil.getNonNullText(getDriverBrand()));
            hardWareData.put("board", CommonUtil.getNonNullText(getBoard()));
            hardWareData.put("sdk_version", CommonUtil.getNonNullText(getDriverSDKVersion()));
            hardWareData.put("model", CommonUtil.getNonNullText(getDriverModel()));
            hardWareData.put("release", CommonUtil.getNonNullText(getDriverOsVersion()));
            hardWareData.put("serial_number", CommonUtil.getNonNullText(getSerialNumber()));
            hardWareData.put("physical_size", CommonUtil.getNonNullText(getScreenPhysicalSize(context)));
            hardWareData.put("production_date", CommonUtil.getNonNullText(getDriverTime()));
            hardWareData.put("device_height", CommonUtil.getNonNullText(getDisplayMetrics(context).heightPixels + ""));
            hardWareData.put("device_width", CommonUtil.getNonNullText(getDisplayMetrics(context).widthPixels + ""));
            hardWareData.put("cpu_num", getCpuNum() + "");
            hardWareData.put("imei1", CommonUtil.getNonNullText(getIMEI1(context)));
            hardWareData.put("imei2", CommonUtil.getNonNullText(getIMEI2(context)).equals("") ? CommonUtil.getNonNullText(getIMEI1(context)) : CommonUtil.getNonNullText(getIMEI2(context)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return hardWareData;
    }

    public static JSONObject getGeneralData() {
        JSONObject generalData = new JSONObject();
        try {
            generalData.put("gaid", CommonUtil.getNonNullText(getGAID()));
            generalData.put("and_id", CommonUtil.getNonNullText(getAndroidId(context)));
            generalData.put("phone_type", CommonUtil.getNonNullText(String.valueOf(getPhoneType())));
            generalData.put("mac", CommonUtil.getNonNullText(getMacAddress()));
            generalData.put("locale_iso_3_language", CommonUtil.getNonNullText(getISO3Language(context)));
            generalData.put("locale_display_language", CommonUtil.getNonNullText(getLocaleDisplayLanguage()));
            generalData.put("locale_iso_3_country", CommonUtil.getNonNullText(getISO3Country(context)));
            generalData.put("imei", CommonUtil.getNonNullText(getIMEI1(context)));
            generalData.put("phone_number", CommonUtil.getNonNullText(getCurrentPhoneNum()));
            generalData.put("network_operator_name", CommonUtil.getNonNullText(getNetWorkOperatorName()));
            generalData.put("network_type", CommonUtil.getNonNullText(getNetworkState()));
            generalData.put("time_zone_id", CommonUtil.getNonNullText(getCurrentTimeZone()));
            generalData.put("language", CommonUtil.getNonNullText(getLanguage()));
            generalData.put("is_using_proxy_port", isWifiProxy());
            generalData.put("is_using_vpn", isUsingVPN());
            generalData.put("is_usb_debug", isUsbDebug());
            generalData.put("sensor_list", getSensorList());
            generalData.put("elapsedRealtime", getElapsedRealtime());
            generalData.put("currentSystemTime", System.currentTimeMillis());
            generalData.put("uptimeMillis", getUpdateMills());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generalData;
    }

    public static JSONObject getOtherData() {
        JSONObject otherData = new JSONObject();
        try {
            otherData.put("root_jailbreak", isRoot() ? "1" : "0");
            otherData.put("last_boot_time", bootTime() + "");
            otherData.put("keyboard", "1");
            otherData.put("simulator", isEmulator() ? "1" : "0");
            otherData.put("dbm", CommonUtil.getNonNullText(getMobileDbm()));
            otherData.put("total_boot_time", getTotalBootTime());
            otherData.put("total_boot_time_wake", getTotalBootTimeWake());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return otherData;
    }

    public static JSONObject getNetworkData() {
        JSONObject network = new JSONObject();
        JSONObject currentNetwork = new JSONObject();
        JSONArray configNetwork = new JSONArray();

        try {
            WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
            if (wifiManager != null && wifiManager.isWifiEnabled()) {
                WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                currentNetwork.put("bssid", wifiInfo.getBSSID());
                currentNetwork.put("name", wifiInfo.getSSID());
                currentNetwork.put("ssid", wifiInfo.getSSID());
                currentNetwork.put("mac", wifiInfo.getMacAddress());
                network.put("current_wifi", currentNetwork);
                network.put("IP", getWifiIP());
                List<ScanResult> configs = wifiManager.getScanResults();
                Iterator var6 = configs.iterator();

                while (var6.hasNext()) {
                    ScanResult scanResult = (ScanResult) var6.next();
                    JSONObject config = new JSONObject();
                    config.put("bssid", scanResult.BSSID);
                    config.put("ssid", scanResult.SSID);
                    config.put("mac", scanResult.BSSID);
                    config.put("name", scanResult.SSID);
                    configNetwork.put(config);
                }

                network.put("wifi_count", configs.size() + 1);
                network.put("configured_wifi", configNetwork);
            }
        } catch (Exception var9) {
        }

        return network;
    }

    @RequiresApi(
            api = 21
    )
    public static JSONObject getBatteryData() {
        JSONObject jSONObject = new JSONObject();
        try {
            BatteryManager manager = (BatteryManager) context.getSystemService(Context.BATTERY_SERVICE);
            if (manager != null) {
                int dianliang = manager.getIntProperty(4);
                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                DecimalFormatSymbols symbols = new DecimalFormatSymbols();
                symbols.setDecimalSeparator('.');
                decimalFormat.setDecimalFormatSymbols(symbols);
                jSONObject.put("battery_pct", decimalFormat.format((double) ((float) dianliang / 100.0F)));
            }

            Intent intent = context.registerReceiver((BroadcastReceiver) null, new IntentFilter("android.intent.action.BATTERY_CHANGED"));
            int k = intent.getIntExtra("plugged", -1);
            switch (k) {
                case 1:
                    jSONObject.put("is_usb_charge", 0);
                    jSONObject.put("is_ac_charge", 1);
                    jSONObject.put("is_charging", 1);
                    return jSONObject;
                case 2:
                    jSONObject.put("is_usb_charge", 1);
                    jSONObject.put("is_ac_charge", 0);
                    jSONObject.put("is_charging", 1);
                    return jSONObject;
                default:
                    jSONObject.put("is_usb_charge", 0);
                    jSONObject.put("is_ac_charge", 0);
                    jSONObject.put("is_charging", 0);
                    return jSONObject;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jSONObject;
    }

    public static String getGAID() {
        if (!TextUtils.isEmpty(HcContext.getGaidValue())) {
            return HcContext.getGaidValue();
        } else {
            try {
                return AdvertisingIdClient.getGoogleAdId(context);
            } catch (Exception var1) {
                var1.printStackTrace();
                return "";
            }
        }
    }

    private static String getTotalBootTime() {
        String total_boot_time = "";
        try {
            total_boot_time = SystemClock.elapsedRealtime() + "";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total_boot_time;
    }

    private static String getTotalBootTimeWake() {
        String total_boot_time = "";
        try {
            total_boot_time = SystemClock.uptimeMillis() + "";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total_boot_time;
    }

    private static String getISO3Language(Context paramContext) {
        return paramContext.getResources().getConfiguration().locale.getISO3Language();
    }

    private static String getISO3Country(Context paramContext) {
        return paramContext.getResources().getConfiguration().locale.getISO3Country();
    }

    private static String getLocaleDisplayLanguage() {
        return Locale.getDefault().getDisplayLanguage();
    }

    @SuppressLint({"MissingPermission"})
    public static String getDeviceImeIValue(Context paramContext) {
        if (!TextUtils.isEmpty(HcContext.getImeIValue())) {
            return HcContext.getImeIValue();
        } else {
            if (CommonUtil.haveSelfPermission(paramContext, "android.permission.READ_PHONE_STATE")) {
                try {
                    if (VERSION.SDK_INT >= 26) {
                        return ((TelephonyManager) paramContext.getSystemService(Context.TELEPHONY_SERVICE)).getImei();
                    }

                    return ((TelephonyManager) paramContext.getSystemService(Context.TELEPHONY_SERVICE)).getDeviceId();
                } catch (Exception var2) {
                }
            }

            return "";
        }
    }

    @SuppressLint({"MissingPermission"})
    private static String getCurrentPhoneNum() {
//        try {
//            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//            if (tm != null) {
//                String tel = tm.getLine1Number();
//                return tel;
//            }
//        } catch (Exception var2) {
//        }

        return "";
    }

    private static String getScreenPhysicalSize(Context paramContext) {
        Display display = ((WindowManager) paramContext.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay();
        DisplayMetrics displayMetrics = new DisplayMetrics();
        display.getMetrics(displayMetrics);
        return Double.toString(Math.sqrt(Math.pow((double) ((float) displayMetrics.heightPixels / displayMetrics.ydpi), 2.0D) + Math.pow((double) ((float) displayMetrics.widthPixels / displayMetrics.xdpi), 2.0D)));
    }

    public static String getAudioExternalNumber() {
        int result = 0;
        if (!CommonUtil.haveSelfPermission(HcContext.getApplication(), "android.permission.READ_EXTERNAL_STORAGE")) {
            return "";
        } else {
            Cursor cursor;
            for (cursor = HcContext.getApplication().getContentResolver().query(Media.EXTERNAL_CONTENT_URI, new String[]{"date_added", "date_modified", "duration", "mime_type", "is_music", "year", "is_notification", "is_ringtone", "is_alarm"}, (String) null, (String[]) null, (String) null); cursor != null && cursor.moveToNext(); ++result) {
            }

            if (cursor != null && !cursor.isClosed()) {
                cursor.close();
            }

            return String.valueOf(result);
        }
    }

    public static String getAudioInternalNumber() {
        int result = 0;

        Cursor cursor;
        for (cursor = HcContext.getApplication().getContentResolver().query(Media.INTERNAL_CONTENT_URI, new String[]{"date_added", "date_modified", "duration", "mime_type", "is_music", "year", "is_notification", "is_ringtone", "is_alarm"}, (String) null, (String[]) null, "title_key"); cursor != null && cursor.moveToNext(); ++result) {
        }

        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }

        return String.valueOf(result);
    }

    public static String getImagesExternalNumber() {
        int result = 0;
        if (!CommonUtil.haveSelfPermission(HcContext.getApplication(), "android.permission.READ_EXTERNAL_STORAGE")) {
            return "";
        } else {
            Cursor cursor;
            for (cursor = HcContext.getApplication().getContentResolver().query(android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI, new String[]{"datetaken", "date_added", "date_modified", "height", "width", "latitude", "longitude", "mime_type", "title", "_size"}, (String) null, (String[]) null, (String) null); cursor != null && cursor.moveToNext(); ++result) {
            }

            if (cursor != null && !cursor.isClosed()) {
                cursor.close();
            }

            return String.valueOf(result);
        }
    }

    public static String getImagesInternalNumber() {
        int result = 0;

        Cursor cursor;
        for (cursor = HcContext.getApplication().getContentResolver().query(android.provider.MediaStore.Images.Media.INTERNAL_CONTENT_URI, new String[]{"datetaken", "date_added", "date_modified", "height", "width", "latitude", "longitude", "mime_type", "title", "_size"}, (String) null, (String[]) null, (String) null); cursor != null && cursor.moveToNext(); ++result) {
        }

        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }

        return String.valueOf(result);
    }

    public static String getVideoExternalNumber() {
        int result = 0;
        if (!CommonUtil.haveSelfPermission(HcContext.getApplication(), "android.permission.READ_EXTERNAL_STORAGE")) {
            return "";
        } else {
            String[] arrayOfString = new String[]{"date_added"};

            Cursor cursor;
            for (cursor = HcContext.getApplication().getContentResolver().query(android.provider.MediaStore.Video.Media.EXTERNAL_CONTENT_URI, arrayOfString, (String) null, (String[]) null, (String) null); cursor != null && cursor.moveToNext(); ++result) {
            }

            if (cursor != null && !cursor.isClosed()) {
                cursor.close();
            }

            return String.valueOf(result);
        }
    }

    public static String getVideoInternalNumber() {
        int result = 0;
        String[] arrayOfString = new String[]{"date_added"};

        Cursor cursor;
        for (cursor = HcContext.getApplication().getContentResolver().query(android.provider.MediaStore.Video.Media.INTERNAL_CONTENT_URI, arrayOfString, (String) null, (String[]) null, (String) null); cursor != null && cursor.moveToNext(); ++result) {
        }

        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }

        return String.valueOf(result);
    }

    public static String getDownloadFileNumber() {
        int result = 0;
        File[] files = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).listFiles();
        if (files != null) {
            result = files.length;
        }

        return String.valueOf(result);
    }

    public static String getContactsGroupNumber() {
        int result = 0;
        if (!CommonUtil.haveSelfPermission(HcContext.getApplication(), "android.permission.READ_CONTACTS")) {
            return "";
        } else {
            Uri uri = Groups.CONTENT_URI;
            ContentResolver contentResolver = HcContext.getApplication().getContentResolver();

            Cursor cursor;
            for (cursor = contentResolver.query(uri, (String[]) null, (String) null, (String[]) null, (String) null); cursor != null && cursor.moveToNext(); ++result) {
            }

            if (cursor != null && !cursor.isClosed()) {
                cursor.close();
            }

            return String.valueOf(result);
        }
    }

    private static int getPhoneType() {
        try {
            TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            return manager.getPhoneType();
        } catch (Exception var1) {
            return 0;
        }
    }

    private static String getLanguage() {
        Locale locale = context.getResources().getConfiguration().locale;
        String language = locale.getLanguage();
        return language;
    }

    private static String getNetWorkOperatorName() {
        TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        return manager.getNetworkOperatorName();
    }

    private static boolean isOnline() {
        ConnectivityManager manager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo info = manager.getActiveNetworkInfo();
        return info != null && info.isConnected();
    }

    public static JSONArray getAppList(Context context) {
        List<PackageInfo> packages = context.getPackageManager().getInstalledPackages(0);
        JSONArray jsonArray = new JSONArray();
        if (packages != null && packages.size() > 0) {
            try {
                for (int i = 0; i < packages.size(); ++i) {
                    PackageInfo packageInfo = (PackageInfo) packages.get(i);
                    String name = packageInfo.applicationInfo.loadLabel(context.getPackageManager()).toString();
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("app_name", name);
                    jsonObject.put("package", packageInfo.packageName);
                    jsonObject.put("version_name", packageInfo.versionName);
                    jsonObject.put("version_code", packageInfo.versionCode);
                    jsonObject.put("in_time", packageInfo.firstInstallTime);
                    jsonObject.put("up_time", packageInfo.lastUpdateTime);
                    jsonObject.put("flags", packageInfo.applicationInfo.flags);
                    jsonObject.put("app_type", (packageInfo.applicationInfo.flags & 1) == 0 ? "0" : "1");
                    jsonArray.put(jsonObject);
                }
            } catch (Exception var7) {
            }
        }

        return jsonArray;
    }

    public static JSONArray getAppList2(Context context) {
        JSONArray jsonArray = new JSONArray();

        try {
            PackageManager pm = context.getPackageManager();
            Process process = Runtime.getRuntime().exec("pm list packages");
            BufferedReader bis = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = "";

            while ((line = bis.readLine()) != null) {
                PackageInfo packageInfo = pm.getPackageInfo(line.replace("package:", ""), PackageManager.GET_GIDS);
                String name = packageInfo.applicationInfo.loadLabel(context.getPackageManager()).toString();
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("app_name", name);
                jsonObject.put("package", packageInfo.packageName);
                jsonObject.put("version_name", packageInfo.versionName);
                jsonObject.put("version_code", packageInfo.versionCode);
                jsonObject.put("in_time", packageInfo.firstInstallTime);
                jsonObject.put("up_time", packageInfo.lastUpdateTime);
                jsonObject.put("flags", packageInfo.applicationInfo.flags);
                jsonObject.put("app_type", (packageInfo.applicationInfo.flags & 1) == 0 ? "0" : "1");
                jsonArray.put(jsonObject);
            }

            bis.close();
        } catch (Exception var9) {
        }

        return jsonArray;
    }

    private static String getMobileDbm() {
        int dbm = -1;
        TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        try {
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                List<CellInfo> cellInfoList = tm.getAllCellInfo();
                if (null != cellInfoList) {
                    Iterator var3 = cellInfoList.iterator();

                    while (var3.hasNext()) {
                        CellInfo cellInfo = (CellInfo) var3.next();
                        if (cellInfo instanceof CellInfoGsm) {
                            CellSignalStrengthGsm cellSignalStrengthGsm = ((CellInfoGsm) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthGsm.getDbm();
                        } else if (cellInfo instanceof CellInfoCdma) {
                            CellSignalStrengthCdma cellSignalStrengthCdma = ((CellInfoCdma) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthCdma.getDbm();
                        } else if (cellInfo instanceof CellInfoWcdma) {
                            CellSignalStrengthWcdma cellSignalStrengthWcdma = ((CellInfoWcdma) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthWcdma.getDbm();
                        } else if (cellInfo instanceof CellInfoLte) {
                            CellSignalStrengthLte cellSignalStrengthLte = ((CellInfoLte) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthLte.getDbm();
                        }
                    }
                }
            }
        } catch (Exception var6) {
            var6.printStackTrace();
        }

        return String.valueOf(dbm);
    }

    private static String getWifiIP() {
        String ip = null;

        try {
            WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
            if (wifiManager.isWifiEnabled()) {
                WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                int i = wifiInfo.getIpAddress();
                ip = (i & 255) + "." + (i >> 8 & 255) + "." + (i >> 16 & 255) + "." + (i >> 24 & 255);
            }
        } catch (Exception var4) {
            var4.printStackTrace();
        }

        return ip;
    }

    private static String getWifiName() {
        if (isOnline() && getNetworkState().equals("WIFI")) {
            WifiManager wifiManager = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            String ssid = wifiInfo.getSSID();
            if (!TextUtils.isEmpty(ssid) && ssid.contains("\"")) {
                ssid = ssid.replaceAll("\"", "");
            }

            return ssid;
        } else {
            return "";
        }
    }

    private static String getMacAddress() {
        String mac = getMacAddress1();
        if (TextUtils.isEmpty(mac)) {
            mac = getMacFromHardware();
        }

        return mac;
    }

    private static String getMacAddress1() {
        try {
            WifiManager localWifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
            WifiInfo localWifiInfo = localWifiManager.getConnectionInfo();
            String macAddress = localWifiInfo.getMacAddress();
            if (TextUtils.isEmpty(macAddress) || "02:00:00:00:00:00".equals(macAddress)) {
                macAddress = getMacAddress2();
            }

            return macAddress;
        } catch (Exception var3) {
            var3.printStackTrace();
            return null;
        }
    }

    private static String getMacAddress2() {
        if (isOnline() && getNetworkState().equals("WIFI")) {
            String macSerial = null;
            String str = "";

            try {
                Process pp = Runtime.getRuntime().exec("cat /sys/class/net/wlan0/address ");
                InputStreamReader ir = new InputStreamReader(pp.getInputStream());
                LineNumberReader input = new LineNumberReader(ir);

                while (null != str) {
                    str = input.readLine();
                    if (str != null) {
                        macSerial = str.trim();
                        break;
                    }
                }
            } catch (Exception var5) {
                var5.printStackTrace();
            }

            return macSerial;
        } else {
            return "";
        }
    }

    private static String getMacFromHardware() {
        try {
            List<NetworkInterface> all = Collections.list(NetworkInterface.getNetworkInterfaces());
            Iterator var1 = all.iterator();

            while (var1.hasNext()) {
                NetworkInterface nif = (NetworkInterface) var1.next();
                if (nif.getName().equalsIgnoreCase("wlan0")) {
                    byte[] macBytes = nif.getHardwareAddress();
                    if (macBytes == null) {
                        return null;
                    }

                    StringBuilder mac = new StringBuilder();
                    byte[] var5 = macBytes;
                    int var6 = macBytes.length;

                    for (int var7 = 0; var7 < var6; ++var7) {
                        byte b = var5[var7];
                        mac.append(String.format("%02X:", b));
                    }

                    if (mac.length() > 0) {
                        mac.deleteCharAt(mac.length() - 1);
                    }

                    return mac.toString();
                }
            }
        } catch (Exception var9) {
            var9.printStackTrace();
        }

        return null;
    }

    public static String getProductName() {
        return Build.PRODUCT;
    }

    public static String getModelName() {
        return Build.MODEL;
    }

    public static String getManufacturerName() {
        return Build.MANUFACTURER;
    }

    public static String getFingeprint() {
        return Build.FINGERPRINT;
    }

    public static String getBrand() {
        return Build.BRAND;
    }

    public static String getBoard() {
        return Build.BOARD;
    }

    public static String getSerial() {
        return Build.SERIAL;
    }

    public static boolean getRootAuth() {
        Process process = null;
        DataOutputStream os = null;

        boolean var4;
        try {
            boolean var3;
            try {
                process = Runtime.getRuntime().exec("su");
                os = new DataOutputStream(process.getOutputStream());
                os.writeBytes("exit\n");
                os.flush();
                int exitValue = process.waitFor();
                if (exitValue != 0) {
                    var3 = false;
                    return var3;
                }

                var3 = true;
                var4 = var3;
                return var4;
            } catch (Exception var15) {
                var3 = false;
                var4 = var3;
            }
        } finally {
            try {
                if (os != null) {
                    os.close();
                }

                process.destroy();
            } catch (Exception var14) {
                var14.printStackTrace();
            }

        }

        return var4;
    }

    private static boolean isRoot() {
        boolean bool = false;

        try {
            if (!(new File("/system/bin/su")).exists() && !(new File("/system/xbin/su")).exists()) {
                bool = false;
            } else {
                bool = true;
            }
        } catch (Exception var2) {
        }

        return bool;
    }

    private static long bootTime() {
        return System.currentTimeMillis() - SystemClock.elapsedRealtimeNanos() / 1000000L;
    }

    private static boolean isEmulator() {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            String imei = tm.getDeviceId();
            if (imei != null && imei.equals("000000000000000")) {
                return true;
            } else {
                return Build.MODEL.equals("sdk") || Build.MODEL.equals("google_sdk");
            }
        } catch (Exception var2) {
            return false;
        }
    }

    @SuppressLint({"HardwareIds"})
    private static String getAndroidId(Context context) {
        try {
            return Secure.getString(context.getApplicationContext().getContentResolver(), "android_id");
        } catch (Exception var2) {
            var2.printStackTrace();
            return null;
        }
    }

    private static String getNetworkState() {
        ConnectivityManager connManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (null == connManager) {
            return "none";
        } else {
            NetworkInfo activeNetInfo = connManager.getActiveNetworkInfo();
            if (activeNetInfo != null && activeNetInfo.isAvailable()) {
                NetworkInfo wifiInfo = connManager.getNetworkInfo(1);
                if (null != wifiInfo) {
                    State state = wifiInfo.getState();
                    if (null != state && (state == State.CONNECTED || state == State.CONNECTING)) {
                        return "WIFI";
                    }
                }

                NetworkInfo networkInfo = connManager.getNetworkInfo(0);
                if (null != networkInfo) {
                    State state = networkInfo.getState();
                    String strSubTypeName = networkInfo.getSubtypeName();
                    if (null != state && (state == State.CONNECTED || state == State.CONNECTING)) {
                        switch (activeNetInfo.getSubtype()) {
                            case 1:
                            case 2:
                            case 4:
                            case 7:
                            case 11:
                                return "2G";
                            case 3:
                            case 5:
                            case 6:
                            case 8:
                            case 9:
                            case 10:
                            case 12:
                            case 14:
                            case 15:
                                return "3G";
                            case 13:
                                return "4G";
                            default:
                                if (!strSubTypeName.equalsIgnoreCase("TD-SCDMA") && !strSubTypeName.equalsIgnoreCase("WCDMA") && !strSubTypeName.equalsIgnoreCase("CDMA2000")) {
                                    return "other";
                                }

                                return "3G";
                        }
                    }
                }

                return "none";
            } else {
                return "none";
            }
        }
    }

    private static String getCurrentTimeZone() {
        TimeZone tz = TimeZone.getDefault();
        String strTz = tz.getDisplayName(false, 0);
        return strTz;
    }

    private static String getDriverBrand() {
        try {
            return Build.BRAND;
        } catch (Exception var1) {
            return "";
        }
    }

    private static String getDriverSDKVersion() {
        try {
            return VERSION.SDK_INT + "";
        } catch (Exception var1) {
            return "";
        }
    }

    private static String getDriverModel() {
        try {
            return Build.MODEL;
        } catch (Exception var1) {
            return "";
        }
    }

    private static String getDriverOsVersion() {
        try {
            return VERSION.RELEASE;
        } catch (Exception var1) {
            return "";
        }
    }

    private static String getSerialNumber() {
        try {
            Class<?> clazz = Class.forName("android.os.SystemProperties");
            return (String) clazz.getMethod("get", String.class).invoke(clazz, "ro.serialno");
        } catch (Exception var1) {
            return "";
        }
    }

    private static boolean isUsbDebug() {
        return Secure.getInt(context.getContentResolver(), "adb_enabled", 0) > 0;
    }

    private static boolean isWifiProxy() {
        boolean IS_ICS_OR_LATER = VERSION.SDK_INT >= 14;
        String proxyAddress;
        int proxyPort;
        if (IS_ICS_OR_LATER) {
            proxyAddress = System.getProperty("http.proxyHost");
            String portStr = System.getProperty("http.proxyPort");
            proxyPort = Integer.parseInt(portStr != null ? portStr : "-1");
        } else {
            proxyAddress = Proxy.getHost(context);
            proxyPort = Proxy.getPort(context);
        }

        return !TextUtils.isEmpty(proxyAddress) && proxyPort != -1;
    }

    private static JSONArray getSensorList() throws JSONException {
        SensorManager sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        new ArrayList();
        List<Sensor> sensors = sensorManager.getSensorList(-1);
        JSONArray jsonArray = new JSONArray();
        Iterator var3 = sensors.iterator();

        while (var3.hasNext()) {
            Sensor sensor = (Sensor) var3.next();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("type", String.valueOf(sensor.getType()));
            jsonObject.put("name", String.valueOf(sensor.getName()));
            jsonObject.put("version", String.valueOf(sensor.getVersion()));
            jsonObject.put("vendor", String.valueOf(sensor.getVendor()));
            jsonObject.put("maxRange", String.valueOf(sensor.getMaximumRange()));
            jsonObject.put("minDelay", String.valueOf(sensor.getMinDelay()));
            jsonObject.put("power", String.valueOf(sensor.getPower()));
            jsonObject.put("resolution", String.valueOf(sensor.getResolution()));
            jsonArray.put(jsonObject);
        }

        return jsonArray;
    }

    public static String getStoragePath(boolean is_removale) {
        StorageManager mStorageManager = (StorageManager) context.getSystemService(Context.STORAGE_SERVICE);
        Class storageVolumeClazz = null;

        try {
            storageVolumeClazz = Class.forName("android.os.storage.StorageVolume");
            Method getVolumeList = mStorageManager.getClass().getMethod("getVolumeList");
            Method getPath = storageVolumeClazz.getMethod("getPath");
            Method isRemovable = storageVolumeClazz.getMethod("isRemovable");
            Object result = getVolumeList.invoke(mStorageManager);
            int length = Array.getLength(result);

            for (int i = 0; i < length; ++i) {
                Object storageVolumeElement = Array.get(result, i);
                String path = (String) getPath.invoke(storageVolumeElement);
                boolean removable = (Boolean) isRemovable.invoke(storageVolumeElement);
                if (is_removale == removable) {
                    return path;
                }
            }
        } catch (ClassNotFoundException var12) {
            var12.printStackTrace();
        } catch (InvocationTargetException var13) {
            var13.printStackTrace();
        } catch (NoSuchMethodException var14) {
            var14.printStackTrace();
        } catch (IllegalAccessException var15) {
            var15.printStackTrace();
        }

        return null;
    }

    public static boolean isUsingVPN() {
        if (VERSION.SDK_INT > 14) {
            String defaultHost = Proxy.getDefaultHost();
            return !TextUtils.isEmpty(defaultHost);
        } else {
            return false;
        }
    }

    public static DisplayMetrics getDisplayMetrics(Context context) {
        return context.getResources().getDisplayMetrics();
    }

    public static String getDriverTime() {
        try {
            long l = Build.TIME;
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append(l);
            stringBuilder.append("");
            return stringBuilder.toString();
        } catch (Exception var3) {
            return "";
        }
    }

    public static long getElapsedRealtime() {
        return SystemClock.elapsedRealtime();
    }

    public static long getUpdateMills() {
        return SystemClock.uptimeMillis();
    }

    public static int getCpuNum() {
        try {
            return Runtime.getRuntime().availableProcessors();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public static String getIMEI1(Context context) {
        String imei1 = "";
        try {
            imei1 = getImeiOrMeid(context, 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (TextUtils.isEmpty(imei1)) {
            imei1 = Settings.System.getString(
                    context.getContentResolver(), Secure.ANDROID_ID);
        }
        if (!TextUtils.isEmpty(imei1)) {
            return imei1;
        }

        return "";
    }


    @RequiresApi(api = Build.VERSION_CODES.M)
    public static String getIMEI2(Context context) {

        try {
            //imei2 imei1
            String imeiDefault = getIMEI1(context);
            if (TextUtils.isEmpty(imeiDefault)) {
                // imei ，，
                //， imei2
                return "";
            }

            //， IMEI 0，2 IMEI 1，
            String imei1 = getImeiOrMeid(context, 0);
            String imei2 = getImeiOrMeid(context, 1);
            //sim ，imei1 imei2， imeidefault 
            if (!TextUtils.equals(imei2, imeiDefault)) {
                // imeiDefault 
                return imei2;
            }
            if (!TextUtils.equals(imei1, imeiDefault)) {
                return imei1;
            }
        } catch (Exception e) {
            e.printStackTrace();

        }

        return "";
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public static String getImeiOrMeid(Context context, int slotId) {
        String imei = "";

        //Android 6.0   
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            return imei;
        }

        try {
            TelephonyManager manager = (TelephonyManager) context.getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);
            if (manager != null) {
                if (VERSION.SDK_INT >= Build.VERSION_CODES.O) {// android 8 getImei  MEID
                    Method method = manager.getClass().getMethod("getImei", int.class);
                    imei = (String) method.invoke(manager, slotId);
                } else if (VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    //5.0MEID/IMEI1/IMEI2  ----framework“ril.cdma.meid"“ril.gsm.imei"
                    imei = getSystemPropertyByReflect("ril.gsm.imei");
                    //  getDeviceId 

                } else {//5.0imei/meid getDeviceId  


                }
            }
        } catch (Exception e) {
        }

        if (TextUtils.isEmpty(imei)) {
            imei = getDeviceId(context, slotId);
        }
        return imei;
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public static String getDeviceId(Context context, int slotId) {
        String imei = "";
        imei = getDeviceIdFromSystemApi(context, slotId);
        if (TextUtils.isEmpty(imei)) {
            imei = getDeviceIdByReflect(context, slotId);
        }
        return imei;
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public static String getDeviceIdFromSystemApi(Context context, int slotId) {
        String imei = "";
        try {
            TelephonyManager telephonyManager =
                    (TelephonyManager) context.getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);
            if (telephonyManager != null) {
                imei = telephonyManager.getDeviceId(slotId);
            }
        } catch (Throwable e) {
        }
        return imei;
    }


    /**
     *  deviceId
     *
     * @param context
     * @param slotId  slotIdId， 0、1；
     * @return
     */
    public static String getDeviceIdByReflect(Context context, int slotId) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);
            Method method = tm.getClass().getMethod("getDeviceId", int.class);
            return method.invoke(tm, slotId).toString();
        } catch (Throwable e) {
        }
        return "";
    }

    private static String getSystemPropertyByReflect(String key) {
        try {
            @SuppressLint("PrivateApi")
            Class<?> clz = Class.forName("android.os.SystemProperties");
            Method getMethod = clz.getMethod("get", String.class, String.class);
            return (String) getMethod.invoke(clz, key, "");
        } catch (Exception e) {/**/}
        return "";
    }
}
