import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';

class AppBarShapeOval extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(size.width*0.2275000,size.height*1.5700000);
    path0.lineTo(size.width*1.0150000,size.height*1.5700000);
    path0.lineTo(size.width*1.0150000,size.height*2.2100000);
    path0.quadraticBezierTo(size.width*0.9968750,size.height*2.0125000,size.width*0.9475000,size.height*2.0000000);
    path0.cubicTo(size.width*0.7900000,size.height*1.9900000,size.width*0.4750000,size.height*1.9700000,size.width*0.3175000,size.height*1.9600000);
    path0.quadraticBezierTo(size.width*0.2306250,size.height*1.9675000,size.width*0.2300000,size.height*2.1500000);
    path0.lineTo(size.width*0.2275000,size.height*1.5700000);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

Widget curvedBodyContainer(double height){
  return Container(
    height: height,
    decoration: BoxDecoration(
        color: layoutBglight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
    ),
  );
}
