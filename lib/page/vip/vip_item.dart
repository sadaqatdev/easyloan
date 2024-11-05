import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../entity/VipProduct.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';

class VipItem extends StatefulWidget {

  final VipProduct item;

  VipItem({Key? key, required this.item}) : super(key: key);

  @override
  State<VipItem> createState() => _VipItemState();
}

class _VipItemState extends State<VipItem> {

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.item.mexicanTermCartoonBlueHusband;

    return Container(
      margin: EdgeInsets.only(top: 15.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: HcColors.color_DBF2EB,
          borderRadius:
          BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: EdgeInsets.only(
            top: 20.0,
            left: 15.0,
            right: 15.0,
            bottom: 20.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              width: 34.0,
              height: 34.0,
              placeholder: (context, url) => CircularProgressIndicator(
                color: HcColors.color_02B17B,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(width: 10.0),
            Expanded(
                child: Text(
                  widget.item.rectangleSelfRainbowTomato ?? '',
                  style: TextStyle(
                    color: HcColors.color_02B17B,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              // width: 120.0,
              // height: 45.0,
              child: TextButton(
                  style: ButtonStyle(
                    tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                    minimumSize:
                    MaterialStateProperty.all(
                        Size(0, 0)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.zero),
                  ),
                  onPressed: () async{
                    if(Debounce.checkClick()) {
                      try {
                        String url = widget.item
                            .popularEmpireTortoiseUnfortunateLab ?? '';
                        if (url.isNotEmpty) {
                          launch(url);
                        }
                      } catch (e) {}
                    }
                  },
                  child: Text(
                      S.of(context).apply_now,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0))),
              padding: EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 12.0,
                  right: 12.0),
              decoration: BoxDecoration(
                  color: HcColors.color_02B17B,
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0))),
            )
          ],
        ),
      ),
    );
  }
}
