import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/data/model/response/zone_response_model.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_app.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:farmacie_stilo/view/base/custom_button.dart';
import 'package:farmacie_stilo/view/base/custom_loader.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:farmacie_stilo/view/base/no_data_screen.dart';
import 'package:farmacie_stilo/view/screens/address/widget/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/view/screens/location/widget/web_landing_page.dart';

class AccessLocationScreen extends StatefulWidget {
  final bool fromSignUp;
  final bool fromHome;
  final String? route;
  const AccessLocationScreen(
      {Key? key,
      required this.fromSignUp,
      required this.fromHome,
      required this.route})
      : super(key: key);

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();

    if (!widget.fromHome &&
        Get.find<LocationController>().getUserAddress() != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.dialog(const CustomLoader(), barrierDismissible: false);
        Get.find<LocationController>().autoNavigate(
          Get.find<LocationController>().getUserAddress(),
          widget.fromSignUp,
          widget.route,
          widget.route != null,
          ResponsiveHelper.isDesktop(context),
        );
      });
    }
    if (_isLoggedIn) {
      Get.find<LocationController>().getAddressList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          CustomAppBarWithoutenddrawer(title: 'set_location'.tr, backButton: widget.fromHome),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: SafeArea(
          child: Padding(
        padding: ResponsiveHelper.isDesktop(context)
            ? EdgeInsets.zero
            : const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GetBuilder<LocationController>(builder: (locationController) {
          return (ResponsiveHelper.isDesktop(context) &&
                  locationController.getUserAddress() == null)
              ? WebLandingPage(
                  fromSignUp: widget.fromSignUp,
                  fromHome: widget.fromHome,
                  route: widget.route,
                )
              : _isLoggedIn
                  ? Column(children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: FooterView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              locationController.addressList != null
                                  ? locationController.addressList!.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: locationController
                                              .addressList!.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                                child: SizedBox(
                                                    width: 700,
                                                    child: AddressWidget(
                                                      val: index+1,
                                                      address:
                                                          locationController
                                                                  .addressList![
                                                              index],
                                                      fromAddress: false,
                                                      onTap: () {
                                                        Get.dialog(
                                                            const CustomLoader(),
                                                            barrierDismissible:
                                                                false);
                                                        AddressModel address =
                                                            locationController
                                                                    .addressList![
                                                                index];
                                                        locationController
                                                            .saveAddressAndNavigate(
                                                          address,
                                                          widget.fromSignUp,
                                                          widget.route,
                                                          widget.route != null,
                                                          ResponsiveHelper
                                                              .isDesktop(
                                                                  context),
                                                        );
                                                      },
                                                    )));
                                          },
                                        )
                                      : NoDataScreen(
                                          text: 'no_saved_address_found'.tr)
                                  : const Center(
                                      child: CircularProgressIndicator()),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              ResponsiveHelper.isDesktop(context)
                                  ? BottomButton(
                                      locationController: locationController,
                                      fromSignUp: widget.fromSignUp,
                                      route: widget.route)
                                  : const SizedBox(),
                            ])),
                      )),
                      ResponsiveHelper.isDesktop(context)
                          ? const SizedBox()
                          : BottomButton(
                              locationController: locationController,
                              fromSignUp: widget.fromSignUp,
                              route: widget.route),
                    ])
                  : Center(
                      child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: FooterView(
                          child: SizedBox(
                              width: 700,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(Images.logo,
                                        height: 220),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeLarge),
                                    Text(
                                        'Farmacie Stilo.'
                                            .tr
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(   color: Color(0xff1a3922) , fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'LM Sans 10'),
                                        // style: robotoMedium.copyWith(
                                        //     fontSize:
                                        //         Dimensions.fontSizeExtraLarge)
                                                ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:22, vertical: 6),
                                      child: Text(
                                        'by_allowing_location_access'.tr,
                                        textAlign: TextAlign.center,
                                        style: robotoRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: Color(0xff1a3922)),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeLarge),
                                    BottomButton(
                                        locationController: locationController,
                                        fromSignUp: widget.fromSignUp,
                                        route: widget.route),
                                  ]))),
                    ));
        }),
      )),
    );
  }
}

class BottomButton extends StatelessWidget {
  final LocationController locationController;
  final bool fromSignUp;
  final String? route;
  const BottomButton(
      {Key? key,
      required this.locationController,
      required this.fromSignUp,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 700,
            child: Column(children: [
              CustomButton(
                buttonText: 'user_current_location'.tr,
                onPressed: () async {
                  // String _color = '0xFFAA6843';
                  // String _color1 = '0xFFc7794c';
                  // Get.find<ThemeController>().changeTheme(Color(int.parse(_color)), Color(int.parse(_color1)));
                  Get.find<LocationController>().checkPermission(() async {
                    Get.dialog(const CustomLoader(), barrierDismissible: false);
                    AddressModel address = await Get.find<LocationController>()
                        .getCurrentLocation(true);
                    ZoneResponseModel response = await locationController
                        .getZone(address.latitude, address.longitude, false);
                    if (response.isSuccess) {
                      locationController.saveAddressAndNavigate(
                        address,
                        fromSignUp,
                        route,
                        route != null,
                        ResponsiveHelper.isDesktop(Get.context),
                      );
                    } else {
                      Get.back();
                      Get.toNamed(RouteHelper.getPickMapRoute(
                          route ?? RouteHelper.accessLocation, route != null));
                      showCustomSnackBar(
                          'service_not_available_in_current_location'.tr);
                    }
                  });
                },
                icon: Icons.my_location,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2, 
                           color: Color(0xffA4A4A4)
                        // color: Theme.of(context).primaryColor
                        ),
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  ),
                  minimumSize: const Size(Dimensions.webMaxWidth, 50),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Get.toNamed(RouteHelper.getPickMapRoute(
                  route ??
                      (fromSignUp
                          ? RouteHelper.signUp
                          : RouteHelper.accessLocation),
                  route != null,
                )),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       right: Dimensions.paddingSizeExtraSmall),
                  //   child:
                  //       Icon(Icons.map, color: Theme.of(context).primaryColor),
                  // ),
                  Text('set_from_map'.tr,
                      textAlign: TextAlign.center,
                      style: robotoRegulars,
                      // style: robotoBold.copyWith(
                      //   color: Theme.of(context).primaryColor,
                      //   fontSize: Dimensions.fontSizeLarge,
                      // )
                      ),
                ]),
              ),
            ])));
  }
}
