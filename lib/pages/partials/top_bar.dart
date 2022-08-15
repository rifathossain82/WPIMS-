import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';

PreferredSizeWidget topBar({String title='WPIMS',isCentered=false}){
  return AppBar(
    centerTitle: isCentered,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    backgroundColor: colorPrimary,
    foregroundColor: colorSecondary,
    elevation: 0,


  );
}

