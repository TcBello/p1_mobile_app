import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showShort(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
  }

  static void showLong(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }
}
