package com.homecredit.loan;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.provider.ContactsContract;
import android.provider.MediaStore;
import android.provider.Settings;
import android.speech.tts.TextToSpeech;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.camera.core.CameraSelector;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.google.android.gms.auth.api.phone.SmsRetriever;
import com.google.android.gms.auth.api.phone.SmsRetrieverClient;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.play.core.review.ReviewInfo;
import com.google.android.play.core.review.ReviewManager;
import com.google.android.play.core.review.ReviewManagerFactory;
import com.google.firebase.analytics.FirebaseAnalytics;
import com.homecredit.loan.camera.CamaraParcelable;
import com.homecredit.loan.camera.CameraUtils;
import com.homecredit.loan.camera.CameraXActivity;
import com.homecredit.loan.dialog.HAnimationsType;
import com.homecredit.loan.dialog.HDialog;
import com.homecredit.loan.hcjson.CommonUtil;
import com.homecredit.loan.hcjson.DeviceUtils;
import com.homecredit.loan.hcjson.PhoneTools;
import com.homecredit.loan.hcjson.UploadInfo;
import com.homecredit.loan.hcjson.config.ConfigValues;
import com.homecredit.loan.receiver.OTPReceiver;
import com.homecredit.loan.utils.AGZIP;
import com.homecredit.loan.utils.ALog;
import com.homecredit.loan.utils.AToast;
import com.homecredit.loan.utils.BitmapUtil;
import com.homecredit.loan.utils.CalendarReminderUtils;
import com.homecredit.loan.utils.DateTimeUtils;
import com.homecredit.loan.utils.FastClickHelper;
import com.homecredit.loan.utils.LocUtil;
import com.homecredit.loan.utils.NetworkUtil;
import com.homecredit.loan.utils.PhoneId;
import com.homecredit.loan.utils.SpUtils;
import com.homecredit.loan.utils.WebAgentUtil;

import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import im.crisp.client.ChatActivity;
import im.crisp.client.Crisp;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import top.zibin.luban.CompressionPredicate;
import top.zibin.luban.Luban;
import top.zibin.luban.OnCompressListener;

public class MainActivity extends FlutterActivity implements TextToSpeech.OnInitListener  {

    private final int requestAllPermissions = 600;
    private final int requestReadMediaImages = 500;
    private final int requestContactCode = 199;
    private final int requestPermissionCode = 100;
    private final int requestWebviewCode = 101;
    private final int requestCameraCode = 105;
    private final int REQUEST_IMAGE_CAPTURE = 111;
    private final int REQUEST_IMAGES = 112;

    private final int REQUEST_CAMERA8 = 200;
    private final int REQUEST_IMAGES8 = 201;
    private HDialog dialog;
    private HDialog cameraDialog;

    private static final String channel = "android";
    MethodChannel methodChannel_android;
    public static MethodChannel methodChannel_flutter;
    private MethodChannel.Result methodCall;
    public static final String KEY_IMAGE_PATH = "imagePath";

    private TextToSpeech tts;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        //android
        methodChannel_android = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), channel);
        methodChannel_android.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                try {
                    if (call.method != null) {
                        if ("getJson".equals(call.method)) {
                            getDeviceInfo(result);
                        } else if ("showDialog".equals(call.method)) {
                            Map<String, String> map = (Map<String, String>) call.arguments;
                            showDialog(map, result);
                        } else if ("getGaid".equals(call.method)) {
                            getGaid(result);
                        } else if ("logEvent".equals(call.method)) {
                            logEvent(call.arguments.toString());
                        } else if ("startLocation".equals(call.method)) {
                            startLocation();
                        } else if ("getLocation".equals(call.method)) {
                            result.success(getLocation());
                        } else if ("addCalendarEvent".equals(call.method)) {
                            Map<String, String> map = (Map<String, String>) call.arguments;
                            addCalendarEvent(map, result);
                        } else if ("startPermission".equals(call.method)) {
                            Intent intent = new Intent(MainActivity.this, PermissionActivity.class);
                            startActivity(intent);
                        } else if ("startUPermission".equals(call.method)) {
                            Intent intent = new Intent(MainActivity.this, UPerissionActivity.class);
                            startActivity(intent);
                        } else if ("showConfirmDialog".equals(call.method)) {
                            int flag = (int) call.arguments;
                            showConfirmDialog(flag, result);
                        } else if ("getUniqueID".equals(call.method)) {
                            getUniqueID(result);
                        } else if ("openWebview".equals(call.method)) {
                            boolean flag = NetworkUtil.isNetworkAvailable(MainActivity.this);
                            if (!flag) {
                                showNetworkDialog();
                            } else {
                                methodCall = result;
                                String url = call.arguments.toString();
                                Intent intent;
                                if (url.contains("easyloanPrivacy.html") || url.contains("easyloanterms.html")) {
                                    intent = new Intent(MainActivity.this, ProtocolActivity.class);
                                } else {
                                    intent = new Intent(MainActivity.this, WebActivity.class);
                                }
                                intent.putExtra("url", url);
                                startActivityForResult(intent, requestWebviewCode);
                            }
                        } else if ("getShowGuide".equals(call.method)) {
                            boolean flag = SpUtils.getInstance().getBoolean(ConfigValues.GUIDE, false);
                            result.success(flag);
                        } else if ("getShowPermission".equals(call.method)) {
                            boolean flag = SpUtils.getInstance().getBoolean(ConfigValues.PERMISSION, false);
                            result.success(flag);
                        } else if ("getShowUPermission".equals(call.method)) {
                            boolean flag = SpUtils.getInstance().getBoolean(ConfigValues.USER_POLICY, false);
                            result.success(flag);
                        } else if ("checkNetwork".equals(call.method)) {
                            boolean flag = NetworkUtil.isNetworkAvailable(MainActivity.this);
                            result.success(flag);
                            if (!flag) {
                                showNetworkDialog();
                            }
                        } else if ("getAppInstanceId".equals(call.method)) {
                            getAppInstanceId();
                        } else if ("getAppInstanceIdValue".equals(call.method)) {
                            String appInstanceId = SpUtils.getInstance().getString(ConfigValues.AppInstanceId, "");
                            result.success(appInstanceId);
                        } else if ("branchAndFirebaseEvent".equals(call.method)) {
                            branchAndFirebaseEvent(call.arguments.toString());
                        } else if ("facebookEvent".equals(call.method)) {
                            facebookEvent(call.arguments.toString());
                        } else if ("openContact".equals(call.method)) {
                            methodCall = result;
                            Intent intent = new Intent();
                            intent.setAction(Intent.ACTION_PICK);
                            intent.setType(ContactsContract.CommonDataKinds.Phone.CONTENT_TYPE);
                            intent.addCategory(Intent.CATEGORY_DEFAULT);
                            startActivityForResult(intent, requestContactCode);
                        } else if ("checkPhonePermission".equals(call.method)) {
                            boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.READ_CONTACTS) == PackageManager.PERMISSION_GRANTED;
                            result.success(flag);
                        } else if ("checkReadCallPermission".equals(call.method)) {
                            boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.READ_CALL_LOG) == PackageManager.PERMISSION_GRANTED;
                            result.success(flag);
                        } else if ("checkWriteStroagePermission".equals(call.method)) {
                            boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED;
                            result.success(flag);
                        } else if ("checkCameraPermission".equals(call.method)) {
                            boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED;
                            result.success(flag);
                        } else if ("openCrisp".equals(call.method)) {
                            Intent crispIntent = new Intent(MainActivity.this, ChatActivity.class);
                            startActivity(crispIntent);
                        } else if ("setCrispLogin".equals(call.method)) {
                            String phone = call.arguments.toString();
                            Crisp.resetChatSession(MainActivity.this);
                            Crisp.setTokenID(phone);
                            Crisp.setUserPhone(phone);
                        } else if ("setSessionSegment".equals(call.method)) {
                            Crisp.setSessionSegment(call.arguments.toString());
                        } else if ("setUserEmail".equals(call.method)) {
                            Crisp.setUserEmail(call.arguments.toString());
                        } else if ("startCamera".equals(call.method)) {
                            int type = (int) call.arguments;
                            boolean flag = NetworkUtil.isNetworkAvailable(MainActivity.this);
                            if (!flag) {
                                showNetworkDialog();
                            } else {
                                methodCall = result;
                                startCamera(type);
                            }
                        } else if ("showToast".equals(call.method)) {
                            AToast.shortToast(MainActivity.this, call.arguments.toString());
                        } else if ("getImei".equals(call.method)) {
                            result.success(getImei());
                        } else if ("openReview".equals(call.method)) {
                            openReview();
                        } else if ("checkReadMediaImages".equals(call.method)) {
                            checkReadMediaImages(result);
                        } else if ("checkTIRAMISU".equals(call.method)) {
                            checkTIRAMISU(result);
                        } else if ("checkPermission".equals(call.method)) {
                            String permission = call.arguments.toString();
                            if (permission.isEmpty() || !permission.contains("android.permission")) {
                                return;
                            }
                            boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, permission) == PackageManager.PERMISSION_GRANTED;
                            result.success(flag);
                        } else if ("requestReadMediaImages".equals(call.method)) {
                            methodCall = result;
                            ActivityCompat.requestPermissions(MainActivity.this,
                                    new String[]{
                                            Manifest.permission.READ_MEDIA_IMAGES,
                                    }, requestReadMediaImages);
                        } else if ("openAppSettings".equals(call.method)) {
                            openAppSettings();
                        } else if ("requestAllPermission".equals(call.method)) {
                            methodCall = result;
                            requestAllPermission();
                        } else if("getSmsCode".equals(call.method)){
                            startOTPListener(result);
                        }else if("initTextToSpeech".equals(call.method)){
                            initTextToSpeech();
                        }
                        else if("speakText".equals(call.method)){
                            Map<String, String> map = (Map<String, String>) call.arguments;
                            speakText(map);
                        }
                        else if("stopSpeak".equals(call.method)){
                            stopSpeak();
                        } else {
                            result.notImplemented();
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        methodChannel_flutter = new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(), "flutter"
        );
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        try {
            if (resultCode == RESULT_OK) {
                if (requestCode == requestPermissionCode) {
                    if (methodCall != null) {
                        methodCall.success(true);
                    }
                } else if (requestCode == requestWebviewCode) {
                    if (methodCall != null) {
                        methodCall.success(true);
                    }
                } else if (requestCode == requestContactCode) {
                    Map<String, String> map = getContactMap(data);
                    if (methodCall != null) {
                        methodCall.success(map);
                    }
                } else if (requestCode == requestCameraCode) {

                    Log.e("onActivityResult", "camera result");

                    String imagePath = data.getStringExtra(CamaraParcelable.CamaraConstante.PICTURE_PATH_KEY);
                    Log.e("onActivityResult", "camera result image url:" + imagePath);
                    Luban.with(this)
                            .load(imagePath)
                            .ignoreBy(100)
                            .setTargetDir(getPath())
                            .filter(new CompressionPredicate() {
                                @Override
                                public boolean apply(String path) {
                                    return !(TextUtils.isEmpty(path) || path.toLowerCase().endsWith(".gif"));
                                }
                            })
                            .setCompressListener(new OnCompressListener() {
                                @Override
                                public void onStart() {

                                }

                                @Override
                                public void onSuccess(File file) {
                                    if (methodCall != null) {
                                        methodCall.success(file.getAbsolutePath());
                                    }
                                }

                                @Override
                                public void onError(Throwable e) {
                                    if (methodCall != null) {
                                        methodCall.success("");
                                    }
                                }
                            }).launch();
                } else if (requestCode == REQUEST_IMAGES) {

                    Log.e("onActivityResult", "ablum result");

                    try {

                        Bitmap bitmap = BitmapFactory.decodeStream(getContentResolver().openInputStream(data.getData()));
                        File file = BitmapUtil.saveBitmap(bitmap, System.currentTimeMillis() + ".jpg", this);
                        if (file == null) {
                            return;
                        }
                        String imagePath = file.getAbsolutePath();
                        Log.e("onActivityResult", "ablum result image url" + imagePath);

                        Luban.with(this)
                                .load(imagePath)
                                .ignoreBy(100)
                                .setTargetDir(getPath())
                                .filter(new CompressionPredicate() {
                                    @Override
                                    public boolean apply(String path) {
                                        return !(TextUtils.isEmpty(path) || path.toLowerCase().endsWith(".gif"));
                                    }
                                })
                                .setCompressListener(new OnCompressListener() {
                                    @Override
                                    public void onStart() {

                                    }

                                    @Override
                                    public void onSuccess(File file) {
                                        if (methodCall != null) {
                                            methodCall.success(file.getAbsolutePath());
                                        }
                                    }

                                    @Override
                                    public void onError(Throwable e) {
                                        e.printStackTrace();
                                        if (methodCall != null) {
                                            methodCall.success("");
                                        }
                                    }
                                }).launch();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } else {
                if (requestCode == requestCameraCode || requestCode == REQUEST_IMAGES) {
                    if (methodCall != null) {
                        methodCall.success("");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getPath() {
        String path = getExternalFilesDir(null).getPath() + File.separator + "Camera";
        File file = new File(path);
        if (file.mkdirs()) {
            return path;
        }
        return path;
    }

    @SuppressLint("Range")
    private Map<String, String> getContactMap(Intent data) {
        String phoneNum = null;
        String contactName = null;
        Map<String, String> contactMap = new HashMap<>();
        Cursor cursor = null;
        try {
            Uri uri = data.getData();
            ContentResolver contentResolver = getContentResolver();
            if (uri != null) {
                cursor = contentResolver.query(uri, new String[]{"display_name", "data1"}, null, null, null);
            }
            while (cursor.moveToNext()) {
                contactName = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
                phoneNum = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
            }
            contactMap.put("name", contactName == null ? "" : contactName);
            contactMap.put("mobile", phoneNum == null ? "" : phoneNum);
        } catch (Exception e) {
            e.printStackTrace();
            contactMap.put("name", "");
            contactMap.put("mobile", "");
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        return contactMap;
    }

    private void getUniqueID(MethodChannel.Result result) {
        try {
            String uuid = PhoneId.getUniqueID();
            result.success(uuid);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void getGaid(final MethodChannel.Result result) {
        try {
            Map<String, String> map = new HashMap<String, String>();
            map.put("electricalLowCanada", PhoneTools.getSoftSDKVersion());
            map.put("violentChipsSorryEquipment", WebAgentUtil.getUserAgent());
            map.put("tallDiskNewspaperNationality", PhoneTools.getManufacturerName());
            map.put("sorryAccidentToothVillager", PhoneTools.getModelName());
            map.put("musicalMistFlatGlobe", SpUtils.getInstance().getString("musicalMistFlatGlobe", ""));
            result.success(map);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void getDeviceInfo(final MethodChannel.Result result) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    final JSONObject deviceInfo = UploadInfo.getDeviceJson(getContext());
                    result.success(AGZIP.compress(deviceInfo.toString()));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();

    }

    public void showDialog(Map<String, String> map, final MethodChannel.Result result) {
        try {
            String title = "";
            String content = "";
            if (map != null) {
                title = map.get("title");
                content = map.get("message");

                dialog = HDialog.newInstance(getActivity(), R.layout.dialog_confirm);
                dialog.setGravity(Gravity.CENTER)
                        .setText(R.id.tv_title, title)
                        .setText(R.id.tv_content, content)
                        .setAnimations(HAnimationsType.SCALE)
                        .setWidthRatio(0.9)
                        .setCancelBtn(R.id.tv_cancel)
                        .setOnClickListener(new HDialog.DialogOnClickListener() {
                            @Override
                            public void onClick(View v, HDialog dialog) {
                                if (FastClickHelper.isOnDoubleClick()) {
                                    return;
                                }
                                dialog.dismiss();
                                result.success(true);
                            }
                        }, R.id.tv_confirm)
                        .show();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void logEvent(String eventName) {
        if (!TextUtils.isEmpty(eventName)) {
            String[] value = eventName.split(",");
            if (value.length == 1) {
                ALog.branchAndFirebaseEvent(getContext(), value[0]);
            } else if (value.length == 2) {
                ALog.branchAndFirebaseEvent(getContext(), value[0]);
                ALog.facebookEvent(getContext(), value[1]);
            }
        }
    }

    public void startLocation() {
        try {
            LocUtil locationHelper = new LocUtil(this);
            locationHelper.startLoction();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getLocation() {
        String lbs = "0,0";
        try {
            String latitude = SpUtils.getInstance().getString(ConfigValues.latitude, "");
            String longitude = SpUtils.getInstance().getString(ConfigValues.longitude, "");
            if (!TextUtils.isEmpty(latitude) && !TextUtils.isEmpty(longitude)) {
                lbs = latitude + "," + longitude;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lbs;
    }

    public void addCalendarEvent(Map<String, String> map, final MethodChannel.Result result) {
        try {
            String dateStr = "";
            String format = "";
            String title = "";
            String description = "";
            if (map != null) {
                dateStr = map.get("date");
                format = map.get("format");
                title = map.get("title");
                description = map.get("description");
                if (ContextCompat.checkSelfPermission(getContext(), Manifest.permission.WRITE_CALENDAR) == PackageManager.PERMISSION_GRANTED) {
                    Date date = DateTimeUtils.parse(dateStr, format);
                    CalendarReminderUtils.addCalendarEvent(getContext(), title, description, date.getTime(), 0);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void showConfirmDialog(int flag, final MethodChannel.Result result) {
        try {
            dialog = HDialog.newInstance(getActivity(), R.layout.dialog_confirm_fixed);
            LinearLayout layoutSms = dialog.getView(R.id.layout_sms);
            LinearLayout layoutPhone = dialog.getView(R.id.layout_phone);
            float heightRatio = 0.5F;
            if (flag == 0) {
                layoutSms.setVisibility(View.GONE);
                layoutPhone.setVisibility(View.VISIBLE);
            } else {
                layoutSms.setVisibility(View.VISIBLE);
                layoutPhone.setVisibility(View.VISIBLE);
//                heightRatio = 0.8F;
            }
            dialog.setCanceledOnTouchOutside(false);
            dialog.setCancelable(false);
            dialog.setGravity(Gravity.CENTER)
                    .setAnimations(HAnimationsType.SCALE)
                    .setWidthRatio(0.9)
                    .setHeightRatio(heightRatio)
//                    .setCancelBtn(R.id.tv_cancel)
                    .setOnClickListener(new HDialog.DialogOnClickListener() {
                        @Override
                        public void onClick(View v, HDialog dialog) {
                            if (FastClickHelper.isOnDoubleClick()) {
                                return;
                            }
                            dialog.dismiss();
                            switch (v.getId()) {
                                case R.id.tv_confirm:
                                    result.success(true);
                                    break;
                                case R.id.tv_cancel:
                                    result.success(false);
                                    break;
                            }
                        }
                    }, R.id.tv_confirm, R.id.tv_cancel)
                    .show();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void showNetworkDialog() {
        try {
            dialog = HDialog.newInstance(this, R.layout.dialog_confirm);
            dialog.setGravity(Gravity.CENTER)
                    .setText(R.id.tv_title, "System hint")
                    .setText(R.id.tv_content, "The current network is unavailable, please check the network settings")
                    .setAnimations(HAnimationsType.SCALE)
                    .setWidthRatio(0.9)
                    .setCancelBtn(R.id.tv_cancel)
                    .setOnClickListener(new HDialog.DialogOnClickListener() {
                        @Override
                        public void onClick(View v, HDialog dialog) {
                            if (FastClickHelper.isOnDoubleClick()) {
                                return;
                            }
                            dialog.dismiss();
                            Intent intent = new Intent(Settings.ACTION_SETTINGS);
                            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                            startActivity(intent);
                        }
                    }, R.id.tv_confirm)
                    .show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void getAppInstanceId() {
        try {
            String pseudo_id = SpUtils.getInstance().getString(ConfigValues.AppInstanceId, "");
            if (TextUtils.isEmpty(pseudo_id)) {
                FirebaseAnalytics.getInstance(this).getAppInstanceId().addOnCompleteListener(new OnCompleteListener<String>() {
                    @Override
                    public void onComplete(@NonNull Task<String> task) {
                        if (task.isSuccessful()) {
                            String user_pseudo_id = task.getResult();
                            if (!TextUtils.isEmpty(user_pseudo_id)) {
                                SpUtils.getInstance().putString(ConfigValues.AppInstanceId, user_pseudo_id);
                            }
                        }
                    }
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void branchAndFirebaseEvent(String eventName) {
        if (!TextUtils.isEmpty(eventName)) {
            ALog.branchAndFirebaseEvent(getContext(), eventName);
        }
    }

    public void facebookEvent(String eventName) {
        if (!TextUtils.isEmpty(eventName)) {
            ALog.facebookEvent(getContext(), eventName);
        }
    }

    private void startCamera(int type) {
        Intent intent = new Intent(MainActivity.this, CameraXActivity.class);
        intent.putExtra(CameraUtils.CameraType, type);
        startActivityForResult(intent, requestCameraCode);
//        showPictureSelectorDialog(type);
    }

    public void showPictureSelectorDialog(int type) {
        try {
            if(type == 0){
                //
                Intent intent = new Intent(MainActivity.this, CameraXActivity.class);
                intent.putExtra(CameraUtils.CameraType, type);
                startActivityForResult(intent, requestCameraCode);
            }else {
                cameraDialog = HDialog.newInstance(this, R.layout.dialog_camera);
                cameraDialog.setCanceledOnTouchOutside(false);
                cameraDialog.setCancelable(false);
                cameraDialog.setGravity(Gravity.BOTTOM)
                        .setAnimations(HAnimationsType.SCALE)
                        .setWidthRatio(1)
                        .setCancelBtn(R.id.tv_cancel)
                        .setOnClickListener(new HDialog.DialogOnClickListener() {
                            @Override
                            public void onClick(View v, HDialog dialog) {
                                if (FastClickHelper.isOnDoubleClick()) {
                                    return;
                                }
                                dialog.dismiss();
                                switch (v.getId()) {
                                    case R.id.tv_camera:
                                        Intent intent = new Intent(MainActivity.this, CameraXActivity.class);
                                        intent.putExtra(CameraUtils.CameraType, type);
                                        startActivityForResult(intent, requestCameraCode);
                                        break;
                                    case R.id.tv_album:
                                        intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                                        intent.setDataAndType(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "image/*");
                                        startActivityForResult(intent, REQUEST_IMAGES);
                                        break;
                                }
                            }
                        }, R.id.tv_camera, R.id.tv_album)
                        .show();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getImei() {
        String imei = "";
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                imei = CommonUtil.getNonNullText(DeviceUtils.getIMEI1(this));
            } else {
                imei = DeviceUtils.getDeviceImeIValue(this);
            }
        } catch (Exception e) {
            imei = "";
        }
        return imei;
    }

    public void openReview() {
        ReviewManager manager = ReviewManagerFactory.create(MainActivity.this);
        Task<ReviewInfo> request = manager.requestReviewFlow();
        request.addOnCompleteListener(new OnCompleteListener<ReviewInfo>() {
            @Override
            public void onComplete(@NonNull Task<ReviewInfo> task) {
                try {
                    if (task.isSuccessful()) {
                        ReviewInfo reviewInfo = task.getResult();
                        reviewInfo.describeContents();
                        Task<Void> flow = manager.launchReviewFlow(MainActivity.this, reviewInfo);
                        flow.addOnCompleteListener(new OnCompleteListener<Void>() {
                            @Override
                            public void onComplete(@NonNull Task<Void> task2) {
                            }
                        });
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    private void checkTIRAMISU(MethodChannel.Result result) {
        result.success(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU ? true : false);
    }

    private void checkReadMediaImages(MethodChannel.Result result) {
        boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.READ_MEDIA_IMAGES) == PackageManager.PERMISSION_GRANTED;
        result.success(flag);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == requestReadMediaImages) {
            if (methodCall != null) {
                methodCall.success(true);
            }
        } else if (requestCode == requestAllPermissions) {
            if (methodCall != null) {
                try {
                    Map<String, Integer> map = new HashMap<>();
                    for (int i = 0; i < permissions.length; i++) {
                        map.put(permissions[i], grantResults[i]);
                    }
                    methodCall.success(map);
                } catch (Exception e) {

                }
            }
        }
    }

    public void openAppSettings() {
        Intent intent = new Intent();
        intent.setAction("android.settings.APPLICATION_DETAILS_SETTINGS");
        intent.setData(Uri.fromParts("package", getPackageName(), null));
        startActivity(intent);
    }

    private void requestAllPermission() {
        ActivityCompat.requestPermissions(this,
                new String[]{
//                        Manifest.permission.READ_SMS,
//                        Manifest.permission.READ_PHONE_STATE,
//                        Manifest.permission.WRITE_EXTERNAL_STORAGE,
                        Manifest.permission.CAMERA,
                        Manifest.permission.ACCESS_COARSE_LOCATION,
//                        Manifest.permission.READ_CALENDAR,
//                        Manifest.permission.WRITE_CALENDAR,
//                        Manifest.permission.READ_CALL_LOG
                }, requestAllPermissions);
    }

    private void requestPermission(String permission) {
        try {
            if (!TextUtils.isEmpty(permission)) {
                ActivityCompat.requestPermissions(this, new String[]{permission}, requestPermissionCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void checkPermission(String permission, MethodChannel.Result result) {
        boolean flag = ActivityCompat.checkSelfPermission(MainActivity.this, permission) == PackageManager.PERMISSION_GRANTED;
        if (!flag) {
            if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                    permission)) {

            } else {
                ActivityCompat.requestPermissions(this,
                        new String[]{permission}, requestPermissionCode);
            }
        }
        result.success(flag);
    }


    private void startOTPListener(MethodChannel.Result result) {
        try {
            OTPReceiver otpReceiver = new OTPReceiver();
            otpReceiver.setOTPListener(new OTPReceiver.OTPReceiveListener() {
                @Override
                public void onOTPReceived(String otp) {
                    try {
                        result.success(otp);
                        MainActivity.this.unregisterReceiver(otpReceiver);
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }

                @Override
                public void onOTPTimeOut() {

                }

                @Override
                public void onOTPReceivedError(String error) {

                }
            });

            IntentFilter intentFilter = new IntentFilter();
            intentFilter.addAction(SmsRetriever.SMS_RETRIEVED_ACTION);
            this.registerReceiver(otpReceiver, intentFilter);

            SmsRetrieverClient client = SmsRetriever.getClient(this);
            Task<Void> task = client.startSmsRetriever();
            task.addOnSuccessListener(new OnSuccessListener<Void>() {
                @Override
                public void onSuccess(Void aVoid) {
                    //
                    Log.d("OTPReceiver", "Success");
                }
            });

            task.addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    //，SMS
                    Log.e("OTPReceiver", "Failure");
                    e.printStackTrace();
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void initTextToSpeech() {
        // Context,TextToSpeech.OnInitListener
        tts = new TextToSpeech(this, this);
        // ，（），,1.0
        tts.setPitch(1.0f);
        // 
//        tts.setSpeechRate(0.5f);

    }

    private void speakText(Map<String, String> map) {
        if (map == null) {
            return;
        }
        try {
            if (tts != null) {
                if (tts.isSpeaking()) {
                    tts.stop();
                }
                tts.speak(map.get("text_ur"), TextToSpeech.QUEUE_FLUSH, null);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private void stopSpeak(){
        try{
            if(tts != null){
                // TTS
                tts.stop();
                // ，
                tts.shutdown();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void onInit(int i) {
        if (i == TextToSpeech.SUCCESS) {
            tts.setLanguage(new Locale("ur_PK"));
        }
    }

    @Override
    public void onStop() {
        super.onStop();
        try{
            if(tts != null){
                // TTS
                tts.stop();
                // ，
                tts.shutdown();
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @Override
    public void onDestroy() {
        if (tts != null) {
            tts.stop();
            tts.shutdown();
            tts = null;
        }
        super.onDestroy();
    }

}
