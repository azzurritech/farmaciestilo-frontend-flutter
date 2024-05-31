import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/util/styles.dart';

void showCustomSnackBar(String? message,
    {bool isError = true, bool getXSnackBar = false}) {
  if (message != null && message.isNotEmpty) {
    if (getXSnackBar) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: isError ? Color(0xffA4A4A4): Color(0xffFCDDD3),
        message: message,
        maxWidth: Dimensions.webMaxWidth,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        borderRadius: Dimensions.radiusSmall,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ));
    } else {
     ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      elevation: 0,
  dismissDirection: DismissDirection.horizontal,
  margin: EdgeInsets.only(
    right: ResponsiveHelper.isDesktop(Get.context)
        ? Get.context!.width * 0.7
        : Dimensions.paddingSizeSmall,
    top: Dimensions.paddingSizeSmall,
    bottom: Dimensions.paddingSizeSmall,
    left: Dimensions.paddingSizeSmall,
  ),
  duration: const Duration(seconds: 3),
  backgroundColor: isError ? Color(0xffF3E9D5): Color(0xffFCDDD3),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
  ),
  content: Center(child: Text(message, style: robotoMedium.copyWith(color: Colors.grey))),
));

    }
  }
}
