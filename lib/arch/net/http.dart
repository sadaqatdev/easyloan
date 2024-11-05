import 'dart:io';

import 'package:alog/alog.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/params.dart';
import 'package:homecredit/utils/aes.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/utils/md5.dart';
import 'package:homecredit/utils/sp.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/loading.dart';
import '../../utils/toast.dart';
import '../api/api.dart';
import 'code.dart';
import 'config.dart';
import 'result_data.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();

  Dio? _dio;

  factory HttpManager() => _instance;

  ///
  HttpManager._internal({String baseUrl = NetConfig.BASE_URL}) {
    if (null == _dio) {
      _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: NetConfig.TIME_OUT,
          receiveTimeout: NetConfig.TIME_OUT,
          sendTimeout: NetConfig.TIME_OUT,
          // headers: {"Access-Control-Allow-Origin": "*"},
          //
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // Fiddler
      // (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (client) {
      //   client.findProxy = (url) {
      //     return "PROXY 192.168.20.12:8888";
      //   };
      //
      //   //
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      // };

      //
      _dio?.interceptors
        ?..add(LogInterceptor(responseBody: true, requestBody: true)); //
    }
  }

  ///
  static HttpManager instance({String baseUrl = NetConfig.BASE_URL}) {
    var oldBaseUrl = _instance._dio?.options.baseUrl;

    if (oldBaseUrl != baseUrl) {
      //
      _instance._dio?.options.baseUrl = baseUrl;
    }
    return _instance;
  }

  ///
  get(api, {params, withLoading = true}) async {
    if (withLoading) LoadingUtil.show();

    try {
      Response response = await _dio!.get(api, queryParameters: params);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
      if (withLoading) LoadingUtil.hide();
    }
  }

  ///
  post(api, {params, withLoading = true, mul = false,subMap}) async {
    if (withLoading) LoadingUtil.show();

    try {
      Map<String, dynamic> headers = await CommonParams.addHeaders(api);

      if(subMap != null){
        String appSsid = subMap[Api.appssid];
        String curUserId = subMap[Api.curUserId];
        //
        headers[Api.client_id] = appSsid;
        headers[Api.currentUserId] = curUserId;
        //
        params[Api.appssid] = appSsid;
        params[Api.userId] = curUserId;
      }else {
        if (mul) {
          String appSsid = await SpUtil.getString(Api.appSsid);
          HLog.error("mul:${appSsid}");
          String curUserId = await SpUtil.getString(Api.curUserId);
          //
          headers[Api.client_id] = appSsid;
          headers[Api.currentUserId] = curUserId;
          //
          params[Api.appssid] = appSsid;
          params[Api.userId] = curUserId;
        }
      }

      //
      String str = await CommonParams.someBoothLastProvince(params,headers);
      if(str.isNotEmpty){
        // HLog.error(api);
        // HLog.error(str);
        headers['someBoothLastProvince'] = Md5Util.generateMD5(AesUtil.encrypt(str));
      }
      _dio!.options.headers.clear();
      _dio!.options.headers.addAll(headers);
      Response response = await _dio!.post(api, data: params);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
      if (withLoading) LoadingUtil.hide();
    }
  }

  postImage(api, {params, withLoading = true, mul = false}) async {
    if (withLoading) LoadingUtil.show();

    try {
      Map<String, dynamic> headers = await CommonParams.addHeaders(api);
      Map<String, dynamic> queryParameters = await CommonParams.addParams();

      if (mul) {
        String appSsid = await SpUtil.getString(Api.appSsid);
        String curUserId = await SpUtil.getString(Api.curUserId);
        //
        headers[Api.client_id] = appSsid;
        headers[Api.currentUserId] = curUserId;
        //
        queryParameters[Api.appssid] = appSsid;
        queryParameters[Api.userId] = curUserId;
      }

      var uploadOptions = Options(contentType: "multipart/form-data");
      _dio!.options.headers.clear();
      _dio!.options.headers.addAll(headers);
      Response response = await _dio!.post(api,
          data: params,
          options: uploadOptions,
          queryParameters: queryParameters);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
      if (withLoading) LoadingUtil.hide();
    }
  }

  postJson(api, {params, withLoading = true, mul = false}) async {
    if (withLoading) LoadingUtil.show();

    try {
      Map<String, dynamic> headers = await CommonParams.addHeaders(api);
      Map<String, dynamic> queryParameters = await CommonParams.addParams();

      if (mul) {
        String appSsid = await SpUtil.getString(Api.appSsid);
        String curUserId = await SpUtil.getString(Api.curUserId);
        //
        headers[Api.client_id] = appSsid;
        headers[Api.currentUserId] = curUserId;
        //
        queryParameters[Api.appssid] = appSsid;
        queryParameters[Api.userId] = curUserId;
      }

      var uploadOptions = Options(contentType: "text/plain");
      _dio!.options.headers.clear();
      _dio!.options.headers.addAll(headers);
      Response response = await _dio!.post(api,
          data: params,
          options: uploadOptions,
          queryParameters: queryParameters);
      return _doResponse(response);
    } catch (e) {
      return _doDioError(e);
    } finally {
      if (withLoading) LoadingUtil.hide();
    }
  }
}

///
_doResponse(Response response) {
  //
  if (response.statusCode == 200) {
    var code = response.data[Api.code];
    var msg = response.data[Api.msg];

    //
    if (code == Code.SUCCESS) {
      var realData = response.data[Api.data];
      return ResultData(realData, code, msg, true);
    } else {
      //token
      if (code == Code.TOKEN_INVALID) {
        SpUtil.put(Api.token, "");
        SpUtil.put(Api.userId, "");
        RouteUtil.toLoginPage(clearStack: true);
        return;
      }

      //
      return ResultData(null, code, msg, false);
    }
  } else {
    return ResultData(
      null,
      response.statusCode ?? Code.UNKNOW,
      response.statusMessage ?? "unknown error",
      false,
    );
  }
}

///
_doDioError(e) {

  ALog(e,mode: ALogMode.error);

  if (e.type == DioErrorType.connectTimeout ||
      e.type == DioErrorType.receiveTimeout ||
      e.type == DioErrorType.other){
    return ResultData(null, 1087, "Network Error", false);
  }
  String msg = e.message;
  if(msg.contains('SocketException')){
    msg = "Network Error";
  }
  return ResultData(null, 1086, msg, false);
}
