//
import 'package:flutter/services.dart';
import 'package:homecredit/utils/toast.dart';

class ClipboardUtil {
  //
  static setData(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  //
  static setDataToast(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtil.show('Copy successful:${data}');
    }
  }

  //
  static setDataToastMsg(String data, {String toastMsg = 'Copy successful'}) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtil.show(toastMsg);
    }
  }

  //
  static Future getData() {
    return Clipboard.getData(Clipboard.kTextPlain);
  }

//
//   ClipboardUtil.setData('123');
//   ClipboardUtil.getData().then((data){}).catchError((e){});

}