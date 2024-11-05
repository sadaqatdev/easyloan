package com.homecredit.loan.hcjson;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.content.Context;

import org.json.JSONArray;
import org.json.JSONObject;

public class AccountsUtil {
    public static JSONArray getAppAccounts(Context context) {
        JSONArray jsonArray = new JSONArray();
        try {
            Account[] accounts = AccountManager.get(context).getAccounts();
            if (accounts != null && accounts.length > 0) {
                for (Account account : accounts) {
                    String name = account.name;
                    String type = account.type;
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", name);
                    jsonObject.put("type", type);
                    jsonArray.put(jsonObject);
                }
            } else {

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jsonArray;
    }
}
