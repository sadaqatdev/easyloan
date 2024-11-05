

class Debounce {
  static var lastPopTime = DateTime.now();

  // 
  static bool checkClick({int milliseconds = 800}) {
    print('-------------DateTime.now()--------------------');
    print(lastPopTime);
    print(DateTime.now());
    if (lastPopTime == null ||
        DateTime.now().difference(lastPopTime) > Duration(milliseconds: milliseconds)) {
      lastPopTime = DateTime.now();
      return true;
    }
    return false;
  }
}
