import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/speech/controller/model/chairman_speech_model.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class ChairmanSpeech extends StatefulWidget {

  const ChairmanSpeech({Key? key}) : super(key: key);

  @override
  State<ChairmanSpeech> createState() => _ChairmanSpeechState();
}

class _ChairmanSpeechState extends State<ChairmanSpeech> {
  late Message message;
  bool isLoading = true;
  bool isEmptyData = false;
  String statusMessage='No Data Found';
  Future getData() async {
    final response=await ApiService().get('chairman-message');
    if(response.statusCode==200) {
      ChairmanSpeechApi speechInstance = chairmanSpeechFromJson(response.body);
      message=speechInstance.message;
      setState(() {
        isLoading=false;
        isEmptyData = false;
      });

    }else {
      setState(() {
        isEmptyData = true;
        isLoading=false;
      });
      // ShowWarningMsg(context: context,message:'No Data Found');
    }
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(title: 'Chairman Speech', isCentered: true),
      body: isEmptyData?Center(child: noData()):SingleChildScrollView(
        // padding: EdgeInsets.only(top: 90, left: 2, right: 2),
        physics: const ScrollPhysics(),
        child: isLoading?profileShimmer():Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipPath(
              clipper: AppBarShapeOval(),
              // this is my own class which extendsCustomClipper
              child: Container(
                height: 50,
                color: colorPrimary,
              ),
            ),
            // addVerticalSpace(16.0),
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Stack(
                children: [profileContent(), profileImg()],
              ),
            ),

            const SizedBox(height: 8),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: const BoxDecoration(
                  color: bgLight,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0.0, 0.0),
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child:Html(
                  data: message.quote,
                )
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget profileImg() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/user.jpeg'),
        radius: 50,
      ),
    );
  }

  Widget profileContent() {
    return Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 0.0),
          )
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(50),
            topHeading(message.name),
            subHeading(message.designation, color: colorPrimary),
            // horizontalSeparator(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget textLabel(String label) {
    return Row(
      children: [
        Flexible(child: rowHeading(label)),
      ],
    );
  }

  Widget textContent(String label) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: Row(
          children: [
            Flexible(
              child: bodyTextNormal(label),
            ),
          ],
        ));
  }

  Widget horizontalSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: addHorizontalDivider(),
    );
  }

  Widget profileShimmer(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipPath(
          clipper: AppBarShapeOval(),
          // this is my own class which extendsCustomClipper
          child: Container(
            height: 50,
            color: colorPrimary,
          ),
        ),
        // addVerticalSpace(16.0),
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Stack(
            children: [shimmerContent(), shimmerImg()],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: const BoxDecoration(
              color: bgLight,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0.0, 0.0),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child:
            ShimmerWidget.rectangular(height: 300.0),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget shimmerImg() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: const ShimmerWidget.circular(width: 100.0, height: 100.0),
    );
  }

  Widget shimmerContent() {
    return Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 0.0),
          )
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(50),
            ShimmerWidget.rectangular(height: 50.0),
            addVerticalSpace(10.0),
            ShimmerWidget.rectangular(height: 30.0),
            // horizontalSeparator(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

}
