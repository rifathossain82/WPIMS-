import 'package:get/get.dart';

import '../model/slider.dart';

class HomeController extends GetxController{
  var sliders=<Slider>[].obs;

  void setSliders(List<Slider> slides){
    sliders.value=slides;
  }
}