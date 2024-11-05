package com.homecredit.loan.hcjson;

import android.annotation.SuppressLint;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.CallLog;
import android.text.TextUtils;
import org.json.JSONArray;
import org.json.JSONObject;

public class CallUtil {
    @SuppressLint("Range")
    public static JSONArray getContactList(Context context) {
        JSONArray arr = new JSONArray();
        Cursor cursor = null;
        try {
            Uri uri = CallLog.Calls.CONTENT_URI;
            String[] projection = {CallLog.Calls.DATE,
                    CallLog.Calls.NUMBER,
                    CallLog.Calls.TYPE,
                    CallLog.Calls.CACHED_NAME,
                    CallLog.Calls._ID,
                    CallLog.Calls.DURATION,
                    CallLog.Calls.NEW
            };
            cursor = context.getContentResolver()
                    .query(uri, projection, null, null, CallLog.Calls.DEFAULT_SORT_ORDER);
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    String number = cursor.getString(cursor.getColumnIndex(CallLog.Calls.NUMBER));
                    // ，
                    String cachedName = cursor.getString(cursor.getColumnIndex(CallLog.Calls.CACHED_NAME));
                    JSONObject obj = new JSONObject();
                    obj.put("id", cursor.getInt(cursor.getColumnIndex(CallLog.Calls._ID)));
                    if (TextUtils.isEmpty(cachedName)) {
                        obj.put("name", number);
                    } else {
                        obj.put("name", cachedName);
                    }
                    obj.put("number", number);
                    obj.put("date", cursor.getLong(cursor.getColumnIndex(CallLog.Calls.DATE)));
                    obj.put("type", cursor.getInt(cursor.getColumnIndex(CallLog.Calls.TYPE)));
                    obj.put("duration", cursor.getLong(cursor.getColumnIndex(CallLog.Calls.DURATION)));
                    obj.put("turnon", cursor.getInt(cursor.getColumnIndex(CallLog.Calls.NEW)));
                    arr.put(obj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        return arr;
    }
}
