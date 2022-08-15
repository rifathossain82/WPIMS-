import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Error404 extends StatelessWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topHeading('404',color: colorPrimaryAccent,fontSize: 50.0, fontWeight: FontWeight.bold),
            subHeading('Page was not found!', color: textGrey)
          ],
        ),
      ),
    );
  }
}
