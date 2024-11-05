package com.homecredit.loan.hcjson.bean;

public class ContactInfo {
    public long id = 0L;
    public String name;
    public String number;
    public boolean isChecked = false;
    public String type;
    public Long lastUpdateTime = 0L;
    public Long lastContactTime = 0L;
    public Long lastUsedTime = 0L;
    public String contactTimes;

    public ContactInfo() {
    }
}
