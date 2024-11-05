import 'package:flutter/material.dart';

import 'package:homecredit/page/vip/banner_page.dart';
import 'package:homecredit/routes/route_util.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../routes/routes.dart';
import '../../../utils/debounce.dart';
import '../../../widget/PrivacyPolicy.dart';
import '../../../widget/StatusTopBar.dart';
import '../../../widget/SubTopBar.dart';
import '../../../arch/api/api.dart';
import '../../../arch/net/http.dart';
import '../../../arch/net/params.dart';
import '../../../arch/net/result_data.dart';
import '../../../utils/toast.dart';
import '../../../utils/money.dart';
import '../order_log.dart';

class SFailedPage extends StatefulWidget {
  const SFailedPage(this.map,{Key? key}) : super(key: key);
  final Map<String, dynamic> map;
  @override
  State<SFailedPage> createState() => _SFailedPageState();
}

class _SFailedPageState extends State<SFailedPage> {
  String? repayAmount;
  String? repayDate;
  String? orderId;

  @override
  void initState() {
    super.initState();
    _indexQuery();
  }

  @override
  Widget build(BuildContext context) {

   return Container(
     child: Column(
       children: [
         SubTopBar(
           S.of(context).app_name,
           backgroundColor: Colors.white,
           offstage: false,
           showSubProductName: true,
           showLeading: false,
         ),
         Container(
           child: Column(
             children: [
               SizedBox(
                 height: 10.0,
               ),
               IntrinsicHeight(
                 child: Row(
                   children: [
                     Column(
                       children: [
                         Image(
                           image: AssetImage('images/ic_under_0.png'),
                           width: 59.0,
                           height: 59.0,
                         ),
                         Text(
                           S.of(context).under_n_review,
                           style: TextStyle(
                             fontSize: 12.0,
                             color: HcColors.color_999999,
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ],
                     ),
                     Column(
                       children: [
                         Image(
                           image: AssetImage('images/ic_repayment_0.png'),
                           width: 59.0,
                           height: 59.0,
                         ),
                         Text(
                           S.of(context).pending_n_repayment,
                           style: TextStyle(
                               fontSize: 12.0, color: HcColors.color_999999),
                           textAlign: TextAlign.center,
                         ),
                       ],
                     ),
                     Column(
                       children: [
                         Image(
                           image: AssetImage('images/ic_overdue_0.png'),
                           width: 59.0,
                           height: 59.0,
                         ),
                         Text(
                           S.of(context).overdue_n_0_days,
                           style: TextStyle(
                               fontSize: 12.0, color: HcColors.color_999999),
                           textAlign: TextAlign.center,
                         ),
                       ],
                     ),
                     Column(
                       children: [
                         Image(
                           image: AssetImage('images/ic_reject_1.png'),
                           width: 59.0,
                           height: 59.0,
                         ),
                         Text(
                           S.of(context).Loan_n_failed,
                           style: TextStyle(
                               fontSize: 12.0, color: HcColors.color_7579E7),
                           textAlign: TextAlign.center,
                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         Image(
                           image: AssetImage('images/ic_reject_sj.png'),
                           width: 29.0,
                           height: 20.0,
                         ),
                       ],
                     ),
                   ],
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 ),
               ),
               Container(
                 width: double.infinity,
                 margin: EdgeInsets.symmetric(horizontal: 15.0),
                 padding: EdgeInsets.only(
                     top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                 decoration: BoxDecoration(
                     color: HcColors.color_E6E8FF,
                     borderRadius: BorderRadius.all(Radius.circular(15.0))),
                 child: Row(
                   children: [
                     Column(
                       children: [
                         Image(
                           image: AssetImage('images/ic_reject_2.png'),
                           width: 57.0,
                           height: 57.0,
                         ),
                         Text(
                           S.of(context).Loan_n_failed,
                           style: TextStyle(
                             fontSize: 12.0,
                             color: HcColors.color_7579E7,
                           ),
                           textAlign: TextAlign.center,
                         ),
                       ],
                     ),
                     SizedBox(
                       width: 30.0,
                     ),
                     Column(
                       children: [
                         Text(
                           S.of(context).loan_amount,
                           style: TextStyle(
                             color: HcColors.color_333333,
                             fontSize: 16.0,
                           ),
                         ),
                         SizedBox(
                           height: 5.0,
                         ),
                         Text.rich(TextSpan(children: [
                           TextSpan(
                             text: 'PKR',
                             style: TextStyle(
                                 color: HcColors.color_7579E7, fontSize: 16.0),
                           ),
                           TextSpan(
                             text: repayAmount ?? '',
                             style: TextStyle(
                                 color: HcColors.color_7579E7,
                                 fontSize: 25.0,
                                 fontWeight: FontWeight.w500),
                           ),
                         ])),
                         SizedBox(
                           height: 8.0,
                         ),
                         Text(
                           S.of(context).date_of_application,
                           style: TextStyle(
                             color: HcColors.color_333333,
                             fontSize: 16.0,
                           ),
                         ),
                         SizedBox(
                           height: 5.0,
                         ),
                         Text(
                           repayDate ?? '',
                           style: TextStyle(
                             color: HcColors.color_7579E7,
                             fontSize: 16.0,
                           ),
                         ),
                       ],
                       crossAxisAlignment: CrossAxisAlignment.start,
                     )
                   ],
                 ),
               ),

               //
               Container(
                 width: double.infinity,
                 margin: EdgeInsets.only(
                     left: 15.0, right: 15, top: 20, bottom: 10),
                 height: 46,
                 child: TextButton(
                     style: ButtonStyle(
                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                       minimumSize: MaterialStateProperty.all(Size(0, 0)),
                       padding: MaterialStateProperty.all(EdgeInsets.zero),
                     ),
                     onPressed: () {
                       if (Debounce.checkClick()) {
                         Map<String, dynamic> map = {
                           Api.orderId: orderId,
                         };
                         RouteUtil.push(context, Routes.update_wallet,
                             params: map);
                       }
                     },
                     child: Text(S.of(context).update_receiving_account,
                         style:
                         TextStyle(color: Colors.white, fontSize: 20.0))),
                 padding: EdgeInsets.only(
                     top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                 decoration: BoxDecoration(
                     color: HcColors.color_02B17B,
                     borderRadius: BorderRadius.all(Radius.circular(15.0))),
               ),

               //
               Container(
                 margin: EdgeInsets.only(
                     top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Image(
                           image: AssetImage('images/ic_under_warn.png'),
                           width: 44.0,
                           height: 44.0,
                         ),
                         SizedBox(
                           width: 10.0,
                         ),
                         Text(
                           S.of(context).sorry,
                           style: TextStyle(
                               fontSize: 20.0,
                               color: HcColors.color_02B17B,
                               fontWeight: FontWeight.w500),
                         ),
                       ],
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Text(
                       S.of(context).failed_hint,
                       style: TextStyle(
                         fontSize: 14.0,
                         color: HcColors.color_02B17B,
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(30.0),
                   bottomRight: Radius.circular(30.0))),
         ),
         Container(
           margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
           child: PrivacyPolicy(),
         ),
         BannerPage(
           margin: EdgeInsets.only(
               top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
         ),
       ],
     ),
     decoration: BoxDecoration(color: HcColors.color_DBF2EB),
   );
  }

  _indexQuery() async {
    try {
      Map<String, dynamic> map = widget.map;

      if (map.isNotEmpty) {

        setState(() {
          orderId = map[Api.orderId].toString();
          double amount = map[Api.repayAmt];
          repayAmount = ' ' + amount.moneyFormat;
          repayDate = map[Api.applyDate] ?? '';
        });
      }
    } catch (e) {}
  }
}
