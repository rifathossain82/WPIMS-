import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wpims/utils/constants/colors.dart';

selectDate({
 required BuildContext context,
  required DateTime initialDate,
  required allowedDays
}) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2010),
    lastDate: DateTime(2025),
    selectableDayPredicate: allowedDays,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: colorPrimary, // header background color
            onPrimary: textLight, // header text color
            onSurface: textPrimaryDark, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: colorPrimary, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return selected;
}