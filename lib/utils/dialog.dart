import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';

class HDailog{
  static showDataDialog(BuildContext context) {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('images/dialog_date.png'),
                          width: 329,
                          height: 355,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: MaterialButton(
                              minWidth: double.infinity,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              height: 46.0,
                              disabledColor: HcColors.color_EEEEEE,
                              color: HcColors.color_02B17B,
                              onPressed: () {
                                RouteUtil.pop(context);
                              },
                              child: Text(S.of(context).i_got_it,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22.0))),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                  ),
                  Positioned(
                    right: 40,
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
            );
          },
        );
      },
    );
  }
}