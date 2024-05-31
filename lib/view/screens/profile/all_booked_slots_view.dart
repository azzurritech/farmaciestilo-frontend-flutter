
import 'package:farmacie_stilo/controller/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AllBookedSlotsView extends ConsumerStatefulWidget {
  const AllBookedSlotsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllBookedSlotsViewState();
}

class _AllBookedSlotsViewState extends ConsumerState<AllBookedSlotsView> {
  bool isLoading=false;
  List<Map<String,dynamic>> allBookedSlots=[];

  @override
  void initState() {
  
    filterListFn();
    // TODO: implement initState
    super.initState();
  }
filterListFn()async{
  isLoading=true;
  setState(() {
    
  });
for (var i = 0; i < ref.read(sheduleCallProvider).newWeekDayList.length; i++) {
   await ref.read(sheduleCallProvider).getAllSlots(context,ref.read(sheduleCallProvider).newWeekDayList[i], false);
    for (var element in ref.read(sheduleCallProvider).ssList) {
    if (element["currentUser"]==true) {
      allBookedSlots.add({ref.read(sheduleCallProvider).newWeekDayList[i]:element});
    }
  }
}
  isLoading=false;
  setState(() {
    
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:     Text("your_booked_slots".tr),
      ),
body: isLoading==true?Center(child: const CircularProgressIndicator.adaptive()): Column(
  children: [

    Expanded(
      child: ListView.separated(itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text("${allBookedSlots[index].entries.first.value['starttime'].substring(0, 5)} - ${allBookedSlots[index].entries.first.value['endtime'].substring(0, 5)}"),
      Text("${allBookedSlots[index].entries.first.key}")
        ],
      ),
          
        );
      }, separatorBuilder: (context, index) {
        return const Divider();
      }, itemCount:allBookedSlots.length ,),
    )
  ],
),
    );
  }
}