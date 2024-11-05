import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/entity/AppConfigEntity.dart';
import 'package:homecredit/widget/HcInput.dart';

class InputItemWrap extends StatefulWidget {
  final String title;
  final Color? titleColor;
  final String subTitle;
  final Color? subTitleColor;
  final Color? backgroundColor;
  final String keyName;
  String defaultText;
  final Function? onTapCallback;
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  String hintText;

  InputItemWrap(String this.defaultText,
      {Key? key,
      this.title = '',
      this.titleColor,
      this.backgroundColor,
      this.keyName = '',
      this.onTapCallback,
      this.controller,
      this.inputType,
      this.subTitle = '', this.hintText = '',
      this.subTitleColor, this.onChanged, this.inputFormatters})
      : super(key: key);

  @override
  State<InputItemWrap> createState() => _InputItemWrapState();
}

class _InputItemWrapState extends State<InputItemWrap> {
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
      width: double.infinity,
      child: Column(
        children: [
          widget.subTitle.isNotEmpty
              ? Row(
            children: [
              Text(widget.title,
                  style: TextStyle(
                    color: widget.titleColor,
                    fontSize: 14.0,
                  )),
              Container(
                margin: EdgeInsets.only(left: 3.0),
                child: Text(widget.subTitle,
                    style: TextStyle(
                      color: widget.subTitleColor,
                      fontSize: 12.0,
                    )),
              ),
            ],
          )
              : Text(widget.title,
              style: TextStyle(
                color: widget.titleColor,
                fontSize: 14.0,
              )),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.only(
                top: 12.0, left: 13.0, right: 15.0, bottom: 12.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: HcInput(
              controller: widget.controller,
              inputType: widget.inputType,
              onChanged: widget.onChanged,
              inputFormatters: widget.inputFormatters,
              hint: widget.hintText.isEmpty ? widget.title : widget.hintText,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
