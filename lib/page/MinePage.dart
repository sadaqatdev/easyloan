import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/page/service/service_call.dart';
import 'package:homecredit/page/vip/banner_page.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/debounce.dart';
import '../utils/flutter_plugin.dart';
import '../utils/sp.dart';
import '../widget/HomeTopBar.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  String? _userName;
  String? _phoneNo;
  String? _phoneNoM;
  String? _phoneNoValue;
  String? afaceUrl;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    _getPhoneNum();
    SpUtil.getString(Api.token).then((value) {
      if (value.isNotEmpty) {
        _getIdentificationResult();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scrollbar(
          child: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: HcColors.white,
          ),
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('images/top_bg_small.png'),
                  width: double.infinity,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ClipOval(
                      child: afaceUrl == null
                          ? Image(image: AssetImage('images/ic_logo_small.png'))
                          : CachedNetworkImage(
                              imageUrl: afaceUrl!,
                              width: 82.0,
                              height: 82.0,
                              placeholder: (context, url) => Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: HcColors.color_02B17B,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      _userName ?? S.of(context).app_name,
                      style: TextStyle(
                          fontSize: 24.0, color: HcColors.color_333333),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage('images/ic_mine_sj.png'),
                          width: 11.0,
                          height: 16.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '+92',
                          style: TextStyle(
                              fontSize: 14.0, color: HcColors.color_02B17B),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _phoneNoValue ?? '',
                          style: TextStyle(
                              fontSize: 14.0, color: HcColors.color_02B17B),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: isShow
                              ? Image(
                                  image: AssetImage('images/ic_mine_mmx.png'),
                                  width: 27.0,
                                  height: 20.0,
                                )
                              : Image(
                                  image: AssetImage('images/ic_mine_mm.png'),
                                  width: 27.0,
                                  height: 20.0,
                                ),
                          onTap: () {
                            setState(() {
                              isShow = !isShow;
                              if (isShow) {
                                _phoneNoValue = _phoneNo;
                              } else {
                                _phoneNoValue = _phoneNoM;
                              }
                            });
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: HcColors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 23, left: 20, right: 20),
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('images/ic_mine_lan.png'),
                                  width: 29.0,
                                  height: 27.0,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  S.of(context).change_language,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: HcColors.color_333333),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onTap: () {
                              RouteUtil.push(context, Routes.setting);
                            },
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('images/ic_mine_pri.png'),
                                  width: 29.0,
                                  height: 34.0,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  S.of(context).notice_of_privacy,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: HcColors.color_333333),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onTap: () {
                              // Map<String, dynamic> params = {
                              //   "url": NetConfig.PEIVACY_URL,
                              //   "title": ''
                              // };
                              // RouteUtil.push(
                              //   context,
                              //   Routes.webview,
                              //   params: params,
                              // );
                              FlutterPlugin.openWebview(NetConfig.PEIVACY_URL);
                            },
                          ),
                          ServiceCall(
                            type: 1,
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('images/ic_mine_feed.png'),
                                  width: 27.0,
                                  height: 26.0,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  S.of(context).feedback,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: HcColors.color_333333),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onTap: () {
                              // RouteUtil.push(context, Routes.feedback);
                              FlutterPlugin.openCrisp();
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      decoration: BoxDecoration(
                          color: HcColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    BannerPage(
                      margin: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minWidth: double.infinity,
                          height: 46.0,
                          disabledColor: HcColors.color_EEEEEE,
                          color: HcColors.color_02B17B,
                          onPressed: () async {
                            if (Debounce.checkClick()) {
                              SpUtil.remove(Api.token);
                              SpUtil.remove(Api.userId);
                              RouteUtil.push(context, Routes.login,
                                  clearStack: true);
                            }
                          },
                          child: Text(S.of(context).log_out,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0))),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: HcColors.color_DBF2EB,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
            ],
          ),
        ),
      )),
      onRefresh: () async {
        SpUtil.getString(Api.token).then((value) {
          if (value.isNotEmpty) {
            _getIdentificationResult();
          }
        });

        return Future.delayed(Duration(seconds: 1));
      },
    );
  }

  _getPhoneNum() async {
    String mobile = await SpUtil.getString(Api.mobile, '');
    _phoneNo = mobile;
    if (mobile.isNotEmpty) {
      if (mobile.length > 8) {
        setState(() {
          _phoneNoM = mobile.replaceRange(3, 7, '****');
          _phoneNoValue = _phoneNoM;
        });
      }
    }
  }

  _getIdentificationResult() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getIdentificationResult(), params: params, mul: false);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        String fullName = map[Api.fullName];
        afaceUrl = map[Api.afaceUrl];
        if (fullName != null) {
          _userName = fullName;
        }
        setState(() {});
      }
    } catch (e) {}
  }
}
