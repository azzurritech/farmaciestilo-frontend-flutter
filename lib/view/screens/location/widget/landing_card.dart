import 'package:flutter/material.dart';
import 'package:farmacie_stilo/util/dimensions.dart';

class LandingCard extends StatefulWidget {
  final String icon;
  // final String title;
  const LandingCard({Key? key, required this.icon, required String title,})
      : super(key: key);

  @override
  State<LandingCard> createState() => _LandingCardState();
}

class _LandingCardState extends State<LandingCard> {
    bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
     onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        
        height: 180,
        // color: _isHovered ? Colors.green.withOpacity(0.1) : Theme.of(context).primaryColor.withOpacity(0.05),
        alignment: Alignment.center,
      // color: Color(0xffbfdec3),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        //   color: Theme.of(context).primaryColor.withOpacity(0.05),
        // ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Image.asset(icon,  filterQuality: FilterQuality.high,height: 100,width: 70,),
         Container(
        height: 145,
        width: 140,
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(widget.icon), // Assuming 'icon' is the path to your asset
        fit: BoxFit.cover, // Adjust the fit based on your requirements
      ),
        ),
      ),
      
          const SizedBox(height: Dimensions.paddingSizeDefault),
          // Text(title,
          //     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
          //     textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}
