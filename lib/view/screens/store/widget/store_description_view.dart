import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/store_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/controller/wishlist_controller.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/data/model/response/store_model.dart';
import 'package:farmacie_stilo/helper/price_converter.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_image.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreDescriptionView extends StatelessWidget {
  final Store? store;
  const StoreDescriptionView({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAvailable = Get.find<StoreController>() .isStoreOpenNow(store!.active!, store!.schedules);
    Color? textColor =
        ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    return Column(children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          child: Stack(children: [
            CustomImage(
              image:
                  '${Get.find<SplashController>().configModel!.baseUrls!.storeImageUrl}/${store!.logo}',
              height: ResponsiveHelper.isDesktop(context) ? 80 : 60,
              width: ResponsiveHelper.isDesktop(context) ? 100 : 70,
              fit: BoxFit.cover,
            ),
            isAvailable
                ? const SizedBox()
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(Dimensions.radiusSmall)),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Text(
                        'closed_now'.tr,
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ),
          ]),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
                child: Text(
              store!.name!,
              style: newstyleAS.copyWith(
                  fontSize: Dimensions.fontSizeLarge, color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            ResponsiveHelper.isDesktop(context)
                ? InkWell(
                    onTap: () => Get.toNamed(
                        RouteHelper.getSearchStoreItemRoute(store!.id)),
                    child: ResponsiveHelper.isDesktop(context)
                        ? Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusDefault),
                                color: Theme.of(context).primaryColor),
                            child: const Center(
                                child: Icon(Icons.search, color: Colors.white)),
                          )
                        : Icon(Icons.search,
                            color: Theme.of(context).primaryColor),
                  )
                : const SizedBox(),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            GetBuilder<WishListController>(builder: (wishController) {
              bool isWished =
                  wishController.wishStoreIdList.contains(store!.id);
              return InkWell(
                onTap: () {
                  if (Get.find<AuthController>().isLoggedIn()) {
                    isWished
                        ? wishController.removeFromWishList(store!.id, true)
                        : wishController.addToWishList(null, store, true);
                  } else {
                    showCustomSnackBar('you_are_not_logged_in'.tr);
                  }
                },
                child: ResponsiveHelper.isDesktop(context)
                    ? Container(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                            child: Icon(
                                isWished
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white)),
                      )
                    : Icon(
                        isWished ? Icons.favorite : Icons.favorite_border,
                        color: isWished
                            ? Theme.of(context).primaryColor
                            : Color(0xffF6AC90),
                      ),
              );
            }),
          ]),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            store!.address ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Color(0xff1a3922)),
          ),
          SizedBox(
              height: ResponsiveHelper.isDesktop(context)
                  ? Dimensions.paddingSizeExtraSmall
                  : 0),
          Row(children: [
            Text('minimum_order'.tr,
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Color(0xff1a3922),
                )),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text(
              PriceConverter.convertPrice(store!.minimumOrder),
              textDirection: TextDirection.ltr,
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Color(0xff1a3922)),
            ),
          ]),
        ])),
      ]),
      SizedBox(
          height: ResponsiveHelper.isDesktop(context)
              ? 30
              : Dimensions.paddingSizeSmall),
      Row(children: [
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getStoreReviewRoute(store!.id)),
          child: Column(children: [
            Row(children: [
              Icon(Icons.star, color: Color(0xffA4A4A4), size: 20),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Text(
                store!.avgRating!.toStringAsFixed(1),
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: Color(0xff1a3922),)
              ),
            ]),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text(
              '${store!.ratingCount} ${'ratings'.tr}',
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall, color: Color(0xff1a3922)),
            ),
          ]),
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getMapRoute(
            AddressModel(
              id: store!.id,
              address: store!.address,
              latitude: store!.latitude,
              longitude: store!.longitude,
              contactPersonNumber: '',
              contactPersonName: '',
              addressType: '',
            ),
            'store',
          )),
          child: Column(children: [
            Icon(Icons.location_on,
                color: Color(0xffA4A4A4), size: 20),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text('location'.tr,
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: Color(0xff1a3922))),
          ]),
        ),
        const Expanded(child: SizedBox()),
        // Column(children: [
        //   Row(children: [
        //     Icon(Icons.timer,  color: Color(0xffA4A4A4), size: 20),
        //     const SizedBox(width: Dimensions.paddingSizeExtraSmall),
        //     Text(
        //       store!.deliveryTime!,
        //       style: robotoMedium.copyWith(
        //           fontSize: Dimensions.fontSizeSmall, color: Color(0xff1a3922)),
        //     ),
        //   ]),
        //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
        //   Text('delivery_time'.tr,
        //       style: robotoRegular.copyWith(
        //           fontSize: Dimensions.fontSizeSmall, color: Color(0xff1a3922) )),
        // ]),
        // (store!.delivery! && store!.freeDelivery!)
        //     ? const Expanded(child: SizedBox())
        //     : const SizedBox(),
        // (store!.delivery! && store!.freeDelivery!)
        //     ? Column(children: [
        //         Icon(Icons.money_off,
        //             color: Theme.of(context).primaryColor, size: 20),
        //         const SizedBox(width: Dimensions.paddingSizeExtraSmall),
        //         Text('free_delivery'.tr,
        //             style: robotoRegular.copyWith(
        //                 fontSize: Dimensions.fontSizeSmall, color: Color(0xff1a3922))),
        //       ])
        //     : const SizedBox(),
        const Expanded(child: SizedBox()),
      ]),
    ]);
  }
}
