import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';


Widget topHeading(String label,{
  fontSize=fontSizeXl,
  lineHeight=1.5,
  color=textColorPrimary,
  fontWeight=FontWeight.normal,
  textAlign=TextAlign.center,
  maxLines=1
}){
  return Text(
    label,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontSize:fontSize,
        height:lineHeight,
        color:color,
        fontWeight:fontWeight,
    ),
  );
}

Widget subHeading(String label,{
  fontSize=fontSizeMd,
  lineHeight=1.5,
  color=textColorPrimary,
  fontWeight=FontWeight.bold,
  textAlign=TextAlign.center,
  maxLines=1,
  softWrap=false
}){
  return Text(
    label,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    softWrap: softWrap,
    style: TextStyle(
        fontSize:fontSize,
        height:lineHeight,
        color:color,
        fontWeight:fontWeight,
    ),
  );
}

Widget rowHeading(String label,{
  fontSize=fontSizeMd,
  lineHeight=1.5,
  color=textColorPrimary,
  fontWeight=FontWeight.bold,
  textAlign=TextAlign.center,
  maxLines=1
}){
  return Text(
    label,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize:fontSize,
      height:lineHeight,
      color:color,
      fontWeight:fontWeight,
    ),
  );
}

Widget bodyTextNormal(String label,{
  fontSize=fontSizeMd,
  lineHeight=1.2,
  color=textColorPrimary,
  fontWeight=FontWeight.normal,
  textAlign=TextAlign.left,
}){
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
      fontSize:fontSize,
      height:lineHeight,
      color:color,
      fontWeight:fontWeight,
    ),
  );
}

Widget tableTextHeading(String label,{
  fontSize=fontSizeSm,
  lineHeight=1.2,
  color=textColorPrimary,
  fontWeight=FontWeight.bold,
  textAlign=TextAlign.center,
}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
    child: AutoSizeText(
      label,
      textAlign: textAlign,
      maxLines: 1,
      style: TextStyle(
        fontSize:fontSize,
        height:lineHeight,
        color:color,
        fontWeight:fontWeight,
      ),
    ),
  );
}

Widget tableTextBody(String label,{
  fontSize=fontSizeSm,
  // lineHeight=1.5,
  color=textColorPrimary,
  fontWeight=FontWeight.normal,
  textAlign=TextAlign.center,
  verticalPadding=2.0,
  horizontalPadding=2.0
}){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
    child: Text(
      label,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:fontSize,
        // height:lineHeight,
        color:color,
        fontWeight:fontWeight,
      ),
    ),
  );
}

Widget hintText(String label,{
  fontSize=fontSizeSm,
  lineHeight=1.2,
  color=textColorPrimary,
  fontWeight=FontWeight.normal,
  textAlign=TextAlign.left,
}){
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
      fontSize:fontSize,
      height:lineHeight,
      color:color,
      fontWeight:fontWeight,
    ),
  );
}

Widget bodyTextOverflow(String label,{
  fontSize=fontSizeMd,
  lineHeight=1.2,
  color=textColorPrimary,
  fontWeight=FontWeight.normal,
  textAlign=TextAlign.left,
  maxLine=1,
  overflow=TextOverflow.ellipsis
}){
  return Text(
    label,
    textAlign: textAlign,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize:fontSize,
      height:lineHeight,
      color:color,
      fontWeight:fontWeight,
    ),
  );
}