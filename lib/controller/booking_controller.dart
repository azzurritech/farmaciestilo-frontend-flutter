import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:farmacie_stilo/Booking/bookslot.dart';
import 'package:farmacie_stilo/Booking/checkout.dart';
import 'package:farmacie_stilo/data/model/response/item_model.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
// import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final  bookingCallProvider = ChangeNotifierProvider(
  (ref) => BookingProvider(),
);
final videoCamCheckProvider = StateProvider((ref) {
  return false;
});
final micheckProvider = StateProvider((ref) {
  return false;
});
// extension dateFormating on DateFormat{
//  englishToItalian(date){
// DateFormat("EEE dd MMM", 'en').parse(date);
//  }

// }
class BookingProvider extends ChangeNotifier {
  Dio dio = Dio(BaseOptions(headers: {"ontent-Type": "application/json"}));

  // List weekDayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List newWeekDayList = [
    '${DateFormat('EEE dd MMM').format(DateTime.now())}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 1)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 2)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 3)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 4)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 5)))}',
    '${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 6)))}'
  ];

  // ];
  var daySelected = "";
  var bookedEndTime = '';
  var bookedStartTime = '';
  int? storeida;
  var adminStatus;
  bool? isPurposeText;
int? itemida;
  // List<Slot> getSlot = [];
  var load = false;
 
  bool isApiLoading = false;

  getAdminStatus(context) async {
    try {
      final response = await dio.get(
        "${AppConstants.BASE_URL_NEW}status",
      );
      if (response.statusCode == 200) {
        print( response.data["data"]["value"]);
        adminStatus = response.data["data"]["value"];
        notifyListeners();
        //Navigator.pushNamed(context, DoctorAvailability.routeName);

        print(adminStatus);
      } else {
        print("error");
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  List<dynamic> listBookSlot = [];
  List<dynamic> responseSlots = [];
  List<dynamic> ssList = [];
  List<dynamic> responseBooked = [];
  String lang = '';
  getAllSlots(context, String daySelected, bool isRoute , [ int? storeids,int? itemids, Item? items,]) async {
    load = true;
    notifyListeners();
  
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("user_id");
    

    ssList.clear();
    responseSlots.clear();
    responseBooked.clear();

    final response = await dio.get(
      "${AppConstants.BASE_URL_NEW}booking/booking_slots/${daySelected}?store_id=${storeids}&item_id=${itemids}",
    );

    try {
      if (response.statusCode == 200) {
        responseSlots = response.data['slots'];
        responseBooked = response.data['booked'];
        ssList.addAll(responseSlots);
        for (Map i in ssList) {
          for (Map j in responseBooked) {
            if (i['id'] == j['slot_id']) {
              i['book'] = true;
              i['currentUser'] = false;
              if (j["user_id"] == '$userID') {
                i['book'] = true;
                i['currentUser'] = true;
              }
            } else if (!i.containsKey('book')) {
              i['book'] = false;
              i['currentUser'] = false;
            }
          }
          if (!i.containsKey('book')) {
            i['book'] = false;
            i['currentUser'] = false;
          }
        }
        log("$ssList");
        load = false;
        notifyListeners();
        isRoute == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookSlot(storeid: storeids, itemid: itemids, item:items
                )))
            : null;
      } else {
        load = false;

        notifyListeners();
        //showInSnackBar('got some error', context);
      }
    } on DioError catch (e) {
      load = false;
      notifyListeners();
      // showInSnackBar('got some error', context);
    }
  }

 

  bookedSlot(context,
      {required WidgetRef ref,
      required String purpose,
      required int? itemid,
      required int slotId,
      required  int? storeid,
      required Item? items,
      required bookedDate}) async {
    load = true;
    notifyListeners();
    // final user = ref.read(authProvider).user;
    // var englishDate = DateFormat("EEE dd MMM", 'it').parse(bookedDate);
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("user_id");

    String? name = prefs.getString("fname");
    String? email = prefs.getString("email");

    Map<String, dynamic> data = {
      "slot_id": slotId,
      // "date": DateFormat("EEE dd MMM", 'en').format(englishDate).toString(),
      "date": bookedDate,
      "user_id": '${userID}',
      "email": email,
      "name": name,
      "subject": purpose,
      "item_id":itemid,
      "store_id":storeid,
    };

    try {
      final response =
          await dio.post("${AppConstants.BASE_URL_NEW}booking/booked_services", data: data); 
      if (response.statusCode == 200) {
        var message = response.data;
    Get.to(Checkout(fromCart: true, storeId: storeida, item: items,
      // fromCart:false, storeId: storeida,
      ));
     //  ref.watch(bookingCallProvider).getAllSlots(context, bookedDate, false, storeid);
       await getAllSlots(context, bookedDate, false, storeid,itemid);
   
        print(message['message']);
      } else {
        load = false;
        print("error");
      }
    } on DioException catch (e) {
      print(e);
      load = false;
      // showInSnackBar('got some error', context);
    }
  }

  cancelCallApi() async {   
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("user_id");

    final response = await dio.post(
      "${AppConstants.BASE_URL_NEW}end_call/$userID",
    );
    if (response.data["message"] == "Call ended successfully") {
      return;
    } else {
      print('error');
    }
  }


  cancelSlot(  context,{required WidgetRef ref,
      required String purpose,
      required int? itemid,
      required int slotId,
      required  int? storeid,
      required bookedDate}) async {
    load = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("user_id");
  String? name = prefs.getString("fname");
    String? email = prefs.getString("email");

    
    Map<String, dynamic> data = {
     "slot_id": slotId,
      // "date": DateFormat("EEE dd MMM", 'en').format(englishDate).toString(),
      "date": bookedDate,
      "user_id": '${userID}',
      "email": email,
      "name": name,
      "subject": purpose,
      "item_id":itemid,
      "store_id":storeid,
      // "date": ref.read(sheduleCallProvider).daySelected
    };
    final response =
        await dio.post("${AppConstants.BASE_URL_NEW}booking/cancel", data: data);
    try {
      if (response.statusCode == 200) {
        var message = response.data;

        print(message['message']);
       ref.watch(bookingCallProvider).getAllSlots(context, daySelected, false, storeid!);
      } else {
        load = false;
        notifyListeners();
        print("error");
      }
    } on DioException catch (e) {
      load = false;
      print(e);
    }
  }  
}
