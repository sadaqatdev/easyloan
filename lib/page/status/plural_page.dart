import 'package:flutter/material.dart';

import '../../arch/api/api.dart';
import '../../arch/api/log.dart';
import '../../arch/api/log_util.dart';
import '../../arch/net/config.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/date.dart';
import '../../utils/debounce.dart';
import '../../utils/sp.dart';
import '../../widget/HomeTopBar.dart';
import '../vip/banner_page.dart';

class PluralPage extends StatefulWidget {
  const PluralPage({Key? key}) : super(key: key);

  @override
  State<PluralPage> createState() => _PluralPageState();
}

class _PluralPageState extends State<PluralPage> {

  @override
  void initState() {
    super.initState();
    try {
      Future.delayed(Duration(milliseconds: 800), () {
        _showSuccessDialog();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // TopBar(),
          HomeTopBar(),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).max_amount,
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Baseline(
                      baseline: 5.0,
                      //
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        '50,000',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xFF333333),
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                    Baseline(
                      baseline: 1.0,
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        'PKR',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14.0,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Image(image: AssetImage('images/pb_money_bg.png')),
          ),

          Container(
            margin: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).loan_term,
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Baseline(
                      baseline: 8.0,
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        '91',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xFF333333),
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                    Baseline(
                      baseline: 1.0,
                      //
                      baselineType: TextBaseline.alphabetic,
                      child: Text(
                        S.of(context).days,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14.0,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/pb_day_bg1.png'),
                  width: 203.0,
                  height: 36.0,
                ),
                Container(
                  width: 120,
                  child: Text(
                    S.of(context).home_day_hint,
                    style: TextStyle(
                      color: HcColors.color_02B17B,
                      fontSize: 14.0,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  decoration: BoxDecoration(),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: Image(
              image: AssetImage('images/home_coupon.png'),
              width: 173.0,
              height: 59.0,
            ),
          ),

          // apply now
          InkWell(
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Text(
                S.of(context).apply_now,
                style: TextStyle(fontSize: 24.0, color: HcColors.white),
              ),
              height: 46,
              decoration: BoxDecoration(
                  color: HcColors.color_02B17B,
                  borderRadius: BorderRadius.circular(10.0)),
              alignment: Alignment.center,
            ),
            onTap: () async {
              if (Debounce.checkClick()) {
                String token = await SpUtil.getString(Api.token,"");
                if(token.isEmpty){
                  RouteUtil.push(context, Routes.login);
                  return;
                }
                LogUtil.platformLog(optType: PointLog.CLICK_INDEX_APPLY());
                RouteUtil.push(context, Routes.basic, checkLogin: true);
              }
            },
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
                color: HcColors.color_DBF2EB,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/ic_home_step1.png'),
                      width: 53.0,
                      height: 53.0,
                    ),
                    Image(
                      image: AssetImage('images/ic_home_step2.png'),
                      width: 53.0,
                      height: 53.0,
                    ),
                    Image(
                      image: AssetImage('images/ic_home_step3.png'),
                      width: 53.0,
                      height: 53.0,
                    ),
                    Image(
                      image: AssetImage('images/ic_home_step4.png'),
                      width: 53.0,
                      height: 53.0,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image(
                    image: AssetImage('images/home_rexq.png'),
                    width: 329.0,
                    height: 144.0,
                  ),
                ),
                BannerPage(
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                ),
              ],
            ),
            padding: EdgeInsets.only(
                left: 20.0, top: 15.0, right: 20.0, bottom: 15.0),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  _showSuccessDialog() {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),

                      Text(
                        S.of(context).app_name,
                        style: TextStyle(
                            fontSize: 24.0,
                            color: HcColors.color_333333,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30,),

                      Image(
                        image: AssetImage('images/ic_success.png'),
                        width: 274,
                        height: 162,
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          S.of(context).pay_successfully,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: HcColors.color_333333,),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 9),
                        child: Image(
                          image: AssetImage('images/home_coupon.png'),
                          width: 173.0,
                          height: 59.0,
                        ),
                      ),

                      // apply now
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: Text(
                            S.of(context).apply_now,
                            style: TextStyle(fontSize: 24.0, color: HcColors.white),
                          ),
                          height: 46,
                          decoration: BoxDecoration(
                              color: HcColors.color_02B17B,
                              borderRadius: BorderRadius.circular(10.0)),
                          alignment: Alignment.center,
                        ),
                        onTap: () async {
                          if (Debounce.checkClick()) {
                            String token = await SpUtil.getString(Api.token, "");
                            if (token.isEmpty) {
                              RouteUtil.push(context, Routes.login);
                              return;
                            }
                            LogUtil.platformLog(
                                optType: PointLog.CLICK_INDEX_APPLY());
                            RouteUtil.push(context, Routes.basic, checkLogin: true);
                            RouteUtil.pop(context);
                          }
                        },
                      ),

                      Container(
                        margin: EdgeInsets.only(top:50),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Image(
                                image: AssetImage('images/home_rexq.png'),
                                width: 329.0,
                                height: 144.0,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top:39,bottom: 54),
                              child: InkWell(
                                child: Image(
                                  image: AssetImage('images/ic_dialog_close.png'),
                                  width: 25.0,
                                  height: 25.0,
                                ),
                                onTap: () {
                                  RouteUtil.pop(context);
                                },
                              ),
                            ),

                          ],
                        ),
                        decoration: BoxDecoration(
                            color: HcColors.color_DBF2EB,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0))),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  right: 30,
                  top: 10,
                  child: Container(
                    margin: EdgeInsets.only(top:30,bottom: 50),
                    child: InkWell(
                    child: Image(
                      image: AssetImage('images/ic_dialog_close.png'),
                      width: 25.0,
                      height: 25.0,
                    ),
                    onTap: () {
                      RouteUtil.pop(context);
                    },
                  ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

}
