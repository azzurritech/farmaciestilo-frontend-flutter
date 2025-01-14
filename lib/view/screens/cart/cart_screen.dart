import 'package:farmacie_stilo/controller/cart_controller.dart';
import 'package:farmacie_stilo/controller/coupon_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/helper/price_converter.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:farmacie_stilo/view/base/custom_button.dart';
import 'package:farmacie_stilo/view/base/custom_snackbar.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:farmacie_stilo/view/base/no_data_screen.dart';
import 'package:farmacie_stilo/view/base/web_constrained_box.dart';
import 'package:farmacie_stilo/view/screens/cart/widget/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  final bool fromNav;
  const CartScreen({Key? key, required this.fromNav}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: 'my_cart'.tr,
          backButton: (ResponsiveHelper.isDesktop(context) || !widget.fromNav)),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        child: GetBuilder<CartController>(
          builder: (cartController) {
            // List<List<AddOns>> _addOnsList = [];
            // List<bool> _availableList = [];
            // double _itemPrice = 0;
            // double _addOns = 0;
            // cartController.cartList.forEach((cartModel) {
            //
            //   List<AddOns> _addOnList = [];
            //   cartModel.addOnIds.forEach((addOnId) {
            //     for(AddOns addOns in cartModel.item.addOns) {
            //       if(addOns.id == addOnId.id) {
            //         _addOnList.add(addOns);
            //         break;
            //       }
            //     }
            //   });
            //   _addOnsList.add(_addOnList);
            //
            //   _availableList.add(DateConverter.isAvailable(cartModel.item.availableTimeStarts, cartModel.item.availableTimeEnds));
            //
            //   for(int index=0; index<_addOnList.length; index++) {
            //     _addOns = _addOns + (_addOnList[index].price * cartModel.addOnIds[index].quantity);
            //   }
            //   _itemPrice = _itemPrice + (cartModel.price * cartModel.quantity);
            // });
            // double _subTotal = _itemPrice + _addOns;
        
            return cartController.cartList.isNotEmpty
                ?  GetPlatform.isMobile ? Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            padding: ResponsiveHelper.isDesktop(context)
                                ? const EdgeInsets.only(
                                    top: Dimensions.paddingSizeSmall,
                                  )
                                : const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                            physics: const BouncingScrollPhysics(),
                            child: FooterView(
                              child: SizedBox(
                                width: Dimensions.webMaxWidth,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Product
                                      WebConstrainedBox(
                                        dataLength:
                                            cartController.cartList.length,
                                        minLength: 5,
                                        minHeight: 0.6,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              cartController.cartList.length,
                                          itemBuilder: (context, index) {
                                            return CartItemWidget(
                                                cart: cartController
                                                    .cartList[index],
                                                cartIndex: index,
                                                addOns: cartController
                                                    .addOnsList[index],
                                                isAvailable: cartController
                                                    .availableList[index]);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                
                                      // Total
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('item_price'.tr,
                                                style: robotoRegular),
                                            Text(
                                                PriceConverter.convertPrice(
                                                    cartController.itemPrice),
                                                style: robotoRegular,
                                                textDirection: TextDirection.ltr),
                                          ]),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('discount'.tr,
                                                style: robotoRegular),
                                            Text(
                                                '(-) ${PriceConverter.convertPrice(cartController.itemDiscountPrice)}',
                                                style: robotoRegular,
                                                textDirection: TextDirection.ltr),
                                          ]),
                                      SizedBox(
                                          height: Get.find<SplashController>()
                                                  .configModel!
                                                  .moduleConfig!
                                                  .module!
                                                  .addOn!
                                              ? 10
                                              : 0),
                
                                      Get.find<SplashController>()
                                              .configModel!
                                              .moduleConfig!
                                              .module!
                                              .addOn!
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('addons'.tr,
                                                    style: robotoRegular),
                                                Text(
                                                    '(+) ${PriceConverter.convertPrice(cartController.addOns)}',
                                                    style: robotoRegular,
                                                    textDirection:
                                                        TextDirection.ltr),
                                              ],
                                            )
                                          : const SizedBox(),
                
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical:
                                      //           Dimensions.paddingSizeSmall),
                                      //   child: Divider(
                                      //       thickness: 1,
                                      //       color: Theme.of(context)
                                      //           .hintColor
                                      //           .withOpacity(0.5)),
                                      // ),
                
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('subtotal'.tr,
                                              style: robotoMedium),
                                          Text(
                                              PriceConverter.convertPrice(
                                                  cartController.subTotal),
                                              style: robotoMedium,
                                              textDirection: TextDirection.ltr),
                                        ],
                                      ),
                
                                      ResponsiveHelper.isDesktop(context)
                                          ? CheckoutButton(
                                              cartController: cartController,
                                              availableList:
                                                  cartController.availableList)
                                          : const SizedBox.shrink(),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ResponsiveHelper.isDesktop(context)
                          ? const SizedBox.shrink()
                          : CheckoutButton(
                              cartController: cartController,
                              availableList: cartController.availableList),
                    ],
                  ): Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            padding: ResponsiveHelper.isDesktop(context)
                                ? const EdgeInsets.only(
                                    top: Dimensions.paddingSizeSmall,
                                  )
                                : const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                            physics: const BouncingScrollPhysics(),
                            child: FooterView(
                              child: SizedBox(
                                width: Dimensions.webMaxWidth,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Product
                                      Padding(
                                        padding: const EdgeInsets.symmetric (horizontal: 78.0),
                                        child: WebConstrainedBox(
                                          dataLength:
                                              cartController.cartList.length,
                                          minLength: 5,
                                          minHeight: 0.6,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                cartController.cartList.length,
                                            itemBuilder: (context, index) {
                                              return CartItemWidget(
                                                  cart: cartController
                                                      .cartList[index],
                                                  cartIndex: index,
                                                  addOns: cartController
                                                      .addOnsList[index],
                                                  isAvailable: cartController
                                                      .availableList[index]);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                
                                      // Total
                                      Padding(
                                       padding: const EdgeInsets.symmetric (horizontal: 78.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('item_price'.tr,
                                                  style: robotoRegular),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      cartController.itemPrice),
                                                  style: robotoRegular,
                                                  textDirection: TextDirection.ltr),
                                            ]),
                                      ),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeSmall),
                
                                      Padding(
                                           padding: const EdgeInsets.symmetric (horizontal: 78.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('discount'.tr,
                                                  style: robotoRegular),
                                              Text(
                                                  '(-) ${PriceConverter.convertPrice(cartController.itemDiscountPrice)}',
                                                  style: robotoRegular,
                                                  textDirection: TextDirection.ltr),
                                            ]),
                                      ),
                                      SizedBox(
                                          height: Get.find<SplashController>()
                                                  .configModel!
                                                  .moduleConfig!
                                                  .module!
                                                  .addOn!
                                              ? 10
                                              : 0),
                
                                      Get.find<SplashController>()
                                              .configModel!
                                              .moduleConfig!
                                              .module!
                                              .addOn!
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('addons'.tr,
                                                    style: robotoRegular),
                                                Text(
                                                    '(+) ${PriceConverter.convertPrice(cartController.addOns)}',
                                                    style: robotoRegular,
                                                    textDirection:
                                                        TextDirection.ltr),
                                              ],
                                            )
                                          : const SizedBox(),
                
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical:
                                      //           Dimensions.paddingSizeSmall),
                                      //   child: Divider(
                                      //       thickness: 1,
                                      //       color: Theme.of(context)
                                      //           .hintColor
                                      //           .withOpacity(0.5)),
                                      // ),
                
                                      Padding(
                                      padding: const EdgeInsets.symmetric (horizontal: 78.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('subtotal'.tr,
                                                style: robotoMedium),
                                            Text(
                                                PriceConverter.convertPrice(
                                                    cartController.subTotal),
                                                style: robotoMedium,
                                                textDirection: TextDirection.ltr),
                                          ],
                                        ),
                                      ),
                
                                      ResponsiveHelper.isDesktop(context)
                                          ? CheckoutButton(
                                              cartController: cartController,
                                              availableList:
                                                  cartController.availableList)
                                          : const SizedBox.shrink(),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ResponsiveHelper.isDesktop(context)
                          ? const SizedBox.shrink()
                          : CheckoutButton(
                              cartController: cartController,
                              availableList: cartController.availableList),
                    ],
                  )
                : const NoDataScreen(isCart: true, text: '', showFooter: true);
          },
        ),
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  final CartController cartController;
  final List<bool> availableList;
  const CheckoutButton(
      {Key? key, required this.cartController, required this.availableList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 89.0 , vertical: 9),
      child: Container(
        width: Dimensions.webMaxWidth,
        padding: ResponsiveHelper.isDesktop(context)
            ? const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge)
            : const EdgeInsets.all(Dimensions.paddingSizeSmall),
       child: CustomButton(
            buttonText: 'proceed_to_checkout'.tr,
            onPressed: () {
              
           for(int i=0 ; i<cartController.cartList.length; i++){
            print(cartController.cartList[i].item!.name.toString());
              print(cartController.cartList[i].item!.toString());
           }
      
              /*if(Get.find<SplashController>().module == null) {
            showCustomSnackBar('choose_a_module_first'.tr);
          }else */
              if (!cartController.cartList.first.item!.scheduleOrder! &&
                  availableList.contains(false)) {
                showCustomSnackBar('one_or_more_product_unavailable'.tr);
              } else {
                if (Get.find<SplashController>().module == null) {
                  int i = 0;
                  for (i = 0;
                      i < Get.find<SplashController>().moduleList!.length;
                      i++) {
                    if (cartController.cartList[0].item!.moduleId ==
                        Get.find<SplashController>().moduleList![i].id) {
                         
                      break;
                    }
                  }
                  Get.find<SplashController>()
                      .setModule(Get.find<SplashController>().moduleList![i]);
                }
                Get.find<CouponController>().removeCouponData(false);
      
                Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
              }
            }),
      ),
    );
  }
}
