package com.homecredit.loan.utils;

import android.annotation.SuppressLint;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.graphics.Color;
import android.net.Uri;
import android.provider.CalendarContract;
import android.text.TextUtils;

import java.util.Calendar;
import java.util.TimeZone;

public class CalendarReminderUtils {

    private static String CALENDER_URL = "content://com.android.calendar/calendars";
    private static String CALENDER_EVENT_URL = "content://com.android.calendar/events";
    private static String CALENDER_REMINDER_URL = "content://com.android.calendar/reminders";

    private static String CALENDARS_NAME = "easyloan";
    private static String CALENDARS_ACCOUNT_NAME = "EasyLoan@easyloan.com";
    private static String CALENDARS_ACCOUNT_TYPE = "com.android.easyloan";
    private static String CALENDARS_DISPLAY_NAME = "EasyLoan";

    /**
     * ，
     * id，-1
     */
    private static int checkAndAddCalendarAccount(Context context) {
        int oldId = checkCalendarAccount(context);
        if (oldId >= 0) {
            return oldId;
        } else {
            long addId = addCalendarAccount(context);
            if (addId >= 0) {
                return checkCalendarAccount(context);
            } else {
                return -1;
            }
        }
    }

    /**
     * ，id，-1
     */
    @SuppressLint("Range")
    private static int checkCalendarAccount(Context context) {
        Cursor userCursor = context.getContentResolver().query(Uri.parse(CALENDER_URL), null, null, null, null);
        try {
            if (userCursor == null) { //
                return -1;
            }
            int count = userCursor.getCount();
            if (count > 0) { //，id
                userCursor.moveToFirst();
                return userCursor.getInt(userCursor.getColumnIndex(CalendarContract.Calendars._ID));
            } else {
                return -1;
            }
        } finally {
            if (userCursor != null) {
                userCursor.close();
            }
        }
    }

    /**
     * ，id，-1
     */
    private static long addCalendarAccount(Context context) {
        TimeZone timeZone = TimeZone.getDefault();
        ContentValues value = new ContentValues();
        value.put(CalendarContract.Calendars.NAME, CALENDARS_NAME);
        value.put(CalendarContract.Calendars.ACCOUNT_NAME, CALENDARS_ACCOUNT_NAME);
        value.put(CalendarContract.Calendars.ACCOUNT_TYPE, CALENDARS_ACCOUNT_TYPE);
        value.put(CalendarContract.Calendars.CALENDAR_DISPLAY_NAME, CALENDARS_DISPLAY_NAME);
        value.put(CalendarContract.Calendars.VISIBLE, 1);
        value.put(CalendarContract.Calendars.CALENDAR_COLOR, Color.BLUE);
        value.put(CalendarContract.Calendars.CALENDAR_ACCESS_LEVEL, CalendarContract.Calendars.CAL_ACCESS_OWNER);
        value.put(CalendarContract.Calendars.SYNC_EVENTS, 1);
        value.put(CalendarContract.Calendars.CALENDAR_TIME_ZONE, timeZone.getID());
        value.put(CalendarContract.Calendars.OWNER_ACCOUNT, CALENDARS_ACCOUNT_NAME);
        value.put(CalendarContract.Calendars.CAN_ORGANIZER_RESPOND, 0);

        Uri calendarUri = Uri.parse(CALENDER_URL);
        calendarUri = calendarUri.buildUpon()
                .appendQueryParameter(CalendarContract.CALLER_IS_SYNCADAPTER, "true")
                .appendQueryParameter(CalendarContract.Calendars.ACCOUNT_NAME, CALENDARS_ACCOUNT_NAME)
                .appendQueryParameter(CalendarContract.Calendars.ACCOUNT_TYPE, CALENDARS_ACCOUNT_TYPE)
                .build();

        Uri result = context.getContentResolver().insert(calendarUri, value);
        long id = result == null ? -1 : ContentUris.parseId(result);
        return id;
    }

    /**
     * 
     */
    public static void addCalendarEvent(Context context, String title, String description, long reminderTime, int previousDate) {
        if (context == null) {
            return;
        }
        int calId = checkAndAddCalendarAccount(context); //id
        if (calId < 0) { //id，
            return;
        }

        //
        Calendar mCalendar = Calendar.getInstance();
        mCalendar.setTimeInMillis(reminderTime);//
        //
        int year = mCalendar.get(Calendar.YEAR);
        //
        int month = (mCalendar.get(Calendar.MONTH));
        //：
        int day_of_month = mCalendar.get(Calendar.DAY_OF_MONTH);
        mCalendar.set(year, month, day_of_month, 10, 0, 0);
        long start = mCalendar.getTime().getTime();
//        mCalendar.setTimeInMillis(start + 10 * 60 * 1000);//，10
        mCalendar.set(year, month, day_of_month, 23, 59, 0);
        long end = mCalendar.getTime().getTime();
        ContentValues event = new ContentValues();
        event.put(CalendarContract.Events.TITLE, title);// 
        event.put(CalendarContract.Events.DESCRIPTION, description);
        event.put(CalendarContract.Events.CALENDAR_ID, calId); //id
        event.put(CalendarContract.Events.DTSTART, start);// 
        event.put(CalendarContract.Events.DTEND, end);// 
        event.put(CalendarContract.Events.HAS_ALARM, 1);//
        event.put(CalendarContract.Events.EVENT_TIMEZONE, TimeZone.getDefault().getID());//，
        Uri newEvent = context.getContentResolver().insert(Uri.parse(CALENDER_EVENT_URL), event); //
        if (newEvent == null) { //
            return;
        }
        //
        ContentValues values = new ContentValues();
        values.put(CalendarContract.Reminders.EVENT_ID, ContentUris.parseId(newEvent));
        values.put(CalendarContract.Reminders.MINUTES, previousDate * 24 * 60);// previousDate
        values.put(CalendarContract.Reminders.METHOD, CalendarContract.Reminders.METHOD_ALERT);
        Uri uri = context.getContentResolver().insert(Uri.parse(CALENDER_REMINDER_URL), values);
        if (uri == null) { //
            return;
        }
    }

    /**
     * 
     */
    public static void deleteCalendarEvent(Context context, String title) {
        if (context == null) {
            return;
        }
        Cursor eventCursor = context.getContentResolver().query(Uri.parse(CALENDER_EVENT_URL), null, null, null, null);
        try {
            if (eventCursor == null) { //
                return;
            }
            if (eventCursor.getCount() > 0) {
                //，titletitle
                for (eventCursor.moveToFirst(); !eventCursor.isAfterLast(); eventCursor.moveToNext()) {
                    @SuppressLint("Range") String eventTitle = eventCursor.getString(eventCursor.getColumnIndex("title"));
                    if (!TextUtils.isEmpty(title) && title.equals(eventTitle)) {
                        @SuppressLint("Range") int id = eventCursor.getInt(eventCursor.getColumnIndex(CalendarContract.Calendars._ID));//id
                        Uri deleteUri = ContentUris.withAppendedId(Uri.parse(CALENDER_EVENT_URL), id);
                        int rows = context.getContentResolver().delete(deleteUri, null, null);
                        if (rows == -1) { //
                            return;
                        }
                    }
                }
            }
        } finally {
            if (eventCursor != null) {
                eventCursor.close();
            }
        }
    }
}