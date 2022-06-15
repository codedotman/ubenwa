import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

// Colors
const Color ubPrimaryColor = Color(0xffF9923B);
const Color ubBackgroundColor = Color(0xffFFFBF8);
const Color navy1Color = Color(0xff577DEF);
const Color navy4Color = Color(0xffC7D4FA);
const Color navy5Color = Color(0xffECF0FE);
const Color whiteColor = Colors.white;

const Color grayColor = Color(0xffE6E6E6);
const Color deepDarkBlueColor = Color(0xff384571);

const Color gray8Color = Color(0xffF5F5F5);
const Color gray1Color = Color(0xff3D3D3D);
const Color gray3Color = Color(0xff707070);
const Color gray5Color = Color(0xffb8b8b8);
const Color grayBlackColor = Color(0xff212121);

// Spacing
double kPadding = 5.h;
double kSmallPadding = 10.h;
double kRegularPadding = 15.h;
double kMediumPadding = 20.h;
double kExtraMediumPadding = 30.h;
double kLargePadding = 40.h;
double kFullPadding = 60.h;
double kExtraFullPadding = 70.h;

double kWidthRatio = 0.9.h;
double kIconSize = 24;
double kCalculatedWidth(Size size) => size.width * kWidthRatio;
double kCalculatedMargin(Size size) => size.width * (1 - kWidthRatio) / 2;

// Text
TextStyle kHeadline1TextStyle = TextStyle(
  fontSize: 30.sp,
  fontWeight: FontWeight.bold,
  color: gray1Color,
);
TextStyle kHeadline2TextStyle = TextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
  color: gray1Color,
);
TextStyle kHeadline3TextStyle = TextStyle(
  fontSize: 22.sp,
  fontWeight: FontWeight.w500,
  color: gray1Color,
);
TextStyle kBodyText1Style = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: gray1Color,
);
TextStyle kBodyText2Style = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.normal,
  color: gray1Color,
);
TextStyle kSubtitle1Style = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.normal,
  color: gray1Color,
);
TextStyle kSubtitle2Style = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w300,
  color: gray1Color,
);

// Theme
final ThemeData kThemeData = ThemeData.light().copyWith(
    primaryColor: ubPrimaryColor,
    scaffoldBackgroundColor: whiteColor,
    dividerColor: gray8Color,
    canvasColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: whiteColor,
      brightness: Brightness.light,
      elevation: 0,
      textTheme: TextTheme(
        headline1: kHeadline1TextStyle,
        headline2: kHeadline2TextStyle,
        headline3: kHeadline3TextStyle,
        bodyText1: kBodyText1Style,
        bodyText2: kBodyText2Style,
        subtitle1: kSubtitle1Style,
        subtitle2: kSubtitle2Style,
      ),
      iconTheme: IconThemeData(size: kIconSize, color: const Color(0xff2C3E50)),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(size: kIconSize),
    textTheme: TextTheme(
      headline1: kHeadline1TextStyle,
      headline2: kHeadline2TextStyle,
      headline3: kHeadline3TextStyle,
      bodyText1: kBodyText1Style,
      bodyText2: kBodyText2Style,
      subtitle1: kSubtitle1Style,
      subtitle2: kSubtitle2Style,
    ));

bool isEmpty(String? s) => s == null || s == 'null' || s.trim().isEmpty;
