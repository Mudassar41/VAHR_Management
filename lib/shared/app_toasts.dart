import 'package:expense_trackr/shared/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToasts {
  static showToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.whiteColor,
        fontSize: 14.0);
  }
}
