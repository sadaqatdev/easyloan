package com.homecredit.loan.dialog;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Path;
import android.graphics.RectF;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

/**
 * @Description:
 * @Author: liys
 * @CreateDate: 2020/11/30 16:44
 * @UpdateUser: 
 * @UpdateDate: 2020/11/30 16:44
 * @UpdateRemark: 
 * @Version: 1.0
 */
public class HDialogRoot extends FrameLayout {

    private int width;  //
    private int height; //
    private int maxWidth;  //
    private int maxHeight; //

    private float left_top_radius; //
    private float right_top_radius; //
    private float right_bottom_radius; //
    private float left_bottom_radius; //

    private Path path = new Path(); //

    public HDialogRoot(@NonNull Context context) {
        this(context, null);
    }

    public HDialogRoot(@NonNull Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public HDialogRoot(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init(){

    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        if(width==w && height==h){
            return;
        }
        width = w;
        height = h;
        setBgRadius();
    }

    /**
     *  
     * @param bgRadius
     */
    public HDialogRoot setBgRadius(float bgRadius){
        return setBgRadius(bgRadius, bgRadius, bgRadius, bgRadius);
    }
    public HDialogRoot setBgRadius(float left_top_radius, float right_top_radius, float right_bottom_radius, float left_bottom_radius){
        this.left_top_radius = left_top_radius;
        this.right_top_radius = right_top_radius;
        this.right_bottom_radius = right_bottom_radius;
        this.left_bottom_radius = left_bottom_radius;
        setBgRadius();
        return this;
    }

    private HDialogRoot setBgRadius() {
        path.reset();
        path.addRoundRect(new RectF(0, 0, width, height), new float[]{
                        left_top_radius, left_top_radius,
                        right_top_radius, right_top_radius,
                        right_bottom_radius, right_bottom_radius,
                        left_bottom_radius, left_bottom_radius},
                Path.Direction.CW);
        invalidate();
        return this;
    }


    public void setMaxWidth(int maxWidth) {
        this.maxWidth = maxWidth;
        invalidate();
    }

    public void setMaxHeight(int maxHeight) {
        this.maxHeight = maxHeight;
        invalidate();
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(getWidthMeasureSpec(widthMeasureSpec), getHeightMeasureSpec(heightMeasureSpec));
    }

    //
    public int getWidthMeasureSpec(int widthMeasureSpec) {
        if (maxWidth > 0) {
            widthMeasureSpec = MeasureSpec.makeMeasureSpec(maxWidth, MeasureSpec.AT_MOST);
        }
        return widthMeasureSpec;
    }

    public int getHeightMeasureSpec(int heightMeasureSpec) {
        if (maxHeight > 0) {
            heightMeasureSpec = MeasureSpec.makeMeasureSpec(maxHeight, MeasureSpec.AT_MOST);
        }
        return heightMeasureSpec;
    }

//    // 
//    @Override
//    protected boolean drawChild(Canvas canvas, View child, long drawingTime) {
//        canvas.clipPath(path);
//        return super.drawChild(canvas, child, drawingTime);
//    }

    @Override
    public void draw(Canvas canvas) {
        canvas.clipPath(path);
        super.draw(canvas);
    }


    /** dppx */
    private int dp2px(float dpVal){
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,dpVal, getResources().getDisplayMetrics());
    }
}
