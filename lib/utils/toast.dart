import 'package:fluttertoast/fluttertoast.dart';
import 'package:homecredit/utils/flutter_plugin.dart';

class ToastUtil {
  static show(String content) {
    // Fluttertoast.showToast(
    //   msg: content,
    //   gravity: ToastGravity.CENTER,
    // );
    FlutterPlugin.showToast(content);
  }
}
