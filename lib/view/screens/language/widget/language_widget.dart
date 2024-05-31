import 'package:farmacie_stilo/controller/localization_controller.dart';
import 'package:farmacie_stilo/data/model/response/language_model.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget(
      {Key? key,
      required this.languageModel,
      required this.localizationController,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
if (index==2) {
  localizationController.clearLocale();
} else {
          localizationController.setLanguage(Locale(
          AppConstants.languages[index].languageCode!,
          AppConstants.languages[index].countryCode,
        ));
}
        localizationController.setSelectIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration( 
           border: Border.all(
                      color: Color(0xffA4A4A4),
                      width: 1),
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                blurRadius: 5,
                spreadRadius: 1)
          ],
        ),
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 75,
                width: 75,
               
                decoration: BoxDecoration(
                  //  color: Colors.red,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  // border: Border.all(
                  //     color: Theme.of(context).textTheme.bodyLarge!.color!,
                  //     width: 1),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  languageModel.imageUrl!,
                 
                  fit: BoxFit.cover,
                  //colour commented
                  // color: languageModel.languageCode == 'en' ||
                  //         languageModel.languageCode == 'ar'
                  //     ? Theme.of(context).textTheme.bodyLarge!.color
                  //     : null,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              // Text(languageModel.languageName!, style: robotoRegulars),
            ]),
          ),
          localizationController.selectedIndex == index
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.check_circle,
                      color: Color(0xffA4A4A4), size: 25),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
