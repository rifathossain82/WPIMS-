import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeborder;
  final double? radius;

  ShimmerWidget.rectangularWithRadius({Key? key,
    this.width=double.infinity,
    this.radius=5,
    required this.height,
  }):this.shapeborder= RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius!)
  ), super(key: key);

   const ShimmerWidget.rectangular({Key? key,
    this.width=double.infinity,
    required this.height, this.radius
  }):this.shapeborder= const RoundedRectangleBorder(), super(key: key);

   const ShimmerWidget.circular({Key? key,
    required this.width,
    required this.height,
    this.shapeborder=const CircleBorder(), this.radius,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorPrimary.withOpacity(.40),
      highlightColor: colorPrimary.withOpacity(.20),
      period: Duration(milliseconds: 2000),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
            color: Colors.grey,
          shape: shapeborder
        ),
      ),
    );
  }
}
