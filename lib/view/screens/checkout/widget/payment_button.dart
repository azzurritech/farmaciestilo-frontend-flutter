import 'package:farmacie_stilo/controller/order_controller.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentButton extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final Function onTap;
  const PaymentButton(
      {Key? key,
      required this.isSelected,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
        child: InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                    blurRadius: 5,
                    spreadRadius: 1)
              ],
            ),
            child: ListTile(
              leading: Image.asset(
                icon,
                width: 40,
                height: 40,
                color: isSelected
                    ? Color(0xff1a3922)
                    : Theme.of(context).disabledColor,
              ),
              title: Text(
                title,
                style:
                    robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
              // subtitle: Text(
              //   subtitle,
              //   style: robotoRegular.copyWith(
              //       fontSize: Dimensions.fontSizeExtraSmall,
              //       color: Theme.of(context).disabledColor),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
              trailing: isSelected
                  ? Icon(Icons.check_circle,
                      color: Color(0xffA4A4A4))
                  : null,
            ),
         ),
        ),
      );
    });
  }
}
