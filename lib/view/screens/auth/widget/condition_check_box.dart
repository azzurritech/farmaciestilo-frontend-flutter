import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConditionCheckBox extends StatelessWidget {
  final AuthController authController;
  const ConditionCheckBox({Key? key, required this.authController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
            side: const BorderSide(color: Color(0xffA4A4A4)),
            activeColor:     const Color(0xffA4A4A4),
        // activeColor: Theme.of(context).primaryColor,
        value: authController.acceptTerms,
        onChanged: (bool? isChecked) => authController.toggleTerms(),
      ),
      Flexible(child: Text('i_agree_with'.tr, style: robotoRegulars)),
      InkWell(
        onTap: () =>
            Get.toNamed(RouteHelper.getotherHtmlRoute('terms-and-condition')),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Text('terms_conditions'.tr,
              style: robotoMedium.copyWith(color:   const Color(0xffA4A4A4) ,fontFamily: 'LM Sans 10',)),
        ),
      ),
    ]);
  }
}



class ConditionCheckBoxNew extends StatelessWidget {
  final AuthController authController;
  const ConditionCheckBoxNew({Key? key, required this.authController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
            side: const BorderSide(color: Color(0xffA4A4A4)),
            activeColor:     const Color(0xffA4A4A4),
        // activeColor: Theme.of(context).primaryColor,
        value: authController.termsnew,
        onChanged: (bool? isChecked) => authController.toggleTermsnew(),
      ),
      Flexible(child: Text('newtext'.tr, style: robotoRegulars)),
      // InkWell(
      //   onTap: () =>
      //       Get.toNamed(RouteHelper.getotherHtmlRoute('terms-and-condition')),
      //   child: Padding(
      //     padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      //     child: Text('terms_conditions'.tr,
      //         style: robotoMedium.copyWith(color:   Color(0xffA4A4A4) ,fontFamily: 'LM Sans 10',)),
      //   ),
      // ),
    ]);
  }
}
