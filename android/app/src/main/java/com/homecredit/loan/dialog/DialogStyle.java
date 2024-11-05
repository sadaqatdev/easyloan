package com.homecredit.loan.dialog;

import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;

public class DialogStyle {

    public int color; //
    public float left_top_radius; //
    public float right_top_radius; //
    public float right_bottom_radius; //
    public float left_bottom_radius; //

    //
    public GradientDrawable.Orientation gradientsOrientation = GradientDrawable.Orientation.TOP_BOTTOM;
    public int[] gradientsColors; //

    public GradientDrawable getRoundRectDrawable(){
        //1. 
        float[] radiuss = new float[]{ //、、、
                left_top_radius, left_top_radius,
                right_top_radius, right_top_radius,
                right_bottom_radius, right_bottom_radius,
                left_bottom_radius, left_bottom_radius};;
        //2.
        GradientDrawable drawable;
        if(gradientsColors==null){
            drawable = new GradientDrawable();
            drawable.setColor(color!=0 ? color : Color.TRANSPARENT);
        }else{
            drawable = new GradientDrawable(gradientsOrientation, gradientsColors);
        }
        drawable.setCornerRadii(radiuss);
        return drawable;
    }
}
