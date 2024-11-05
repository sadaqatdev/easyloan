import 'package:flutter/material.dart';

import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../utils/toast.dart';
import '../../widget/SubTopBar.dart';
import 'deferred_page.dart';
import 'order_log.dart';

class DeferredNormalPage extends StatefulWidget {
  const DeferredNormalPage({Key? key}) : super(key: key);

  @override
  State<DeferredNormalPage> createState() => _DeferredNormalPageState();
}

class _DeferredNormalPageState extends State<DeferredNormalPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> map = RouteUtil.getParams(context);
    bool ep_visible = map[Api.easyPayFlag];
    bool jc_visible = map[Api.jazzCashFlag];

    return Scaffold(
      appBar: SubTopBar(
        S.of(context).app_name,
        backgroundColor: Colors.white,
        offstage: false,
        showSubProductName: true,
      ),
      body: DeferredPage(
        ep_visible: ep_visible,
        jc_visible: jc_visible,
        map: map,
      ),
      backgroundColor: HcColors.white,
    );
  }
}
