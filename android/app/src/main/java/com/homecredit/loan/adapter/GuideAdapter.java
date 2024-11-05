package com.homecredit.loan.adapter;

import android.view.View;
import android.view.ViewGroup;

import androidx.viewpager.widget.PagerAdapter;
import androidx.viewpager.widget.ViewPager;

import java.util.ArrayList;

public class GuideAdapter extends PagerAdapter {
    private ArrayList<View> views;

    //，
    public GuideAdapter(ArrayList<View> views) {
        this.views = views;
    }

    //  1- ，，ImageView
    @Override
    public int getCount() {
        return views.size();
    }


    // 2-  ，
    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == object;
    }

    // 3-  PagerAdapter，，，

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {

        ((ViewPager) container).removeView(views.get(position));
    }

    // 4- // ，，
    // ImageViewViewGroup，
    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        ((ViewPager) container).addView(views.get(position));
        return views.get(position);
    }
}
