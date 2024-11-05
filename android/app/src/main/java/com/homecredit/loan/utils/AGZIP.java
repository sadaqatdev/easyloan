package com.homecredit.loan.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

public class AGZIP {
    /**
     * 
     *
     * @param str
     *            
     * @return 
     * @throws IOException
     */
    public static String compress(String str) throws IOException {
        if (null == str || str.length() <= 0) {
            return str;
        }
        // 
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        // 
        GZIPOutputStream gzip = new GZIPOutputStream(out);
        // 
        gzip.write(str.getBytes("utf-8")); // GBK，
        gzip.close();
        //  charsetName，
        return out.toString("ISO-8859-1");
    }
}
