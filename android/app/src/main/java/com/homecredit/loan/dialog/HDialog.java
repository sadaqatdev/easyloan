package com.homecredit.loan.dialog;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.os.Build;
import android.os.Bundle;
import android.util.SparseArray;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.animation.AlphaAnimation;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.ColorInt;
import androidx.annotation.ColorRes;
import androidx.annotation.DrawableRes;
import androidx.annotation.IdRes;
import androidx.annotation.NonNull;
import androidx.annotation.Size;
import androidx.annotation.StringRes;
import androidx.appcompat.app.AppCompatDialog;

import com.homecredit.loan.R;

import java.util.ArrayList;
import java.util.List;

public class HDialog extends AppCompatDialog {

    protected Context context;
    protected SparseArray<View> views = new SparseArray<>();
    protected List<Integer> cancelIds = new ArrayList<>();
    protected HDialogRoot controlView;
    protected int layoutId = 0;
    protected int width = 0;
    protected int height = 0;

    protected DialogStyle bgBean = new DialogStyle(); //

    private HDialog(@NonNull Context context) {
        this(context, R.layout.dialog_confirm);
    }

    private HDialog(@NonNull Context context, int layoutId) {
        this(context, layoutId, R.style.HDialog);
    }

    private HDialog(@NonNull Context context, int layoutId, int themeResId) {
        super(context, themeResId);
        this.context = context;
        this.layoutId = layoutId;
    }

    /**
     * 
     * @param context
     * @return
     */
    public static HDialog newInstance(@NonNull Context context){
        return new HDialog(context).with();
    }
    public static HDialog newInstance(@NonNull Context context, int layoutId){
        return new HDialog(context, layoutId).with();
    }
    public static HDialog newInstance(@NonNull Context context, int layoutId, int themeResId){
        return new HDialog(context, layoutId, themeResId).with();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        controlView = new HDialogRoot(context);
        View view = LayoutInflater.from(context).inflate(layoutId, null);
        controlView.addView(view);
        setContentView(controlView);
        init();
    }

    protected void init() {
        setCanceledOnTouchOutside(true);
        getWindow().setBackgroundDrawable(getRoundRectDrawable(dp2px(context, 0), Color.TRANSPARENT));

        width = (int)(ScreenUtils.getWidthPixels(context)*0.8);
        height = WindowManager.LayoutParams.WRAP_CONTENT;
        setWidthHeight();
        getWindow().setWindowAnimations(R.style.hc_dialog_default);
//        getWindow().setWindowAnimations(R.style.dialog_translate);
    }

    protected HDialog with(){
        show();
        dismiss();
        return this;
    }

//    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    /**
     * 
     * @param style
     * @return
     */
    public HDialog setAnimationsStyle(int style){
        getWindow().setWindowAnimations(style);
        return this;
    }

    /**
     * 
     * @param styleType 
     * @return
     */
    public HDialog setAnimations(@HAnimationsType.AAnimationsType String styleType){
        int style = -1;
        switch (styleType){
            case HAnimationsType.DEFAULT: //
                style = R.style.hc_dialog_default;
                break;
            case HAnimationsType.SCALE:
                style = R.style.hc_dialog_scale;
                break;
            case HAnimationsType.LEFT:
                style = R.style.hc_dialog_translate_left;
                break;
            case HAnimationsType.TOP:
                style = R.style.hc_dialog_translate_top;
                break;
            case HAnimationsType.RIGHT:
                style = R.style.hc_dialog_translate_right;
                break;
            case HAnimationsType.BOTTOM:
                style = R.style.hc_dialog_translate_bottom;
                break;
        }
        if(style!=-1){
            setAnimationsStyle(style);
        }
        return this;
    }

//    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    /**
     * 
     * @param gravity
     * @param offX
     * @param offY
     */
    public HDialog setGravity(int gravity, int offX, int offY){
        setGravity(gravity);
        WindowManager.LayoutParams layoutParams = getWindow().getAttributes();
        layoutParams.x = offX;
        layoutParams.y = offY;
        getWindow().setAttributes(layoutParams);
        return this;
    }
    public HDialog setGravity(int gravity){
        getWindow().setGravity(gravity);
        return this;
    }


    /**
     * 
     * @param value 0-1f
     * @return
     */
    public HDialog setMaskValue(float value){
        getWindow().setDimAmount(value);
        return this;
    }

//    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    /**
     * 
     * @return
     */
    protected HDialog refreshBg(){
//        getWindow().setBackgroundDrawable(getRoundRectDrawable(bgRadius, bgColor));
        controlView.setBackground(bgBean.getRoundRectDrawable());
        controlView.setBgRadius(
                bgBean.left_top_radius,
                bgBean.right_top_radius,
                bgBean.right_bottom_radius,
                bgBean.left_bottom_radius);
        return this;
    }

    /**
     * 
     * @return
     */
    public HDialog setBgColor(@ColorInt int color){
        bgBean.color = color;
        return refreshBg();
    }
    public HDialog setBgColor(@Size(min=1) String colorString){
        bgBean.color = Color.parseColor(colorString);
        return refreshBg();
    }

    /**
     * 
     * @param orientation
     * @param colors
     * @return
     */
    public HDialog setBgColor(GradientDrawable.Orientation orientation, @ColorInt int... colors){
        bgBean.gradientsOrientation = orientation;
        bgBean.gradientsColors = colors;
        return refreshBg();
    }
    public HDialog setBgColor(GradientDrawable.Orientation orientation, @Size(min=1) String... colorStrings){
        bgBean.gradientsOrientation = orientation;
        if(colorStrings==null){
            return this;
        }
        bgBean.gradientsColors = new int[colorStrings.length];
        for (int i = 0; i < bgBean.gradientsColors.length; i++) {
            bgBean.gradientsColors[i] = Color.parseColor(colorStrings[i]);
        }
        return refreshBg();
    }

    public HDialog setBgColorRes(@ColorRes int colorRes){
        bgBean.color = context.getResources().getColor(colorRes);
        return refreshBg();
    }
    public HDialog setBgColorRes(GradientDrawable.Orientation orientation, @Size(min=1) String... colorRes){
        bgBean.gradientsOrientation = orientation;
        bgBean.gradientsColors = new int[colorRes.length];
        for (int i = 0; i < colorRes.length; i++) {
            bgBean.gradientsColors[i] = Color.parseColor(colorRes[i]);
        }
        return refreshBg();
    }
    public HDialog setBgColorRes(GradientDrawable.Orientation orientation, @ColorRes int... colorRes){
        bgBean.gradientsOrientation = orientation;
        bgBean.gradientsColors = new int[colorRes.length];
        for (int i = 0; i < colorRes.length; i++) {
            bgBean.gradientsColors[i] = getColor(colorRes[i]);
        }
        return refreshBg();
    }

    /**
     *  
     * @param bgRadius
     */
    public HDialog setBgRadius(float bgRadius){
        setBgRadius(bgRadius, bgRadius, bgRadius, bgRadius);
        return refreshBg();
    }
    public HDialog setBgRadius(float left_top_radius, float right_top_radius, float right_bottom_radius, float left_bottom_radius){
        bgBean.left_top_radius = dp2px(context, left_top_radius);
        bgBean.right_top_radius = dp2px(context, right_top_radius);
        bgBean.right_bottom_radius = dp2px(context, right_bottom_radius);
        bgBean.left_bottom_radius = dp2px(context, left_bottom_radius);
        return refreshBg();
    }

    /**
     *  
     * @param bgRadius
     */
    public HDialog setBgRadiusPX(int bgRadius){
        setBgRadiusPX(bgRadius, bgRadius, bgRadius, bgRadius);
        return refreshBg();
    }
    public HDialog setBgRadiusPX(float left_top_radius, float right_top_radius, float right_bottom_radius, float left_bottom_radius){
        bgBean.left_top_radius = left_top_radius;
        bgBean.right_top_radius = right_top_radius;
        bgBean.right_bottom_radius = right_bottom_radius;
        bgBean.left_bottom_radius = left_bottom_radius;
        return refreshBg();
    }



//    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    /**
     * ()
     */
    private HDialog setWidthHeight(){
//        Window dialogWindow = getWindow();
//        WindowManager.LayoutParams lp = dialogWindow.getAttributes();
//        lp.width = width;
//        lp.height = height;
//        dialogWindow.setAttributes(lp);
        ViewGroup.LayoutParams layoutParams = controlView.getLayoutParams();
        layoutParams.width = width;
        layoutParams.height = height;
        controlView.setLayoutParams(layoutParams);
        return this;
    }

    /**
     * 
     * @param width
     * @return
     */
    public HDialog setWidth(int width){
        this.width = dp2px(context, width);
        return setWidthHeight();
    }

    public HDialog setWidthPX(int width){
        this.width = width;
        return setWidthHeight();
    }

    /**
     * 
     * @param width
     * @return
     */
    public HDialog setMaxWidth(int width){
        setMaxWidthPX(dp2px(context, width));
        return this;
    }
    public HDialog setMaxWidthPX(int width){
        controlView.setMaxWidth(width);
        return this;
    }

    /**
     * 
     * @param width
     * @return
     */
    public HDialog setMinWidth(int width){
        setMinWidthPX(dp2px(context, width));
        return this;
    }
    public HDialog setMinWidthPX(int width){
        controlView.setMinimumWidth(width);
        return this;
    }



    /**
     * 
     * @param height
     * @return
     */
    public HDialog setHeight(int height){
        this.height = dp2px(context, height);
        return setWidthHeight();
    }
    public HDialog setHeightPX(int height){
        this.height = height;
        return setWidthHeight();
    }

    /**
     * 
     * @param height
     * @return
     */
    public HDialog setMaxHeight(int height){
        setMaxHeightPX(dp2px(context, height));
        return this;
    }
    public HDialog setMaxHeightPX(int height){
        controlView.setMaxHeight(height);
        return this;
    }

    /**
     * 
     * @param height
     * @return
     */
    public HDialog setMinHeight(int height){
        setMinHeightPX(dp2px(context, height));
        return this;
    }
    public HDialog setMinHeightPX(int height){
        controlView.setMinimumHeight(height);
        return this;
    }


    /**
     * 
     * @param widthRatio
     */
    public HDialog setWidthRatio(double widthRatio){
        width = (int)(ScreenUtils.getWidthPixels(context)*widthRatio);
        setWidthHeight();
        return this;
    }
    public HDialog setMaxWidthRatio(double widthRatio){
        return setMaxWidthPX((int)(ScreenUtils.getWidthPixels(context)*widthRatio));
    }
    public HDialog setMinWidthRatio(double widthRatio){
        return setMinWidthPX((int)(ScreenUtils.getWidthPixels(context)*widthRatio));
    }

    /**
     * 
     * @param heightRatio
     */
    public HDialog setHeightRatio(double heightRatio){
        height = (int)(ScreenUtils.getHeightPixels(context)*heightRatio);
        setWidthHeight();
        return this;
    }
    public HDialog setMaxHeightRatio(double heightRatio){
        return setMaxHeightPX((int)(ScreenUtils.getWidthPixels(context)*heightRatio));
    }
    public HDialog setMinHeightRatio(double heightRatio){
        return setMinHeightPX((int)(ScreenUtils.getWidthPixels(context)*heightRatio));
    }

//    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    /**
     * 
     * @param onClickListener
     * @param viewIds
     */
    public HDialog setOnClickListener(final DialogOnClickListener onClickListener, int... viewIds){
        final HDialog lDialog = this;
        for (int i = 0; i < viewIds.length; i++) {
            if(cancelIds.contains(viewIds[i])){
                getView(viewIds[i]).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickListener.onClick(v, lDialog);
                        lDialog.dismiss();
                    }
                });
            }else{
                getView(viewIds[i]).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickListener.onClick(v, lDialog);
                    }
                });
            }

        }
        return this;
    }

    /**
     *  dialog
     * @param viewIds
     * @return
     */
    public HDialog setCancelBtn(int... viewIds){
        for (int i = 0; i < viewIds.length; i++) {
            if(cancelIds.contains(viewIds[i])){
               continue;
            }
            cancelIds.add(viewIds[i]);
            getView(viewIds[i]).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    dismiss();
                }
            });
        }
        return this;
    }

    //    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    @SuppressWarnings("unchecked")
    public <T extends View> T getView(@IdRes int viewId) {
        View view = views.get(viewId);
        if (view == null) {
            view = findViewById(viewId);
            views.put(viewId, view);
        }
        return (T) view;
    }

    /**
     * Will set the text of a TextView.
     *
     * @param viewId The view id.
     * @param value  The text to put in the text view.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setText(@IdRes int viewId, CharSequence value) {
        TextView view = getView(viewId);
        view.setText(value);
        return this;
    }

    public HDialog setText(@IdRes int viewId, @StringRes int strId) {
        TextView view = getView(viewId);
        view.setText(strId);
        return this;
    }

    /**
     * 
     * @param viewId
     * @param size (：SP)
     * @return
     */
    public HDialog setTextSize(@IdRes int viewId, float size) {
        setTextSizePX(viewId, sp2px(context, size));
        return this;
    }
    public HDialog setTextSizePX(@IdRes int viewId, float size) {
        TextView view = getView(viewId);
        view.setTextSize(sp2px(context, size));
        return this;
    }

    /**
     * Will set the image of an ImageView from a resource id.
     *
     * @param viewId     The view id.
     * @param imageResId The image resource id.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setImageResource(@IdRes int viewId, @DrawableRes int imageResId) {
        ImageView view = getView(viewId);
        view.setImageResource(imageResId);
        return this;
    }

    /**
     * Will set background color of a view.
     *
     * @param viewId The view id.
     * @param color  A color, not a resource id.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setBackgroundColor(@IdRes int viewId, @ColorInt int color) {
        View view = getView(viewId);
        view.setBackgroundColor(color);
        return this;
    }

    /**
     * Will set background of a view.
     *
     * @param viewId        The view id.
     * @param backgroundRes A resource to use as a background.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setBackgroundRes(@IdRes int viewId, @DrawableRes int backgroundRes) {
        View view = getView(viewId);
        view.setBackgroundResource(backgroundRes);
        return this;
    }

    /**
     * Will set text color of a TextView.
     *
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setTextColor(@IdRes int viewId, @ColorInt int textColor) {
        TextView view = getView(viewId);
        view.setTextColor(textColor);
        return this;
    }


    /**
     * Will set the image of an ImageView from a drawable.
     *
     * @param viewId   The view id.
     * @param drawable The image drawable.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setImageDrawable(@IdRes int viewId, Drawable drawable) {
        ImageView view = getView(viewId);
        view.setImageDrawable(drawable);
        return this;
    }

    /**
     * Add an action to set the image of an image view. Can be called multiple times.
     */
    public HDialog setImageBitmap(@IdRes int viewId, Bitmap bitmap) {
        ImageView view = getView(viewId);
        view.setImageBitmap(bitmap);
        return this;
    }

    /**
     * Add an action to set the alpha of a view. Can be called multiple times.
     * Alpha between 0-1.
     */
    public HDialog setAlpha(@IdRes int viewId, float value) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
            getView(viewId).setAlpha(value);
        } else {
            // Pre-honeycomb hack to set Alpha value
            AlphaAnimation alpha = new AlphaAnimation(value, value);
            alpha.setDuration(0);
            alpha.setFillAfter(true);
            getView(viewId).startAnimation(alpha);
        }
        return this;
    }

    /**
     * Set a view visibility to VISIBLE (true) or GONE (false).
     *
     * @param viewId  The view id.
     * @param visible True for VISIBLE, false for GONE.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setGone(@IdRes int viewId, boolean visible) {
        View view = getView(viewId);
        view.setVisibility(visible ? View.VISIBLE : View.GONE);
        return this;
    }

    /**
     * Set a view visibility to VISIBLE (true) or INVISIBLE (false).
     *
     * @param viewId  The view id.
     * @param visible True for VISIBLE, false for INVISIBLE.
     * @return The BaseViewHolder for chaining.
     */
    public HDialog setVisible(@IdRes int viewId, boolean visible) {
        View view = getView(viewId);
        view.setVisibility(visible ? View.VISIBLE : View.INVISIBLE);
        return this;
    }

    public static GradientDrawable getRoundRectDrawable(int radius, int color){
        //、、、
        float[] radiuss = {radius, radius, radius, radius, radius, radius, radius, radius};
        GradientDrawable drawable = new GradientDrawable();
        drawable.setCornerRadii(radiuss);
        drawable.setColor(color!=0 ? color : Color.TRANSPARENT);
        return drawable;
    }
//    public static GradientDrawable getRoundRectDrawable(int radius, int color){
//        //、、、
//        float[] radiuss = {radius, radius, radius, radius, radius, radius, radius, radius};
//        GradientDrawable drawable = new GradientDrawable();
//        drawable.setCornerRadii(radiuss);
//        drawable.setColor(color!=0 ? color : Color.TRANSPARENT);
//        return drawable;
//    }
//    public static GradientDrawable getRoundRectDrawable(int radius, int color, boolean isFill, int strokeWidth){
//        //、、、
//        float[] radiuss = {radius, radius, radius, radius, radius, radius, radius, radius};
//        GradientDrawable drawable = new GradientDrawable();
//        drawable.setCornerRadii(radiuss);
//        drawable.setColor(isFill ? color : Color.TRANSPARENT);
//        drawable.setStroke(isFill ? 0 : strokeWidth, color);
//        return drawable;
//    }

    public int getColor(int colorResId){
        return context.getResources().getColor(colorResId);
    }

    /** dppx */
    public static int dp2px(Context context, float dpVal){
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,dpVal, context.getResources().getDisplayMetrics());
    }
    /** sppx */
    public static int sp2px(Context context, float spVal){
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_SP,spVal, context.getResources().getDisplayMetrics());
    }

    public interface DialogOnClickListener{
        void onClick(View v, HDialog lDialog);
    }
}
