import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homecredit/index.dart';
import 'package:homecredit/page/GuidePage.dart';
import 'package:homecredit/page/SplashPage.dart';
import 'package:homecredit/provider/current_locale.dart';
import 'package:homecredit/res/colors.dart';
import 'package:homecredit/utils/RouteObserver.dart';
import 'package:homecredit/utils/color.dart';
import 'package:homecredit/utils/debounce.dart';
import 'package:provider/provider.dart';

import 'application.dart';
import 'arch/api/log.dart';
import 'arch/api/log_util.dart';
import 'generated/l10n.dart';
import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();///

  //  fluro routes
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  Debounce.lastPopTime = DateTime.now();

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  LogUtil.platformLog(optType:PointLog.SYSTEM_INIT_OPEN_13(),mul : false);

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => CurrentLocale())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyRouteObserver<PageRoute> routeObserver = MyRouteObserver<PageRoute>();

    return Consumer<CurrentLocale>(
      builder: (context, currentLocale, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EasyLoan',
          // locale: Locale.fromSubtags(languageCode: 'en'),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          locale: currentLocale.value,
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
            primarySwatch: createMaterialColor(HcColors.color_02B17B),
          ),
          navigatorKey: Application.navGK,
          onGenerateRoute: Application.router.generator,
          builder: EasyLoading.init(),
          home: SplashPage(),
          navigatorObservers: [routeObserver],
        );
      },
    );
  }
}

