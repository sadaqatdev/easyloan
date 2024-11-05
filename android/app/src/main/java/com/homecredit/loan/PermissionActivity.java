package com.homecredit.loan;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.widget.TextView;

import com.homecredit.loan.hcjson.config.ConfigValues;
import com.homecredit.loan.utils.FastClickHelper;
import com.homecredit.loan.utils.SpUtils;
import com.homecredit.loan.utils.StatusBar;

public class PermissionActivity extends AppCompatActivity implements View.OnClickListener {

    private static final int PERMISSION_REQUEST = 101;

    private TextView tvPolicy;
    private TextView tvSkip;
    private TextView tvAgree;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatusBar.setWindowStatusBarBlackColor(this);
        setContentView(R.layout.activity_permission);

        tvPolicy = findViewById(R.id.tv_policy);
        tvPolicy.setOnClickListener(this);
        tvSkip = findViewById(R.id.tv_skip);
        tvSkip.setOnClickListener(this);
        tvAgree = findViewById(R.id.tv_agree);
        tvAgree.setOnClickListener(this);

        tvPolicy.setText(Html.fromHtml(getString(R.string.permission_policy)));
    }

    @Override
    public void onClick(View view) {
        if (FastClickHelper.isOnDoubleClick()) {
            return;
        }
        if (view == tvPolicy) {
            Intent intent = new Intent(this, WebActivity.class);
            intent.putExtra("url", ConfigValues.policy_url);
            startActivity(intent);
        } else if (view == tvSkip) {
            sendToFlutter(10);
            notifyMain();
        } else if (view == tvAgree) {
            sendToFlutter(11);
            requestPermission();
        }
    }

    private void requestPermission() {
        ActivityCompat.requestPermissions(this,
                new String[]{
//                        Manifest.permission.RECEIVE_SMS,
//                        Manifest.permission.READ_SMS,
//                        Manifest.permission.READ_PHONE_STATE,
//                        Manifest.permission.WRITE_EXTERNAL_STORAGE,
                        Manifest.permission.CAMERA,
                        Manifest.permission.ACCESS_COARSE_LOCATION,
//                        Manifest.permission.READ_CALENDAR,
//                        Manifest.permission.WRITE_CALENDAR,
//                        Manifest.permission.READ_CALL_LOG,
//                        Manifest.permission.RECORD_AUDIO
                }, PERMISSION_REQUEST);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PERMISSION_REQUEST) {
            notifyMain();
        }
    }

    private void notifyMain() {
//        setResult(RESULT_OK);
        SpUtils.getInstance().putBoolean(ConfigValues.PERMISSION, true);
        boolean flag = SpUtils.getInstance().getBoolean(ConfigValues.USER_POLICY, false);
        if (!flag) {
            Intent intent = new Intent(PermissionActivity.this, UPerissionActivity.class);
            startActivity(intent);
        }
        finish();
    }

    @Override
    public void onBackPressed() {

    }

    private void sendToFlutter(int type) {
        if (MainActivity.methodChannel_flutter != null) {
            MainActivity.methodChannel_flutter.invokeMethod("plog", type);
        }
    }
}