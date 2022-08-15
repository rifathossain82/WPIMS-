import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/widgets/texts.dart';

Widget addVerticalSpace(double space) {
  return SizedBox(height: space);
}

Widget addHorizontalSpace(double space) {
  return SizedBox(width: space);
}

Widget addHorizontalDivider({double? height, double? thickness}) {
  return Divider(
    height: height,
    color: Colors.grey.withOpacity(0.5),
    thickness: thickness,
  );
}

Widget noData(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(Icons.cloud_off, color: colorPrimary.withOpacity(0.60), size: 100.0,),
      hintText(
          'No data found',
          color: textGrey
      )
    ],
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.blueAccent,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    boxShadow: const [
      BoxShadow(
        color: shadowColor,
        blurRadius: 4.0,
        spreadRadius: 1.0,
        offset: Offset(0.0, 0.0),
      )
    ],
    border: Border.all(color: color),
  );
}
