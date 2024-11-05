import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/arch/api/api.dart';
import 'package:homecredit/page/LoginPage.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/utils/sp.dart';

import '../application.dart';

class RouteUtil {

  // push
  static push(
    BuildContext context,
    String path, {
    Map? params,
    bool replace = false,
    bool checkLogin = false,
    bool clearStack = false, Function? onTapCallback
  }) async {

    // ，
    String token = await SpUtil.getString(Api.token,"");
    if(checkLogin && token.isEmpty){
      toLoginPage();
      return;
    }

    Application.router.navigateTo(context, path, clearStack: clearStack,
        replace: replace, routeSettings: RouteSettings(arguments: params)
    ).then((value){
        if(onTapCallback != null) {
          onTapCallback();
        }
    });
  }

  // pop
  static pop(BuildContext context) => Application.router.pop(context);

  // 
  static Map<String, dynamic> getParams(BuildContext context) {
    var result = ModalRoute.of(context)?.settings.arguments;
    if (result == null) return {};
    return result as Map<String, dynamic>;
  }

  // ，token，context
  static toLoginPage({
    bool replace = false,
    bool clearStack = false}) {

    Route route = Right2LeftRouter(child: LoginPage());
    if(clearStack){
      Application.navGK.currentState?.pushAndRemoveUntil(route, (route) => false);
    }else{
      replace
          ? Application.navGK.currentState?.pushReplacement(route)
          : Application.navGK.currentState?.push(route);
    }
  }

}

///
//--->
class Right2LeftRouter<T> extends PageRouteBuilder<T> {
  Widget? child;
  int duration_ms;
  Curve curve;

  Right2LeftRouter(
      {this.child, this.duration_ms = 250, this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: duration_ms),
            pageBuilder: (ctx, a1, a2) {
              return child!;
            },
            transitionsBuilder: (
              ctx,
              a1,
              a2,
              Widget child,
            ) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  ).animate(
                    CurvedAnimation(parent: a1, curve: curve),
                  ),
                  child: child);
            });
}
