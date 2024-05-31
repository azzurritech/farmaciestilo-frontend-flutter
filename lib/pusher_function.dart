import 'dart:async';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class Pusherr {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  StreamController eventStreamController = StreamController();

  void connect() async {
  
    try {
      pusher.init(
        apiKey: "2f2d17781e2ed3fa3299",
        cluster: "ap2",
        onConnectionStateChange: (currentState, previousState) {
          print(currentState.toString());
        },
        onError: (message, code, error) {
          print(error.toString());
        },
        onSubscriptionSucceeded: (channelName, data) {
          print(data);
        },
        onEvent: (event) {
          print(event.       data);
            eventStreamController.add(event.data);
         
        },
        onSubscriptionError: (message, error) {
          print(error.data.toString());
        },
        onDecryptionFailure: (event, reason) {},
        onMemberAdded: (channelName, member) {},
        onMemberRemoved: (channelName, member) {},
      );
      await pusher.subscribe(channelName: 'my-channel');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
      // Close the stream if an error occurs
      eventStreamController.close();
      return;
    }
    

    // Listen to the event stream until pusher is disconnected
  
    // Listen to the event stream
    // eventStreamController.stream.listen((event) {
    //   print('Received event: $event');
    //   // Handle event data here
    // });
  }
  Stream getEventStream() {
    return eventStreamController.stream;
  }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              