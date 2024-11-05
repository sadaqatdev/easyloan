import 'package:fluro/fluro.dart';
import 'package:homecredit/index.dart';
import 'package:homecredit/page/BasicPage.dart';
import 'package:homecredit/page/CNICPage.dart';
import 'package:homecredit/page/ContactPage.dart';
import 'package:homecredit/page/GuidePage.dart';
import 'package:homecredit/page/HomePage.dart';
import 'package:homecredit/page/LoginPage.dart';
import 'package:homecredit/page/SettingPage.dart';
import 'package:homecredit/page/feedback/FeedbackList.dart';
import 'package:homecredit/page/service/service_page.dart';
import 'package:homecredit/page/status/deferred_normal_page.dart';
import 'package:homecredit/page/status/overdue_page.dart';
import 'package:homecredit/page/status/under_review_page.dart';
import '../page/MinePage.dart';
import '../page/OrderPage.dart';
import '../page/SelectPage.dart';
import '../page/SubmitPage.dart';
import '../page/UpdateWalletPage.dart';
import '../page/WaitPage.dart';
import '../page/WalletPage.dart';
import '../page/WorkPage.dart';
import '../page/status/failed_page.dart';
import '../page/status/reject_page.dart';
import '../page/status/repayment_page.dart';
import '../page/web_page.dart';

// var rootHandler = Handler(handlerFunc: (context, params) {
//   return SplashPage();
// });

var indexHandler = Handler(handlerFunc: (context, params) {
  return Index();
});

var basicHandler = Handler(handlerFunc: (context, params) {
  return BasicPage();
});

var cnicHandler = Handler(handlerFunc: (context, params) {
  return CNICPage();
});

var contactHandler = Handler(handlerFunc: (context, params) {
  return ContactPage();
});

var loginHandler = Handler(handlerFunc: (context, params) {
  return LoginPage();
});

var selectHandler = Handler(handlerFunc: (context, params) {
  return SelectPage();
});

var waitHandler = Handler(handlerFunc: (context, params) {
  return WaitPage();
});

var walletHandler = Handler(handlerFunc: (context, params) {
  return WalletPage();
});

var workHandler = Handler(handlerFunc: (context, params) {
  return WorkPage();
});

var submitHandler = Handler(handlerFunc: (context, params) {
  return SubmitPage();
});

var underReviewHandler = Handler(handlerFunc: (context, params) {
  return UnderReviewPage();
});

var repaymentHandler = Handler(handlerFunc: (context, params) {
  return RepaymentPage();
});

var overdueHandler = Handler(handlerFunc: (context, params) {
  return OverduePage();
});

var failedHandler = Handler(handlerFunc: (context, params) {
  return FailedPage();
});

var rejectHandler = Handler(handlerFunc: (context, params) {
  return RejectPage();
});

// var webviewHandler = Handler(handlerFunc: (context, params) {
//   return WebPage();
// });

var updateWalletHandler = Handler(handlerFunc: (context, params) {
  return UpdateWalletPage();
});

var settingHandler = Handler(handlerFunc: (context, params) {
  return SettingPage();
});

var guideHandler = Handler(handlerFunc: (context, params) {
  return GuidePage();
});

var deferredHandler = Handler(handlerFunc: (context, params) {
  return DeferredNormalPage();
});

var serviceHandler = Handler(handlerFunc: (context, params) {
  return ServicePage();
});

var feedbackHandler = Handler(handlerFunc: (context, params) {
  return FeedbackList();
});



