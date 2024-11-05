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

class BannerPage extends StatefulWidget {
  final EdgeInsetsGeometry? margin;
  const BannerPage({Key? key, this.margin}) : super(key: key);

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _getAppImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: imageUrl != null,
        child: Container(
      margin:widget.margin,
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
        imageUrl: imageUrl ?? '',
        placeholder: (context, url) =>  Container(child: Center(
          child: CircularProgressIndicator(
            color: HcColors.color_02B17B,
          ),
        ),),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    ));
  }

  _getAppImageList() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.imageType] = '03';
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppImageList(), params: params, withLoading: false);
      if (resultData.success) {
        List list = resultData.data;
        if(list.isNotEmpty && list.length>0){
          imageUrl = list[0][Api.url];
          setState(() {});
        }
      }
    } catch (e) {}
  }
}
