import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmacie_stilo/controller/banner_controller.dart';
import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/view/screens/home/web/web_banner_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerView extends StatefulWidget {
  final bool isFeatured;
  const BannerView({Key? key, required this.isFeatured}) : super(key: key);

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      List<String?>? bannerList = widget.isFeatured
          ? bannerController.featuredBannerList
          : bannerController.bannerImageList;
      List<dynamic>? bannerDataList = widget.isFeatured
          ? bannerController.featuredBannerDataList
          : bannerController.bannerDataList;

      return (bannerList != null && bannerList.isEmpty)
          ? const SizedBox()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: GetPlatform.isDesktop
                  ? 300
                  : MediaQuery.of(context).size.width * 0.5,
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: bannerList != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (GetPlatform.isDesktop || GetPlatform.isWeb) ...{
                         Expanded(child:   CarouselSlider.builder(itemCount: Get.find<LocalizationController>().locale!.languageCode=="en" ? items.length : itemsitalian.length, options: CarouselOptions(
            
             autoPlay: true,
                                            enlargeCenterPage: true,
                                            onPageChanged: ((index, reason) {
                                            setState(() {
                                              currentinde=index;
                                            });
                                           // bannerController.setCurrentIndex(index, true);
                                            }),
                                            disableCenter: true,
                                            viewportFraction: 1,
                                            autoPlayInterval: const Duration(seconds: 3),
            
            ), itemBuilder: (context, index, _)  { 
            return    Container(
                          
                              width: MediaQuery.of(context).size.width,
                              
                                decoration: BoxDecoration(
                                image: DecorationImage(image: Get.find<LocalizationController>().locale!.languageCode=="en" ? AssetImage(  items[currentinde],
                                  
                                         
                                         
                                         ) : AssetImage(  itemsitalian[currentinde],
                                  
                                         
                                         
                                         ) , fit: BoxFit.fill
                                         ),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radiusDefault),
                                      // color: Colors.red
                                   color: Theme.of(context).primaryColor.withOpacity(0.05),
              )  );
            
            }),)
                        } else ...{
                         Expanded(child:   CarouselSlider.builder(itemCount: Get.find<LocalizationController>().locale!.languageCode=="en" ? items.length : itemsitalian.length, options: CarouselOptions(
            
             autoPlay: true,
                                            enlargeCenterPage: true,
                                            onPageChanged: ((index, reason) {
                                            setState(() {
                                              currentinde=index;
                                            });
                                           // bannerController.setCurrentIndex(index, true);
                                            }),
                                            disableCenter: true,
                                            viewportFraction: 1,
                                            autoPlayInterval: const Duration(seconds: 3),
            
            ), itemBuilder: (context, index, _)  { 
            return    Container(
                          
                              width: MediaQuery.of(context).size.width,
                              
                                decoration: BoxDecoration(
                                image: DecorationImage(image: Get.find<LocalizationController>().locale!.languageCode=="en" ? AssetImage(  items[currentinde],
                                  
                                         
                                         
                                         ) : AssetImage(  itemsitalian[currentinde],
                                  
                                         
                                         
                                         ) , fit: BoxFit.fill
                                         ),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radiusDefault),
                                      // color: Colors.red
                                   color: Theme.of(context).primaryColor.withOpacity(0.05),
              )  );
            
            }),)
              //             Expanded(
              //               child: CarouselSlider.builder(
              //                 options: CarouselOptions(
              //                   autoPlay: true,
              //                   enlargeCenterPage: true,
              //                   disableCenter: true,
              //                   viewportFraction: 0.8,
              //                   autoPlayInterval: const Duration(seconds: 7),
              //                   onPageChanged: (index, reason) {
              //                   setState(() {
              //                     currentinde=index;
              //                   });
              //                   },
              //                 ),
              //                 itemCount:
              //                  items.length,
              //                 itemBuilder: (context, index, _) {
              //                   String? baseUrl =
              //                       bannerDataList![index] is BasicCampaignModel
              //                           ? Get.find<SplashController>()
              //                               .configModel!
              //                               .baseUrls!
              //                               .campaignImageUrl
              //                           : Get.find<SplashController>()
              //                               .configModel!
              //                               .baseUrls!
              //                               .bannerImageUrl;
              //                   return InkWell(
              //                     onTap: () async {
              //                       if (bannerDataList[index] is Item) {
              //                         Item? item = bannerDataList[index];
              //                         Get.find<ItemController>()
              //                             .navigateToItemPage(item, context);
              //                       } else if (bannerDataList[index] is Store) {
              //                         Store? store = bannerDataList[index];
              //                         if (widget.isFeatured &&
              //                             (Get.find<LocationController>()
              //                                         .getUserAddress()!
              //                                         .zoneData !=
              //                                     null &&
              //                                 Get.find<LocationController>()
              //                                     .getUserAddress()!
              //                                     .zoneData!
              //                                     .isNotEmpty)) {
              //                           for (ModuleModel module
              //                               in Get.find<SplashController>()
              //                                   .moduleList!) {
              //                             if (module.id == store!.moduleId) {
              //                               Get.find<SplashController>()
              //                                   .setModule(module);
              //                               break;
              //                             }
              //                           }
              //                           ZoneData zoneData =
              //                               Get.find<LocationController>()
              //                                   .getUserAddress()!
              //                                   .zoneData!
              //                                   .firstWhere((data) =>
              //                                       data.id == store!.zoneId);

              //                           Modules module = zoneData.modules!
              //                               .firstWhere((module) =>
              //                                   module.id == store!.moduleId);
              //                           Get.find<SplashController>().setModule(
              //                               ModuleModel(
              //                                   id: module.id,
              //                                   moduleName: module.moduleName,
              //                                   moduleType: module.moduleType,
              //                                   themeId: module.themeId,
              //                                   storesCount:
              //                                       module.storesCount));
              //                         }
              //                         Get.toNamed(
              //                           RouteHelper.getStoreRoute(store!.id,
              //                               widget.isFeatured ? 'module' : 'banner'),
              //                           arguments: StoreScreen(
              //                               store: store,
              //                               fromModule: widget.isFeatured),
              //                         );
              //                       } else if (bannerDataList[index]
              //                           is BasicCampaignModel) {
              //                         BasicCampaignModel campaign =
              //                             bannerDataList[index];
              //                         Get.toNamed(
              //                             RouteHelper.getBasicCampaignRoute(
              //                                 campaign));
              //                       } else {
              //                         String url = bannerDataList[index];
              //                         if (await canLaunchUrlString(url)) {
              //                           await launchUrlString(url,
              //                               mode:
              //                                   LaunchMode.externalApplication);
              //                         } else {
              //                           showCustomSnackBar(
              //                               'unable_to_found_url'.tr);
              //                         }
              //                       }
              //                     },
              //                     child: Container(
              //                       decoration: BoxDecoration(
              //                         color: Theme.of(context).cardColor,
              //                         borderRadius: BorderRadius.circular(
              //                             Dimensions.radiusSmall),
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey[
              //                                   Get.isDarkMode ? 800 : 200]!,
              //                               spreadRadius: 1,
              //                               blurRadius: 5)
              //                         ],
              //                       ),
              //                       child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(
              //                             Dimensions.radiusSmall),
              //                         child: GetBuilder<SplashController>(
              //                             builder: (splashController) {
              //                           return  Container(
                                
              //                 width: MediaQuery.of(context).size.width,
              //                   height: 320,
              //                   decoration: BoxDecoration(
              //                     image: DecorationImage(image: AssetImage(  items[currentinde],
                                  
                                         
                                         
              //                            ), fit: BoxFit.cover
              //                            ),
              //                     borderRadius:
              //                         BorderRadius.circular(Dimensions.radiusDefault),
              //                         // color: Colors.red
              //                      color: Theme.of(context).primaryColor.withOpacity(0.05),
              // )  );
              //                           //
              //                           // CustomImage(
              //                           //   image:
              //                           //       '$baseUrl/${bannerList[index]}',
              //                           //   fit: BoxFit.fill,
              //                           // );
              //                           // return
              //                           // CachedNetworkImage(
              //                           //   fit: BoxFit.fill,
              //                           //   imageUrl:
              //                           //       '$baseUrl/${bannerList[index]}',
              //                           // );

              //                           // CustomImage(
              //                           //   width: 100,
              //                           //   image:
              //                           //       '$baseUrl/${bannerList[index]}',
              //                           //   fit: BoxFit.contain,
              //                           // );
              //                         }),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               ),
              //             ),
                        },
                        const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: bannerList.map((bnr) {
                            int index = bannerList.indexOf(bnr);
                            return TabPageSelectorIndicator(
                              backgroundColor:
                                  index == bannerController.currentIndex
                                      ? const Color(0XffF6AC90)
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                              borderColor:
                                  Theme.of(context).colorScheme.background,
                              size: index == bannerController.currentIndex
                                  ? 10
                                  : 7,
                            );
                          }).toList(),
                        ), 
                      ],
                    )
                  : Shimmer(
                      duration: const Duration(seconds: 2),
                      enabled: bannerList == null,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            color: Colors.grey[300],
                          )),
                    ),
            );
    });
  }
}
