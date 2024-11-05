package com.homecredit.loan.utils;

import android.os.Build;
import android.text.TextUtils;

import com.homecredit.loan.AppApplication;

import java.lang.reflect.Field;
import java.util.Locale;

public class WebAgentUtil {

    private static String userAgent;

    public static String getUserAgent() {
        if (TextUtils.isEmpty(userAgent)) {
            String webUserAgent = null;
            try {
                Class<?> sysResCls = Class.forName("com.android.internal.R$string");
                Field webUserAgentField = sysResCls.getDeclaredField("web_user_agent");
                Integer resId = (Integer) webUserAgentField.get(null);
                webUserAgent = AppApplication.getInstance().getString(resId);
            } catch (Exception e) {
                // We have nothing to do
            }
            if (TextUtils.isEmpty(webUserAgent)) {
                webUserAgent = "Mozilla/5.0 (Linux; U; Android; en-us;  Build/FRG83) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1";
            }

            Locale locale = Locale.getDefault();
            StringBuffer buffer = new StringBuffer();
            // Add version
            final String version = Build.VERSION.RELEASE;
            if (version.length() > 0) {
                buffer.append(version);
            } else {
                // default to "1.0"
                buffer.append("1.0");
            }
            buffer.append("; ");
            final String language = locale.getLanguage();
            if (language != null) {
                buffer.append(language.toLowerCase(locale));
                final String country = locale.getCountry();
                if (!TextUtils.isEmpty(country)) {
                    buffer.append("-");
                    buffer.append(country.toLowerCase(locale));
                }
            } else {
                // default to "en"
                buffer.append("en");
            }
            // add the model for the release build
            if ("REL".equals(Build.VERSION.CODENAME)) {
                final String model = Build.MODEL;
                if (model.length() > 0) {
                    buffer.append("; ");
                    buffer.append(model);
                }
            }
            final String id = Build.ID;
            if (id.length() > 0) {
                buffer.append(" Build/");
                buffer.append(id);
            }
            userAgent = String.format(webUserAgent, buffer, "Mobile ");
        }
        return userAgent;
    }
}
