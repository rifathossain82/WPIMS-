import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/payment/model/payment_model.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/services/payment.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/methods.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/snackbars.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController dateController = TextEditingController();
  String? _selectedYear = null;
  late PaymentList paymentList;
  bool isLoading = true;
  bool isEmptyData = false;
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String query='monthly-payment';
  Future _refresh() {
    return getData();
  }

  Future getData() async {
    setState(() {
      isLoading=true;
    });

    if(_selectedYear !=null){
      query='monthly-payment?year='+_selectedYear!;
    }

    final response=await ApiService().get(query);
    if(response.statusCode==200) {
      PaymentList paymentListInstance = paymentListFromJson(response.body);
      paymentList = paymentListInstance;
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


  void sslInit(String amount) async {
    final SSLCTransactionInfoModel? paymentInit =
        await PaymentService.sslCommerz(double.parse(amount));
    if (paymentInit != null) {
      getData();
      ShowSuccessMsg(context: context, message: 'Transaction Was Successful');
    }
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
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
    return Scaffold(
      appBar: topBar(title: 'Payments'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Stack(
          children: [
            Container(
              height: size.height,
              color: colorPrimary,
            ),
            curvedBodyContainer(size.height),
            Container(
              height: size.height,
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: isEmptyData
                  ? Center(child: noData())
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount:
                          isLoading ? 6 : paymentList.payments.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (isLoading) {
                          return _buildRoutineListShimmer();
                        }
                        if (index == 0) {
                          return _buildYearPicker();
                        }
                        index -= 1;

                        if (index == paymentList.payments.length - 1) {
                          return Column(
                            children: [
                              _buildPaymentMonth(paymentList.payments[index]),
                              addVerticalSpace(12.0),
                              Container(
                                width: double.infinity,
                                color: warningColor.withOpacity(0.21),
                                padding: EdgeInsets.all(12.0),
                                child: topHeading('Due ${paymentList.due}',
                                    fontWeight: FontWeight.bold),
                              ),
                              addVerticalSpace(12.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Image.asset('assets/images/bkash.png',
                                    fit: BoxFit.cover),
                              ),
                              addVerticalSpace(12.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: InkWell(
                                    onTap: (){
                                      _buildDialog();
                                      amountController.text=paymentList.due;
                                    },
                                    child: Image.asset('assets/images/ssl.png',
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          );
                        }

                        return _buildPaymentMonth(paymentList.payments[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return addVerticalSpace(4.0);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPaymentMonth(PaymentModel payment) {
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
                        color: colorPrimary.withOpacity(.80),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(payment.month.toString(),
                          fontSize: fontSizeMd, color: textLight)),
                ),
                addHorizontalSpace(8.0),
                Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: colorPrimary.withOpacity(.80),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(payment.due.toString(),
                          color: textLight, maxLines: 2, fontSize: fontSizeMd)),
                ),
                addHorizontalSpace(8.0),
                Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: colorPrimary.withOpacity(.80),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(payment.paid.toString(),
                          color: textLight, maxLines: 2, fontSize: fontSizeMd)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildYearPicker() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200.0,
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              fillColor: colorPrimary.withOpacity(0.5),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimaryAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimaryAccent),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimaryAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimaryAccent),
              ),
            ),
            isExpanded: true,
            itemHeight: 60.0,
            value: _selectedYear,
            alignment: AlignmentDirectional.center,
            hint: Center(child: subHeading('Select year')),
            items: List.generate(
                paymentList.years.length,
                (index) => DropdownMenuItem(
                    child: Center(
                        child: subHeading(paymentList.years[index].label)),
                    value: paymentList.years[index].value)),
            onChanged: (value) {
              setState(() {
                _selectedYear = value.toString();
              });
              getData();
            }),
      ),
    );
  }

  Widget _buildRoutineListShimmer() {
    final size = MediaQuery.of(context).size;
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
                flex: 4,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
              addHorizontalSpace(10),
              Flexible(
                flex: 3,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
              addHorizontalSpace(10),
              Flexible(
                flex: 3,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
            ],
          ),
          addVerticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
              addHorizontalSpace(10),
              Flexible(
                flex: 3,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
              addHorizontalSpace(10),
              Flexible(
                flex: 3,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
            ],
          ),
          addVerticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
              addHorizontalSpace(10),
              Flexible(
                flex: 3,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
              addHorizontalSpace(10),
              Flexible(
                flex: 3,
                child: ShimmerWidget.rectangularWithRadius(
                  height: 40,
                  radius: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Future _buildDialog(){
    return Get.defaultDialog(
      title: 'Enter Amount',
      contentPadding:const EdgeInsets.all(12.0),
      content:Form(
        key:_formKey,
        child:  _buildAmountField(),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(
                  context, 'Cancel'),
              child: subHeading('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  sslInit(amountController.text);
                  return Navigator.pop(context, 'OK');
                }
              },
              child: subHeading('Pay',color: infoColor),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: amountController,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: paymentList.due,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: bgGrey, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: bgGrey, width: 0.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: bgGrey, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: bgGrey, width: 0.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid amount';
        }
        return null;
      },
      // onSaved: (String? value) {
      //   setState(() {
      //     _formEmail = value;
      //   });
      // },
    );
  }
}
