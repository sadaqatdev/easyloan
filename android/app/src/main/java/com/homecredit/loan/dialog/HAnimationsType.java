package com.homecredit.loan.dialog;

import static java.lang.annotation.RetentionPolicy.SOURCE;

import androidx.annotation.StringDef;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

public interface HAnimationsType {

    String DEFAULT = "default";
    String LEFT = "left";
    String RIGHT = "right";
    String TOP = "top";
    String BOTTOM = "bottom";
    String SCALE = "scale";

    @StringDef({DEFAULT, LEFT, RIGHT, TOP, BOTTOM, SCALE})
    @Retention(SOURCE)
    @Target({ElementType.PARAMETER})
    @interface AAnimationsType{}
}
