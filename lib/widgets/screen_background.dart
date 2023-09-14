import 'package:task_manager_using_getx/ui/utills/assetUtills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenBackground extends StatefulWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  State<ScreenBackground> createState() => _ScreenBackgroundState();
}

class _ScreenBackgroundState extends State<ScreenBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
            child:SvgPicture.asset(
          AssetUtills.backgroundSVG,
              fit: BoxFit.cover,
        ),
        ),
        widget.child
      ],
    );
  }
}
