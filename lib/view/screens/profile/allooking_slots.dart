
import 'package:farmacie_stilo/data/model/booking_model.dart';
import 'package:farmacie_stilo/helper/route_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class AllBookingSlots extends StatefulWidget {
  @override
  _AllBookingSlotsState createState() =>
      _AllBookingSlotsState();
}

class _AllBookingSlotsState extends State<AllBookingSlots> {
  late Future<List<Welcome>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchDataFromApi();
  }

  Future<List<Welcome>> fetchDataFromApi() async {
     final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("user_id");
    final response = await http.get(Uri.parse('https://new-admin.farmaciestilo.com/api/v3/booking/user_booked_slots?user_id=${userID}'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> body = jsonDecode(response.body);
      List<Welcome> data = body.map((dynamic item) => Welcome.fromJson(item)).toList();
      return data;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('booked_slots'.tr),
      ),
      body: Center(
        child: FutureBuilder<List<Welcome>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Welcome welcome = snapshot.data![index];
                  return InkWell(
                    onTap: (){
                           Get.offAllNamed(RouteHelper.getOrderDetailsRoute(
           welcome.orderid,
                fromNotification: true));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(children: [
                        CircleAvatar(radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage('https://new-admin.farmaciestilo.com/storage/app/public/store/${welcome.storelogo.toString()}'),
                        )
                          ],),
                          Column(children: [
                                           Text(welcome.pharmacyName.toString()),
                                           const SizedBox(height: 19,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(welcome.starttime.toString()),const SizedBox(width: 23,),
                               Text(welcome.endtime.toString()),
                            ],
                          ),
                            const SizedBox(height: 19,),
                           Text(welcome.date.toString()),
                          ],),
                        ],
                      ),
                    ),
                  );
                }, 
                separatorBuilder: (BuildContext context, int index) { 
                  return const Divider();
                 },
              );
            }
          },
        ),
      ),
    );
  }
}