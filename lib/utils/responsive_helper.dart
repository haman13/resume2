import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

// iPhone 11 Pro height as base
// iPhone 11 Pro width as base
    
    // تقسیم صفحه به 100 بلوک برای محاسبات نسبی
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
  
  // محاسبه عرض نسبی (براساس درصد)
  static double getProportionateScreenWidth(double inputWidth) {
    return blockSizeHorizontal * inputWidth;
  }
  
  // محاسبه ارتفاع نسبی (براساس درصد)
  static double getProportionateScreenHeight(double inputHeight) {
    return blockSizeVertical * inputHeight;
  }
  
  // محاسبه فونت نسبی
  static double getProportionateFontSize(double inputFontSize) {
    return blockSizeHorizontal * inputFontSize;
  }
  
  // محاسبه padding و margin نسبی
  static double getProportionateSpacing(double inputSpacing) {
    return blockSizeHorizontal * inputSpacing;
  }
  
  // تشخیص نوع دستگاه
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && 
           MediaQuery.of(context).size.width < 900;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }
  
  // محاسبه flex برای ستون‌ها
  static int getSideMenuFlex() {
    if (screenWidth < 600) return 1; // موبایل
    if (screenWidth < 900) return 2; // تبلت
    return 3; // دسکتاپ
  }
  
  static int getMainContentFlex() {
    if (screenWidth < 600) return 4; // موبایل
    if (screenWidth < 900) return 3; // تبلت
    return 7; // دسکتاپ
  }
  
  // محاسبه اندازه عکس پروفایل
  static double getProfileImageSize() {
    if (screenWidth < 600) return screenWidth * 0.25; // 25% of screen width
    if (screenWidth < 900) return screenWidth * 0.15; // 15% of screen width
    return 120; // ثابت برای دسکتاپ
  }
  
  // محاسبه padding های نسبی
  static EdgeInsets getProportionatePadding({
    double horizontal = 2.0,
    double vertical = 2.0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: getProportionateSpacing(horizontal),
      vertical: getProportionateSpacing(vertical),
    );
  }
  
  // محاسبه margin های نسبی
  static EdgeInsets getProportionateMargin({
    double horizontal = 2.0,
    double vertical = 2.0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: getProportionateSpacing(horizontal),
      vertical: getProportionateSpacing(vertical),
    );
  }
}
