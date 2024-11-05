package com.homecredit.loan;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.homecredit.loan.utils.AToast;
import com.homecredit.loan.utils.StatusBar;

public class WebActivity extends AppCompatActivity {

    private ProgressBar pb;
    private ImageView imgBack;
    private TextView tbTvTitile;
    private WebView webView;
    private CountDownTimer mCountDownTimer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatusBar.setWindowStatusBarBlackColor(this);
        setContentView(R.layout.activity_web);
        String url = getIntent().getStringExtra("url");
        init();
        if (!TextUtils.isEmpty(url)) {
            webView.loadUrl(url);
            if(url.contains("easyloanPrivacy.html") || url.contains("easyloanterms.html")){
                startCountDownTimer();
            }
        }
    }

    private void init() {
        webView = this.findViewById(R.id.webView);
        imgBack = findViewById(R.id.img_back);
        imgBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                WebActivity.this.finish();
            }
        });
        tbTvTitile = findViewById(R.id.tb_tv_titile);
        pb = findViewById(R.id.pb);
        setWebView();
    }

    private void setWebView(){

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
        webView.setWebViewClient(new WebViewClient(){
            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
                if (url != null) {
                    if (url.contains("/static/MPsuccess.html")) {
                        setResult(RESULT_OK);
                        finish();
                    }
                }
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                Log.e("WebActivity","onPageFinished");
                cancelCountDownTimer();
            }
        });
        webView.setWebChromeClient(new WebChromeClient(){
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                super.onProgressChanged(view,newProgress);
                if(newProgress > 70){
                    pb.setVisibility(View.GONE);//
                }
                else{
                    pb.setVisibility(View.VISIBLE);//
                    pb.setProgress(newProgress);//
                }
            }

            @Override
            public void onReceivedTitle(WebView view, String title) {
                super.onReceivedTitle(view, title);
                if (tbTvTitile != null && !TextUtils.isEmpty(title)) {
                    if (title.length() > 22) {
                        title = title.substring(0, 22).concat("...");
                    }
                }
                tbTvTitile.setText(title);
            }
        });
    }

    private void startCountDownTimer(){
        try {
            mCountDownTimer = new CountDownTimer(10 * 1000, 1000) {
                @Override
                public void onTick(long millisUntilFinished) {

                }

                @Override
                public void onFinish() {
                    AToast.shortToast(WebActivity.this,getString(R.string.network_slow));
                    mCountDownTimer = null;
                }
            };
            mCountDownTimer.start();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private void cancelCountDownTimer(){
        try {
            if (mCountDownTimer != null) {
                mCountDownTimer.cancel();
                mCountDownTimer = null;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        cancelCountDownTimer();
    }

    @Override
    public void onBackPressed() {
        if(webView!= null && webView.canGoBack()){
            webView.goBack();
        }else {
            super.onBackPressed();
        }
    }
}