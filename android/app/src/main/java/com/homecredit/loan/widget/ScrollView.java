package com.homecredit.loan.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.webkit.WebView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

public class ScrollView  extends WebView {

    public ScrollView(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public ScrollView(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public ScrollView(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
    }

    public ScrollView(Context context) {
        super(context);
    }
    //
    //l，old
    @Override
    protected void onScrollChanged(int l, int t, int oldl, int oldt) {
        super.onScrollChanged(l, t, oldl, oldt);
        mScrollInterface.onSChanged(l, t, oldl, oldt);
    }
    public ScrollInterface mScrollInterface;
    //
    public void setOnCustomScrollChangeListener(ScrollInterface scrollInterface) {
        this.mScrollInterface = scrollInterface;
    }
    public interface ScrollInterface {
        public void onSChanged(int l, int t, int oldl, int oldt);
    }
}