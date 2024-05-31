import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmacie_stilo/controller/item_controller.dart';
import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:flutter/material.dart';

import 'package:farmacie_stilo/controller/banner_controller.dart';
import 'package:farmacie_stilo/data/model/response/basic_campaign_model.dart';
import 'package:farmacie_stilo/data/model/response/item_model.dart';
import 'package:farmacie_stilo/data/model/response/store_model.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/screens/store/store_screen.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher_string.dart';
  int currentinde=0;
List items=[Images.lanbanner1, Images.lanbanner2, Images.lanbanner3];
List itemsitalian=[Images.itbanner1, Images.itbanner2, Images.itbanner3];
class WebBannerView extends StatefulWidget {
  final BannerController bannerController;

  const WebBannerView({Key? key, required this.bannerController}) : super(key: key);

  @override
  State<WebBannerView> createState() => _WebBannerViewState();
}

class _WebBannerViewState extends State<WebBannerView> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Container(
    width: MediaQuery.of(context).size.width, 
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      // alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 320,
        child:
        //  widget.bannerController.bannerImageList != null
          //   ? 
            CarouselSlider.builder(itemCount: Get.find<LocalizationController>().locale!.languageCode=="en" ? items.length : itemsitalian.length, options: CarouselOptions(
            
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
                                            autoPlayInterval: const Duration(seconds: 5),
            
            ), itemBuilder: (context, index, _)  { 
            return    Container(
                                
                              width: MediaQuery.of(context).size.width,
                                height: 320,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: Get.find<LocalizationController>().locale!.languageCode=="en" ? AssetImage(  items[currentinde],
                                  
                                         
                                         
                                         ) : AssetImage(  itemsitalian[currentinde],
                                  
                                         
                                         
                                         ) , fit: BoxFit.cover
                                         ),
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radiusDefault),
                                      // color: Colors.red
                                   color: Theme.of(context).primaryColor.withOpacity(0.05),
              )  );
            
            }),
    )
    );
  }

  void _onTap(int index, BuildContext context) async {
    if (widget.bannerController.bannerDataList![index] is Item) {
      Item? item = widget.bannerController.bannerDataList![index];
      Get.find<ItemController>().navigateToItemPage(item, context);
    } else if (widget.bannerController.bannerDataList![index] is Store) {
      Store store = widget.bannerController.bannerDataList![index];
      Get.toNamed(
        RouteHelper.getStoreRoute(store.id, 'banner'),
        arguments: StoreScreen(store: store, fromModule: false),
      );
    } else if (widget.bannerController.bannerDataList![index] is BasicCampaignModel) {
      BasicCampaignModel campaign = widget.bannerController.bannerDataList![index];
      Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
    } else {
      String url = widget.bannerController.bannerDataList![index];
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        showCustomSnackBar('unable_to_found_url'.tr);
      }
    }
  }
}

class WebBannerShimmer extends StatelessWidget {
  final BannerController bannerController;
  const WebBannerShimmer({Key? key, required this.bannerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      enabled: bannerController.bannerImageList == null,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        child: Row(children: [
          Expanded(
              child: Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Colors.grey[300]),
          )),
          const SizedBox(width: Dimensions.paddingSizeLarge),
          Expanded(
              child: Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Colors.grey[300]),
          )),
        ]),
      ),
    );
  }
}
