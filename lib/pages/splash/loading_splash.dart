import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';

class LoadingSplash extends StatefulWidget {
  const LoadingSplash({Key? key}) : super(key: key);

  @override
  State<LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/images/logo.png',
            width: 200.0,
          )),

          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/interwind.gif', width: 150.0),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Text('Powered by WebPointLtd',textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
