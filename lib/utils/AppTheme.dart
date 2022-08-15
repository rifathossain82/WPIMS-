import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wpims/utils/constants/colors.dart';


class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: layoutBglight,
    primaryColor: appColorPrimary,
    primaryColorDark: appColorPrimary,
    errorColor: Colors.red,
    hoverColor: Colors.white54,
    dividerColor: const Color(0xFFEAEAEA),
    // fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: const AppBarTheme(
      color: appLayout_background,
      iconTheme: IconThemeData(color: textLight),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    // textTheme: GoogleFonts.montserratTextTheme(),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: textDark),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      // hintStyle: primaryTextStyle(),
      filled: true,
      fillColor: bgLight,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: bgLight, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: bgLight, width: 0.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
      errorStyle: const TextStyle(
        fontSize: 16.0,
      )
    ),
    colorScheme: const ColorScheme.light(primary: appColorPrimary, primaryVariant: appColorPrimary),
    cardTheme: const CardTheme(color: bgLight),
    cardColor: bgLight,
    iconTheme: const IconThemeData(color: textLight),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: bgLight
    ),
    // textTheme: TextTheme(
    //   button: TextStyle(color: appColorPrimary),
    //   headline6: TextStyle(color: textPrimaryColor),
    //   subtitle2: TextStyle(color: textSecondaryColor),
    // ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    highlightColor: appBackgroundColorDark,
    errorColor: const Color(0xFFCF6676),
    appBarTheme: const AppBarTheme(
      color: appBackgroundColorDark,
      iconTheme: IconThemeData(color: bgDark),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: color_primary_black,
    dividerColor: const Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: color_primary_black,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      // hintStyle: primaryTextStyle(),
      filled: true,
      fillColor: bgDark,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: bgDark, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: bgDark, width: 0.0),
      ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(
          fontSize: 16.0,
        )
    ),
    hoverColor: Colors.black12,
    // fontFamily: GoogleFonts.openSans().fontFamily,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    primaryTextTheme: const TextTheme(headline6: TextStyle(color: textLight), overline: TextStyle(color: textLight)),
    // primaryTextTheme: TextTheme(headline6: primaryTextStyle(color: Colors.white), overline: primaryTextStyle(color: Colors.white)),
    cardTheme: const CardTheme(color: cardBackgroundBlackDark),
    cardColor: layoutBgDark,
    iconTheme: const IconThemeData(color: textLight),
    textTheme: const TextTheme(
      button: TextStyle(color: color_primary_black),
      headline6: TextStyle(color: textLight),
      subtitle2: TextStyle(color: Colors.white54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(primary: appBackgroundColorDark, onPrimary: cardBackgroundBlackDark, primaryVariant: color_primary_black).copyWith(secondary: textLight),
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );
}
