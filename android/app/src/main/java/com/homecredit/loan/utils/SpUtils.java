package com.homecredit.loan.utils;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.SharedPreferences;

public class SpUtils {
    public static final String SP_NAME = "Config";

    // SharedPreferences
    private SharedPreferences sp;
    // SharedPreferences，SharedReferences
    private SharedPreferences.Editor editor;
    // 
    private volatile static SpUtils mInstance = null;

    /**
     * 
     */
    private SpUtils() { }

    /**
     * ，
     * @return
     */
    public static SpUtils getInstance() {
        if (mInstance == null) {
            synchronized (SpUtils.class) {
                if (mInstance == null) {
                    mInstance = new SpUtils();
                }
            }
        }
        return mInstance;
    }

    /**
     * SharedPreferences
     * MODE_PRIVATE：
     * MODE_WORLD_READABLE:，
     * MODE_WORLD_WRITEABLE:
     */
    @SuppressLint("CommitPrefEdits")
    public void initSp(Context mContext) {
        sp = mContext.getSharedPreferences(SP_NAME, Context.MODE_PRIVATE);
        editor = sp.edit();
    }

    /**
     * int
     * @param key
     * @param values
     */
    public void putInt(String key, int values) {
        editor.putInt(key, values);
        editor.commit();
    }

    /**
     * int
     * @param key
     * @param defValues
     * @return
     */
    public int getInt(String key, int defValues) {
        return sp.getInt(key, defValues);
    }

    /**
     * String
     * @param key
     * @param values
     */
    public void putString(String key, String values) {
        editor.putString(key, values);
        editor.commit();
    }

    /**
     * String
     * @param key
     * @param defValues
     * @return
     */
    public String getString(String key, String defValues) {
        return sp.getString(key, defValues);
    }

    /**
     * Boolean
     * @param key
     * @param values
     */
    public void putBoolean(String key, boolean values) {
        editor.putBoolean(key, values);
        editor.commit();
    }

    /**
     * boolean
     * @param key
     * @param defValues
     * @return
     */
    public boolean getBoolean(String key, boolean defValues) {
        return sp.getBoolean(key, defValues);
    }

    /**
     * Key
     * @param key
     */
    public void deleteKey(String key) {
        editor.remove(key);
        editor.commit();
    }

}
