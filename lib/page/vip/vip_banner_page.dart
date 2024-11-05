import 'package:alog/alog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/res/colors.dart';

import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../entity/VipProduct.dart';
import '../../generated/l10n.dart';
import 'vip_item.dart';
import '../../routes/route_util.dart';
import '../../utils/toast.dart';

class VipBannerPage extends StatefulWidget {
  const VipBannerPage({Key? key}) : super(key: key);

  @override
  State<VipBannerPage> createState() => _VipBannerPageState();
}

class _VipBannerPageState extends State<VipBannerPage> {
  List<VipProduct>? productList = [];
  String? vipProductImageUrl;

  @override
  void initState() {
    super.initState();
    _queryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
        width: double.infinity,
        height: 105.0,
        decoration: BoxDecoration(
          color: HcColors.color_DDDDDD,
          borderRadius: BorderRadius.circular(10.0),
          // image: vipProductImageUrl == null
          //     ? null
          //     : DecorationImage(
          //         image: NetworkImage(vipProductImageUrl ?? ''),
          //         fit: BoxFit.cover),
        ),
        child: CachedNetworkImage(
          imageUrl: vipProductImageUrl ?? '',
          placeholder: (context, url) => Container(
            child: Center(
              child: CircularProgressIndicator(
                color: HcColors.color_02B17B,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
      onTap: () {
        if (productList != null && productList!.length > 0) {
          _showVipDialog();
        }
      },
    );
  }

  _queryProducts() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.vipProducts(), params: params, withLoading: false);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        vipProductImageUrl = map[Api.vipProductImageUrl];
        ALog(vipProductImageUrl, mode: ALogMode.debug);
        List list = map[Api.vipProductList];
        productList = list.map((e) {
          return VipProduct.fromJson(e);
        }).toList();
        setState(() {});
      }
    } catch (e) {}
  }

  _showVipDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;

          return Center(
            child: Container(
              width: width * 0.9,
              height: height * 0.9,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30, bottom: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            S.of(context).dialog_hello,
                            style: TextStyle(
                                color: HcColors.color_333333,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20),
                          Text(
                            S.of(context).dialog_vip_hint,
                            style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 18.0,
                            ),
                          ),
                          Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: productList?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  VipProduct item = productList![index];
                                  return VipItem(
                                    item: item,
                                  );
                                },
                              ),
                              removeTop: true,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
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
                            alignment: Alignment.center,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: HcColors.white,
                    ),
                  ),
                  Image(
                    image: AssetImage('images/ic_lab.png'),
                    width: 150,
                    height: 143,
                  ),
                ],
                alignment: Alignment.topRight,
              ),
            ),
          );
        });
  }
}
