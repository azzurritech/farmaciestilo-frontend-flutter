import 'package:get/get.dart';
import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:flutter/material.dart';
final newstyle=    robotoBold.copyWith(
                         fontFamily: 'LM Sans 10',
                        color: 
                             Color(0xffA4A4A4)
                          ,
                        fontSize:   Dimensions.fontSizeDefault,
                      );


                      final newstyleAS=    robotoBold.copyWith(
                         fontFamily: 'LM Sans 10',
                        color: 
                              Color(0xff1a3922),
                          
                        fontSize:   Dimensions.fontSizeDefault,
                      );

final robotoRegular = TextStyle(
    color: Color(0xff1a3922),
  fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);


final robotoRegularprice = TextStyle(
    color: Color(0xffA4A4A4),
  fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);




final robotoRegularcolor = TextStyle(
  color: Color(0xff1a3922),
 fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);
final robotoRegulars = TextStyle(
  color: Color(0xffA4A4A4),
 fontFamily: 'LM Sans 10',
  // fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMediumonboarding = TextStyle(
  color: Color(0xff1a3922),
  fontFamily: 'Roboto',
  fontWeight: FontWeight.bold,
  fontSize: Dimensions.fontSizeDefault,
);
final robotoMedium = TextStyle(
   color: 
                              Color(0xff1a3922),
fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.bold,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMediumquantity = TextStyle(
   color:  Color(0xff1a3922),
fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.bold,
  fontSize: Dimensions.fontSizeDefault,
);
final robotoMediumchange = TextStyle(
   color: 
                              Color(0xff1a3922),
 fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);




final robotoBold = TextStyle(
   color:  const Color(0xff1a3922),
 fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoBlack = TextStyle(
   fontFamily: 'LM Sans 10',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);


final BoxDecoration riderContainerDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
  color: Theme.of(Get.context!).primaryColor.withOpacity(0.1),
  shape: BoxShape.rectangle,
);
