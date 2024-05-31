import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/item_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/controller/wishlist_controller.dart';
import 'package:farmacie_stilo/data/model/response/config_model.dart';
import 'package:farmacie_stilo/data/model/response/item_model.dart';
import 'package:farmacie_stilo/data/model/response/module_model.dart';
import 'package:farmacie_stilo/data/model/response/store_model.dart';
import 'package:farmacie_stilo/helper/date_converter.dart';
import 'package:farmacie_stilo/helper/price_converter.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_image.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/base/discount_tag.dart';
import 'package:farmacie_stilo/view/base/not_available_widget.dart';
import 'package:farmacie_stilo/view/base/rating_bar.dart';
import 'package:farmacie_stilo/view/screens/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemWidget extends StatelessWidget {
  final Item? item;
  final Store? store;
  final bool isStore;
  final int index;
  final int? length;
  final bool inStore;
  final bool isCampaign;
  final bool isFeatured;
  const   ItemWidget(
      {Key? key,
      required this.item,
      required this.isStore,
      required this.store,
      required this.index,
      required this.length,
      this.inStore = false,
      this.isCampaign = false,
      this.isFeatured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseUrls? baseUrls = Get.find<SplashController>().configModel!.baseUrls;
    bool desktop = ResponsiveHelper.isDesktop(context);
    double? discount;
    String? discountType;
    bool isAvailable;
    if (isStore) {
      discount = store!.discount != null ? store!.discount!.discount : 0;
      discountType =
          store!.discount != null ? store!.discount!.discountType : 'percent';
      // bool _isClosedToday = Get.find<StoreController>().isRestaurantClosed(true, store.active, store.offDay);
      // _isAvailable = DateConverter.isAvailable(store.openingTime, store.closeingTime) && store.active && !_isClosedToday;
      isAvailable = store!.open == 1 && store!.active!;
    } else {
      discount = (item!.storeDiscount == 0 || isCampaign)
          ? item!.discount
          : item!.storeDiscount;
      discountType = (item!.storeDiscount == 0 || isCampaign)
          ? item!.discountType
          : 'percent';
      isAvailable = DateConverter.isAvailable(
          item!.availableTimeStarts, item!.availableTimeEnds);
    }

    return InkWell(
      onTap: () {
        if (isStore) {
          if (store != null ) {
            if (isFeatured && Get.find<SplashController>().moduleList != null) {
              for (ModuleModel module
                  in Get.find<SplashController>().moduleList!) {
                if (module.id == store!.moduleId) {
                  Get.find<SplashController>().setModule(module);
                  break;
                }
              }
            }
           
            Get.toNamed(
              RouteHelper.getStoreRoute(
                  store!.id, isFeatured ? 'module' : 'item'),
              arguments: StoreScreen(store: store, fromModule: isFeatured),
            );
          }
           

        } 
        else {
          if (isFeatured && Get.find<SplashController>().moduleList != null) {
            for (ModuleModel module
                in Get.find<SplashController>().moduleList!) {
              if (module.id == item!.moduleId) {
                Get.find<SplashController>().setModule(module);
                break;
              }
            }
          }
          Get.find<ItemController>().navigateToItemPage(item, context,
              inStore: inStore, isCampaign: isCampaign);
        }
      },





      child: Container(
            
        
        padding: ResponsiveHelper.isDesktop(context)
            ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
            : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: ResponsiveHelper.isDesktop(context)
              ? Theme.of(context).cardColor
              : Colors.white,
          boxShadow: ResponsiveHelper.isDesktop(context)
              ? [
                  BoxShadow( 
                    color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Row(children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    child: CustomImage(
                      image:
                          '${isCampaign ? baseUrls!.campaignImageUrl : isStore ? baseUrls!.storeImageUrl : baseUrls!.itemImageUrl}'
                          '/${isStore ? store != null ? store!.logo : '' : item!.image}',
                      height: desktop
                          ? 120
                          : length == null
                              ? 100
                              : 65,
                      width: desktop ? 120 : 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  DiscountTag(
                    discount: discount,
                    discountType: discountType,
                    freeDelivery: isStore ? store!.freeDelivery : false,
                  ),
                  isAvailable
                      ? const SizedBox()
                      : NotAvailableWidget(isStore: isStore),
                ]),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      // isStore ?   Text(
                      //         "${store?.isservice}" ,
                      //           style: robotoRegular.copyWith(
                      //             fontSize: Dimensions.fontSizeExtraSmall,
                      //             color: Theme.of(context).disabledColor,
                      //           ),
                      //           maxLines: 1,
                      //           overflow: TextOverflow.ellipsis,
                      //         ) : SizedBox(),
                        Text(
                          isStore ? store!.name! : item!.name!,
                          style: newstyleAS.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                          maxLines: desktop ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height:
                                isStore ? Dimensions.paddingSizeExtraSmall : 0),
                        (isStore
                                ? store!.address != null
                                : item!.storeName != null)
                            ? Text(
                                isStore
                                    ? store!.address ?? ''
                                    :  "${item?.isService}",
                                style:newstyleAS.copyWith(
                                  fontSize: 11,
                                  color: Theme.of(context).disabledColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : const SizedBox(),
                        SizedBox(
                            height: ((desktop || isStore) &&
                                    (isStore
                                        ? store!.address != null
                                        : item!.storeName != null))
                                ? 02
                                : 0),
                        !isStore
                            ? RatingBar(
                              
                                rating:
                                    isStore ? store!.avgRating : item!.avgRating,
                                size: desktop ? 15 : 12,
                                ratingCount: isStore
                                    ? store!.ratingCount
                                    : item!.ratingCount,
                              )
                            : const SizedBox(),
                        SizedBox(
                            height: (!isStore && desktop)
                                ? Dimensions.paddingSizeExtraSmall
                                : 0),
                        isStore
                            ? RatingBar(
                                rating:
                                    isStore ? store!.avgRating : item!.avgRating,
                                size: desktop ? 15 : 12,
                                ratingCount: isStore
                                    ? store!.ratingCount
                                    : item!.ratingCount,
                              )
                            : Row(children: [
                                Text(
                                  PriceConverter.convertPrice(item!.price,
                                      discount: discount,
                                      discountType: discountType),
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                  textDirection: TextDirection.ltr,
                                ),
                                SizedBox(
                                    width: discount! > 0
                                        ? Dimensions.paddingSizeExtraSmall
                                        : 0),
                                discount > 0
                                    ? Text(
                                        PriceConverter.convertPrice(item!.price),
                                        style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeExtraSmall,
                                          color: Theme.of(context).disabledColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      )
                                    : const SizedBox(),
                              ]),
                      ]),
                ),
                Column(
                    mainAxisAlignment: isStore
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                       if(!isStore && item?.isService==0)...{
                      Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      desktop ? Dimensions.paddingSizeSmall : 0),
                              child: Icon(Icons.add, size: desktop ? 30 : 25),
                            )
                       }
                           else...{
                           if(!isStore)...{
   Container(height: 40, width: 100,
           
           child: Center(child: Text("book_now".tr, style: TextStyle(color: Colors.white),)),
            decoration: BoxDecoration(
              color: Color(0xffA4A4A4),
              
              borderRadius: BorderRadius.circular(12)),)
                           }
                           },
                      GetBuilder<WishListController>(builder: (wishController) {
                        bool isWished = isStore
                            ? wishController.wishStoreIdList.contains(store!.id)
                            : wishController.wishItemIdList.contains(item!.id);
                        return InkWell(
                          onTap: !wishController.isRemoving
                              ? () {
                                  if (Get.find<AuthController>().isLoggedIn()) {
                                    isWished
                                        ? wishController.removeFromWishList(
                                            isStore ? store!.id : item!.id,
                                            isStore)
                                        : wishController.addToWishList(
                                            item, store, isStore);
                                  } else {
                                    showCustomSnackBar(
                                        'you_are_not_logged_in'.tr);
                                  }
                                }
                              : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    desktop ? Dimensions.paddingSizeSmall : 0),
                            child: Icon(
                              isWished ? Icons.favorite : Icons.favorite_border,
                              size: desktop ? 30 : 25,
                              color: isWished
                                  ? Theme.of(context).primaryColor
                                  :  
                              const Color(0xffF6AC90),
                            ),
                          ),
                        );
                      }),
                    ]),
              ])),
          desktop || length == null
              ? const SizedBox()
              : 
                   Divider(
                      color: index == length! - 1
                          ? Colors.transparent
                          : const Color(0xffE2E1E1)),
              
        ]),
      ),
    );
  }
}
