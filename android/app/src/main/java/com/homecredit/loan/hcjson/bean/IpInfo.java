package com.homecredit.loan.hcjson.bean;

import android.text.TextUtils;

public class IpInfo {
    private String first_ip = "";
    private String second_ip = "";

    public String getFirst_ip() {
        return first_ip;
    }

    public void setFirst_ip(String first_ip) {
        if (TextUtils.isEmpty(first_ip)) {
            first_ip = "";
        }
        this.first_ip = first_ip;
    }

    public String getSecond_ip() {
        return second_ip;
    }

    public void setSecond_ip(String second_ip) {

        if (TextUtils.isEmpty(second_ip)) {
            second_ip = "";
        }
        this.second_ip = second_ip;
    }
}
