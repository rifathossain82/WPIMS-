import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/result/model/result_model.dart';
import 'package:wpims/pages/result/view/marksheet.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

import '../../../services/api.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Random random = Random();
  late List<ResultListModel> resultList;
  bool isLoading = true;
  bool isEmptyData = false;

  Future getData() async {
    final response=await ApiService().get('result');
    if(response.statusCode==200) {
      ResultListApi resultListInstance = resultListApiFromJson(response.body);
      resultList = resultListInstance.results;

      setState(() {
        isEmptyData = false;
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading=false;
        isEmptyData = true;
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
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: topBar(title: 'Result'),
      body: Stack(
        children: [
          Container(
            height: size.height,
            color: colorPrimary,
          ),
          curvedBodyContainer(size.height),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: isEmptyData?Center(child: noData()):ListView.builder(
              itemCount: isLoading ? 8: resultList.length,
              itemBuilder: (BuildContext context, int index) {
                if (isLoading) {
                  return resultListShimmer();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>MarkSheet(id: resultList[index].id,)
                        )
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: resultList[index].isPassed
                          ? successColor.withOpacity(0.2)
                          : dangerColor.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: bgGrey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(3, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          subHeading(resultList[index].title),
                          addVerticalSpace(10.0),
                          ...resultList[index].result.map((item) {
                            return _buildResultRow(
                                item.label, item.obtained, item.total);
                          }),
                          Center(
                              child: subHeading(
                                  resultList[index].isPassed ? 'Passed' : 'Failed',
                                  color: resultList[index].isPassed
                                      ? successColor
                                      : dangerColor)),
                        ],
                      ),
                    ),
                  ),
                );
              },
              // separatorBuilder: (BuildContext context, int index)=>addVerticalSpace(15.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String title, String obtained, String total) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: textGrey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: bodyTextNormal(title),
            ),
          ),
          addHorizontalSpace(8.0),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: textGrey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: bodyTextNormal(obtained, textAlign: TextAlign.center),
            ),
          ),
          addHorizontalSpace(8.0),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  border: Border.all(color: textGrey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: bodyTextNormal(total, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  Widget resultListShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangularWithRadius(height: 25, width: size.width/2),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),


                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),


                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 30,radius: 10,),
                  ),


                ],
              ),
              addVerticalSpace(15),
              Center(child: ShimmerWidget.rectangularWithRadius(height: 25, width: size.width/4)),

            ],
          ),
        ));
  }
}
