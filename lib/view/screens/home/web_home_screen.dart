import 'package:farmacie_stilo/controller/banner_controller.dart';
import 'package:farmacie_stilo/controller/campaign_controller.dart';
import 'package:farmacie_stilo/controller/item_controller.dart';
import 'package:farmacie_stilo/controller/search_controller.dart';
import 'package:farmacie_stilo/controller/store_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/item_view.dart';
import 'package:farmacie_stilo/view/base/paginated_list_view.dart';
import 'package:farmacie_stilo/view/screens/home/web/module_widget.dart';
import 'package:farmacie_stilo/view/screens/home/web/web_banner_view.dart';
import 'package:farmacie_stilo/view/screens/home/web/web_popular_item_view.dart';
import 'package:farmacie_stilo/view/screens/home/web/web_campaign_view.dart';
import 'package:farmacie_stilo/view/screens/search/widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_snackbar.dart';

class WebHomeScreen extends StatelessWidget {
  final ScrollController scrollController;
  const WebHomeScreen({Key? key, required this.scrollController})
  : super(key: key);
   
   
  @override
  Widget build(BuildContext context) {
    
      final TextEditingController _searchController = TextEditingController();
  void searchData() {
    if (_searchController.text.trim().isEmpty) {
      showCustomSnackBar(Get.find<SplashController>()
              .configModel!
              .moduleConfig!
              .module!
              .showRestaurantText!
          ? 'search_food_or_restaurant'.tr
          : 'search_item_or_store'.tr);
    } else {
      Get.toNamed(
          RouteHelper.getSearchRoute(queryText: _searchController.text.trim()));
    }
  }

    Get.find<BannerController>().setCurrentIndex(0, false);

    return GetBuilder<SplashController>(builder: (splashController) {
      return Stack(clipBehavior: Clip.none, children: [
        SizedBox(height: context.height),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              GetBuilder<BannerController>(builder: (bannerController) {
                return bannerController.bannerImageList == null
                    ? WebBannerView(bannerController: bannerController)
                    : bannerController.bannerImageList!.isEmpty
                        ? const SizedBox()
                        : WebBannerView(bannerController: bannerController);
              }),
              FooterView(
                  child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // GetBuilder<CategoryController>(
                            //     builder: (categoryController) {
                            //   return categoryController.categoryList == null
                            //       ? WebCategoryView(
                            //           categoryController: categoryController)
                            //       : categoryController.categoryList!.isEmpty
                            //           ? const SizedBox()
                            //           : WebCategoryView(
                            //               categoryController: categoryController);
                            // }),
                            const SizedBox(width: Dimensions.paddingSizeLarge),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
          
          
          Center(
            child: SizedBox(
                            width: MediaQuery.of(context).size.width/2,
                            child: GetBuilder<SearchControllers>(
                                builder: (searchController) {
                              _searchController.text =
                                  searchController.searchHomeText!;
                              return SearchField(
                                controller: _searchController,
                                hint: Get.find<SplashController>()
                                        .configModel!
                                        .moduleConfig!
                                        .module!
                                        .showRestaurantText!
                                    ? 'search_food_or_restaurant'.tr
                                    : 'search_item_or_store'.tr,
                                suffixIcon:
                                    searchController.searchHomeText!.isNotEmpty
                                        ? Icons.highlight_remove
                                        : Icons.search,
                                filledColor:
                                    Theme.of(context).colorScheme.background,
                                iconPressed: () {
                                  if (searchController.searchHomeText!.isNotEmpty) {
                                    _searchController.text = '';
                                    searchController.clearSearchHomeText();
                                  } else {
                                    searchData();
                                  }
                                },
                                onSubmit: (text) => searchData(),
                              );
                            })),
          ),
           const SizedBox(height: Dimensions.paddingSizeLarge),
          //       Container(
                                      
          //                                    height:  GetPlatform.isDesktop
          //                   ? 300
          //                   : MediaQuery.of(context).size.width * 0.45,
          //                                        child: 
          //                                           //  Expanded(
          //                                           //                              child: CarouselSlider.builder(
          //                                           //                                options: CarouselOptions(
          //                                           //                                  autoPlay: true,
          //                                           //                                  enlargeCenterPage: true,
          //                                           //                                  disableCenter: true,
          //                                           //                                  viewportFraction: 0.8,
          //                                           //                                  autoPlayInterval: const Duration(seconds: 7),
          //                                           //                                  onPageChanged: (index, reason) {
          //                                           //                                    // bannerController.setCurrentIndex(index, true);
          //                                           //                                  },
          //                                           //                                ),
          //                                           //                                itemCount:3,
          //                                           //                                    // bannerList.isEmpty ? 1 : bannerList.length,
          //                                           //                                itemBuilder: (context, index, _) {
          //                                           //                                  String? baseUrl =
          //                                           //                                   '';
          //                                           //                                  return InkWell(
          //                                           //                                    onTap: () async {
                                                                               
          //                                           //                                    },
          //                                           //                                    child: Container(
          //                                           //                                      decoration: BoxDecoration(
          //                                           //   color: Theme.of(context).cardColor,
          //                                           //   borderRadius: BorderRadius.circular(
          //                                           //       Dimensions.radiusSmall),
          //                                           //   boxShadow: [
          //                                           //     BoxShadow(
          //                                           //         color: Colors.grey[
          //                                           //             Get.isDarkMode ? 800 : 200]!,
          //                                           //         spreadRadius: 1,
          //                                           //         blurRadius: 5)
          //                                           //   ],
          //                                           //                                      ),
          //                                           //                                      child: ClipRRect(
          //                                           //   borderRadius: BorderRadius.circular(
          //                                           //       Dimensions.radiusSmall),
          //                                           //   child: GetBuilder<SplashController>(
          //                                           //       builder: (splashController) {
          //                                           //     return  Image.asset(banner[index], fit: BoxFit.fill,);
                                            
          //                                           //   }),
          //                                           //                                      ),
          //                                           //                                    ),
          //                                           //                                  );
          //                                           //                                },
          //                                           //                              ),
          //                                           //                            ),
          
          // //                                         Row(
          // //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // //   children: [
          // //     InkWell(
          // //       onTap: (){
          // //           Get.toNamed(DoctorAvailability.routeName);
          // //       },
          // //       child: Container(
          // //         // color: Colors.green,
          // //         width: MediaQuery.of(context).size.width/4,
          // //         height: MediaQuery.of(context).size.height,
          // //          decoration: BoxDecoration(
          // //         image: DecorationImage(
          // //       image: AssetImage(Images.webtelemedicina),
          // //       fit: BoxFit.fill,
          // //       filterQuality: FilterQuality.high
          // //        // You can adjust the BoxFit as needed
          // //         ),
          // //       ),
                
          // //         ),
          // //     ),
          // //       //  InkWell(
          // //       //   onTap: ()async {
            
          // //       //       if (await canLaunchUrlString("https://gls-group.com/GROUP/en/parcel-tracking")) {
          // //       //       await launchUrlString("https://gls-group.com/GROUP/en/parcel-tracking", mode: LaunchMode.inAppBrowserView);
          // //       //     }
          // //       //   },
          // //       //    child: Container(
          // //       //          // color: Colors.green,
          // //       //    width: MediaQuery.of(context).size.width/4,
          // //       //          height: MediaQuery.of(context).size.height,
          // //       //       decoration: BoxDecoration(
          // //       //      image: DecorationImage(
          // //       //        image: AssetImage(Images.webconsegna),
          // //       //        fit: BoxFit.fill,
          // //       //        filterQuality: FilterQuality.high
          // //       //         // You can adjust the BoxFit as needed
          // //       //      ),
          // //       //    ),
           
          // //       //          ),
          // //       //  ),
          // // //        Container(
          // // //       // color: Colors.green,
          // // //       width: MediaQuery.of(context).size.width/4,
          // // //       height: MediaQuery.of(context).size.height,
          // // //    decoration: BoxDecoration(
          // // //   image: DecorationImage(
          // // //     image: AssetImage(Images.webappuntamento),
          // // //     fit: BoxFit.fill,
          // // //     filterQuality: FilterQuality.high
          // // //      // You can adjust the BoxFit as needed
          // // //   ),
          // // // ),
          
          // // //     ),
          // //     // SizedBox(
          // //     //   height: MediaQuery.of(context).size.height > 600 ? 100 : 390,
          // //     //   width: MediaQuery.of(context).size.width > 600 ? 50 : 140,
          // //     //   child: Image.asset(Images.telemedicine),
          // //     // ),
          // //     // Container(
          // //     //   height: MediaQuery.of(context).size.width > 600 ? 100 : 100,
          // //     //   width: MediaQuery.of(context).size.width > 600 ? 50 : 140,
          // //     //   child: Image.asset(Images.telemedicine),
          // //     // ),
          // //     // Container(
          // //     //   height: MediaQuery.of(context).size.width > 600 ? 100 : 100,
          // //     //   width: MediaQuery.of(context).size.width > 600 ? 50 : 130,
          // //     //   child: Image.asset(Images.telemedicine),
          // //     // ),
          // //   ],
          // // )
          
                                           
                                         
          //                                      ),
          // GetBuilder<CategoryController>(
          //                               builder: (categoryController) {
          //                             return categoryController.categoryList == null
          //                                 ? WebCategoryView(
          //                                     categoryController: categoryController)
          //                                 : categoryController.categoryList!.isEmpty
          //                                     ? const SizedBox()
          //                                     : WebCategoryView(
          //                                         categoryController: categoryController);
          //                           }),
                                    // GetBuilder<StoreController>(
                                    //     builder: (storeController) {
                                    //   return storeController.popularStoreList ==
                                    //           null
                                    //       ? WebPopularStoreView(
                                    //           storeController: storeController,
                                    //           isPopular: true)
                                    //       : storeController
                                    //               .popularStoreList!.isEmpty
                                    //           ? const SizedBox()
                                    //           : WebPopularStoreView(
                                    //               storeController:
                                    //                   storeController,
                                    //               isPopular: true);
                                    // }),
                                    GetBuilder<CampaignController>(
                                        builder: (campaignController) {
                                      return campaignController
                                                  .itemCampaignList ==
                                              null
                                          ? WebCampaignView(
                                              campaignController:
                                                  campaignController)
                                          : campaignController
                                                  .itemCampaignList!.isEmpty
                                              ? const SizedBox()
                                              : WebCampaignView(
                                                  campaignController:
                                                      campaignController);
                                    }),
                                    GetBuilder<ItemController>(
                                        builder: (itemController) {
                                      return itemController.popularItemList ==
                                              null
                                          ? WebPopularItemView(
                                              itemController: itemController,
                                              isPopular: true)
                                          : itemController
                                                  .popularItemList!.isEmpty
                                              ? const SizedBox()
                                              : WebPopularItemView(
                                                  itemController: itemController,
                                                  isPopular: true);
                                    }),
                          //           SizedBox(
                          // width: 250,
                          // child: GetBuilder<SearchControllers>(
                          //     builder: (searchController) {
                          //   _searchController.text =
                          //       searchController.searchHomeText!;
                          //   return SearchField(
                          //     controller: _searchController,
                          //     hint: Get.find<SplashController>()
                          //             .configModel!
                          //             .moduleConfig!
                          //             .module!
                          //             .showRestaurantText!
                          //         ? 'search_food_or_restaurant'.tr
                          //         : 'search_item_or_store'.tr,
                          //     suffixIcon:
                          //         searchController.searchHomeText!.isNotEmpty
                          //             ? Icons.highlight_remove
                          //             : Icons.search,
                          //     filledColor:
                          //         Theme.of(context).colorScheme.background,
                          //     iconPressed: () {
                          //       if (searchController.searchHomeText!.isNotEmpty) {
                          //         _searchController.text = '';
                          //         searchController.clearSearchHomeText();
                          //       } else {
                          //         searchData();
                          //       }
                          //     },
                          //     onSubmit: (text) => searchData(),
                          //   );
                          // })),
                                    // GetBuilder<StoreController>(
                                    //     builder: (storeController) {
                                    //   return storeController.latestStoreList ==
                                    //           null
                                    //       ? WebPopularStoreView(
                                    //           storeController: storeController,
                                    //           isPopular: false)
                                    //       : storeController
                                    //               .latestStoreList!.isEmpty
                                    //           ? const SizedBox()
                                    //           : WebPopularStoreView(
                                    //               storeController:
                                    //                   storeController,
                                    //               isPopular: false);
                                //    }),
                                    GetBuilder<ItemController>(
                                        builder: (itemController) {
                                      return itemController.reviewedItemList ==
                                              null
                                          ? WebPopularItemView(
                                              itemController: itemController,
                                              isPopular: false)
                                          : itemController
                                                  .reviewedItemList!.isEmpty
                                              ? const SizedBox()
                                              : WebPopularItemView(
                                                  itemController: itemController,
                                                  isPopular: false);
                                    }),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 20, 0, 5),
                                      child: GetBuilder<StoreController>(
                                          builder: (storeController) {
                                        return Row(children: [
                                          Expanded(
                                              child: Text(
                                            Get.find<SplashController>()
                                                    .configModel!
                                                    .moduleConfig!
                                                    .module!
                                                    .showRestaurantText!
                                                ? 'all_restaurants'.tr
                                                : 'all_stores'.tr,
                                            style: robotoMedium.copyWith(
                                                fontSize: 24),
                                          )),
                                          storeController.storeModel != null
                                              ? PopupMenuButton(
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                          value: 'all',
                                                          textStyle: robotoMedium
                                                              .copyWith(
                                                            color: storeController
                                                                        .storeType ==
                                                                    'all'
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color
                                                                : Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                          ),
                                                          child: Text('all'.tr)),
                                                      PopupMenuItem(
                                                          value: 'take_away',
                                                          textStyle: robotoMedium
                                                              .copyWith(
                                                            color: storeController
                                                                        .storeType ==
                                                                    'take_away'
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color
                                                                : Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                          ),
                                                          child: Text(
                                                              'take_away'.tr)),
                                                      PopupMenuItem(
                                                          value: 'delivery',
                                                          textStyle: robotoMedium
                                                              .copyWith(
                                                            color: storeController
                                                                        .storeType ==
                                                                    'delivery'
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color
                                                                : Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                          ),
                                                          child: Text(
                                                              'delivery'.tr)),
                                                    ];
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radiusSmall)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .paddingSizeSmall),
                                                    child:
                                                        Icon(Icons.filter_list),
                                                  ),
                                                  onSelected: (dynamic value) =>
                                                      storeController
                                                          .setStoreType(value),
                                                )
                                              : const SizedBox(),
                                        ]);
                                      }),
                                    ),
                                    GetBuilder<StoreController>(
                                        builder: (storeController) {
                                      return PaginatedListView(
                                        scrollController: scrollController,
                                        totalSize:
                                            storeController.storeModel != null
                                                ? storeController
                                                    .storeModel!.totalSize
                                                : null,
                                        offset: storeController.storeModel != null
                                            ? storeController.storeModel!.offset
                                            : null,
                                        onPaginate: (int? offset) async =>
                                            await storeController.getStoreList(
                                                offset!, false),
                                        itemView: ItemsView(
                                          isStore: true,
                                          items: null,
                                          stores: storeController.storeModel !=
                                                  null
                                              ? storeController.storeModel!.stores!.where((element) => element.isservice==0).toList()
                                              : null,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ResponsiveHelper
                                                    .isDesktop(context)
                                                ? Dimensions.paddingSizeExtraSmall
                                                : Dimensions.paddingSizeSmall,
                                            vertical: ResponsiveHelper.isDesktop(
                                                    context)
                                                ? Dimensions.paddingSizeExtraSmall
                                                : 0,
                                          ),
                                        ),
                                      );
                                    }),























                                      Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 20, 0, 5),
                                      child: GetBuilder<StoreController>(
                                          builder: (storeController) {
                                        return Row(children: [
                                          Expanded(
                                              child: Text(
                                            Get.find<SplashController>()
                                                    .configModel!
                                                    .moduleConfig!
                                                    .module!
                                                    .showRestaurantText!
                                                ? 'all_restaurants'.tr
                                                : 'book_service'.tr,
                                            style: robotoMedium.copyWith(
                                                fontSize: 24),
                                          )),
                                          storeController.storeModel != null
                                              ? PopupMenuButton(
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                          value: 'all',
                                                          textStyle: robotoMedium
                                                              .copyWith(
                                                            color: storeController
                                                                        .storeType ==
                                                                    'all'
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color
                                                                : Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                          ),
                                                          child: Text('all'.tr)),
                                                      PopupMenuItem(
                                                          value: 'take_away',
                                                          textStyle: robotoMedium
                                                              .copyWith(
                                                            color: storeController
                                                                        .storeType ==
                                                                    'take_away'
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color
                                                                : Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                          ),
                                                          child: Text(
                                                              'take_away'.tr)),
                                                      PopupMenuItem(
                                                          value: 'delivery',
                                                          textStyle: robotoMedium
                                                              .copyWith(
                                                            color: storeController
                                                                        .storeType ==
                                                                    'delivery'
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color
                                                                : Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                          ),
                                                          child: Text(
                                                              'delivery'.tr)),
                                                    ];
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radiusSmall)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .paddingSizeSmall),
                                                    child:
                                                        Icon(Icons.filter_list),
                                                  ),
                                                  onSelected: (dynamic value) =>
                                                      storeController
                                                          .setStoreType(value),
                                                )
                                              : const SizedBox(),
                                        ]);
                                      }),
                                    ),
                                    GetBuilder<StoreController>(
                                        builder: (storeController) {
                                      return PaginatedListView(
                                        scrollController: scrollController,
                                        totalSize:
                                            storeController.storeModel != null
                                                ? storeController
                                                    .storeModel!.totalSize
                                                : null,
                                        offset: storeController.storeModel != null
                                            ? storeController.storeModel!.offset
                                            : null,
                                        onPaginate: (int? offset) async =>
                                            await storeController.getStoreList(
                                                offset!, false),
                                        itemView: ItemsView(
                                          isStore: true,
                                          items: null,
                                          stores: storeController.storeModel !=
                                                  null
                                              ? storeController.storeModel!.stores!.where((element) => element.isservice==1).toList()
                                              : null,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ResponsiveHelper
                                                    .isDesktop(context)
                                                ? Dimensions.paddingSizeExtraSmall
                                                : Dimensions.paddingSizeSmall,
                                            vertical: ResponsiveHelper.isDesktop(
                                                    context)
                                                ? Dimensions.paddingSizeExtraSmall
                                                : 0,
                                          ),
                                        ),
                                      );
                                    }),
                                  ]),
                            ),
                          ]))),
            ]),
          ),
        ),
        const Positioned(
            right: 0, top: 0, bottom: 0, child: Center(child: ModuleWidget())),
      ]);
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
