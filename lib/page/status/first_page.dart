import 'package:flutter/material.dart';
import '../../arch/api/api.dart';
import '../../arch/api/log.dart';
import '../../arch/api/log_util.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';
import '../../utils/flutter_plugin.dart';
import '../../utils/sp.dart';
import '../../widget/HomeTopBar.dart';
import '../../widget/PrivacyPolicy.dart';
import '../vip/banner_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                Column(
                  children: [
                    Text(
                      S.of(context).max_amount,
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 14.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            '1,000',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Text(
                            'PKR',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14.0,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                Column(children: [

                  Text(
                    S.of(context).loan_term,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14.0,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 8.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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

          // apply now
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
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
                try {
                  FlutterPlugin.checkNetwork().then((value) async {
                    if (value) {
                      String token = await SpUtil.getString(Api.token, "");
                      if (token.isEmpty) {
                        RouteUtil.push(context, Routes.login);
                        return;
                      }
                      RouteUtil.push(context, Routes.basic, checkLogin: true);
                      LogUtil.platformLog(
                          optType: PointLog.CLICK_INDEX_APPLY());
                      LogUtil.otherLog(
                          bfEvent: PointLog.CLICK_FIRST_INDEX_APPLY(),
                          fbEvent: 'fb_mobile_add_to_wishlist');
                    }
                  });
                } catch (e) {}
              }
            },
          ),

          //
          Container(
            margin: EdgeInsets.only(
                top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
            child: PrivacyPolicy(),
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
                BannerPage(
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                ),
                SizedBox(height: 10.0,),
                Text(
                  S.of(context).splash_hint1,
                  style: TextStyle(fontSize: 12.0, color: HcColors.color_333333),
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
}
