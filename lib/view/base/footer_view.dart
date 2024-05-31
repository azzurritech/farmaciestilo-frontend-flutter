// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:farmacie_stilo/controller/splash_controller.dart';
// import 'package:farmacie_stilo/data/model/response/config_model.dart';
// import 'package:farmacie_stilo/helper/responsive_helper.dart';
// import 'package:farmacie_stilo/helper/route_helper.dart';
// import 'package:farmacie_stilo/util/app_constants.dart';
// import 'package:farmacie_stilo/util/dimensions.dart';
// import 'package:farmacie_stilo/util/images.dart';
// import 'package:farmacie_stilo/util/styles.dart';
// import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
// import 'package:farmacie_stilo/view/base/text_hover.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// class FooterView extends StatefulWidget {
//   final Widget child;
//   final double minHeight;
//   final bool visibility;
//   const FooterView(
//       {Key? key,
//       required this.child,
//       this.minHeight = 0.65,
//       this.visibility = true})
//       : super(key: key);

//   @override
//   State<FooterView> createState() => _FooterViewState();
// }

// class _FooterViewState extends State<FooterView> {
//   final TextEditingController _newsLetterController = TextEditingController();
//   final Color _color = Colors.white;
//   final ConfigModel? _config = Get.find<SplashController>().configModel;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       ConstrainedBox(
//         constraints: BoxConstraints(
//             minHeight:
//                 (widget.visibility && ResponsiveHelper.isDesktop(context))
//                     ? MediaQuery.of(context).size.height * widget.minHeight
//                     : MediaQuery.of(context).size.height * 0.7),
//         child: widget.child,
//       ),
//       (widget.visibility && ResponsiveHelper.isDesktop(context))
//           ? Container(
//               color: const Color(0xFFBEDEC5),
//               width: context.width,
//               margin: const EdgeInsets.only(top: Dimensions.paddingSizeLarge,),
//               child: Center(
//                   child: Column(children: [
//                 SizedBox(
//                   width: Dimensions.webMaxWidth,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(12),
                        
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeLarge * 2),
//                                   Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       // mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           AppConstants.appName,
//                                           style: robotoBold.copyWith(
//                                               fontSize: 40, color: _color),
//                                         ),
//                                       ]),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeLarge),
//                                   Text('news_letter'.tr,
//                                       style: robotoBold.copyWith(
//                                           color: _color,
//                                           fontSize: Dimensions.fontSizeSmall)),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeSmall),
//                                   Text(
//                                       'subscribe_to_out_new_channel_to_get_latest_updates'
//                                           .tr,
//                                       style: robotoRegular.copyWith(
//                                           color: _color,
//                                           fontSize:
//                                               Dimensions.fontSizeExtraSmall)),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeLarge),
//                                   Container(
//                                     width: 400,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(
//                                           Dimensions.radiusDefault),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.black.withOpacity(0.05),
//                                             blurRadius: 2)
//                                       ],
//                                     ),
//                                     child: Row(children: [
//                                       const SizedBox(width: 20),
//                                       Expanded(
//                                           child: TextField(
//                                         controller: _newsLetterController,
//                                         style: robotoMedium.copyWith(
//                                             color: Colors.black),
//                                         decoration: InputDecoration(
//                                           hintText: 'your_email_address'.tr,
//                                           hintStyle: robotoRegular.copyWith(
//                                               color: Colors.grey,
//                                               fontSize: Dimensions.fontSizeSmall),
//                                           border: InputBorder.none,
//                                         ),
//                                         maxLines: 1,
//                                       )),
//                                       GetBuilder<SplashController>(
//                                           builder: (splashController) {
//                                         return !splashController.isLoading
//                                             ? InkWell(
//                                                 onTap: () {
//                                                   String email =
//                                                       _newsLetterController.text
//                                                           .trim()
//                                                           .toString();
//                                                   if (email.isEmpty) {
//                                                     showCustomSnackBar(
//                                                         'enter_email_address'.tr);
//                                                   } else if (!GetUtils.isEmail(
//                                                       email)) {
//                                                     showCustomSnackBar(
//                                                         'enter_a_valid_email_address'
//                                                             .tr);
//                                                   } else {
//                                                     Get.find<SplashController>()
//                                                         .subscribeMail(email)
//                                                         .then((value) {
//                                                       if (value) {
//                                                         _newsLetterController
//                                                             .clear();
//                                                       }
//                                                     });
//                                                   }
//                                                 },
//                                                 child: Container(
//                                                   margin:
//                                                       const EdgeInsets.symmetric(
//                                                           horizontal: 2,
//                                                           vertical: 2),
//                                                   decoration: BoxDecoration(
//                                                       color: const Color(0xff1c592d),
//                                                       borderRadius: BorderRadius
//                                                           .circular(Dimensions
//                                                               .radiusDefault)),
//                                                   padding:
//                                                       const EdgeInsets.symmetric(
//                                                           horizontal: 15,
//                                                           vertical: 10),
//                                                   child: Text('subscribe'.tr,
//                                                       style:
//                                                           robotoRegular.copyWith(
//                                                               color: Colors.white,
//                                                               fontSize: Dimensions
//                                                                   .fontSizeSmall)),
//                                                 ),
//                                               )
//                                             : const Center(
//                                                 child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: Dimensions
//                                                         .paddingSizeSmall),
//                                                 child:
//                                                     CircularProgressIndicator(),
//                                               ));
//                                       }),
//                                     ]),
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeDefault),
//                                 ])
                                
//                       ),
//                       // Expanded(
//                       //     flex: 4,
//                       //     child: Column(children: [
//                       //       const SizedBox(
//                       //           height: Dimensions.paddingSizeLarge * 2),
//                       //       (_config!.landingPageLinks!.appUrlAndroidStatus ==
//                       //                   '1' ||
//                       //               _config!.landingPageLinks!
//                       //                       .appUrlIosStatus ==
//                       //                   '1')
//                       //           ? Text(
//                       //               'download_our_apps'.tr,
//                       //               style: robotoBold.copyWith(
//                       //                   color: _color,
//                       //                   fontSize:
//                       //                       Dimensions.fontSizeExtraLarge),
//                       //             )
//                       //           : const SizedBox(),
//                       //       SizedBox(
//                       //           height: (_config!.landingPageLinks!
//                       //                           .appUrlAndroidStatus ==
//                       //                       '1' ||
//                       //                   _config!.landingPageLinks!
//                       //                           .appUrlIosStatus ==
//                       //                       '1')
//                       //               ? Dimensions.paddingSizeLarge
//                       //               : 0),
//                       //       Row(
//                       //           mainAxisAlignment: MainAxisAlignment.center,
//                       //           children: [
//                       //             _config!.landingPageLinks!
//                       //                         .appUrlAndroidStatus ==
//                       //                     '1'
//                       //                 ? InkWell(
//                       //                     onTap: () => _launchURL(_config!
//                       //                             .landingPageLinks!
//                       //                             .appUrlAndroid ??
//                       //                         ''),
//                       //                     child: Padding(
//                       //                       padding: const EdgeInsets.symmetric(
//                       //                           horizontal: Dimensions
//                       //                               .paddingSizeSmall),
//                       //                       child: Image.asset(
//                       //                           Images.landingGooglePlay,
//                       //                           height: 40,
//                       //                           fit: BoxFit.contain),
//                       //                     ),
//                       //                   )
//                       //                 : const SizedBox(),
//                       //             _config!.landingPageLinks!.appUrlIosStatus ==
//                       //                     '1'
//                       //                 ? InkWell(
//                       //                     onTap: () => _launchURL(_config!
//                       //                             .landingPageLinks!
//                       //                             .appUrlIos ??
//                       //                         ''),
//                       //                     child: Padding(
//                       //                       padding: const EdgeInsets.symmetric(
//                       //                           horizontal: Dimensions
//                       //                               .paddingSizeSmall),
//                       //                       child: Image.asset(
//                       //                           Images.landingAppStore,
//                       //                           height: 40,
//                       //                           fit: BoxFit.contain),
//                       //                     ),
//                       //                   )
//                       //                 : const SizedBox(),
//                       //           ]),
//                       //       const SizedBox(height: Dimensions.paddingSizeLarge),
//                       //       if (_config!.socialMedia!.isNotEmpty)
//                       //         GetBuilder<SplashController>(
//                       //             builder: (splashController) {
//                       //           return Column(children: [
//                       //             Text(
//                       //               'follow_us_on'.tr,
//                       //               style: robotoBold.copyWith(
//                       //                   color: _color,
//                       //                   fontSize: Dimensions.fontSizeSmall),
//                       //             ),
//                       //             const SizedBox(
//                       //                 height: Dimensions.paddingSizeSmall),
//                       //             SizedBox(
//                       //                 height: 50,
//                       //                 child: ListView.builder(
//                       //                   scrollDirection: Axis.horizontal,
//                       //                   shrinkWrap: true,
//                       //                   physics:
//                       //                       const NeverScrollableScrollPhysics(),
//                       //                   padding: EdgeInsets.zero,
//                       //                   itemCount: splashController
//                       //                       .configModel!.socialMedia!.length,
//                       //                   itemBuilder: (context, index) {
//                       //                     String? name = splashController
//                       //                         .configModel!
//                       //                         .socialMedia![index]
//                       //                         .name;
//                       //                     late String icon;
//                       //                     if (name == 'facebook') {
//                       //                       icon = Images.facebook;
//                       //                     } else if (name == 'linkedin') {
//                       //                       icon = Images.linkedin;
//                       //                     } else if (name == 'youtube') {
//                       //                       icon = Images.youtube;
//                       //                     } else if (name == 'twitter') {
//                       //                       icon = Images.twitter;
//                       //                     } else if (name == 'instagram') {
//                       //                       icon = Images.instagram;
//                       //                     } else if (name == 'pinterest') {
//                       //                       icon = Images.pinterest;
//                       //                     }
//                       //                     return Padding(
//                       //                       padding: const EdgeInsets.symmetric(
//                       //                           horizontal: Dimensions
//                       //                               .paddingSizeExtraSmall),
//                       //                       child: InkWell(
//                       //                         onTap: () async {
//                       //                           String url = splashController
//                       //                               .configModel!
//                       //                               .socialMedia![index]
//                       //                               .link!;
//                       //                           if (!url
//                       //                               .startsWith('https://')) {
//                       //                             url = 'https://$url';
//                       //                           }
//                       //                           url = url.replaceFirst(
//                       //                               'www.', '');
//                       //                           if (await canLaunchUrlString(
//                       //                               url)) {
//                       //                             _launchURL(url);
//                       //                           }
//                       //                         },
//                       //                         child: Image.asset(icon,
//                       //                             height: 30,
//                       //                             width: 30,
//                       //                             fit: BoxFit.contain),
//                       //                       ),
//                       //                     );
//                       //                   },
//                       //                 )),
//                       //           ]);
//                       //         }),
//                       //     ])),
//                       // Expanded(
//                       //     flex: 2,
//                       //     child: Column(
//                       //         crossAxisAlignment: CrossAxisAlignment.start,
//                       //         children: [
//                       //           const SizedBox(
//                       //               height: Dimensions.paddingSizeLarge * 2),
//                       //           Text('my_account'.tr,
//                       //               style: robotoBold.copyWith(
//                       //                   color: _color,
//                       //                   fontSize: Dimensions.fontSizeSmall)),
//                       //           const SizedBox(
//                       //               height: Dimensions.paddingSizeLarge),
//                       //           FooterButton(
//                       //               title: 'profile'.tr,
//                       //               route: RouteHelper.getProfileRoute()),
//                       //           const SizedBox(
//                       //               height: Dimensions.paddingSizeSmall),
//                       //           FooterButton(
//                       //               title: 'address'.tr,
//                       //               route: RouteHelper.getAddressRoute()),
//                       //           const SizedBox(
//                       //               height: Dimensions.paddingSizeSmall),
//                       //           FooterButton(
//                       //               title: 'my_orders'.tr,
//                       //               route: RouteHelper.getOrderRoute()),
//                       //           SizedBox(
//                       //               height: _config!.toggleStoreRegistration!
//                       //                   ? Dimensions.paddingSizeSmall
//                       //                   : 0),
//                       //           _config!.toggleStoreRegistration!
//                       //               ? FooterButton(
//                       //                   title: 'become_a_seller'.tr,
//                       //                   url: true,
//                       //                   route:
//                       //                       '${AppConstants.baseUrl}/store/apply',
//                       //                 )
//                       //               : const SizedBox(),
//                       //           SizedBox(
//                       //               height: _config!.toggleDmRegistration!
//                       //                   ? Dimensions.paddingSizeSmall
//                       //                   : 0),
//                       //           _config!.toggleDmRegistration!
//                       //               ? FooterButton(
//                       //                   title: 'become_a_delivery_man'.tr,
//                       //                   url: true,
//                       //                   route:
//                       //                       '${AppConstants.baseUrl}/deliveryman/apply',
//                       //                 )
//                       //               : const SizedBox(),
//                       //         ])),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 31.0),
//                         child: Expanded(
//                             flex: 2,
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeLarge * 2),
//                                   Text('quick_links'.tr,
//                                       style: robotoBold.copyWith(
//                                           color: _color,
//                                           fontSize: Dimensions.fontSizeSmall)),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeLarge),
//                                   // FooterButton(
//                                   //     title: 'contact_us'.tr,
//                                   //     route: RouteHelper.getSupportRoute()),
//                                   // const SizedBox(
//                                   //     height: Dimensions.paddingSizeSmall),
//                                   FooterButton(
//                                       title: 'privacy_policy'.tr,
//                                       route: RouteHelper.getHtmlRoute(
//                                           'privacy-policy')),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeSmall),
                                  // FooterButton(
                                  //     title: 'terms_and_condition'.tr,
                                  //     route: RouteHelper.getHtmlRoute(
                                  //         'terms-and-condition')),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeSmall),
//                                   _config!.refundPolicyStatus == 1
//                                       ? FooterButton(
//                                           title: 'refund_policy'.tr,
//                                           route: RouteHelper.getHtmlRoute(
//                                               'refund-policy'))
//                                       : const SizedBox(),
//                                   SizedBox(
//                                       height: _config!.refundPolicyStatus == 1
//                                           ? Dimensions.paddingSizeSmall
//                                           : 0.0),
//                                   _config!.cancellationPolicyStatus == 1
//                                       ? FooterButton(
//                                           title: 'cancellation_policy'.tr,
//                                           route: RouteHelper.getHtmlRoute(
//                                               'cancellation-policy'))
//                                       : const SizedBox(),
//                                   SizedBox(
//                                       height:
//                                           _config!.cancellationPolicyStatus == 1
//                                               ? Dimensions.paddingSizeSmall
//                                               : 0.0),
//                                   _config!.shippingPolicyStatus == 1
//                                       ? FooterButton(
//                                           title: 'shipping_policy'.tr,
//                                           route: RouteHelper.getHtmlRoute(
//                                               'shipping-policy'))
//                                       : const SizedBox(),
//                                   SizedBox(
//                                       height: _config!.shippingPolicyStatus == 1
//                                           ? Dimensions.paddingSizeSmall
//                                           : 0.0),
//                                   FooterButton(
//                                       title: 'who'.tr,
//                                       route:
//                                           RouteHelper.getHtmlRoute('about-us')),
//                                 ])),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(thickness: 0.5, color: Theme.of(context).disabledColor),
//                 Text(
//                   _config!.footerText ?? '',
//                   style: robotoRegular.copyWith(
//                       color: _color, fontSize: Dimensions.fontSizeExtraSmall),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeDefault),
//               ])),
//             )
//           : const SizedBox.shrink(),
//     ]);
//   }

//   _launchURL(String url) async {
//     if (await canLaunchUrlString(url)) {
//       await launchUrlString(url, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

// class FooterButton extends StatelessWidget {
//   final String title;
//   final String route;
//   final bool url;
//   const FooterButton(
//       {Key? key, required this.title, required this.route, this.url = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextHover(builder: (hovered) {
//       return InkWell(
//         hoverColor: Colors.transparent,
//         onTap: route.isNotEmpty
//             ? () async {
//                 if (url) {
//                   if (await canLaunchUrlString(route)) {
//                     launchUrlString(route,
//                         mode: LaunchMode.externalApplication);
//                   }
//                 } else {
//                   Get.toNamed(route);
//                 }
//               }
//             : null,
//         child: Text(title,
//             style: hovered
//                 ? robotoMedium.copyWith(
//                   fontFamily: 'LM Sans 10',
//                     color: Theme.of(context).primaryColor,
//                     fontSize: Dimensions.fontSizeSmall)
//                 : robotoRegular.copyWith(
//                     color: Colors.white,
//                     fontSize: Dimensions.fontSizeExtraSmall)),
//       );
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/data/model/response/config_model.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/text_hover.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterView extends StatefulWidget {
  final Widget child;
  final double minHeight;
  final bool visibility;
  const FooterView(
      {Key? key,
      required this.child,
      this.minHeight = 0.65,
      this.visibility = true})
      : super(key: key);

  @override
  State<FooterView> createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {
  final TextEditingController _newsLetterController = TextEditingController();
  final Color _color = Colors.white;
  final ConfigModel? _config = Get.find<SplashController>().configModel;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ConstrainedBox(
        constraints: BoxConstraints(
            minHeight:
                (widget.visibility && ResponsiveHelper.isDesktop(context))
                    ? MediaQuery.of(context).size.height * widget.minHeight
                    : MediaQuery.of(context).size.height * 0.7),
        child: widget.child,
      ),
      (widget.visibility && ResponsiveHelper.isDesktop(context))
          ? Container(
            height: 330,
              color: const Color(0xffD5EBC8),
              width: context.width,
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeLarge,),
              child: Center(
                  child: Column(children: [
                   
                SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 12),
                        
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Container(
                               height: 120, width: 130,
                              child: Image.asset(Images.imagebanner, fit: BoxFit.contain,)),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeLarge * 1),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                         "FARMACIE STILO.",
                                          style: robotoBold.copyWith(
                                           fontSize: Dimensions.fontSizeSmall, color: _color),
                                        ),
                                      ]),
                                  // const SizedBox(
                                  //     height: Dimensions.paddingSizeLarge),
                                  Text('Farmacia IGEA S.r.l. a socio unico',
                                      style: robotoBold.copyWith(
                                          color: _color,
                                          fontSize: Dimensions.fontSizeSmall)),
                                  // const SizedBox(
                                  //     height: Dimensions.paddingSizeSmall),
                                  Text(
                                      'Via Gustavo Modena 25, Milano',
                                      style: robotoBold.copyWith(
                                          color: _color,
                                          fontSize: Dimensions.fontSizeSmall)),
                                    //  const SizedBox(
                                    //   height: Dimensions.paddingSizeSmall),
                                        Text(
                                      'C.F., P.IVA 07980390962',
                                      style: robotoBold.copyWith(
                                          color: _color,
                                          fontSize: Dimensions.fontSizeSmall)),
                                      //       const SizedBox(
                                      // height: Dimensions.paddingSizeSmall),
                                        Text(
                                      'telefono: 022049584',
                                      style: robotoBold.copyWith(
                                          color: _color,
                                          fontSize: Dimensions.fontSizeSmall)),
                                      //        const SizedBox(
                                      // height: Dimensions.paddingSizeSmall),
                                        Text(
                                      'email: farmaciaigea@farmaciestilo.com',
                                      style: robotoBold.copyWith(
                                          color: _color,
                                          fontSize: Dimensions.fontSizeSmall)),
                                      //       const SizedBox(
                                      // height: Dimensions.paddingSizeSmall),
                                        Text(
                                      'pec: mi01598@pec1.federfarma.lombardia.it',
                                      style: robotoBold.copyWith(
                                          color: _color,
                                          fontSize: Dimensions.fontSizeSmall)),
                                  // const SizedBox(
                                  //     height: Dimensions.paddingSizeLarge),
                                  Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDefault),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Colors.black.withOpacity(0.05),
                                      //       blurRadius: 2)
                                      // ],
                                    ),
                                    
                                    // child: Row(children: [
                                    //   const SizedBox(width: 20),
                                    //   Expanded(
                                    //       child: TextField(
                                    //     controller: _newsLetterController,
                                    //     style: robotoMedium.copyWith(
                                    //         color: Colors.black),
                                    //     decoration: InputDecoration(
                                    //       hintText: 'your_email_address'.tr,
                                    //       hintStyle: robotoRegular.copyWith(
                                    //           color: Colors.grey,
                                    //           fontSize: Dimensions.fontSizeSmall),
                                    //       border: InputBorder.none,
                                    //     ),
                                    //     maxLines: 1,
                                    //   )),
                                    //   GetBuilder<SplashController>(
                                    //       builder: (splashController) {
                                    //     return !splashController.isLoading
                                    //         ? InkWell(
                                    //             onTap: () {
                                    //               String email =
                                    //                   _newsLetterController.text
                                    //                       .trim()
                                    //                       .toString();
                                    //               if (email.isEmpty) {
                                    //                 showCustomSnackBar(
                                    //                     'enter_email_address'.tr);
                                    //               } else if (!GetUtils.isEmail(
                                    //                   email)) {
                                    //                 showCustomSnackBar(
                                    //                     'enter_a_valid_email_address'
                                    //                         .tr);
                                    //               } else {
                                    //                 Get.find<SplashController>()
                                    //                     .subscribeMail(email)
                                    //                     .then((value) {
                                    //                   if (value) {
                                    //                     _newsLetterController
                                    //                         .clear();
                                    //                   }
                                    //                 });
                                    //               }
                                    //             },
                                    //             child: Container(
                                    //               margin:
                                    //                   const EdgeInsets.symmetric(
                                    //                       horizontal: 2,
                                    //                       vertical: 2),
                                    //               decoration: BoxDecoration(
                                    //                   color: const Color(0xff1c592d),
                                    //                   borderRadius: BorderRadius
                                    //                       .circular(Dimensions
                                    //                           .radiusDefault)),
                                    //               padding:
                                    //                   const EdgeInsets.symmetric(
                                    //                       horizontal: 15,
                                    //                       vertical: 10),
                                    //               child: Text('subscribe'.tr,
                                    //                   style:
                                    //                       robotoRegular.copyWith(
                                    //                           color: Colors.white,
                                    //                           fontSize: Dimensions
                                    //                               .fontSizeSmall)),
                                    //             ),
                                    //           )
                                    //         : const Center(
                                    //             child: Padding(
                                    //             padding: EdgeInsets.symmetric(
                                    //                 horizontal: Dimensions
                                    //                     .paddingSizeSmall),
                                    //             child:
                                    //                 CircularProgressIndicator(),
                                    //           ));
                                    //   }),
                                    // ]),
                                  ),
                                  // const SizedBox(
                                  //     height: Dimensions.paddingSizeDefault),
                                ]
                                )
                                
                      ),
                          
                                    // child: Row(children: [
                                    //   const SizedBox(width: 20),
                                    //   Expanded(
                                    //       child: TextField(
                                    //     controller: _newsLetterController,
                                    //     style: robotoMedium.copyWith(
                                    //         color: Colors.black),
                                    //     decoration: InputDecoration(
                                    //       hintText: 'your_email_address'.tr,
                                    //       hintStyle: robotoRegular.copyWith(
                                    //           color: Colors.grey,
                                    //           fontSize: Dimensions.fontSizeSmall),
                                    //       border: InputBorder.none,
                                    //     ),
                                    //     maxLines: 1,
                                    //   )),
                                    //   GetBuilder<SplashController>(
                                    //       builder: (splashController) {
                                    //     return !splashController.isLoading
                                    //         ? InkWell(
                                    //             onTap: () {
                                    //               String email =
                                    //                   _newsLetterController.text
                                    //                       .trim()
                                    //                       .toString();
                                    //               if (email.isEmpty) {
                                    //                 showCustomSnackBar(
                                    //                     'enter_email_address'.tr);
                                    //               } else if (!GetUtils.isEmail(
                                    //                   email)) {
                                    //                 showCustomSnackBar(
                                    //                     'enter_a_valid_email_address'
                                    //                         .tr);
                                    //               } else {
                                    //                 Get.find<SplashController>()
                                    //                     .subscribeMail(email)
                                    //                     .then((value) {
                                    //                   if (value) {
                                    //                     _newsLetterController
                                    //                         .clear();
                                    //                   }
                                    //                 });
                                    //               }
                                    //             },
                                    //             child: Container(
                                    //               margin:
                                    //                   const EdgeInsets.symmetric(
                                    //                       horizontal: 2,
                                    //                       vertical: 2),
                                    //               decoration: BoxDecoration(
                                    //                   color: const Color(0xff1c592d),
                                    //                   borderRadius: BorderRadius
                                    //                       .circular(Dimensions
                                    //                           .radiusDefault)),
                                    //               padding:
                                    //                   const EdgeInsets.symmetric(
                                    //                       horizontal: 15,
                                    //                       vertical: 10),
                                    //               child: Text('subscribe'.tr,
                                    //                   style:
                                    //                       robotoRegular.copyWith(
                                    //                           color: Colors.white,
                                    //                           fontSize: Dimensions
                                    //                               .fontSizeSmall)),
                                    //             ),
                                    //           )
                                    //         : const Center(
                                    //             child: Padding(
                                    //             padding: EdgeInsets.symmetric(
                                    //                 horizontal: Dimensions
                                    //                     .paddingSizeSmall),
                                    //             child:
                                    //                 CircularProgressIndicator(),
                                    //           ));
                                    //   }),
                                    // ]),
                      Expanded(
                          flex: 4,
                          child: Column(children: [
                            // const SizedBox(
                            //     height: Dimensions.paddingSizeLarge * 2),
                            // (_config!.landingPageLinks!.appUrlAndroidStatus ==
                            //             '1' ||
                            //         _config!.landingPageLinks!
                            //                 .appUrlIosStatus ==
                            //             '1')
                            //     ? Text(
                            //         'download_our_apps'.tr,
                            //         style: robotoBold.copyWith(
                            //             color: _color,
                            //             fontSize:
                            //                 Dimensions.fontSizeExtraLarge),
                            //       )
                            //     : const SizedBox(),
                            // SizedBox(
                            //     height: (_config!.landingPageLinks!
                            //                     .appUrlAndroidStatus ==
                            //                 '1' ||
                            //             _config!.landingPageLinks!
                            //                     .appUrlIosStatus ==
                            //                 '1')
                            //         ? Dimensions.paddingSizeLarge
                            //         : 0),
                            // Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       _config!.landingPageLinks!
                            //                   .appUrlAndroidStatus ==
                            //               '1'
                            //           ? InkWell(
                            //               onTap: () => _launchURL(_config!
                            //                       .landingPageLinks!
                            //                       .appUrlAndroid ??
                            //                   ''),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: Dimensions
                            //                         .paddingSizeSmall),
                            //                 child: Image.asset(
                            //                     Images.landingGooglePlay,
                            //                     height: 40,
                            //                     fit: BoxFit.contain),
                            //               ),
                            //             )
                            //           : const SizedBox(),
                            //       _config!.landingPageLinks!.appUrlIosStatus ==
                            //               '1'
                            //           ? InkWell(
                            //               onTap: () => _launchURL(_config!
                            //                       .landingPageLinks!
                            //                       .appUrlIos ??
                            //                   ''),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: Dimensions
                            //                         .paddingSizeSmall),
                            //                 child: Image.asset(
                            //                     Images.landingAppStore,
                            //                     height: 40,
                            //                     fit: BoxFit.contain),
                            //               ),
                            //             )
                            //           : const SizedBox(),
                            //     ]),
                            // const SizedBox(height: Dimensions.paddingSizeLarge),
                            // if (_config!.socialMedia!.isNotEmpty)
                            //   GetBuilder<SplashController>(
                            //       builder: (splashController) {
                            //     return Column(children: [
                            //       Text(
                            //         'follow_us_on'.tr,
                            //         style: robotoBold.copyWith(
                            //             color: _color,
                            //             fontSize: Dimensions.fontSizeSmall),
                            //       ),
                            //       const SizedBox(
                            //           height: Dimensions.paddingSizeSmall),
                            //       SizedBox(
                            //           height: 50,
                            //           child: ListView.builder(
                            //             scrollDirection: Axis.horizontal,
                            //             shrinkWrap: true,
                            //             physics:
                            //                 const NeverScrollableScrollPhysics(),
                            //             padding: EdgeInsets.zero,
                            //             itemCount: splashController
                            //                 .configModel!.socialMedia!.length,
                            //             itemBuilder: (context, index) {
                            //               String? name = splashController
                            //                   .configModel!
                            //                   .socialMedia![index]
                            //                   .name;
                            //               late String icon;
                            //               if (name == 'facebook') {
                            //                 icon = Images.facebook;
                            //               } else if (name == 'linkedin') {
                            //                 icon = Images.linkedin;
                            //               } else if (name == 'youtube') {
                            //                 icon = Images.youtube;
                            //               } else if (name == 'twitter') {
                            //                 icon = Images.twitter;
                            //               } else if (name == 'instagram') {
                            //                 icon = Images.instagram;
                            //               } else if (name == 'pinterest') {
                            //                 icon = Images.pinterest;
                            //               }
                            //               return Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: Dimensions
                            //                         .paddingSizeExtraSmall),
                            //                 child: InkWell(
                            //                   onTap: () async {
                            //                     String url = splashController
                            //                         .configModel!
                            //                         .socialMedia![index]
                            //                         .link!;
                            //                     if (!url
                            //                         .startsWith('https://')) {
                            //                       url = 'https://$url';
                            //                     }
                            //                     url = url.replaceFirst(
                            //                         'www.', '');
                            //                     if (await canLaunchUrlString(
                            //                         url)) {
                            //                       _launchURL(url);
                            //                     }
                            //                   },
                            //                   child: Image.asset(icon,
                            //                       height: 30,
                            //                       width: 30,
                            //                       fit: BoxFit.contain),
                            //                 ),
                            //               );
                            //             },
                            //           )),
                            //     ]);
                            //   }),
                          ])),
                      // Expanded(
                      //     flex: 2,
                      //     child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const SizedBox(
                      //               height: Dimensions.paddingSizeLarge * 2),
                      //           Text('my_account'.tr,
                      //               style: robotoBold.copyWith(
                      //                   color: _color,
                      //                   fontSize: Dimensions.fontSizeSmall)),
                      //           const SizedBox(
                      //               height: Dimensions.paddingSizeLarge),
                      //           FooterButton(
                      //               title: 'profile'.tr,
                      //               route: RouteHelper.getProfileRoute()),
                      //           const SizedBox(
                      //               height: Dimensions.paddingSizeSmall),
                      //           FooterButton(
                      //               title: 'address'.tr,
                      //               route: RouteHelper.getAddressRoute()),
                      //           const SizedBox(
                      //               height: Dimensions.paddingSizeSmall),
                      //           FooterButton(
                      //               title: 'my_orders'.tr,
                      //               route: RouteHelper.getOrderRoute()),
                      //           SizedBox(
                      //               height: _config!.toggleStoreRegistration!
                      //                   ? Dimensions.paddingSizeSmall
                      //                   : 0),
                      //           _config!.toggleStoreRegistration!
                      //               ? FooterButton(
                      //                   title: 'become_a_seller'.tr,
                      //                   url: true,
                      //                   route:
                      //                       '${AppConstants.baseUrl}/store/apply',
                      //                 )
                      //               : const SizedBox(),
                      //           SizedBox(
                      //               height: _config!.toggleDmRegistration!
                      //                   ? Dimensions.paddingSizeSmall
                      //                   : 0),
                      //           _config!.toggleDmRegistration!
                      //               ? FooterButton(
                      //                   title: 'become_a_delivery_man'.tr,
                      //                   url: true,
                      //                   route:
                      //                       '${AppConstants.baseUrl}/deliveryman/apply',
                      //                 )
                      //               : const SizedBox(),
                      //         ])),
                        // const SizedBox(
                        //               height: Dimensions.paddingSizeLarge),
                        //           Text('news_letter'.tr,
                        //               style: robotoBold.copyWith(
                        //                   color: _color,
                        //                   fontSize: Dimensions.fontSizeSmall)),
                        //           const SizedBox(
                        //               height: Dimensions.paddingSizeSmall),
                        //           Text(
                        //               'subscribe_to_out_new_channel_to_get_latest_updates'
                        //                   .tr,
                        //               style: robotoRegular.copyWith(
                        //                   color: _color,
                        //                   fontSize:
                        //                       Dimensions.fontSizeExtraSmall)),











    
                                    // child: Row(children: [
                                    //   const SizedBox(width: 20),
                                    //   Expanded(
                                    //       child: TextField(
                                    //     controller: _newsLetterController,
                                    //     style: robotoMedium.copyWith(
                                    //         color: Colors.black),
                                    //     decoration: InputDecoration(
                                    //       hintText: 'your_email_address'.tr,
                                    //       hintStyle: robotoRegular.copyWith(
                                    //           color: Colors.grey,
                                    //           fontSize: Dimensions.fontSizeSmall),
                                    //       border: InputBorder.none,
                                    //     ),
                                    //     maxLines: 1,
                                    //   )),
                                    //   GetBuilder<SplashController>(
                                    //       builder: (splashController) {
                                    //     return !splashController.isLoading
                                    //         ? InkWell(
                                    //             onTap: () {
                                    //               String email =
                                    //                   _newsLetterController.text
                                    //                       .trim()
                                    //                       .toString();
                                    //               if (email.isEmpty) {
                                    //                 showCustomSnackBar(
                                    //                     'enter_email_address'.tr);
                                    //               } else if (!GetUtils.isEmail(
                                    //                   email)) {
                                    //                 showCustomSnackBar(
                                    //                     'enter_a_valid_email_address'
                                    //                         .tr);
                                    //               } else {
                                    //                 Get.find<SplashController>()
                                    //                     .subscribeMail(email)
                                    //                     .then((value) {
                                    //                   if (value) {
                                    //                     _newsLetterController
                                    //                         .clear();
                                    //                   }
                                    //                 });
                                    //               }
                                    //             },
                                    //             child: Container(
                                    //               margin:
                                    //                   const EdgeInsets.symmetric(
                                    //                       horizontal: 2,
                                    //                       vertical: 2),
                                    //               decoration: BoxDecoration(
                                    //                   color: const Color(0xff1c592d),
                                    //                   borderRadius: BorderRadius
                                    //                       .circular(Dimensions
                                    //                           .radiusDefault)),
                                    //               padding:
                                    //                   const EdgeInsets.symmetric(
                                    //                       horizontal: 15,
                                    //                       vertical: 10),
                                    //               child: Text('subscribe'.tr,
                                    //                   style:
                                    //                       robotoRegular.copyWith(
                                    //                           color: Colors.white,
                                    //                           fontSize: Dimensions
                                    //                               .fontSizeSmall)),
                                    //             ),
                                    //           )
                                    //         : const Center(
                                    //             child: Padding(
                                    //             padding: EdgeInsets.symmetric(
                                    //                 horizontal: Dimensions
                                    //                     .paddingSizeSmall),
                                    //             child:
                                    //                 CircularProgressIndicator(),
                                    //           ));
                                    //   }),
                                    // ]),
                      Expanded(
                          flex: 2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge * 2),
                                Text('quick_links'.tr,
                                    style: robotoBold.copyWith(
                                        color: _color,
                                        fontSize: Dimensions.fontSizeSmall)),
                             
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                FooterButton(
                                    title: 'privacy_policy'.tr,
                                    route: RouteHelper.getotherHtmlRoute(
                                        'privacy-policy')),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                             
                                _config!.shippingPolicyStatus == 1
                                    ? FooterButton(
                                        title: 'shipping_policy'.tr,
                                        route: RouteHelper.getHtmlRoute(
                                            'shipping-policy'))
                                    : const SizedBox(),
                                SizedBox(
                                    height: _config!.shippingPolicyStatus == 1
                                        ? Dimensions.paddingSizeSmall
                                        : 0.0),
                                // FooterButton(
                                //     title: 'TERME AND CONDITIONS',
                                //     route:
                                //         RouteHelper.getHtmlRoute('terms-and-conditions')),
                                   FooterButton(
                                      title: 'terms_conditions'.tr,
                                      route:  RouteHelper.getotherHtmlRoute('terms-and-condition')),
                                           const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                             InkWell(
                                              onTap: ()async{
                                                
                                                await canLaunchUrl(Uri.parse("https://www.salute.gov.it/portale/temi/p2_6.jsp?lingua=italiano&id=4402&area=farmaci&menu=online&VOLID=F2966"));
                                               launchUrl(Uri.parse("https://www.salute.gov.it/portale/temi/p2_6.jsp?lingua=italiano&id=4402&area=farmaci&menu=online&VOLID=F2966"));
                                              },
                                               child: Container(
                                                height: 140,width: 130,
                                                child:DecoratedBox(decoration: BoxDecoration(
                                                  image: DecorationImage(image: AssetImage(Images.landingn, ), fit: BoxFit.fill)
                                                )
                                                )
                                                ),
                                             ),
                              ]
                              )
                              ),
                    ],
                  ),
                ),
                // Divider(thickness: 0.5, color: Theme.of(context).disabledColor),
                // Text(
                //   _config!.footerText ?? '',
                //   style: robotoRegular.copyWith(
                //       color: _color, fontSize: Dimensions.fontSizeExtraSmall),
                // ),
                // const SizedBox(height: Dimensions.paddingSizeDefault),
              ])),
            )

          : const SizedBox.shrink(),
    ]);
  }

  _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class FooterButton extends StatelessWidget {
  final String title;
  final String route;
  final bool url;
  const FooterButton(
      {Key? key, required this.title, required this.route, this.url = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        hoverColor: Colors.transparent,
        onTap: route.isNotEmpty
            ? () async {
                if (url) {
                  if (await canLaunchUrlString(route)) {
                    launchUrlString(route,
                        mode: LaunchMode.externalApplication);
                  }
                } else {
                  Get.toNamed(route);
                }
              }
            : null,
        child: Text(title,
            // style: hovered
            //     ? robotoMedium.copyWith(
            //         color: Theme.of(context).primaryColor,
            //         fontSize: Dimensions.fontSizeSmall)
            //     : robotoRegular.copyWith(
            //         color: Colors.white,
            //         fontSize: Dimensions.fontSizeExtraSmall)
             style:  robotoRegular.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeExtraSmall)
                    ),
      );
    });
  }
}