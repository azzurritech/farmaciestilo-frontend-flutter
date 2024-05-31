import 'package:farmacie_stilo/controller/auth_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/controller/wishlist_controller.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:farmacie_stilo/view/base/not_logged_in_screen.dart';
import 'package:farmacie_stilo/view/screens/favourite/widget/fav_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
 late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
     _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
      Get.find<WishListController>().getWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'favourite'.tr, backButton: false),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body:_isLoggedIn==true
          ? SafeArea(
              child: Column(children: [
              Container(
                width: Dimensions.webMaxWidth,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Color(0xff1a3922),
                  indicatorWeight: 3,
                  labelColor: Color(0xff1a3922),
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  unselectedLabelStyle: robotoRegular.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.fontSizeSmall),
                  labelStyle: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Color(0xff1a3922)
                      
                      )
                      ,
                  tabs: [
                    Tab(text: 'item'.tr),
                    Tab(
                        text: Get.find<SplashController>()
                                .configModel!
                                .moduleConfig!
                                .module!
                                .showRestaurantText!
                            ? 'restaurants'.tr
                            : 'stores'.tr),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: const [
                  FavItemView(isStore: false),
                  FavItemView(isStore: true),
                ],
              )),
            ]))
          : const NotLoggedInScreen(),
    );
  }
}



