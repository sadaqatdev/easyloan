package com.homecredit.loan.utils;

import android.text.format.DateFormat;
import android.text.format.DateUtils;
import android.text.format.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateTimeUtils {
    /**
     *  ：2010-12-01 23:15:06
     */
    public static final String FORMAT_LONG = "yyyy-MM-dd HH:mm:ss";

    /**
     *  ：yyyy-MM-dd HH:mm:ss.SSS
     */
    private static final String FORMAT_FULL = "yyyy-MM-dd HH:mm:ss.SSS";
    /**
     * （）：2010-12-01
     */
    public static String FORMAT_SHORT = "dd-MM-yyyy";
    public static String FORMAT_SHORT1 = "yyyy-MM-dd";

    private DateTimeUtils() {
        throw new UnsupportedOperationException("cannot be instantiated");
    }

    /**
     *  date pattern
     */
    private static String getDatePattern() {
        return FORMAT_LONG;
    }

    /**
     * 
     *
     * @param date
     * @return
     */
    public static String format(Date date) {
        return format(date, getDatePattern());
    }

    /**
     * 
     *
     * @param date    
     * @param pattern 
     * @return
     */
    public static String format(Date date, String pattern) {
        String returnValue = "";
        if (date != null) {
            SimpleDateFormat df = new SimpleDateFormat(pattern, Locale.CHINA);
            returnValue = df.format(date);
        }
        return (returnValue);
    }

    /**
     * 
     *
     * @param strDate 
     * @return
     */
    private static Date parse(String strDate) {
        return parse(strDate, getDatePattern());
    }

    /**
     * 
     *
     * @param strDate 
     * @param pattern 
     * @return
     */
    public static Date parse(String strDate, String pattern) {
        SimpleDateFormat df = new SimpleDateFormat(pattern, Locale.CHINA);
        try {
            return df.parse(strDate);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     *
     * @param date 
     * @param n    
     * @return
     */
    public static Date addDay(Date date, int n) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, n);
        return cal.getTime();
    }

    /**
     * UTC-0.
     *
     * @param strUtcTime UTC-0
     * @param strInFmt   
     * @param strOutFmt  ，null
     * @return .
     * @throws ParseException 
     */
    public static String getUserZoneString(final String strUtcTime,
                                           final String strInFmt, final String strOutFmt)
            throws ParseException {
        if (StringUtils.isNull(strUtcTime)) {
            throw new NullPointerException("strDate");
        } else if (StringUtils.isNull(strInFmt)) {
            throw new NullPointerException("strInFmt");
        }
        long lUserMillis = getUserZoneMillis(strUtcTime, strInFmt);
        String strFmt = strInFmt;
        if (!StringUtils.isNull(strOutFmt)) {
            strFmt = strOutFmt;
        }
        return format(lUserMillis, strFmt);
    }

    /**
     * .
     *
     * @param lMillis  
     * @param strInFmt 
     * @return 
     */
    public static String format(final long lMillis, final String strInFmt) {
        if (StringUtils.isNull(strInFmt)) {
            throw new NullPointerException("strInFmt");
        }
        return (String) DateFormat.format(strInFmt, lMillis);
    }

    /**
     * UTC-01970-01-01.
     *
     * @param strUtcTime UTC-0
     * @param strInFmt   
     * @return 1970-01-01.
     * @throws ParseException 
     */
    @SuppressWarnings("deprecation")
    public static long getUserZoneMillis(final String strUtcTime,
                                         final String strInFmt) throws ParseException {
        if (StringUtils.isNull(strUtcTime)) {
            throw new NullPointerException("strUtcTime");
        } else if (StringUtils.isNull(strInFmt)) {
            throw new NullPointerException("strInFmt");
        }
        long lUtcMillis = parseMillis(strUtcTime, strInFmt);
        Time time = new Time();
        time.setToNow();
        long lOffset = time.gmtoff * DateUtils.SECOND_IN_MILLIS;
        long lUserZoneMillis = lUtcMillis + lOffset;
        return lUserZoneMillis;
    }

    /**
     * ，1970-01-01.
     *
     * @param strDate  
     * @param strInFmt 
     * @return 1970-01-01
     * @throws ParseException 
     */
    public static long parseMillis(final String strDate, final String strInFmt)
            throws ParseException {
        if (StringUtils.isNull(strDate)) {
            throw new NullPointerException("strDate");
        } else if (StringUtils.isNull(strInFmt)) {
            throw new NullPointerException("strInFmt");
        }
        SimpleDateFormat sdf = new SimpleDateFormat(strInFmt,
                Locale.getDefault());
        Date date = sdf.parse(strDate);
        return date.getTime();
    }

    public static String utc2BeiJingTime(String message) {
        String beiJingTime = message;
        if (message.contains("#")) {
            String[] loginInfo = message.split("#");
            if (loginInfo != null && loginInfo.length >= 3) {
                try {
                    String utcTime = loginInfo[1];
                    beiJingTime = getUserZoneString(utcTime, "HH:mm", null);
                    String repaceTimeStr = "#"+utcTime+"#";
                    beiJingTime = message.replace(repaceTimeStr,beiJingTime);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }
        return beiJingTime;
    }
}
