import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/controller/order_controller.dart';
import 'package:farmacie_stilo/data/model/response/order_model.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/screens/order/order_details_screen.dart';

class RunningOrderViewWidget extends StatelessWidget {
  final List<OrderModel> reversOrder;
  const RunningOrderViewWidget({Key? key, required this.reversOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xffC3DFEA),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.paddingSizeExtraLarge),
              topRight: Radius.circular(Dimensions.paddingSizeExtraLarge),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!,
                  offset: const Offset(0, -5),
                  blurRadius: 10)
            ]),
        child: Column(children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
            ),
          ),
          ListView.builder(
              itemCount: reversOrder.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                bool isFirstOrder = index == 0;

                String? orderStatus = reversOrder[index].orderStatus;
                int status = 0;

                if (orderStatus == AppConstants.pending) {
                  status = 1;
                } else if (orderStatus == AppConstants.accepted ||
                    orderStatus == AppConstants.processing ||
                    orderStatus == AppConstants.confirmed) {
                  status = 2;
                } else if (orderStatus == AppConstants.handover ||
                    orderStatus == AppConstants.pickedUp) {
                  status = 3;
                }

                return InkWell(
                  onTap: () async {
                    await Get.toNamed(
                      RouteHelper.getOrderDetailsRoute(reversOrder[index].id),
                      arguments: OrderDetailsScreen(
                        orderId: reversOrder[index].id,
                        orderModel: reversOrder[index],
                      ),
                    );
                    if (orderController.showBottomSheet) {
                      orderController.showRunningOrders();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeExtraSmall,
                        top: Dimensions.paddingSizeSmall),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Center(
                            //   child: SizedBox(
                            //     height: orderStatus == AppConstants.pending
                            //         ? 50
                            //         : 60,
                            //     width: orderStatus == AppConstants.pending
                            //         ? 50
                            //         : 60,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Image.asset(
                                    
                            //           status == 2
                            //               ? orderStatus ==
                            //                           AppConstants.confirmed ||
                            //                       orderStatus ==
                            //                           AppConstants.accepted
                            //                   ? Images.confirmedGif
                            //                   : Images.processingGif
                            //               : status == 3
                            //                   ? orderStatus ==
                            //                           AppConstants.handover
                            //                       ? Images.handoverGif
                            //                       : Images.onTheWayGif
                            //                   : Images.pendingGif,
                            //           height: 60,
                            //           width: 60,
                                      
                            //           fit: BoxFit.fill),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                                width: isFirstOrder
                                    ? 0
                                    : Dimensions.paddingSizeSmall),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: isFirstOrder
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: isFirstOrder
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment: isFirstOrder
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.start,
                                        children: [
                                          Text('${'your_order_is'.tr} ',
                                              style: TextStyle(
   color:  Colors.white,
 fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
)),
                                          Text(
                                              reversOrder[index]
                                                  .orderStatus!
                                                  .tr,
                                              style: TextStyle(
         color: Color(0xffA4A4A4),
 fontFamily: 'LM Sans 10',
  // fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
)

                                              
                                              
                                              //  robotoBold.copyWith(
                                              //     fontSize: Dimensions
                                              //         .fontSizeDefault,
                                              //     // color: Theme.of(context)
                                              //     //     .primaryColor
                                              //         color: Color(0xffA4A4A4)
                                              //         )
                                                      ),
                                        ]),
                                    const SizedBox(
                                        height:
                                            Dimensions.paddingSizeExtraSmall),
                                    Text(
                                      '${'order'.tr} #${reversOrder[index].id}',
                                      style: robotoRegular.copyWith(
                                        color: Colors.white,
                                          fontSize: Dimensions.fontSizeSmall),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    isFirstOrder
                                        ? SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .paddingSizeDefault,
                                                      vertical: Dimensions
                                                          .paddingSizeSmall),
                                              child: Row(children: [
                                                Expanded(
                                                    child: trackView(context,
                                                        status: status >= 1
                                                            ? true
                                                            : false)),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Expanded(
                                                    child: trackView(context,
                                                        status: status >= 2
                                                            ? true
                                                            : false)),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Expanded(
                                                    child: trackView(context,
                                                        status: status >= 3
                                                            ? true
                                                            : false)),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Expanded(
                                                    child: trackView(context,
                                                        status: status >= 4
                                                            ? true
                                                            : false)),
                                              ]),
                                            ),
                                          )
                                        : const SizedBox()
                                  ]),
                            ),
                            Container(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 227, 222, 222),
                                  shape: BoxShape.circle),
                              child: isFirstOrder
                                  ? !(reversOrder.length < 2)
                                      ? InkWell(
                                          onTap: () => Get.toNamed(
                                              RouteHelper.getOrderRoute()),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '+${reversOrder.length - 1}',
                                                    style: robotoBold.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeLarge,color: Colors.white
                                                        // color: Theme.of(context)
                                                        //     .primaryColor
                                                            )
                                                            
                                                            ),
                                                Text('more'.tr,
                                                    style: TextStyle(
   color:  Colors.white,
 fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
)),
                                            ]),
                                        )
                                      : const Icon(Icons.arrow_forward,
                                          size: 18,
                                          color: Colors.white)
                                  : const Icon(Icons.arrow_forward,
                                      size: 18,
                                     color: Colors.white,
                                     
                                     ),
                            ),
                          ]),
                    ),
                  ),
                );
              }),
        ]),
      );
    });
  }

  Widget trackView(BuildContext context, {required bool status}) {
    return Container(
        height: 5,
        decoration: BoxDecoration(
            color: status
                ? Color(0xffBEDEC5)
                : Theme.of(context).disabledColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
            )
            
            );
  }
}
