class NetConfig {
  static const String APP_NAME = "EasyLoan";
  static const String APP_SSID = "06";
  static const String LANGUAGE = "en";
  static const String AES_KEY = "925e0855b6801486e85612bd176a2320";
  static const String CHANNEL = "googleplay";
  static const String GUIDE = "guide";
  static const String PERMISSION = "permission";
  static const String INDEX_DIALOG = "index_dialog";

  //
  static const String BASE_URL = "https://www.homecreditpk.com/homecredit/everydayTheory";
  // static const String BASE_URL = "https://bjst.ultracreditosmx.com/homecredit/everydayTheory";
  static const int TIME_OUT = 60000;

  static String appMobile = "";
  // static const String PEIVACY_URL = "https://www.homecreditpk.com/homecreditpks/easyloanPrivacy.html";
  // static const String TERM_URL = "https://www.homecreditpk.com/homecreditpks/easyloanterms.html";
  static const String PEIVACY_URL = "https://www.homecreditpk.com/homecreditpks/privacy.html";
  static const String TERM_URL = "https://www.homecreditpk.com/homecreditpks/terms.html";
  static const String CONTRACT_URL = "https://www.homecreditpk.com/homecreditpks/bjcontract.html";

  
  static const int TYPE_PRODUCT_STATUS_APPLY = 0;
  /**  */
  static const int TYPE_PRODUCT_STATUS_REPAY = 1;
  /**  */
  static const int TYPE_PRODUCT_STATUS_OVERDUE = 2;
  /**  */
  static const int TYPE_PRODUCT_STATUS_WAIT = 3;
  /**  */
  static const int TYPE_PRODUCT_STATUS_REJECT = 4;
  /**  */
  static const int TYPE_PRODUCT_STATUS_FAILED = 5;

  //Order List Status
  static const int TYPE_ORDER_STATUS_REVIEW = 0;
  static const int TYPE_ORDER_STATUS_REJECT = 1;
  static const int TYPE_ORDER_STATUS_FINISH = 2;
  static const int TYPE_ORDER_STATUS_OVERDUE = 3;
  static const int TYPE_ORDER_STATUS_REPAY = 4;
  static const int TYPE_ORDER_STATUS_FAILED = 5;
}
