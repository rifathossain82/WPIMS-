import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:get/get.dart';
import 'package:wpims/pages/errors/view/404.dart';
import 'package:wpims/utils/snackbars.dart';
class PaymentService{
  static const String sslStoreId='evend5f68e22208b16';
  static const String sslStorePassword='evend5f68e22208b16@ssl';
  static Future<SSLCTransactionInfoModel?>sslCommerz(double amount)async{
    try{
      Sslcommerz sslcommerz = Sslcommerz(
          initializer: SSLCommerzInitialization(
              multi_card_name: "visa,master,bkash",
              currency: SSLCurrencyType.BDT,
              product_category: "Sevice Fees",
              sdkType: SSLCSdkType.TESTBOX,
              store_id: sslStoreId,
              store_passwd: sslStorePassword,
              total_amount: amount,
              tran_id: "custom_transaction_id")
      );
      final SSLCTransactionInfoModel response=await sslcommerz.payNow();
      if(response.status=='VALID' || response.status=='VALIDATED'){
        return response;
      }else{
        toastMsg('Failed','Something went wrong');
      }

    }catch(e){
      Get.to(Error404());
    }
  }
}