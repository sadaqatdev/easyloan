package com.homecredit.loan.hcjson;

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build.VERSION;
import android.provider.ContactsContract.CommonDataKinds.Phone;
import android.provider.ContactsContract.Contacts;
import android.provider.ContactsContract.Data;
import android.provider.ContactsContract.Groups;
import android.telephony.TelephonyManager;
import android.text.TextUtils;

import com.homecredit.loan.hcjson.bean.ContactInfo;

import org.json.JSONArray;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class ContactsUtil {
    private Context mContext;
    private final String TYPE_DEVIECE = "device";
    private final String TYPE_SIM = "sim";
    private String[] PHONES_PROJECTION = new String[]{"display_name", "data1", "times_contacted", "last_time_contacted", "photo_id", "contact_id"};
    private final String LIMIT_PARAM_KEY = "limit";

    public ContactsUtil(Context context) {
        this.mContext = context;
    }

    public JSONArray getContactsInfo() {
        List<ContactInfo> list = this.queryContacts(0, -1);
        JSONArray contacts = new JSONArray();
        if (list != null && !list.isEmpty()) {
            Iterator var3 = list.iterator();

            while(var3.hasNext()) {
                ContactInfo item = (ContactInfo)var3.next();
                JSONObject contact = new JSONObject();

                try {
                    contact.put("contact_display_name", RDataUtil.filterOffUtf8Mb4(item.name));
                    contact.put("number", RDataUtil.filterOffUtf8Mb4(item.number));
                    String times_contacted = item.contactTimes;
                    if(TextUtils.isEmpty(times_contacted)){
                        times_contacted = "0";
                    }
                    contact.put("times_contacted", times_contacted);
                    contact.put("last_time_contacted", item.lastContactTime);
                    contact.put("up_time", item.lastUpdateTime);
                    contact.put("lastUsedTime", item.lastUsedTime);
                    contact.put("source", CommonUtil.getNonNullText(item.type));
                    contact.put("group", this.queryGroups(item.id));
                    contacts.put(contact);
                } catch (Exception var7) {
                }
            }
        }

        return contacts;
    }

    private List<ContactInfo> queryContacts(int id, int limit) {
        ArrayList allFriendInfoList = new ArrayList();

        try {
            allFriendInfoList.addAll(this.fillDetailInfo(id, limit));
            allFriendInfoList.addAll(this.getSimContactInfoList());
            return allFriendInfoList;
        } catch (Exception var8) {
            var8.printStackTrace();
            return allFriendInfoList;
        } finally {
            ;
        }
    }

    private ArrayList<ContactInfo> getSimContactInfoList() {
        ArrayList<ContactInfo> simFriendInfos = new ArrayList();
        TelephonyManager manager = (TelephonyManager)this.mContext.getSystemService(Context.TELEPHONY_SERVICE);
        if (manager != null && manager.getSimState() != TelephonyManager.SIM_STATE_READY) {
            return simFriendInfos;
        } else {
            ContentResolver resolver = this.mContext.getContentResolver();
            Uri uri = Uri.parse("content://icc/adn");
            Cursor phoneCursor = resolver.query(uri, this.PHONES_PROJECTION, (String)null, (String[])null, (String)null);

            while(phoneCursor != null && phoneCursor.moveToNext()) {
                int columnIndex = phoneCursor.getColumnIndex("_id");
                long id = phoneCursor.getLong(columnIndex);
                String phoneNumber = phoneCursor.getString(1);
                if (!TextUtils.isEmpty(phoneNumber)) {
                    String contactName = phoneCursor.getString(0);
                    ContactInfo friendInfo = new ContactInfo();
                    friendInfo.name = contactName;
                    friendInfo.number = phoneNumber;
                    friendInfo.type = "sim";
                    friendInfo.id = id;
                    simFriendInfos.add(friendInfo);
                }
            }

            if (phoneCursor != null) {
                phoneCursor.close();
            }

            return simFriendInfos;
        }
    }

    private ArrayList<ContactInfo> fillDetailInfo(int id, int limit) {
        ArrayList<ContactInfo> phoneFriendInfoList = new ArrayList();
        ContentResolver cr = this.mContext.getContentResolver();
        String[] projection = new String[]{"_id", "has_phone_number", "display_name"};
        String selection = "_id > " + id;
        String sort = "_id";
        Uri queryUri = limit > 0 ? Contacts.CONTENT_URI.buildUpon().appendQueryParameter("limit", String.valueOf(limit)).build() : Contacts.CONTENT_URI;
        Cursor cursor = cr.query(queryUri, projection, selection, (String[])null, sort);
        if (cursor != null && cursor.getCount() > 0) {
            while(true) {
                boolean hasPhone;
                String displayName;
                ContactInfo friendInfo;
                String phoneNumber;
                while(true) {
                    if (!cursor.moveToNext()) {
                        return phoneFriendInfoList;
                    }

                    queryUri = Phone.CONTENT_URI;
                    selection = "contact_id = ? ";
                    String[] args = new String[1];
                    StringBuilder builder = new StringBuilder();
                    int columnIndex = cursor.getColumnIndex("_id");
                    long rawId = cursor.getLong(columnIndex);
                    int hasPhoneColumnIndex = cursor.getColumnIndex("has_phone_number");
                    hasPhone = hasPhoneColumnIndex > 0 && cursor.getInt(hasPhoneColumnIndex) > 0;
                    int displayNameColumnIndex = cursor.getColumnIndex("display_name");
                    displayName = cursor.getString(displayNameColumnIndex);
                    friendInfo = new ContactInfo();
                    friendInfo.id = rawId;
                    phoneNumber = "";
                    if (!hasPhone) {
                        break;
                    }

                    args[0] = String.valueOf(rawId);
                    List projectionList;
                    if (VERSION.SDK_INT >= 18) {
                        projectionList = Arrays.asList("data1", "last_time_contacted", "last_time_used", "times_used", "times_contacted", "contact_last_updated_timestamp");
                    } else {
                        projectionList = Arrays.asList("data1", "times_contacted");
                    }

                    String[] projection2 = (String[])((String[])projectionList.toArray());
                    Cursor phoneCur = cr.query(queryUri, projection2, selection, args, (String)null);
                    if (phoneCur != null && phoneCur.getCount() > 0) {
                        builder.delete(0, builder.length());

                        while(phoneCur.moveToNext()) {
                            int timesContactsColumnIndex = phoneCur.getColumnIndex("times_contacted");
                            friendInfo.contactTimes = phoneCur.getString(timesContactsColumnIndex);
                            if (VERSION.SDK_INT >= 18) {
                                int lastTimeUsedColumnIndex = phoneCur.getColumnIndex("last_time_used");
                                friendInfo.lastUsedTime = phoneCur.getLong(lastTimeUsedColumnIndex);
                                int lastTimeContactedColumnIndex = phoneCur.getColumnIndex("last_time_contacted");
                                friendInfo.lastContactTime = phoneCur.getLong(lastTimeContactedColumnIndex);
                                int lastUpdateTimeUsedColumnIndex = phoneCur.getColumnIndex("contact_last_updated_timestamp");
                                friendInfo.lastUpdateTime = phoneCur.getLong(lastUpdateTimeUsedColumnIndex);
                            }

                            columnIndex = phoneCur.getColumnIndex("data1");
                            if (columnIndex >= 0) {
                                String phone = phoneCur.getString(columnIndex);
                                if (!RDataUtil.isValidChinaChar(phone)) {
                                    builder.append(phone);
                                    if (!phoneCur.isLast()) {
                                        builder.append(",");
                                    }
                                }
                            }
                        }

                        phoneCur.close();
                        phoneNumber = builder.toString();
                        break;
                    }
                }

                friendInfo.name = displayName;
                friendInfo.type = "device";
                if (hasPhone) {
                    friendInfo.number = phoneNumber;
                } else {
                    friendInfo.number = displayName;
                }

                phoneFriendInfoList.add(friendInfo);
            }
        } else {
            return phoneFriendInfoList;
        }
    }

    private ArrayList<String> queryGroups(Long rawId) {
        ArrayList<String> groupNameArray = new ArrayList();
        ContentResolver cr = this.mContext.getContentResolver();
        String[] projection = new String[]{"data1"};
        Cursor groupCursor = cr.query(Data.CONTENT_URI, projection, "mimetype='vnd.android.cursor.item/group_membership' AND raw_contact_id = " + rawId, (String[])null, (String)null);

        while(groupCursor != null && groupCursor.moveToNext()) {
            Cursor groupNameCursor = cr.query(Groups.CONTENT_URI, (String[]) Arrays.asList("title").toArray(new String[0]), "_id=" + groupCursor.getInt(0), (String[])null, (String)null);
            if (groupNameCursor != null) {
                groupNameCursor.moveToNext();
                groupNameArray.add(groupNameCursor.getString(0));
                groupNameCursor.close();
            }
        }

        if (groupCursor != null) {
            groupCursor.close();
        }

        return groupNameArray;
    }
}
