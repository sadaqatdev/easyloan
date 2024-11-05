import 'package:flutter/services.dart';

class FlutterPlugin {
  static const channel = const MethodChannel("android");

  static Future<bool> showConfirmDialog(int flag) async {
    bool isConfirm = await channel.invokeMethod('showConfirmDialog', flag);
    return isConfirm;
  }

  static Future<bool> showDialog(Map<String, String> map) async {
    bool isConfirm = await channel.invokeMethod('showDialog', map);
    return isConfirm;
  }

  static Future<String> getJson() async {
    String json = await channel.invokeMethod('getJson');
    return json;
  }

  static Future<String> getLocation() async {
    String value = await channel.invokeMethod('getLocation');
    return value;
  }

  static Future<Map<dynamic, dynamic>> getGaid() async {
    Map<dynamic, dynamic> map = await channel.invokeMethod('getGaid');
    return map;
  }

  static otherLog(String eventName) async {
    channel.invokeMethod('logEvent', eventName);
  }

  static startLocation() async {
    channel.invokeMethod('startLocation');
  }

  static addCalendarEvent(Map<String, String> map) async {
    channel.invokeMethod('addCalendarEvent',map);
  }

  static Future<bool> startPermission() async{
    bool flag = await channel.invokeMethod('startPermission');
    return flag;
  }

  static Future<bool> startUPermission() async{
    bool flag = await channel.invokeMethod('startUPermission');
    return flag;
  }

  static Future<bool> startGuide() async{
    bool flag = await channel.invokeMethod('startGuide');
    return flag;
  }

  static Future<String> getUniqueID() async {
    String uuid = await channel.invokeMethod('getUniqueID');
    return uuid;
  }

  static Future<bool> openWebview(String url) async {
    bool flag = await channel.invokeMethod('openWebview',url);
    return flag;
  }

  static Future<bool> getShowGuide() async {
    bool flag = await channel.invokeMethod('getShowGuide');
    return flag;
  }

  static Future<bool> getShowPermission() async {
    bool flag = await channel.invokeMethod('getShowPermission');
    return flag;
  }

  static Future<bool> getShowUPermission() async {
    bool flag = await channel.invokeMethod('getShowUPermission');
    return flag;
  }

  static Future<bool> checkNetwork() async {
    bool flag = await channel.invokeMethod('checkNetwork');
    return flag;
  }

  static getAppInstanceId() async {
    channel.invokeMethod('getAppInstanceId');
  }

  static Future<String> getAppInstanceIdValue() async {
    String appInstanceId = await channel.invokeMethod('getAppInstanceIdValue');
    return appInstanceId;
  }

  static branchAndFirebaseEvent(String eventName) async {
    channel.invokeMethod('branchAndFirebaseEvent', eventName);
  }

  static facebookEvent(String eventName) async {
    channel.invokeMethod('facebookEvent', eventName);
  }

  static Future<Map<dynamic, dynamic>> openContact() async {
    Map<dynamic, dynamic> map = await channel.invokeMethod('openContact');
    return map;
  }

  static Future<bool> checkPhonePermission() async {
    bool flag = await channel.invokeMethod('checkPhonePermission');
    return flag;
  }

  static Future<bool> checkReadCallPermission() async {
    bool flag = await channel.invokeMethod('checkReadCallPermission');
    return flag;
  }

  static openCrisp() async {
    channel.invokeMethod('openCrisp');
  }

  static setCrispLogin(String phone) async {
    channel.invokeMethod('setCrispLogin', phone);
  }

  static setSessionSegment(String name) async {
    channel.invokeMethod('setSessionSegment', name);
  }

  static setUserEmail(String email) async {
    channel.invokeMethod('setUserEmail', email);
  }

  static Future<String> startCamera(int type) async{
    String filePath = await channel.invokeMethod('startCamera',type);
    return filePath;
  }

  static showToast(String content) async {
    channel.invokeMethod('showToast', content);
  }

  static Future<String> getImei() async {
    String imei = await channel.invokeMethod('getImei');
    return imei;
  }

  static openReview() async {
    channel.invokeMethod('openReview');
  }

  static Future<bool> checkReadMediaImages() async {
    bool flag = await channel.invokeMethod('checkReadMediaImages');
    return flag;
  }

  static Future<bool> checkTIRAMISU() async {
    bool flag = await channel.invokeMethod('checkTIRAMISU');
    return flag;
  }

  static Future<bool> checkWriteStroagePermission() async {
    bool flag = await channel.invokeMethod('checkWriteStroagePermission');
    return flag;
  }

  static Future<bool> checkCameraPermission() async {
    bool flag = await channel.invokeMethod('checkCameraPermission');
    return flag;
  }

  static Future<bool> checkPermission(String permission) async {
    bool flag = await channel.invokeMethod('checkPermission');
    return flag;
  }

  static Future<bool> requestReadMediaImages() async {
    bool flag = await channel.invokeMethod('requestReadMediaImages');
    return flag;
  }

  static Future<Map<dynamic, dynamic>> requestAllPermission() async {
    Map<dynamic, dynamic> map = await channel.invokeMethod('requestAllPermission');
    return map;
  }

  static openAppSettings() async {
    channel.invokeMethod('openAppSettings');
  }

  static Future<String> getSmsCode() async {
    String code = await channel.invokeMethod('getSmsCode');
    return code;
  }

  static speakText(Map<String, String> map) async {
    channel.invokeMethod('speakText', map);
  }

  static stopSpeak() async {
    channel.invokeMethod('stopSpeak');
  }

  static initTextToSpeech() async {
    channel.invokeMethod('initTextToSpeech');
  }
}
