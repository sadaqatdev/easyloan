import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../generated/l10n.dart';

class LoadingUtil {
  static show() {
    EasyLoading.show(
        status: S.current.loading, maskType: EasyLoadingMaskType.clear);
  }

  static hide() {
    EasyLoading.dismiss();
  }
}
