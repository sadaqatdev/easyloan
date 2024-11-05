import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/routes/route_handler.dart';

class Routes {
  static String root = "/";
  static String index = "/index";
  static String basic = "/basic";
  static String cnic = "/cnic";
  static String contact = "/contact";
  static String login = "/login";
  static String mine = "/mine";
  static String order = "/product";
  static String select = "/select";
  static String wait = "/wait";
  static String wallet = "/wallet";
  static String work = "/work";
  static String submit = "/submit";

  static String under_review = "/under_review";
  static String repayment = "/repayment";
  static String overdue = "/overdue";
  static String failed = "/failed";
  static String reject = "/reject";
  static String webview = "/webview";
  static String update_wallet = "/update_wallet";
  static String setting = "/setting";
  static String guide = "/guide";
  static String deferred = "/deferred";

  static String service = "/service";
  static String feedback = "/feedback";


  static void configureRoutes(FluroRouter router) {

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
         print("ROUTE WAS NOT FOUND !!!");
    });

    // router.define(root, handler: rootHandler, transitionType: TransitionType.cupertino);
    router.define(index, handler: indexHandler, transitionType: TransitionType.fadeIn);
    router.define(basic, handler: basicHandler, transitionType: TransitionType.cupertino);
    router.define(cnic, handler: cnicHandler, transitionType: TransitionType.cupertino);
    router.define(contact, handler: contactHandler, transitionType: TransitionType.cupertino);
    router.define(login, handler: loginHandler, transitionType: TransitionType.cupertino);
    router.define(select, handler: selectHandler, transitionType: TransitionType.cupertino);
    router.define(wait, handler: waitHandler, transitionType: TransitionType.cupertino);
    router.define(wallet, handler: walletHandler, transitionType: TransitionType.cupertino);
    router.define(work, handler: workHandler, transitionType: TransitionType.cupertino);
    router.define(submit, handler: submitHandler, transitionType: TransitionType.cupertino);
    router.define(under_review, handler: underReviewHandler, transitionType: TransitionType.cupertino);
    router.define(repayment, handler: repaymentHandler, transitionType: TransitionType.cupertino);
    router.define(overdue, handler: overdueHandler, transitionType: TransitionType.cupertino);
    router.define(failed, handler: failedHandler, transitionType: TransitionType.cupertino);
    router.define(reject, handler: rejectHandler, transitionType: TransitionType.cupertino);
    // router.define(webview, handler: webviewHandler, transitionType: TransitionType.cupertino);
    router.define(update_wallet, handler: updateWalletHandler, transitionType: TransitionType.cupertino);
    router.define(setting, handler: settingHandler, transitionType: TransitionType.cupertino);
    router.define(guide, handler: guideHandler, transitionType: TransitionType.cupertino);
    router.define(deferred, handler: deferredHandler, transitionType: TransitionType.cupertino);
    router.define(service, handler: serviceHandler, transitionType: TransitionType.cupertino);
    router.define(feedback, handler: feedbackHandler, transitionType: TransitionType.cupertino);
  }
}
