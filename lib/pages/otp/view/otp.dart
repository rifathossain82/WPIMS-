import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:wpims/pages/home/controller/home_controller.dart';
import 'package:wpims/pages/home/view/home.dart';
import 'package:wpims/pages/login/controller/auth_controller.dart';
import 'package:wpims/pages/otp/model/initial_data_model.dart';
import 'package:wpims/pages/otp/view/timer.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/snackbars.dart';
import 'package:wpims/utils/widgets/buttons.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Otp extends StatefulWidget {
  final String userId;

  const Otp({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  final AuthenticationManager authManager = Get.find<AuthenticationManager>();
  HomeController homeCtrl = Get.put(HomeController());

  // Constants
  int time = 180;
  late AnimationController _controller;
  bool btnLoading = false;
  bool isLoading = false;

  // Variables
  // Size? _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;

  Timer? timer;
  int? totalTimeInSeconds;
  bool _hideResendButton = true;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: topHeading("Verification Code", color: colorPrimary)),
        addVerticalSpace(5),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: subHeading(
                "Please enter the OTP sent on your registered phone number",
                maxLines: 2),
          ),
        )
      ],
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(child: _otpTextField(_firstDigit)),
        Flexible(child: _otpTextField(_secondDigit)),
        Flexible(child: _otpTextField(_thirdDigit)),
        Flexible(child: _otpTextField(_fourthDigit)),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        addVerticalSpace(5),
        Expanded(flex: 3, child: _getVerificationCodeLabel),
        Expanded(flex: 2, child: _getInputField),
        Expanded(
            flex: 1,
            child: _hideResendButton ? _getTimerText : _getResendButton),
        Expanded(flex: 4, child: _getOtpKeyboard)
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return SizedBox(
      height: 32,
      child: Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.access_time,
              color: colorPrimary,
            ),
            const SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 20.0, colorPrimary)
          ],
        ),
      ),
    );
  }

  get _getResendButton {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 40.0,
        width: 140.0,
        child: submitButton(
            label: 'Resend Otp',
            onPressed: () {
              setState(() {
                btnLoading = true;
              });
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _startCountdown();
                });
              });
            },
            btnLoading: btnLoading,
            padding: 0.0),
      ),
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        height: _screenSize.width - 80,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardActionButton(
                      label: const Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: const Icon(
                        Icons.check_circle,
                        color: colorPrimary,
                        size: 30,
                      ),
                      onPressed: () {
                        if (_firstDigit != null &&
                            _secondDigit != null &&
                            _thirdDigit != null &&
                            _fourthDigit != null) {
                          var otp = _firstDigit.toString() +
                              _secondDigit.toString() +
                              _thirdDigit.toString() +
                              _fourthDigit.toString();
                          sendOtpRequest(otp);
                        } else {
                          ShowHintMsg(context: context, message: 'Please input 4 digit otp');
                        }
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  _otpKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();
        sendOtpRequest(otp);
      }
    });
  }

  Future<void> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      btnLoading = false;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }

  void sendOtpRequest(String otp) async {
    setState(() {
      isLoading=true;
    });
    final response = await ApiService().post('otp-match', {
      'otp': otp,
      'studentId':widget.userId
    });
    if (response.statusCode == 200) {
      InitialData initData = initialDataFromJson(response.body);
      authManager.login(initData.authToken);
      homeCtrl.setSliders(initData.sliders);
      setState(() {
        isLoading=false;
      });
      Get.off(() => Home());
    } else {
      var errors = otpErrorFromJson(response.body);
      setState(() {
        isLoading=false;
      });
      ShowWarningMsg(context: context, message: errors.message);
    }
  }


  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: topBar(isCentered: true),
          body: Container(
            height: _screenSize.height,
            constraints: BoxConstraints(
              maxHeight: _screenSize.height,
            ),
            child: Stack(children: [
              ClipPath(
                clipper: AppBarShapeOval(),
                // this is my own class which extendsCustomClipper
                child: Container(
                  height: 50,
                  color: colorPrimary,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                width: _screenSize.width,
                height: _screenSize.height,
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _getInputPart,
              ),
            ]),
          ),
        ),
        isLoading?AbsorbPointer(
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                color: bgDark.withOpacity(0.2),
                width: 200.0,
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: colorPrimary,
                    ),
                    addVerticalSpace(20.0),
                    DefaultTextStyle(
                        style: TextStyle(),
                        child: subHeading('Please Wait...',color: textLight))
                  ],
                ),
              ),
            ),
          ),
        ):Container()
      ],
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int? digit) {
    return Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: Text(
        digit != null ? digit.toString() : "",
        style: const TextStyle(
          fontSize: 30.0,
          color: textColorPrimary,
        ),
      ),
      decoration: const BoxDecoration(
          // color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: colorPrimary,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String? label, VoidCallback? onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label ?? '',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"

}


