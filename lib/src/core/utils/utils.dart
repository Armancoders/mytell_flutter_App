import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../theme/color_theme.dart';

var spinKitButton = SpinKitThreeBounce(
  color: Colors.white,
  size: Get.width * .06,
);
var spinKitButtonPrimary = SpinKitThreeBounce(
  color: primaryColor,
  size: Get.width * .06,
);

var spinKitPage = SpinKitThreeBounce(
  color: primaryColor,
  size: Get.width * .08,
);

var spinKitSection = SpinKitThreeBounce(
  color: muteColor,
  size: Get.width * .05,
);

var spinKitLink = SpinKitThreeBounce(
  color: textColor,
  size: Get.width * .03,
);