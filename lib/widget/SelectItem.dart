import 'package:flutter/material.dart';
import 'package:homecredit/entity/AppConfigEntity.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';

class SelectItem extends StatefulWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final String keyName;
  String defaultText;
  String hintText;

  final Function? onTapCallback;

  SelectItem(String this.defaultText,
      {Key? key,
      this.title = '',
      this.titleColor,
      this.backgroundColor,
      this.keyName = '',
      this.onTapCallback,
      this.hintText = ''})
      : super(key: key);

  @override
  State<SelectItem> createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
  List<AppConfigEntity>? appConfigList;
  List<bool>? pressedAttentions;
  TextStyle? textStyle;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Padding(
        padding:
            EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: Column(
          children: [
            Text(widget.title,
                style: TextStyle(
                  color: widget.titleColor,
                  fontSize: 14.0,
                )),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.only(
                    top: 12.0, left: 13.0, right: 15.0, bottom: 12.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Row(
                  children: [
                    widget.defaultText.isEmpty
                        ? Text(
                            widget.hintText.isEmpty ?  widget.title : widget.hintText,
                            style: TextStyle(
                              color: HcColors.color_999999,
                              fontSize: 14.0,
                            ),
                          )
                        : Text(widget.defaultText,
                            style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 14.0,
                            )),
                    Spacer(),
                    Image(
                        image: AssetImage('images/ic_right_arrow.png'),
                        width: 9.0,
                        height: 12.0),
                  ],
                ),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                String type = widget.keyName;
                if (type.isNotEmpty) {
                  if (appConfigList != null && appConfigList!.length > 0) {
                    _showDialog();
                  } else {
                    _getAppConfig(widget.keyName);
                  }
                }
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  _getAppConfig(String type) async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.type] = type;
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppConfig(), params: params, mul: true);
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
          _showDialog();
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _showDialog() {
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
                            for (int i = 0;
                                i < pressedAttentions!.length;
                                i++) {
                              if (pressedAttentions![i]) {
                                id = appConfigList![i]
                                    .personalProperHallPark
                                    .toString();
                                text = appConfigList![i]
                                    .mobileFistLowJuly
                                    .toString();
                                break;
                              }
                            }

                            if (text.isNotEmpty) {
                              widget.onTapCallback!(id, text);
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

final TextStyle _availableTextStyle =
    TextStyle(fontSize: 16.0, color: HcColors.color_333333);

final TextStyle _unavailableTextStyle =
    TextStyle(fontSize: 14.0, color: HcColors.color_999999);
