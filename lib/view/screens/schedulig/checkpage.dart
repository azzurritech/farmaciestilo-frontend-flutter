import 'dart:convert';
import 'package:farmacie_stilo/controller/scheduling_provider.dart';
import 'package:farmacie_stilo/util/images.dart';
import 'package:farmacie_stilo/view/screens/schedulig/videocall_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:farmacie_stilo/pusher_function.dart';

class CheckPage extends ConsumerStatefulWidget {
  CheckPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckPageState();
}

class _CheckPageState extends ConsumerState<CheckPage> {
  Pusherr push = Pusherr();

  @override
  void initState() {
    push.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: GetPlatform.isMobile ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.1),
            SizedBox(
            height: 200,
            child: Image.asset(Images.videocallicon),
          ),
          SizedBox(height: height * 0.1),
          StreamBuilder(
            stream: push.getEventStream(),
            builder: (context, AsyncSnapshot snapshot) {
              print('Raw JSON data: ${snapshot.data}');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasData) {
                try {
                  if (snapshot.data != null && snapshot.data.isNotEmpty) {
                 Map<String, dynamic> eventData = jsonDecode(snapshot.data);
                   
                    // Check if eventData is an empty JSON object
                    if (eventData.isEmpty) {
                      return Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'LM Sans 10',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    if (eventData.containsKey("data")) {
                      Map<String, dynamic> data =
                          jsonDecode(eventData["data"]);

                      if (data.containsKey('type')) {
                        String? eventType = data['type'];

                        if (eventType != null) {
                          if (eventType == 'reject') {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                            return Center(
                              child: Text(
                                'Call rejected: ${data['message']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'LM Sans 10',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else if (eventType == 'accept') {
                            final dsa = ref.watch(videotoken);
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VideoView(token: dsa),
                                ),
                              );
                            });
                            return Container(); // Placeholder widget, replace as needed
                          } else {
                            return Center(
                              child: Text(
                                'Waiting $eventType'.tr,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'LM Sans 10',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        } else {
                          return  Center(
                            child: Text(
                              'Waiting'.tr,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'LM Sans 10',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Text(
                            'waiting'.tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'LM Sans 10',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          'Waiting'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'LM Sans 10',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  } else {
                    return  Center(
                      child: Text(
                        'Waiting'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'LM Sans 10',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  // Handle JSON parsing errors
                  return Text('Error parsing JSON: $e');
                }
              } else if (snapshot.hasError) {
                // Handle stream errors
                return Text('Stream error: ${snapshot.error}');
              } else {
                // Show loading indicator while waiting for data
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ):
      
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.1),
          // SizedBox(
          //   height: 100,
          //   child: Image.asset('assets/image/logossx.png'),
          // ),
           SizedBox(
            height: 300,
            child: Image.asset(Images.videocallicon),
          ),
          SizedBox(height: height * 0.1),
          StreamBuilder(
            stream: push.getEventStream(),
            builder: (context, AsyncSnapshot snapshot) {
              print('Raw data: ${snapshot.data}');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                try {
                  dynamic responseData = snapshot.data;
                 print("respond data${responseData}");
                  if (responseData is String) {
                    // If data is received as a String, display it directly
                    return Center(
                      child: Text(
                        'Received data: $responseData',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'LM Sans 10',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } 
                  // else if (responseData is Map<String, dynamic>) {
                    // If data is a Map, process it as JSON
                    if (responseData.containsKey("data")) {
                      final eventData = jsonDecode(responseData["data"]);

                      // Check if the eventData contains the expected "type" field
                      if (eventData.containsKey("type")) {
                        final eventType = eventData["type"];

                        // Process event based on its type
                        if (eventType == 'reject') {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });
                          return Center(
                            child: Text(
                              'Call rejected: ${eventData['message']}',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'LM Sans 10',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else if (eventType == 'accept') {
                          final dsa = ref.watch(videotoken);
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VideoView(token: dsa),
                              ),
                            );
                          });
                          return Container();
                        } else {
                          return Center(
                            child: Text(
                              'Waiting $eventType',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'LM Sans 10',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Text(
                            'waiting'.tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'LM Sans 10',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          'waiting'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'LM Sans 10',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  // } 
                  // else { 
                  //   // Handle other types of data
                  //   return Center(
                  //     child: Text(
                  //       'Invalid event data format: Not a valid JSON object',
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontFamily: 'LM Sans 10',
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   );
                  // }
                } catch (e) {
                  // Handle JSON parsing errors
                  return Text('Error parsing JSON: $e');
                }
              } else if (snapshot.hasError) {
                // Handle stream errors
                return Text('Stream error: ${snapshot.error}');
              } else {
                // Show loading indicator while waiting for data
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      )
      
      
      
      ,
    );
  }
}
