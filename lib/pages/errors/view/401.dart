import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Error401 extends StatelessWidget {
  const Error401({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topHeading('401',color: warningColor,fontSize: 50.0, fontWeight: FontWeight.bold),
            subHeading('Unauthorized!', color: textGrey)
          ],
        ),
      ),
    );
  }
}
