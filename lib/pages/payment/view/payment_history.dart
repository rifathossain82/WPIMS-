import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/payment/model/payment_history_model.dart';
import 'package:wpims/pages/payment/model/payment_model.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/methods.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  TextEditingController dateController = TextEditingController();
  late PaymentHistoryList histories;
  bool isLoading = true;
  bool isEmptyData = false;
  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String query='payment-history';
  Future _refresh() {
    setState(() {
      isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    setState(() {
      isLoading=true;
    });

    if(selectedDateFrom!=null && selectedDateTo!=null){
      query='payment-history?dateFrom=${DateFormat('dd-MM-yyyy').format(selectedDateFrom!).toString()}&dateTo=${DateFormat('dd-MM-yyyy').format(selectedDateTo!).toString()}';
    }
    final response=await ApiService().get(query);
    if(response.statusCode==200) {
      PaymentHistoryList historyInstance = paymentHistoryFromJson(response.body);
      histories = historyInstance;
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

  void getDateWiseHistory(){
    if(selectedDateFrom!=null && selectedDateTo!=null){
      getData();
    }
  }


  @override
  void dispose(){
    // controller.dispose();
    super.dispose();
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
      appBar: topBar(title: 'Payment History'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child:Stack(
          children: [
            Container(
              height: size.height,
              color: colorPrimary,
            ),
            curvedBodyContainer(size.height),
            Container(
              height: size.height,
              margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
              child: isEmptyData?Center(child: noData()):ListView.separated(
                  shrinkWrap: true,
                  itemCount: isLoading?1:histories.history.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    if(isLoading){
                      return _buildPaymentHistoryShimmer();
                    }
                    if(index==0){
                      return _buildDatePicker();
                    }
                    index-=1;
                    return _buildPaymentMonth(histories.history[index]);
                  },
                  separatorBuilder: (BuildContext context, int index){
                    return addVerticalSpace(4.0);
                  },

              ),
            ),
          ],
        ),
      ),
    );
  }


  _buildPaymentMonth(PaymentHistoryModel payment){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color:colorViolate,
                    ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                      payment.date.toString(),
                          fontSize: fontSizeMd,
                        color: textLight
                      )
                  ),
                ),
                addHorizontalSpace(8.0),
                Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color:colorViolate.withOpacity(.90),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
    payment.method.toString(),
                          color: textLight,
                          maxLines: 2,
                          fontSize: fontSizeMd
                      )
                  ),
                ),
                addHorizontalSpace(8.0),
                Expanded(
                  flex: 3 ,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color:colorViolate.withOpacity(.90),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                      payment.amount.toString(),
                          color: textLight,
                          maxLines: 2,
                        fontSize: fontSizeMd
                      )
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildPaymentHistoryShimmer() {
    final size=MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                ],
              ),
              addVerticalSpace(10),
              ...List.generate(12, (index) => _buildShimmerRow())
            ],
          ),
        )
    );
  }

  Column _buildShimmerRow(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
            ),
            addHorizontalSpace(10),
            Flexible(
              flex: 3,
              child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
            ),
            addHorizontalSpace(10),
            Flexible(
              flex: 3,
              child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
            ),
          ],
        ),
        addVerticalSpace(10.0),
      ],
    );
  }


  Widget _buildDatePicker() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: TextFormField(
                controller: startDateController,
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  suffixIcon: Icon(Icons.date_range, color: textDark),
                  hintText: "YYYY-MM-DD",
                  fillColor: greyColor.withOpacity(0.4),
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
                      initialDate: selectedDateFrom??DateTime.now(),
                      allowedDays: _allowedDays);
                  if (pickedDate != null && pickedDate != selectedDateFrom) {
                    setState(() {
                      selectedDateFrom = pickedDate;
                      startDateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDateFrom??DateTime.now());
                    });
                    getDateWiseHistory();
                    // FocusScope.of(context).requestFocus(FocusNode());
                  }
                }),
          ),
          addHorizontalSpace(8.0),
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: endDateController,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: greyColor.withOpacity(0.4),
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
                    initialDate: selectedDateTo??DateTime.now(),
                    allowedDays: _allowedDays);
                if (pickedDate != null && pickedDate != selectedDateTo) {
                  setState(() {
                    selectedDateTo = pickedDate;
                    endDateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDateTo??DateTime.now());
                  });
                  getDateWiseHistory();
                }
                // FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _allowedDays(DateTime day) {
    if ((day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }
}
