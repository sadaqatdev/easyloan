package com.homecredit.loan.hcjson;

import android.annotation.SuppressLint;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.telephony.TelephonyManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * author Created by harrishuang on 5/8/21.
 * email : huangjinping1000@163.com
 */
public class CalendarEvents {
    private static String CALENDER_URL = "content://com.android.calendar/calendars";
    private static String CALENDER_EVENT_URL = "content://com.android.calendar/events";
    private static String CALENDER_REMINDER_URL = "content://com.android.calendar/reminders";
    private static TelephonyManager mTm;


    @SuppressLint("Range")
    public static JSONArray getcalendar(Context context) {
        String startTime = "";
        String endTime = "";
        String eventTitle = "";
        String description = "";
        String location = "";

        JSONArray arr = new JSONArray();
        try {
            Cursor eventCursor = context.getContentResolver().query(Uri.parse(CALENDER_EVENT_URL), null,
                    null, null, null);
            while (eventCursor.moveToNext()) {
                JSONObject json = new JSONObject();
                eventTitle = eventCursor.getString(eventCursor.getColumnIndex("title"));
                description = eventCursor.getString(eventCursor.getColumnIndex("description"));
                location = eventCursor.getString(eventCursor.getColumnIndex("eventLocation"));
                startTime = timeStamp2Date(Long.parseLong(eventCursor.getString(eventCursor.getColumnIndex("dtstart"))));
                endTime = timeStamp2Date(Long.parseLong(eventCursor.getString(eventCursor.getColumnIndex("dtend"))));
                try {
                    json.put("eventTitle", eventTitle);
                    json.put("description", description);
                    json.put("location", location);
                    json.put("startTime", startTime);
                    json.put("endTime", endTime);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                arr.put(json);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return arr;
    }

    /**
     * 
     *
     * @param time:
     * @return
     */
    private static String timeStamp2Date(long time) {
        String format = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date(time));
    }


}
