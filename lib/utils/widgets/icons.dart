import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';

Widget iconText({
  required IconData icon,
  required String label,
  Color? color=textColorSecondary,
  double? size=15,
  FontWeight fontWeight=FontWeight.bold
}){
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 4.0,
    children: [
      Icon(icon, color: textDark,size: size,),
      Text(
        label,
        style: TextStyle(
          fontSize:size,
          color:color,
          fontWeight:fontWeight,
        ),
      )
    ],
  );
}

Widget iconImageLocal(String path, {
  double width=25.0,
}){
  return Image.asset(
      path,
      width: width,
      fit: BoxFit.cover
  );
}