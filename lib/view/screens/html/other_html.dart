import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/helper/responsive_helper.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/html_type.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/view/base/footer_view.dart';
import 'package:farmacie_stilo/view/base/menu_drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OtherHtml extends StatefulWidget {
  final HtmlType htmlType;
  const OtherHtml({Key? key, required this.htmlType}) : super(key: key);

  @override
  State<OtherHtml> createState() => _OtherHtmlState();
}

class _OtherHtmlState extends State<OtherHtml> {
  @override
  void initState() {
    super.initState();

    Get.find<SplashController>().getHtmlText(widget.htmlType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.htmlType == HtmlType.termsAndCondition
              ? 'terms_conditions'.tr
              : widget.htmlType == HtmlType.aboutUs
                  ? 'about_us'.tr
                  : widget.htmlType == HtmlType.privacyPolicy
                      ? 'privacy_policy'.tr
                      : widget.htmlType == HtmlType.shippingPolicy
                          ? 'shipping_policy'.tr
                          : widget.htmlType == HtmlType.refund
                              ? 'refund_policy'.tr
                              : widget.htmlType == HtmlType.cancellation
                                  ? 'cancellation_policy'.tr
                                  : 'no_data_found'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.htmlText != null
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FooterView(
                      child: Ink(
                    width: Dimensions.webMaxWidth,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ResponsiveHelper.isDesktop(context)
                              ? Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  color: Theme.of(context).cardColor,
                                  width: Dimensions.webMaxWidth,
                                  child: SelectableText(
                                    widget.htmlType ==
                                            HtmlType.termsAndCondition
                                        ? 'terms_conditions'.tr
                                        : widget.htmlType == HtmlType.aboutUs
                                            ? 'about_us'.tr
                                            : widget.htmlType ==
                                                    HtmlType.privacyPolicy
                                                ? 'privacy_policy'.tr
                                                : widget.htmlType ==
                                                        HtmlType.shippingPolicy
                                                    ? 'shipping_policy'.tr
                                                    : widget.htmlType ==
                                                            HtmlType.refund
                                                        ? 'refund_policy'.tr
                                                        : widget.htmlType ==
                                                                HtmlType
                                                                    .cancellation
                                                            ? 'cancellation_policy'
                                                                .tr
                                                            : 'no_data_found'
                                                                .tr,
                                    style: robotoBold.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: Colors.black),
                                  ),
                                )
                              : const SizedBox(),
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
                              : Html(
                                  data: (widget.htmlType==HtmlType.termsAndCondition && Get.find<LocalizationController>().locale!.languageCode=="en") ? 
                                  splashController.aboutf["terms_and_conditions"] : 
                                  
                                  (widget.htmlType==HtmlType.privacyPolicy && Get.find<LocalizationController>().locale!.languageCode=="en") ? 
                                  splashController.aboutf["privacy_policy"] : (widget.htmlType==HtmlType.privacyPolicy && Get.find<LocalizationController>().locale!.languageCode=="it") ? 
                                  splashController.aboutf["privacy_policy_it"]: splashController.aboutf["terms_and_conditions_it"]
                                  
                                  ,
                                  shrinkWrap: true,
                                 
                                ),
                        ]),
                  )),
                )
              : const CircularProgressIndicator(),
        );
      }),
    );
  }
}