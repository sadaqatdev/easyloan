package com.homecredit.loan.camera;

import android.app.Activity;
import android.content.Intent;
import android.os.Parcel;
import android.os.Parcelable;

import java.io.File;

public class CamaraParcelable implements Parcelable {
    private boolean pcfront;
    private String picturePath;
    private String pictureTempPath;
    private boolean showMask;
    private boolean showSwitch;

    private String focusSuccessTips;
    private String focusFailTips;
    private Activity mActivity;

    private boolean showFocusTips;

    private int requestCode;
    private int maskImageId;

    private CamaraParcelable(Builder mBuilder) {
        pcfront = mBuilder.front;
        picturePath = mBuilder.picturePath;
        showMask = mBuilder.showMask;
        showSwitch = mBuilder.showSwitch;
        focusSuccessTips = mBuilder.focusSuccessTips;
        focusFailTips = mBuilder.focusFailTips;
        mActivity = mBuilder.mActivity;
        showFocusTips = mBuilder.showFocusTips;
        requestCode = mBuilder.requestCode;
        maskImageId = mBuilder.maskImageId;
        if (mActivity == null) {
            throw new NullPointerException("Activity param is null");
        }
    }

    protected CamaraParcelable(Parcel in) {
        pcfront = in.readByte() != 0;
        picturePath = in.readString();
        pictureTempPath = in.readString();
        showMask = in.readByte() != 0;
        showSwitch = in.readByte() != 0;
        focusSuccessTips = in.readString();
        focusFailTips = in.readString();
        showFocusTips = in.readByte() != 0;
        requestCode = in.readInt();
        maskImageId = in.readInt();
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeByte((byte) (pcfront ? 1 : 0));
        dest.writeString(picturePath);
        dest.writeString(pictureTempPath);
        dest.writeByte((byte) (showMask ? 1 : 0));
        dest.writeByte((byte) (showSwitch ? 1 : 0));
        dest.writeString(focusSuccessTips);
        dest.writeString(focusFailTips);
        dest.writeByte((byte) (showFocusTips ? 1 : 0));
        dest.writeInt(requestCode);
        dest.writeInt(maskImageId);
    }

    @Override
    public int describeContents() {
        return 0;
    }


    public static final Creator<CamaraParcelable> CREATOR = new Creator<CamaraParcelable>() {
        @Override
        public CamaraParcelable createFromParcel(Parcel in) {
            return new CamaraParcelable(in);
        }

        @Override
        public CamaraParcelable[] newArray(int size) {
            return new CamaraParcelable[size];
        }
    };

    private CamaraParcelable startActivity(int requestCode) {
        Intent intent = new Intent(mActivity, CameraXActivity.class);
        intent.putExtra(CamaraConstante.CAMERA_PARAM_KEY, this);
        mActivity.startActivityForResult(intent, requestCode);
        return this;
    }


    public boolean isPcfront() {
        return pcfront;
    }

    public String getPicturePath() {
        return picturePath;
    }

    public boolean isShowMask() {
        return showMask;
    }

    public boolean isShowSwitch() {
        return showSwitch;
    }


    public String getPictureTempPath() {
        File file = new File(getPicturePath());
        String pictureName = file.getName();
        String newName = null;
        if (pictureName.contains(".")) {
            int lastDotIndex = pictureName.lastIndexOf('.');
            newName = pictureName.substring(0, lastDotIndex) + "_temp" + pictureName.substring(lastDotIndex);
        }
        if (newName == null) {
            newName = pictureName;
        }
        return file.getParent() + File.separator + newName;
    }


    public boolean isShowFocusTips() {
        return showFocusTips;
    }

    public int getRequestCode() {
        return requestCode;
    }


    public static class Builder {
        private boolean front = false;
        private String picturePath = CameraUtils.getPicturePath();
        private boolean showMask = true;
        private boolean showSwitch = false;
        private String focusSuccessTips;
        private String focusFailTips;
        private Activity mActivity;
        private boolean showFocusTips = true;
        private int requestCode = CamaraConstante.REQUEST_CODE;

        private int maskImageId = 0;


        public Builder setMaskImageId(int maskImageId) {
            this.maskImageId = maskImageId;
            return this;
        }

        public Builder setFront(boolean front) {
            this.front = front;
            return this;
        }

        public Builder setPicturePath(String picturePath) {
            this.picturePath = picturePath;
            return this;
        }

        public Builder setShowMask(boolean showMask) {
            this.showMask = showMask;
            return this;
        }

        public Builder setShowSwitch(boolean showSwitch) {
            this.showSwitch = showSwitch;
            return this;
        }


        public Builder setFocusSuccessTips(String focusSuccessTips) {
            this.focusSuccessTips = focusSuccessTips;
            return this;
        }

        public Builder setFocusFailTips(String focusFailTips) {
            this.focusFailTips = focusFailTips;
            return this;
        }

        public Builder setActivity(Activity mActivity) {
            this.mActivity = mActivity;
            return this;
        }

        public Builder setShowFocusTips(boolean showFocusTips) {
            this.showFocusTips = showFocusTips;
            return this;
        }

        public Builder setRequestCode(int requestCode) {
            this.requestCode = requestCode;
            return this;
        }

        public CamaraParcelable build() {
            return new CamaraParcelable(this).startActivity(requestCode);
        }
    }

    public interface CamaraConstante {
        String CAMERA_PARAM_KEY = "camera_param_key";
        String PICTURE_PATH_KEY = "picture_path_key";

        double RATIO_4_3_VALUE = 4.0 / 3.0;
        double RATIO_16_9_VALUE = 16.0 / 9.0;

        int REQUEST_CODE = 0x1010;
    }

}
