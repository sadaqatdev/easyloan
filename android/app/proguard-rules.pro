
#
#-----------------------------------------------------------------------------------------
#
#
# ----------------------------- -----------------------------
#

#  0 - 7(，Android5，。)
-optimizationpasses 5
# ()
-dontusemixedcaseclassnames
# (librarypublic)
-dontskipnonpubliclibraryclasses
#
-dontskipnonpubliclibraryclassmembers
#，，
-dontoptimize
 # ,Android,。
-dontpreverify
#
-ignorewarnings
# ，
# ，
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
# Annotation
-keepattributes *Annotation*
# , JSON
-keepattributes Signature
#
-keepattributes SourceFile,LineNumberTable
 #，。
# ，getter，。
# java，。-repackageclasses。
#：，public ,apipublic
-allowaccessmodification
 # ()
 #
 # ->
-verbose

#
# -----------------------------  -----------------------------
#
#----------------------------------------------------
#
#activity,application,service,broadcastReceiver,contentprovider....
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.support.multidex.MultiDexApplication
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep class android.support.** {*;}## support

-keep public class com.google.vending.licensing.ILicensingService
-keep public class com.android.vending.licensing.ILicensingService
#，，Google。
#----------------------------------------------------

#
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**


#nativenative，
-keepclasseswithmembernames class * {
    native <methods>;
}


#layout onclickandroid:onclick="onClick"，
#ActivityView，，XMLandroid:onClick=”buttonClick”，
#ActivitybuttonClick(View view)，
-keepclassmembers class * extends android.app.Activity{
    public void *(android.view.View);
}

#values()valueOf()，，
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

#ViewsetXxx()getXxx()，
#settergetter，。
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

#ParcelableCREATOR，
#，CREATOR，，Parcelable。
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
# Serizalizable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
# R
#-keep class **.R$* {
# *;
#}
#static
-keepclassmembers class **.R$* {
    public static <fields>;
}

# onXXEvent、**On*Listener，
-keepclassmembers class * {
    void *(**On*Event);
    void *(**On*Listener);
}

# （View）
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

#
#----------------------------- WebView() -----------------------------
#
#webView
-keepclassmembers class fqcn.of.javascript.interface.for.Webview {
   public *;
}
-keepclassmembers class * extends android.webkit.WebViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.WebViewClient {
    public void *(android.webkit.WebView, jav.lang.String);
}
#appHTML5JavaScript
#js，：

#
#------------------------------------------------------------------
#--------(Model，)-----
#

#
# -----------------------------  -----------------------------
#
# Log
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

#
-dontnote junit.framework.**
-dontnote junit.runner.**
-dontwarn android.test.**
-dontwarn android.support.test.**
-dontwarn org.junit.**


#
# -----------------------------  -----------------------------
#
-keep class com.google.android.gms.** { *; }
-keep class com.huawei.hms.ads.** { *; }
-keep interface com.huawei.hms.ads.** { *; }

# Retrolambda
-dontwarn java.lang.invoke.*

-keep class com.luck.picture.lib.** { *; }
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }