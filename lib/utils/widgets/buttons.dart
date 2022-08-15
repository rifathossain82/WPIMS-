import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/widgets/texts.dart';

Widget submitButton({
  required String label,
  required Function onPressed,
  required bool btnLoading,
  double padding =16.0
}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        elevation: 4,
        primary: colorPrimary,
        textStyle: const TextStyle(color: textLight)),
    onPressed: (){
      onPressed();
    },
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(80.0)),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: btnLoading?const SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              color: textPrimaryDark,

            ),
          ):Text(
            label,
            style: const TextStyle(color: textLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget elevatedButton({
  required Function onPressed,
  required String label,
  required double width,
  double padding=15,
  Color bgColor=colorPrimary,
  Color textColor=textLight,
  bool? btnLoading,
}){
  return SizedBox(
    width:width,
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            colorPrimary,
          ),
          // foregroundColor: MaterialStateProperty.all(
          //   colorPrimary,
          // ),
          // overlayColor: MaterialStateProperty.all(
          //   Colors.red,
          // ),

          padding: MaterialStateProperty.all(
            EdgeInsets.all(padding),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(
                color: colorPrimary,
                width: 1.0,
              ),
            ),
          ),

        ),
      onPressed: ()=>onPressed(),
      child: btnLoading!=null && btnLoading?
          Center(child: SizedBox(
            width: 25.0,
            height: 25.0,
            child: CircularProgressIndicator(
              color: textPrimaryDark,
            ),
          ),):
      subHeading(label,color: textColor, maxLines: 3),
    ),
  );
}