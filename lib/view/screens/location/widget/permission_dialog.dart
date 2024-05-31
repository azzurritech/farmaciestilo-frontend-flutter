import 'package:farmacie_stilo/util/dimensions.dart';
import 'package:farmacie_stilo/util/styles.dart';
import 'package:farmacie_stilo/view/base/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({Key? key}) : super(key: key);

 Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
       permission = await Geolocator.requestPermission();
      Get.back(); // Close the dialog if permission is granted
    } else {
      // If permission is denied again, show the dialog to ask manually
      _showPermissionDialog();
    }
  }
   void _showPermissionDialog() {
    Get.defaultDialog(
      title: 'Action Required',
      middleText: 'Please change the location settings manually in your browser and try again.',
      textConfirm: 'Retry',
      onConfirm: () {
        Get.back(); // Close the dialog
        _requestPermission(); // Retry requesting permission
      },
      textCancel: 'Cancel',
      onCancel: () {
        Get.back(); // Close the dialog
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Text(
              'you_denied_location_permission'.tr,
              textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: const Size(1, 50),
                  ),
                  child: Text('close'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                  child: CustomButton(
                      buttonText: 'settings'.tr,
                      onPressed: () async {
                        if(kIsWeb){
                          _requestPermission();
                        }
                        await Geolocator.openAppSettings();
                        Get.back();
                      })),
            ]),
          ]),
        ),
      ),
    );
  }
}
