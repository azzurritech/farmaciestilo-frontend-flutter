import 'dart:ui';

import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/data/model/response/config_model.dart';
import 'package:farmacie_stilo/data/model/response/zone_response_model.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/view/base/custom_loader.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/html_type.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher_string.dart';

class HtmlViewerScreen extends StatefulWidget {
  final HtmlType htmlType;
  const HtmlViewerScreen({Key? key, required this.htmlType}) : super(key: key);

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
    final TextEditingController _controller = TextEditingController();
  final PageController _pageController = PageController();
  AddressModel? _address;
  final ConfigModel? _config = Get.find<SplashController>().configModel;
  @override
  void initState() {
    super.initState();

    Get.find<SplashController>().getHtmlText(widget.htmlType);
  }

  @override
  Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
print(screenWidth);
  // Calculate the font size based on the screen width
 
  // Define breakpoints and corresponding font sizes
  double fontSize = 23.0; // Default font size
  if (screenWidth < 600) {
    fontSize = 17.0;
  } else if (screenWidth < 1200) {
    fontSize = 21.0;
  }
   double heading = 100.0; // Default font size
  if (screenWidth < 600) {
 heading = 50.0;
  } else if (screenWidth < 100) {
  heading = 50.0;
  }
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.htmlType == HtmlType.termsAndCondition
              ? 'terms_conditions'.tr
              : widget.htmlType == HtmlType.aboutUs
                  ? 'about_us'.tr
                  : widget.htmlType == HtmlType.privacyPolicy
                      ? 'privacy_policy'.tr
                      : widget.htmlType == HtmlType.shippingPolicy
                          ? 'ç'.tr
                          : widget.htmlType == HtmlType.refund
                              ? 'refund_policy'.tr
                              : widget.htmlType == HtmlType.cancellation
                                  ? 'cancellation_policy'.tr
                                  : 'no_data_found'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: GetBuilder<SplashController>(builder: (splashController) {
          return Column(
            children: [
              Column(
                children: [
                    if(widget.htmlType==HtmlType.aboutUs && GetPlatform.isWeb)...{
                      Get.find<LocalizationController>().locale!.languageCode=="it" ?  Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 320,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(  Images.siamoitaly
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: const [
                            SizedBox(width: 40),
                        
                          ])
                     
                        ):
                        
                        
                        
                         Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 320,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage(  Images.siamoenglish
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: const Row(children: [
                            SizedBox(width: 40),
                        
                          ])
                     
                        ),
                    }



     else  if(widget.htmlType==HtmlType.aboutUs && GetPlatform.isMobile)...{
                      Get.find<LocalizationController>().locale!.languageCode=="it" ?  Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 320,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(  Images.aboutusmobileitalian
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 40),
                        
                          ])
                     
                        ):
                        
                        
                        
                         Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 320,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage(  Images.aboutusmobileenglish
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 40),
                        
                          ])
                     
                        ),
                    }


                    
                       else  if(widget.htmlType==HtmlType.refund)...{
              Get.find<LocalizationController>().locale!.languageCode=="it" ?          Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 280,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(  Images.gruppo
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 40),
                        
                          ])
                     
                        ): Container(
                                 height: 280,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(  Images.gruppoenglish
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 40),
                        
                          ])
                        ),
                    }
                   else if (widget.htmlType == HtmlType.shippingPolicy) ...{
                Get.find<LocalizationController>().locale!.languageCode=="it" ?    Container(
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.shops),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    color: Theme.of(context).primaryColor.withOpacity(0.05),
                  ),
                 
                ):  Container(
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.shopsenglish),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    color: Theme.of(context).primaryColor.withOpacity(0.05),
                  ),
                 
                )
                
                
                
                ,
              }
              
              
                         else  if(widget.htmlType==HtmlType.cancellation)...{
              
              
              
               Get.find<LocalizationController>().locale!.languageCode=="it" ?     Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 320,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(  Images.servizi
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 40),
                        
                          ])
                     
                        ):
                          Container(
                          
                          // width: MediaQuery.of(context).size.w,
                          height: 320,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(  Images.servizienglish
                            
                                   
                                   
                                   ), fit: BoxFit.cover
                                   ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                                // color: Colors.red
                             color: Theme.of(context).primaryColor.withOpacity(0.05),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 40),
                        
                          ])
                     
                        ),
                    }








                      else  if(widget.htmlType==HtmlType.termsAndCondition)...{
              
              
              
               Get.find<LocalizationController>().locale!.languageCode=="it" ?    SizedBox(height: 2,):
                          SizedBox()
                    } ,
                  splashController.htmlText != null
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: FooterView(
                              child: Ink(
                            width: Dimensions.webMaxWidth,
                            // color: Theme.of(context).cardColor,
                            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // ResponsiveHelper.isDesktop(context)
                                  //     ? Container(
                                  //         height: 50,
                                  //         alignment: Alignment.center,
                                  //         color: Theme.of(context).cardColor,
                                  //         width: Dimensions.webMaxWidth,
                                  //         child: SelectableText(
                                  //           widget.htmlType ==
                                  //                   HtmlType.termsAndCondition
                                  //               ? 'terms_conditions'.tr
                                  //               : widget.htmlType == HtmlType.aboutUs
                                  //                   ? 'who'.tr
                                  //                   : widget.htmlType ==
                                  //                           HtmlType.privacyPolicy
                                  //                       ? 'privacy_policy'.tr
                                  //                       : widget.htmlType ==
                                  //                               HtmlType.shippingPolicy
                                  //                           ? 'shops'.tr
                                  //                           : widget.htmlType ==
                                  //                                   HtmlType.refund
                                  //                               ? 'the'.tr
                                  //                               : widget.htmlType ==
                                  //                                       HtmlType
                                  //                                           .cancellation
                                  //                                   ? 'servicea'
                                  //                                       .tr
                                  //                                   : 'no_data_found'
                                  //                                       .tr,
                                  //           style: robotoBold.copyWith(
                                  //               fontSize: Dimensions.fontSizeLarge,
                                  //               color: Colors.black),
                                  //         ),
                                  //       )
                                  //     : const SizedBox(),
                                  (splashController.htmlText!.contains('<ol>') ||
                                          splashController.htmlText!.contains('<ul>'))
                                      ? HtmlWidget(
                                          splashController.htmlText ?? '',
                                          key: Key(widget.htmlType.toString()),
                                          isSelectable: true,
                                          onTapUrl: (String url) {
                                            return launchUrlString(url,
                                                mode: LaunchMode.externalApplication);
                                          },
                                        )
                                      : widget.htmlType==HtmlType.shippingPolicy ? Column(
                                        children: [
                                          Container(
                                         height: MediaQuery.of(context).size.height,
                                            child: Stack(
                                          children: [
                                               Positioned(
                      top: 140, // Adjusted top position for HTML content
                      left: MediaQuery.of(context).size.width * 0.1, // Adjusted left position for HTML content
                      right: MediaQuery.of(context).size.width * 0.1, // Adjusted right position for HTML content
                      child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.0),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                   // Adjusted height for HTML content
                   decoration:  BoxDecoration(color: const Color(0xffAAD1B3),
                      borderRadius: BorderRadius.circular(33)
                  
                  ), // HTML content background color
                  child: Column(
                    children: [
                      // Text(splashController.aboutf["about_us"]),
                      const SizedBox(height: 83,),
                      SelectionArea(
                        child: Container(
                          child: Html(
                                            style: {
                        "body": Style(
                          textAlign: TextAlign.center,
                          fontFamily: 'FiraSans',
                          fontSize: FontSize(fontSize),
                          
                          // fontWeight: FontWeight.bold,
                          color: Color(0xff266F3A),
                        ),
                                            },
                                       data: (widget.htmlType == HtmlType.aboutUs &&
                       Get.find<LocalizationController>().locale!.languageCode == "it" 
                      ) ? 
                      splashController.aboutf["about_us_it"] : 
                    (widget.htmlType == HtmlType.shippingPolicy &&
                       Get.find<LocalizationController>().locale!.languageCode == "it" 
                    ) ? 
                    splashController.aboutf["shipping_policy_it"] : 
                    (widget.htmlType == HtmlType.cancellation &&
                    Get.find<LocalizationController>().locale!.languageCode == "it" ) ?
                    splashController.aboutf["cancelation_it"] :
                    (widget.htmlType == HtmlType.refund &&
                    Get.find<LocalizationController>().locale!.languageCode == "it") ?
                    splashController.aboutf["refund_it"] :
                    (widget.htmlType == HtmlType.aboutUs &&
                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                   ) ?
                    splashController.aboutf["about_us"] :
                    (widget.htmlType == HtmlType.shippingPolicy &&
                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                    ) ? 
                    splashController.aboutf["shipping_policy"]["value"] :
                    (widget.htmlType == HtmlType.refund &&
                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                    ) ?
                    splashController.aboutf["refund"]["value"] :
              
                    (widget.htmlType == HtmlType.cancellation &&
                    Get.find<LocalizationController>().locale!.languageCode == "en" ) ?
                    splashController.aboutf["cancelation"]["value"] :
                (widget.htmlType == HtmlType.termsAndCondition &&
                    Get.find<LocalizationController>().locale!.languageCode == "en"  &&  widget.htmlType==HtmlType.termsAndCondition )?   splashController.aboutf["terms_and_conditions"] :
                   splashController.aboutf["terms_and_conditions"],
                   shrinkWrap: true,
                                           onLinkTap: (String? url, Map<String, String> attributes, element) {
                        if (url!.startsWith('www.')) {
                          url = 'https://$url';
                        }
                        if (kDebugMode) {
                          print('Redirect to url: $url');
                        }
                        html.window.open(url, "_blank");
                                            },
                                          ),
                                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                      ),
                    ),
                    // "Chi Siamo" text overlay
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: null, // Half of the screen
                      child: Container(
                      // color: Colors.red,
              child:   Center(
                child:  Center(
                  child:  Text(
                    "ourr".tr,
                    style: TextStyle(color: Color(0xff266F3A), fontWeight: FontWeight.bold, fontSize: 90, fontFamily: 'Intro'),
                  ),
                ) 
              ),
                      ),
                    ),
                       Positioned(
                      top:82,
                      left: 0,
                      right: 0,
                      height: null, // Half of the screen
                      child: Container(
                      // color: Colors.red,
              child:   Center(
                child:  Center(
                  child:  Text(
                    "shopsss".tr,
                    style: TextStyle(color: Color(0xff266F3A), fontWeight: FontWeight.bold, fontSize: 90, fontFamily: 'Intro'),
                  ),
                ) 
              ),
                      ),
                    ),
                                            ],
                                            ),
                                          ),
                                     
                                         Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _config!.landingPageLinks!
                                                  .appUrlAndroidStatus ==
                                              '1'
                                          ? InkWell(
                                              onTap: () => _launchURL(_config!
                                                      .landingPageLinks!
                                                      .appUrlAndroid ??
                                                  ''),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeSmall),
                                                child: Image.asset(
                                                    Images.landingGooglePlay,
                                                    height: 120,
                                                    fit: BoxFit.contain),
                                              ),
                                            )
                                          : const SizedBox(),
                                      _config!.landingPageLinks!.appUrlIosStatus ==
                                              '1'
                                          ? InkWell(
                                              onTap: () => _launchURL(_config!
                                                      .landingPageLinks!
                                                      .appUrlIos ??
                                                  ''),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeSmall),
                                                child: Image.asset(
                                                    Images.landingAppStore,
                                                    height: 100,
                                                    fit: BoxFit.contain),
                                              ),
                                            )
              
                                        
                                          : const SizedBox(),
              //                                    Container(
              //                                     width: 100,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8.0),
              //     color: const Color(0xffBCDEC2) // Adjust the color according to your design
              //   ),
              //   child: InkWell(
              //     onTap: () {
              //       Get.toNamed(RouteHelper.getAccessLocationRoute('home'));
              //     },
              //     child: const Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Icon(Icons.shopping_cart, color: Colors.white,),
              //     ),
              //   ),
              // )
              
                                    ]),
                                        ],
                                      ):
                                      
              Container(
               height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // HTML content
                    Positioned(
                      // top:widget.htmlType==HtmlType.aboutUs ?  MediaQuery.of(context).size.height * 0.08 : widget.htmlType==HtmlType.cancellation ? MediaQuery.of(context).size.height * 0.14: widget.htmlType==HtmlType.refund ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.27, // Adjusted top position for HTML content
                     top:widget.htmlType==HtmlType.aboutUs ?  MediaQuery.of(context).size.height * 0.08 : 140,
                      left: MediaQuery.of(context).size.width * 0.1, // Adjusted left position for HTML content
                      right: MediaQuery.of(context).size.width * 0.1, // Adjusted right position for HTML content
                      child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.0),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  // height:   widget.htmlType==HtmlType.refund ?  MediaQuery.of(context).size.height * 32 : widget.htmlType==HtmlType.cancellation ?  MediaQuery.of(context).size.height * 0.99  :  MediaQuery.of(context).size.height * 0.73, // Adjusted height for HTML content
                   decoration:  BoxDecoration(color: widget.htmlType==HtmlType.aboutUs ? Color(0xffD8F3FA) : widget.htmlType==HtmlType.refund ? Color(0xffFCDED3) : widget.htmlType==HtmlType.cancellation ? Color.fromARGB(255, 243, 232, 211) : widget.htmlType==HtmlType.shippingPolicy ? Color(0xff266F3A) : Colors.white,
                      borderRadius: BorderRadius.circular(33)
                  
                  ), // HTML content background color
                  child: Column(
                    children: [
                      // Text(splashController.aboutf["about_us"]),
                      SizedBox(height: 69,),
                      SelectionArea(
                        child: Container(
                          
                          child: Column(
                            children: [
                              Html(
                                                style: {
                                                  "body": Style(
                              textAlign: TextAlign.center,
                              fontFamily: 'FiraSans',
                              fontSize: widget.htmlType==HtmlType.refund ?FontSize(1) : FontSize(fontSize),
                              
                              // fontWeight: FontWeight.bold,
                              color: widget.htmlType==HtmlType.aboutUs ? Color(0xff2884A8) : widget.htmlType==HtmlType.cancellation ? Color(0xffEF9D29) : widget.htmlType==HtmlType.refund ? Color(0xffFF8A5D) :Colors.black,
                                                  ),
                                                },
                                           data: (widget.htmlType == HtmlType.aboutUs &&
                                       Get.find<LocalizationController>().locale!.languageCode == "it" 
                                      ) ? 
                                      splashController.aboutf["about_us_it"] : 
                                    (widget.htmlType == HtmlType.shippingPolicy &&
                                       Get.find<LocalizationController>().locale!.languageCode == "it" 
                                    ) ? 
                                    splashController.aboutf["shipping_policy_it"] : 
                                    (widget.htmlType == HtmlType.cancellation &&
                                    Get.find<LocalizationController>().locale!.languageCode == "it" ) ?
                                    splashController.aboutf["cancelation_it"] :
                                    (widget.htmlType == HtmlType.refund &&
                                    Get.find<LocalizationController>().locale!.languageCode == "it") ?
                                    splashController.aboutf["refund_it"] :
                                     (widget.htmlType == HtmlType.privacyPolicy &&
                                       Get.find<LocalizationController>().locale!.languageCode == "it" 
                                    ) ? splashController.aboutf["privacy_policy_it"] :
                                    (widget.htmlType == HtmlType.privacyPolicy &&
                                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                                    ) ?splashController.aboutf["privacy_policy"] :
                                    (widget.htmlType == HtmlType.aboutUs &&
                                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                                   ) ?
                                    splashController.aboutf["about_us"] :
                                    (widget.htmlType == HtmlType.shippingPolicy &&
                                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                                    ) ? 
                                    splashController.aboutf["shipping_policy"]["value"] :
                                    (widget.htmlType == HtmlType.refund &&
                                    Get.find<LocalizationController>().locale!.languageCode == "en" 
                                    ) ?
                                    splashController.aboutf["refund"]["value"] :
                                    
                                    (widget.htmlType == HtmlType.cancellation &&
                                    Get.find<LocalizationController>().locale!.languageCode == "en" ) ?
                                    splashController.aboutf["cancelation"]["value"] :
                                    
                               (widget.htmlType == HtmlType.termsAndCondition &&
                    Get.find<LocalizationController>().locale!.languageCode == "en"  &&  widget.htmlType==HtmlType.termsAndCondition )?   splashController.aboutf["terms_and_conditions"] :
                   splashController.aboutf["terms_and_conditions_it"],
                                   shrinkWrap: true,
                                                onLinkTap: (String? url, Map<String, String> attributes, element) {
                                                  if (url!.startsWith('www.')) {
                              url = 'https://$url';
                                                  }
                                                  if (kDebugMode) {
                              print('Redirect to url: $url');
                                                  }
                                                  html.window.open(url, "_blank");
                                                },
                                              ),
                                            widget.htmlType==HtmlType.cancellation ? InkWell(
                                              onTap: ()async{
                                                 Get.dialog(const CustomLoader(),
                                                  barrierDismissible: false);
                                              _address =
                                                  await Get.find<LocationController>()
                                                      .getCurrentLocation(true);
                                              _controller.text = _address!.address!;
                                        if (_address != null &&
                                            _controller.text.trim().isNotEmpty) {
                                          Get.dialog(const CustomLoader(),
                                              barrierDismissible: false);
                                          ZoneResponseModel response =
                                              await Get.find<LocationController>()
                                                  .getZone(
                                           '45.46532432494875',
                                           '9.167883803503045',
                                            false,
                                          );
                                          if (response.isSuccess) {
                                            Get.find<LocationController>()
                                                .saveAddressAndNavigate(
                                              _address,
                                             false,
                                          null,
                                             null != null,
                                              ResponsiveHelper.isDesktop(Get.context),
                                            );
                                          } else {
                                            Get.back();
                                            showCustomSnackBar(
                                                'service_not_available_in_current_location'
                                                    .tr);
                                          }
                                        } else {
                                          showCustomSnackBar('pick_an_address'.tr);
                                        }
                                              },
                                              child: Container(
                                                height: 100,width: 100,
                                                child: Image.asset(Images.book, fit: BoxFit.fill,)),
                                            ) : SizedBox(),
                                              SizedBox(height: 27,),
                                       
                            ],
                          ),
                                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                      ),
                    ),
                    
                    // "Chi Siamo" text overlay
                    Positioned(
                    top: 0
                    ,
                      left: 0,
                      right: 0,
                      height: widget.htmlType==HtmlType.refund ? null :   widget.htmlType==HtmlType.aboutUs ?  null   :   widget.htmlType==HtmlType.cancellation ?  null : MediaQuery.of(context).size.height * 0.42, // Half of the screen
                      child: Container(
                      // color: Colors.red,
              child:  Center(
                child: widget.htmlType == HtmlType.refund ? Center(
                  child: Text(
                    "   IL",
                    style: TextStyle(
                        shadows: [
                    Shadow(color: Color.fromARGB(255, 160, 158, 158).withOpacity(0.4), blurRadius: 2, offset: Offset(5, 10))
                   ],
                      color: const Color(0xffFF8B5D), fontSize: 90,fontFamily: 'Intro'),
                  ),
                ) :  widget.htmlType==HtmlType.aboutUs ? Text(
                  "chi".tr,
                  style: TextStyle(
                   shadows: [
                    Shadow(color: const Color.fromARGB(255, 160, 158, 158).withOpacity(0.4), blurRadius: 2, offset: Offset(5, 10))
                   ],
                    color: const Color(0xffFCDDD3),  fontSize: heading, fontFamily: 'Intro'),
                ) : widget.htmlType==HtmlType.cancellation ?   Text(
                    "cosa".tr,
                    style: TextStyle(
                        shadows: [
                    Shadow(color: Color.fromARGB(255, 160, 158, 158).withOpacity(0.4), blurRadius: 2, offset: Offset(5, 10))
                   ],
                      color: const Color(0xffEF9D29),  fontSize: 90, fontFamily: 'Intro'),
                  ): const SizedBox(),
              ),
                      ),
                    ),
                       Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      height: widget.htmlType==HtmlType.refund ? null :   widget.htmlType==HtmlType.aboutUs ?  null   :   widget.htmlType==HtmlType.cancellation ?  null : MediaQuery.of(context).size.height * 0.42, // Half of the screen
                      child: Container(
                      // color: Colors.red,
              child:  Center(
                child: widget.htmlType == HtmlType.refund ? Center(
                  child: Text(
                    "   GRUPPO",
                    style: TextStyle(
                        shadows: [
                    Shadow(color: Color.fromARGB(255, 160, 158, 158).withOpacity(0.4), blurRadius: 2, offset: Offset(5, 10))
                   ],
                      color: Color(0xffFF8B5D),  fontSize: 90, fontFamily: 'Intro'),
                  ),
                ) 
                 : widget.htmlType==HtmlType.cancellation ?   Text(
                    "facciamo".tr,
                    style: TextStyle(
                        shadows: [
                    Shadow(color: Color.fromARGB(255, 160, 158, 158).withOpacity(0.4), blurRadius: 2, offset: Offset(5, 10))
                   ],
                      color: Color(0xffEF9D29),  fontSize: 90, fontFamily: 'Intro'),
                  ): const SizedBox(),
              ),
                      ),
                    ),
                  ],
                ),
              ),
              
              
              
                                    ],
                                    
                                
                                ),
                          )),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
String insertLineBreaks(String text, int wordsPerLine) {
  List<String> words = text.split(' ');
  List<String> lines = [];

  for (int i = 0; i < words.length; i += wordsPerLine) {
    lines.add(words.skip(i).take(wordsPerLine).join(' '));
  }

  return lines.join('<br>');
}
 _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }







class TextShadowPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color shadowColor;
  final Offset offset;

  TextShadowPainter({
    required this.text,
    required this.textStyle,
    required this.shadowColor,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final TextSpan span = TextSpan(
      text: text,
      style: textStyle,
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final Offset textOffset = Offset(
      (size.width - tp.width) / 2,
      (size.height - tp.height) / 2,
    );
    tp.paint(canvas, textOffset);

    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.0);
    final shadowOffset = Offset(textOffset.dx + offset.dx, textOffset.dy + offset.dy);
    canvas.drawParagraph(tp.text! as Paragraph, shadowOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}