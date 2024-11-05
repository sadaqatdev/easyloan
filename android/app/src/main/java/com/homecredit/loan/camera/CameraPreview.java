package com.homecredit.loan.camera;

import android.content.Context;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;

public class CameraPreview implements View.OnTouchListener{
    private GestureDetector mGestureDetector;
    private CustomTouchListener mCustomTouchListener;
    private ScaleGestureDetector mScaleGestureDetector;
    private Context context;

    public CameraPreview(Context context) {
        this.context = context;
        mGestureDetector = new GestureDetector(context, onGestureListener);
        mScaleGestureDetector = new ScaleGestureDetector(context, onScaleGestureListener);
    }

    public void setmCustomTouchListener(CustomTouchListener mCustomTouchListener) {
        this.mCustomTouchListener = mCustomTouchListener;
    }

    private ScaleGestureDetector.OnScaleGestureListener onScaleGestureListener = new ScaleGestureDetector.SimpleOnScaleGestureListener() {
        @Override
        public boolean onScale(ScaleGestureDetector detector) {
            float delta = detector.getScaleFactor();
            if (mCustomTouchListener != null) {
                mCustomTouchListener.zoom(delta);
            }
            return true;
        }
    };

    private GestureDetector.SimpleOnGestureListener onGestureListener = new GestureDetector.SimpleOnGestureListener() {
        @Override
        public void onLongPress(MotionEvent e) {
            if (mCustomTouchListener == null) {
                mCustomTouchListener.longPress(e.getX(), e.getY());
            }

        }

        @Override
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
            return true;
        }

        @Override
        public boolean onSingleTapConfirmed(MotionEvent e) {
            if (mCustomTouchListener != null) {
                mCustomTouchListener.click(e.getX(), e.getY());
            }
            return true;
        }

        @Override
        public boolean onDoubleTap(MotionEvent e) {
            if (mCustomTouchListener != null) {
                mCustomTouchListener.doubleClick(e.getX(), e.getY());
            }
            return true;
        }
    };



    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {
        mScaleGestureDetector.onTouchEvent(motionEvent);
        if (!mScaleGestureDetector.isInProgress()) {
            mGestureDetector.onTouchEvent(motionEvent);
        }
        return true;
    }


    public   interface CustomTouchListener {
        void zoom(Float delta);
        void click(Float x, Float y);
        void doubleClick(Float x, Float y);
        void longPress(Float x, Float y);
    }
}
