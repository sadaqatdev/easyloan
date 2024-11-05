// import 'dart:io';
// import 'package:alog/alog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:homecredit/utils/toast.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';
// import '../generated/l10n.dart';
// import '../routes/route_util.dart';
// import '../utils/loading.dart';
// import '../widget/SubTopBar.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebPage extends StatefulWidget {
//   const WebPage({Key? key}) : super(key: key);
//
//   @override
//   State<WebPage> createState() => _WebPageState();
// }
//
// class _WebPageState extends State<WebPage> {
//
//   @override
//   void initState() {
//     super.initState();
//     // Enable hybrid composition.
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }
//
//   @override
//   void dispose() {
//     LoadingUtil.hide();
//     super.dispose();
//   }
//
//   WebViewPlusController? _controller;
//
//   @override
//   Widget build(BuildContext context) {
//
//     var params = RouteUtil.getParams(context);
//     String url = params["url"];
//     String title = params["title"];
//
//
//     return WillPopScope(
//       onWillPop: _requestPop,
//       child: Scaffold(
//         appBar: SubTopBar(
//           S.of(context).app_name,
//           backgroundColor: Colors.white,
//           offstage: false,
//         ),
//         body:WebViewPlus(
//           initialUrl: url,
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (controller) async {
//             _controller = controller;
//           },
//
//           onPageStarted: (_){
//             LoadingUtil.show();
//           },
//
//           onProgress: (progress){
//             if(progress > 70)  LoadingUtil.hide();
//           },
//
//           onPageFinished: (_) {
//             LoadingUtil.hide();
//           },
//         ),
//       ),
//     );
//
//
//   }
//
//   Future<bool> _requestPop() async {
//     bool? canBack = await _controller?.webViewController.canGoBack();
//     if (canBack!) {
//       _controller?.webViewController.goBack();
//       return Future.value(false);
//     } else {
//       RouteUtil.pop(context);
//     }
//     return Future.value(true);
//   }
//
// }
