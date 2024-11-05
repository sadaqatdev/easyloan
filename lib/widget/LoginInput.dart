import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/res/colors.dart';

class LoginInput extends StatefulWidget {
  final String? title;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool obscureText;
  final TextInputType? inputType;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;
  TextEditingController? controller;


  LoginInput(
      {Key? key,
      this.title,
      this.hint,
      this.onChanged,
      this.focusChanged,
      this.obscureText = false,
      this.inputType,
      this.maxLength = 50, this.inputFormatters, this.controller})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left: 25,top: 15),
        //   child: Text(
        //     widget.title!,
        //     style: TextStyle(fontSize: 18),
        //   ),
        // ),
        _input(),
        Divider(
          height: 1,
          thickness: 0.5,
          color: Color(0xFFDDDDDD),
        ),
      ],
    );
  }

  _input() {
    return Container(
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        autofocus: false,
        cursorColor: HcColors.color_02B17B,
        style: TextStyle(fontSize: 14.0, color: HcColors.color_02B17B),
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          // contentPadding: EdgeInsets.only(left: 25, right: 25),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
        inputFormatters: widget.inputFormatters
      ),
      // decoration: BoxDecoration(color: Colors.yellow),
    );
  }
}
