import 'package:farmacie_stilo/controller/order_controller.dart';
import 'package:farmacie_stilo/helper/price_converter.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  final double? total;
  final double? charge;
  final bool? isFree;
  const DeliveryOptionButton(
      {Key? key,
      required this.value,
      required this.title,
      this.total,
      required this.charge,
      required this.isFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        return InkWell(
          onTap: () => orderController.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: orderController.orderType,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (String? value) =>
                    orderController.setOrderType(value),
                activeColor: Color(0xffA4A4A4),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text(title, style: robotoRegular),
              const SizedBox(width: 5),
              Text(
                '(${(value == ' take_away' || isFree!) ? 'free'.tr : orderController.orderType == "delivery" && total! > 59.00 ? 0.00 : PriceConverter.convertPrice(charge)})',
                style: robotoMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
