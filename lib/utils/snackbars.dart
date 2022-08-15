import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wpims/utils/constants/colors.dart';


// ScaffoldFeatureController ShowSuccessMsg(String message){
//   return ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor: myPrimaryColorDark,
//       duration: const Duration(seconds: 3),
//
//     ),
//   );
// }

ScaffoldFeatureController ShowHintMsg({required BuildContext context, required String message, int duration=4}){
  hideCurrentSnackbar(context);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18
        ),
      ),
      backgroundColor: textColorPrimary.withOpacity(.1),
      duration: Duration(seconds: duration),

    ),
  );
}

ScaffoldFeatureController ShowInfoMsg({required BuildContext context, required String message, int duration=4}){
  hideCurrentSnackbar(context);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            fontSize: 18
        ),
      ),
      backgroundColor: colorPrimary,
      duration: Duration(seconds: duration),

    ),
  );
}

ScaffoldFeatureController ShowWarningMsg({required BuildContext context, required String message, int duration=4}){
  hideCurrentSnackbar(context);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            fontSize: 18
        ),
      ),
      backgroundColor: Colors.amber,
      duration: Duration(seconds: duration),

    ),
  );
}

ScaffoldFeatureController ShowSuccessMsg({required BuildContext context, required String message, int duration=4}){
  hideCurrentSnackbar(context);
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 18
        ),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: duration),

    ),
  );
}

ScaffoldFeatureController ShowProcessinggMsg({required BuildContext context, required String message, int duration=4}){
  hideCurrentSnackbar(context);
  final size=MediaQuery.of(context).size;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
          width: size.width,
          child:  Row(
            children: [
              SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator()
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            ],
          )
      ),
      backgroundColor: Colors.amber,
      duration: Duration(minutes: duration),

    ),
  );
}


void hideCurrentSnackbar(BuildContext context){
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

void toastMsg(String type, String msg){
  Get.snackbar(
      type,msg,
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
    colorText: colorPrimary,
    margin: EdgeInsets.only(bottom: 100.0),
  );
}

