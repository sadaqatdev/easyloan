package com.homecredit.loan.camera;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.media.ExifInterface;
import android.os.Build;
import android.os.Environment;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.View;
import androidx.camera.core.AspectRatio;
import androidx.camera.core.CameraInfoUnavailableException;
import androidx.camera.core.CameraSelector;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.core.content.ContextCompat;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CameraUtils {

    private CameraUtils() {
        throw new AssertionError();
    }

    public final static String CameraType = "CameraType";

    private static DisplayMetrics getDisplayMetrics(Context mContext) {
        return mContext.getResources().getDisplayMetrics();
    }

    public static int getScreenwidth(Context mContext) {
        return getDisplayMetrics(mContext).widthPixels;
    }

    public static int getScreenHeight(Context mContext) {
        return getDisplayMetrics(mContext).heightPixels;
    }

    public static boolean hasBackCamera(ProcessCameraProvider cameraProvider) {
        try {
            return cameraProvider == null ? false : cameraProvider.hasCamera(CameraSelector.DEFAULT_BACK_CAMERA);
        } catch (CameraInfoUnavailableException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean hasFrontCamera(ProcessCameraProvider cameraProvider) {
        try {
            return cameraProvider == null ? false : cameraProvider.hasCamera(CameraSelector.DEFAULT_FRONT_CAMERA);
        } catch (CameraInfoUnavailableException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int aspectRatio(Context mContext) {
        int width = getScreenwidth(mContext);
        int height = getScreenHeight(mContext);
        double previewRatio = Math.max(width, height) * 1.0 / Math.min(width, height);
        if (Math.abs(previewRatio - CamaraParcelable.CamaraConstante.RATIO_4_3_VALUE) <= Math.abs(previewRatio - CamaraParcelable.CamaraConstante.RATIO_16_9_VALUE)) {
            return AspectRatio.RATIO_4_3;
        }
        return AspectRatio.RATIO_16_9;
    }

    public static String getPicturePath() {
//        return new File(mContext.getExternalFilesDir("images"), ".jpg");
        String cameraPath = Environment.getExternalStorageDirectory().getPath() + File.separator + "DCIM" + File.separator + "Camera";
        File cameraFolder = new File(cameraPath);
        if (!cameraFolder.exists()) {
            cameraFolder.mkdirs();
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        return cameraFolder.getAbsolutePath() + File.separator + "IMG_" + simpleDateFormat.format(new Date()) + ".jpg";
    }

    private static Matrix pictureDegree(String imgPath, boolean front) {
        Matrix matrix = new Matrix();
        ExifInterface exif = null;
        try {
            exif = new ExifInterface(imgPath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (exif == null) {
            return matrix;
        }
        int degree = 0;
        int orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, -1);
        switch (orientation) {
            case ExifInterface.ORIENTATION_ROTATE_90:
                degree = 90;
                break;
            case ExifInterface.ORIENTATION_ROTATE_180:
                degree = 180;
                break;
            case ExifInterface.ORIENTATION_ROTATE_270:
                degree = 270;
                break;
            default:
                break;
        }
        matrix.postRotate(degree);
        if (front) {
            matrix.postScale(-1, 1);
        }
        return matrix;
    }

    public static Bitmap bitmapClip(Context mContext, String imgPath, boolean front) {
        Bitmap bitmap = BitmapFactory.decodeFile(imgPath);
        Matrix matrix = pictureDegree(imgPath, front);
        double bitmapRatio = bitmap.getHeight() * 1. / bitmap.getWidth();//16/9
        int width = getScreenwidth(mContext);
        int height = getScreenHeight(mContext);
        double screenRatio = height * 1. / width;//
        if (bitmapRatio > screenRatio) {//
            int clipHeight = (int) (bitmap.getWidth() * screenRatio);
            bitmap = Bitmap.createBitmap(bitmap, 0, (bitmap.getHeight() - clipHeight) >> 1, bitmap.getWidth(), clipHeight, matrix, true);
        } else {//
            bitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        }
        return bitmap;
    }

    public static boolean saveBitmap(Context mContext, String originPath, String savePath, Rect rect, boolean front) {
        Matrix matrix = pictureDegree(originPath, front);
        Bitmap clipBitmap = BitmapFactory.decodeFile(originPath);
        clipBitmap = Bitmap.createBitmap(clipBitmap, 0, 0, clipBitmap.getWidth(), clipBitmap.getHeight(), matrix, true);
        if (rect != null) {
            double bitmapRatio = clipBitmap.getHeight() * 1. / clipBitmap.getWidth();//16/9
            int width = getScreenwidth(mContext);
            int height = getScreenHeight(mContext);
            double screenRatio = height * 1. / width;
            if (bitmapRatio > screenRatio) {//
                int clipHeight = (int) (clipBitmap.getWidth() * screenRatio);
                clipBitmap = Bitmap.createBitmap(clipBitmap, 0, (clipBitmap.getHeight() - clipHeight) >> 1, clipBitmap.getWidth(), clipHeight, null, true);
                scalRect(rect, clipBitmap.getWidth() * 1. / getScreenwidth(mContext));
            } else {
                int marginTop = (int) ((height - width * bitmapRatio) / 2);
                rect.top = rect.top - marginTop;
                scalRect(rect, clipBitmap.getWidth() * 1. / getScreenwidth(mContext));
            }
            clipBitmap = Bitmap.createBitmap(clipBitmap, rect.left, rect.top, rect.right, rect.bottom, null, true);
        }
        return saveBitmap(clipBitmap, savePath);
    }

    private static boolean saveBitmap(Bitmap bitmap, String savePath) {
        try {
            File file = new File(savePath);
            File parent = file.getParentFile();
            if (!parent.exists()) {
                parent.mkdirs();
            }
            FileOutputStream fos = new FileOutputStream(file);
            boolean b = bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos);
            fos.flush();
            fos.close();
            return b;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    private static void scalRect(Rect rect, double scale) {
        rect.left = (int) (rect.left * scale);
        rect.top = (int) (rect.top * scale);
        rect.right = (int) (rect.right * scale);
        rect.bottom = (int) (rect.bottom * scale);
    }

    public static int dp2px(Context mContext, float dipValue) {
        return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dipValue, getDisplayMetrics(mContext));
    }


    public static void deletTempFile(String tempPath) {
        File file = new File(tempPath);
        file.delete();
    }

    public static int[] getViewLocal(View view) {
        int[] outLocation = new int[2];
        view.getLocationInWindow(outLocation);
        return outLocation;
    }

    public static boolean checkPermission(Context context) {
        String[] permissions = cameraPermission();
        for (int i = 0; i < permissions.length; i++) {
            if (!isGranted(context, permissions[i])) {
                return false;
            }
        }
        return true;
    }

    private static String[] cameraPermission() {
        return new String[]{
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.CAMERA
        };
    }
    private static boolean isGranted(Context context, String permission) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true;
        }
        return ContextCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED;
    }
}
