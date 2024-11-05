package com.homecredit.loan.utils;

import android.content.Context;
import android.graphics.Bitmap;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class BitmapUtil {

    public static File saveBitmap(Bitmap bitmap, String name, Context ct) {
        File file;
        String savePath = ct.getExternalFilesDir(null) + "/" + name + ".jpg";
        try {
            file = new File(savePath);
            if (!file.exists()) {
                file.getParentFile().mkdirs();
                file.createNewFile();
            }
            FileOutputStream fos = new FileOutputStream(file);
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos);
            fos.flush();
            fos.close();
        } catch (IOException e) {
            return null;
        }
        return file;
    }

}
