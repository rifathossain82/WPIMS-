import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wpims/pages/about/model/about_model.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/image_view.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class About extends StatefulWidget {
  About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isLoading = true;
  late String body;
  String? picture;
  bool isEmptyData = false;

  Random random = Random();

  Future _refresh() {
    setState(() {
      this.isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    final response=await ApiService().get('about');
    if(response.statusCode==200) {
      AboutApi aboutInstance = aboutFromJson(response.body);
      body = aboutInstance.about;
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
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final body_length=isLoading?0:body.length;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'About Institute'),
        body: Container(
          alignment: Alignment.topCenter,
          constraints:
          BoxConstraints(minHeight: size.height, minWidth: size.width),
          child: Stack(
            children: [
              Container(
                height: size.height,
                color: colorPrimary,
              ),
              curvedBodyContainer(size.height),
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: isLoading?aboutShimmer():Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Html(data: body)),
                    if(picture !=null)
                      Container(
                        margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 50.0),
                        constraints: const BoxConstraints(
                          minHeight: 150,
                        ),
                        child: FullScreenImage(
                          child: Image.network(
                            picture!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: colorPrimary,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    // Container(
                    //     margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    //     child: bodyTextNormal(body.substring((body_length/2).toInt(),body_length),textAlign: TextAlign.justify)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(30, (index) => _shimmerRows())
            ],

          ),
        ));
  }

  Widget _shimmerRows(){
    return Column(
      children: [
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(5),
      ],
    );
  }
}
