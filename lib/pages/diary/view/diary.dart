import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:wpims/pages/diary/model/diary_model.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/methods.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  bool isLoading = true;
  bool isEmptyData = false;
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late List<DiaryModel> diaryList;
  Random random = Random();
  late String date;
  late String weekDay;

  Future _refresh() {
    setState(() {
      isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    final response=await ApiService().get('diary?date=${DateFormat('yyyy-MM-dd').format(selectedDate).toString()}');
    if(response.statusCode==200) {
      DiaryListApi diaryListInstance = diaryListFromJson(response.body);
      diaryList=diaryListInstance.diaries;
      date=diaryListInstance.date;
      weekDay=diaryListInstance.weekDay;
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
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'Diary'),
        body: Stack(
          children: [
            Container(
              height: size.height,
              color: colorPrimary,
            ),
            curvedBodyContainer(size.height),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  addVerticalSpace(20.0),
                  _buildDatePicker(),
                  addVerticalSpace(20.0),
                  Expanded(
                    child: isEmptyData?Center(child: noData()):ListView.separated(
                      shrinkWrap: true,
                        itemCount: isLoading?6:diaryList.length+1,
                        itemBuilder: (BuildContext context, int index) {
                          if(isLoading){
                            return _buildDiaryListShimmer();
                          }

                          if(index==0){
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: infoColor,
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Wrap(
                                    alignment:WrapAlignment.spaceBetween,
                                    children: [
                                      subHeading(date,color:textLight),
                                      subHeading(weekDay,color: textLight),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(10.0),

                              ],
                            );
                          }
                          index-=1;
                          return _buildDiaryItem(diaryList[index].subject, diaryList[index].diary);
                        },
                        separatorBuilder: (BuildContext context, int index){
                          return addVerticalSpace(6.0);
                        },

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDiaryItem(String title, String diary){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subHeading(title, color: darkBlue),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: violate.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Html(data: diary),
        ),
        addVerticalSpace(10.0),
      ],
    );
  }

  Widget _buildDatePicker(){
    return TextFormField(
      controller: dateController,
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(8.0),
        suffixIcon: Icon(Icons.date_range, color: textDark),
        hintText: "YYYY-MM-DD",
        hintMaxLines: 1,
        hintStyle: TextStyle(fontSize: 15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bgGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bgGrey),
        ),
      ),
      onTap: () async {
        final pickedDate = await selectDate(
            context: context,
            initialDate: selectedDate,
            allowedDays: _allowedDays);
        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            isLoading=true;
            isEmptyData=false;
            selectedDate = pickedDate;
            dateController.text =
                DateFormat('yyyy-MM-dd').format(selectedDate);
            getData();
          });
        }
        // FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  bool _allowedDays(DateTime day) {
    if ((day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }

  Widget _buildDiaryListShimmer() {
    final size=MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangularWithRadius(height: 20,width: random.nextInt(200).toDouble(),),
              addVerticalSpace(10.0),
              ShimmerWidget.rectangularWithRadius(height: 50.0),

            ],
          ),
        )
    );
  }
}
