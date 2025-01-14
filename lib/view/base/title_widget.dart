import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function? onTap;
  
  const TitleWidget({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: Text(title,
            style: newstyleAS.copyWith(fontSize: Dimensions.fontSizeLarge)),
      ),
      (onTap != null && !ResponsiveHelper.isDesktop(context))
          ? InkWell(
              onTap: onTap as void Function()?,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Text(
                  'view_all'.tr,
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Color(0XffF6AC90)),
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
