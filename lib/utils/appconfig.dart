

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homecredit/utils/toast.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../entity/AppConfigEntity.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';

class AppConfig{
  List<AppConfigEntity>? appConfigList;
  List<bool>? pressedAttentions;
  TextStyle? textStyle;

  final TextStyle _availableTextStyle =
  TextStyle(fontSize: 16.0, color: HcColors.color_333333);

  final TextStyle _unavailableTextStyle =
  TextStyle(fontSize: 14.0, color: HcColors.color_999999);

  getAppConfig(String type,BuildContext context,Function function) async {
    try {
      if(appConfigList != null && appConfigList!.length > 0) {
        showDialog(context, function);
        return;
      }

      Map<String, String> params = await CommonParams.addParams();
      params[Api.type] = type;
      ResultData resultData =
      await HttpManager.instance().post(Api.getAppConfig(), params: params,mul: true);
      if (resultData.success) {
        List list = resultData.data;
        appConfigList = list.map((e) {
          return AppConfigEntity.fromJson(e);
        }).toList();
        if (appConfigList!.isNotEmpty) {
          pressedAttentions = appConfigList?.map((e) => false).toList();
          if(pressedAttentions!.isNotEmpty){
            pressedAttentions![0] = true;
          }
          showDialog(context,function);
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  showDialog(BuildContext context,Function function) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )),
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Text(
                            S.of(context).close,
                            style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                        InkWell(
                          child: Text(
                            S.of(context).confirm,
                            style: TextStyle(
                              color: HcColors.color_02B17B,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {

                            String text = '';
                            String id = '';
                            for (int i = 0; i < pressedAttentions!.length; i++) {
                              if(pressedAttentions![i]){
                                id = appConfigList![i].personalProperHallPark.toString();
                                text = appConfigList![i].mobileFistLowJuly.toString();
                                break;
                              }
                            }

                            if(text.isNotEmpty) {
                              function(id,text);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: appConfigList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          AppConfigEntity entity = appConfigList![index];
                          bool pressAttention = pressedAttentions![index];
                          textStyle = pressAttention
                              ? _availableTextStyle
                              : _unavailableTextStyle;

                          return InkWell(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    entity.mobileFistLowJuly.toString(),
                                    style: textStyle,
                                  ),
                                  decoration: BoxDecoration(),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: HcColors.color_DDDDDD,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                for (int i = 0;
                                i < pressedAttentions!.length;
                                i++) {
                                  if (i == index) {
                                    pressedAttentions![i] = true;
                                  } else {
                                    pressedAttentions![i] = false;
                                  }
                                }
                                textStyle = pressedAttentions![index]
                                    ? _availableTextStyle
                                    : _unavailableTextStyle;
                              });
                            },
                          );
                        },
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}