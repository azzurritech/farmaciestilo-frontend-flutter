import 'package:farmacie_stilo/controller/order_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/screens/checkout/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentFailedDialog extends StatefulWidget {
  final String? orderID;
  final String? orderType;
  final double? orderAmount;
  final double? maxCodOrderAmount;
  final bool? isCashOnDelivery;
  const PaymentFailedDialog(
      {Key? key,
      required this.orderID,
      required this.maxCodOrderAmount,
      required this.orderAmount,
      required this.orderType,
      required this.isCashOnDelivery})
      : super(key: key);

  @override
  State<PaymentFailedDialog> createState() => _PaymentFailedDialogState();
}

class _PaymentFailedDialogState extends State<PaymentFailedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Image.asset(Images.warning, width: 70, height: 70),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge),
                child: Text(
                  'are_you_agree_with_this_order_fail'.tr,
                  textAlign: TextAlign.center,
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Text(
                  'if_you_do_not_pay'.tr,
                  style:
                      robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              GetBuilder<OrderController>(builder: (orderController) {
                return !orderController.isLoading
                    ? Column(children: [
                        widget.isCashOnDelivery!
                            ?const SizedBox()
                            //  CustomButton(
                            //     buttonText: 'switch_to_cash_on_delivery'.tr,
                            //     onPressed: () {
                            //       if ((((maxCodOrderAmount != null &&
                            //                       orderAmount! <
                            //                           maxCodOrderAmount!) ||
                            //                   maxCodOrderAmount == null ||
                            //                   maxCodOrderAmount == 0) &&
                            //               orderType != 'parcel') ||
                            //           orderType == 'parcel') {
                            //         orderController.switchToCOD(orderID);
                            //       } else {
                            //         if (Get.isDialogOpen!) {
                            //           Get.back();
                            //         }
                            //         showCustomSnackBar(
                            //             '${'you_cant_order_more_then'.tr} ${PriceConverter.convertPrice(maxCodOrderAmount)} ${'in_cash_on_delivery'.tr}');
                            //       }
                            //     },
                            //     radius: Dimensions.radiusSmall,
                            //     height: 40,
                            //   )
                            : const SizedBox(),
                        SizedBox(
                            width: Get.find<SplashController>()
                                    .configModel!
                                    .cashOnDelivery!
                                ? Dimensions.paddingSizeLarge
                                : 0),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              state=0;
                            });
                            Get.find<OrderController>()
                                .cancelOrder(int.parse(widget.orderID!),
                                    'Digital payment issue')
                                .then((success) {
                              if (success) {
                                Get.offAllNamed(RouteHelper.getInitialRoute());
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.3),
                            minimumSize: const Size(Dimensions.webMaxWidth, 40),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall)),
                          ),
                          child: Text('cancel_order'.tr,
                              textAlign: TextAlign.center,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color)),
                        ),
                      ])
                    : const Center(child: CircularProgressIndicator());
              }),
            ]),
          )),
    );
  }
}
