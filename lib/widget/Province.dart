import 'package:flutter/material.dart';
import 'package:homecredit/entity/AppConfigEntity.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../entity/RegionEntity.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';

class Province extends StatefulWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  String defaultText;

  final Function? onTapCallback;

  Province(String this.defaultText,
      {Key? key,
      this.title = '',
      this.titleColor,
      this.backgroundColor,
      this.onTapCallback})
      : super(key: key);

  @override
  State<Province> createState() => _ProvinceState();
}

class _ProvinceState extends State<Province> {
  List<RegionEntity>? appConfigList;
  List<bool>? pressedAttentions;
  TextStyle? textStyle;
  int currentRegionlevel = 1;
  Map _map = {};

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
            Text(
              widget.title,
              style: TextStyle(
                color: widget.titleColor,
                fontSize: 14.0,
              ),
            ),
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
                            widget.title,
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

                if (appConfigList != null && appConfigList!.length > 0) {
                  _showDialog();
                } else {
                  _getAddress("-1", "1");
                }
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  _getAddress(String regionParentId, final String regionlevel) async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.regionParentId] = regionParentId;
      params[Api.regionlevel] = regionlevel;
      ResultData resultData = await HttpManager.instance()
          .post(Api.region(), params: params, mul: true);
      if (resultData.success) {
        List list = resultData.data;
        appConfigList = list.map((e) {
          return RegionEntity.fromJson(e);
        }).toList();
        if (appConfigList!.isNotEmpty) {
          pressedAttentions = appConfigList?.map((e) => false).toList();
          if (pressedAttentions!.isNotEmpty) {
            pressedAttentions![0] = true;
          }
          if (currentRegionlevel == 1) {
            _showDialog();
          }
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _showDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
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
                          onTap: () async {
                            String text = '';
                            String id = '';
                            for (int i = 0;
                                i < pressedAttentions!.length;
                                i++) {
                              if (pressedAttentions![i]) {
                                id = appConfigList![i]
                                    .chemicalManagerBank
                                    .toString();
                                text = appConfigList![i]
                                    .hardworkingSuccessfulPleasureScholar
                                    .toString();
                                break;
                              }
                            }

                            if (text.isNotEmpty) {
                              if (currentRegionlevel == 1) {
                                _map['provinceId'] = id;
                                _map['provinceName'] = text;
                                currentRegionlevel = 2;
                                await _getAddress(id, '2');
                                setState(() {});
                              } else {
                                _map['cityId'] = id;
                                _map['cityName'] = text;
                                widget.onTapCallback!(_map);
                                Navigator.pop(context);
                              }
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
                      RegionEntity entity = appConfigList![index];
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
                                entity.hardworkingSuccessfulPleasureScholar
                                    .toString(),
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
      isDismissible: false,
    ).then((value) {
      appConfigList = [];
      pressedAttentions = [];
      _map = {};
      currentRegionlevel = 1;
    });
  }
}

final TextStyle _availableTextStyle =
    TextStyle(fontSize: 16.0, color: HcColors.color_333333);

final TextStyle _unavailableTextStyle =
    TextStyle(fontSize: 14.0, color: HcColors.color_999999);
