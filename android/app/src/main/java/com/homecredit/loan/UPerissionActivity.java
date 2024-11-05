package com.homecredit.loan;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.text.SpannableStringBuilder;
import android.text.TextPaint;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.util.Log;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.CheckBox;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.homecredit.loan.hcjson.config.ConfigValues;
import com.homecredit.loan.utils.AToast;
import com.homecredit.loan.utils.FastClickHelper;
import com.homecredit.loan.utils.NetworkUtil;
import com.homecredit.loan.utils.SpUtils;
import com.homecredit.loan.utils.StatusBar;
import com.homecredit.loan.widget.ScrollView;

public class UPerissionActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView tvPolicy;
    private TextView tvAgree;
    private CheckBox cb;
    private boolean isDown = false;
    private ScrollView webView;
    private ProgressBar pb;

    private String url = "file:///android_asset/tp.html";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatusBar.setWindowStatusBarBlackColor(this);
        setContentView(R.layout.activity_uperission);

        webView = this.findViewById(R.id.webview);
        pb = findViewById(R.id.pb);
        cb = findViewById(R.id.cb);
        tvPolicy = findViewById(R.id.tv_policy);

        tvAgree = findViewById(R.id.tv_agree);
        tvAgree.setOnClickListener(this);

        initData();
    }

    private void initData(){
        initUserPolicy();
        setWebView();
        webView.loadUrl(url);
        webView.setOnCustomScrollChangeListener(new ScrollView.ScrollInterface() {
            @Override
            public void onSChanged(int l, int t, int oldl, int oldt) {
                //WebView  
                float webViewContentHeight = webView.getContentHeight() * webView.getScale();
                //WebView
                float webViewCurrentHeight = (webView.getHeight() + webView.getScrollY());
                if ((webViewContentHeight - webViewCurrentHeight) < 50) {  // == 0 ()   
                    isDown = true;
                    if(!cb.isChecked()){
                        cb.setChecked(true);
                    }
                }
            }
        });
    }

    @Override
    public void onClick(View v) {
        if(FastClickHelper.isOnDoubleClick()){
            return;
        }
        if(v == tvAgree){
            if(!isDown || !cb.isChecked()){
                AToast.shortToast(this,getString(R.string.permission_hint));
                return;
            }
            sendToFlutter(21);
            SpUtils.getInstance().putBoolean(ConfigValues.USER_POLICY, true);
            this.finish();
        }
    }

    private void initUserPolicy() {
        String str = getString(R.string.wkg_tcpp2);

        SpannableStringBuilder ssb = new SpannableStringBuilder();
        ssb.append(str);
        ssb.setSpan(new ClickableSpan() {
            @Override
            public void onClick(View widget) {
                if(FastClickHelper.isOnDoubleClick()){
                    return;
                }
                Intent intent = new Intent(UPerissionActivity.this, WebActivity.class);
                intent.putExtra("url", ConfigValues.term_url);
                startActivity(intent);
            }

            @Override
            public void updateDrawState(TextPaint ds) {
                super.updateDrawState(ds);
                ds.setColor(Color.parseColor("#007D7A"));
            }
        }, 12, 32, 0);
        ssb.setSpan(new ClickableSpan() {
            @Override
            public void onClick(View widget) {
                if(FastClickHelper.isOnDoubleClick()){
                    return;
                }
                Intent intent = new Intent(UPerissionActivity.this, WebActivity.class);
                intent.putExtra("url", ConfigValues.policy_url);
                startActivity(intent);
            }

            @Override
            public void updateDrawState(TextPaint ds) {
                super.updateDrawState(ds);
                ds.setColor(Color.parseColor("#007D7A"));
            }
        }, 37, 53, 0);

        tvPolicy.setMovementMethod(LinkMovementMethod.getInstance());
        tvPolicy.setText(ssb, TextView.BufferType.SPANNABLE);
        tvPolicy.setHighlightColor(ContextCompat.getColor(this, R.color.color_transparent));
    }

    private void setWebView() {

        WebSettings setting = webView.getSettings();
        /**Js**/
        setting.setJavaScriptEnabled(true);

        /**，**/
        //webview
        setting.setUseWideViewPort(true);
        // 
        setting.setLoadWithOverviewMode(true);

        /****/
        // ，
        setting.setBuiltInZoomControls(true);
        setting.setSupportZoom(true);
        // ，
        setting.setDisplayZoomControls(false);
        // 
        setting.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);

        /**JS**/
        setting.setJavaScriptCanOpenWindowsAutomatically(true);
        setting.setDomStorageEnabled(true);

        /**webview**/
        setting.setCacheMode(WebSettings.LOAD_NO_CACHE);
        /** **/
        setting.setAllowFileAccess(true);
        setting.setAllowFileAccessFromFileURLs(true);
        setting.setAllowUniversalAccessFromFileURLs(true);
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);

            }
        });
        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                super.onProgressChanged(view, newProgress);
                if (newProgress == 100) {
                    pb.setVisibility(View.GONE);
                } else {
                    pb.setVisibility(View.VISIBLE);
                    pb.setProgress(newProgress);
                }
            }

            @Override
            public void onReceivedTitle(WebView view, String title) {
                super.onReceivedTitle(view, title);
            }

        });
    }

    @Override
    public void onBackPressed() {

    }

    private void sendToFlutter(int type){
        if(MainActivity.methodChannel_flutter != null){
            MainActivity.methodChannel_flutter.invokeMethod("plog",type);
        }
    }
}