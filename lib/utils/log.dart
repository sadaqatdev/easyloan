
import 'package:alog/alog.dart';

class HLog{

  static debug(dynamic msg){
    ALog(msg,mode: ALogMode.debug);
  }

  static error(dynamic msg){
    ALog(msg,mode: ALogMode.error);
  }

  static warning(dynamic msg){
    ALog(msg,mode: ALogMode.warning);
  }

  static info(dynamic msg){
    ALog(msg,mode: ALogMode.info);
  }

}