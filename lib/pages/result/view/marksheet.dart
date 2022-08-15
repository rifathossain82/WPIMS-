import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/result/model/marksheet_model.dart';
import 'package:wpims/pages/result/model/result_model.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class MarkSheet extends StatefulWidget {
  int id;
  MarkSheet({Key? key, required this.id}) : super(key: key);

  @override
  State<MarkSheet> createState() => _MarkSheetState();
}

class _MarkSheetState extends State<MarkSheet> {
  bool isLoading = true;
  bool isEmptyData = false;
  Random random = Random();
  late List<MarkSheetModel> marksList = marks;

  Future getData() async {
    final response=await ApiService().get('marksheet?id=$widget.id');
    if(response.statusCode==200) {
      MarksheetApi markSheetInstance = marksheetFromJson(response.body);
      marksList = markSheetInstance.marksheet;

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
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: topBar(title: 'Mark Sheet'),
      body: Stack(
        children:[
          Container(
            height: size.height,
            color: colorPrimary,
          ),
          curvedBodyContainer(size.height),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: isEmptyData?Center(child: noData()):ListView.builder(
              itemCount: isLoading?4:marksList.length,
              itemBuilder: (BuildContext context, int index) {

                if (isLoading) {
                  return markListShimmer();
                }
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: marksList[index].isPassed
                        ? successColor.withOpacity(0.2)
                        : dangerColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subHeading(marksList[index].title),
                        addVerticalSpace(10.0),

                        Table(
                         // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                         columnWidths: const <int, TableColumnWidth>{
                         0: FlexColumnWidth(1.5),
                        },

                         border: TableBorder.all(
                             color: textGrey
                         ),
                         children: [
                           _buildHeadingRow(),
                           
                           ...marksList[index].marks.map((item) => _buildMarksRow(item)),
                         ],
                        ),
                        addVerticalSpace(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subHeading(
                                marksList[index].isPassed ? 'Passed' : 'Failed',
                                color: marksList[index].isPassed
                                    ? successColor
                                    : dangerColor),
                            Wrap(children: [
                              subHeading('Total'),
                              Container(
                                margin: const EdgeInsets.only(left: 8.0),
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: textGrey),
                                    borderRadius: const BorderRadius.all(const Radius.circular(5))),
                                child: subHeading('1000'),
                              )
                            ]),
                          ],
                        ),
                      ],
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

  TableRow _buildHeadingRow(){
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: tableTextHeading('Written',textAlign: TextAlign.start),
        ),
        tableTextHeading('Full'),
        tableTextHeading('Highest'),
        tableTextHeading('Pass'),
        tableTextHeading('Obtain'),
      ],
    );
  }

  TableRow _buildMarksRow(Grade item) {
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: tableTextHeading(item.label,textAlign: TextAlign.start),
          ),
          tableTextBody(item.total),
          tableTextBody(item.highest),
          tableTextBody(item.pass),
          tableTextBody(item.obtained),
        ]
    );
  }

  Widget markListShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangularWithRadius(height: 25, width: size.width/2),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),

                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),

                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),

                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  const Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),

                ],
              ),
              addVerticalSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: ShimmerWidget.rectangularWithRadius(height: 25, width: size.width/4)),
                  Flexible(child: ShimmerWidget.rectangularWithRadius(height: 25, width: size.width/3))
                ],
              )
            ],
          ),
        ));
  }
}
