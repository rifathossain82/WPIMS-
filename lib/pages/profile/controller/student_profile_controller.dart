import 'package:get/state_manager.dart';
import 'package:wpims/pages/profile/model/student_model.dart';
import 'package:wpims/services/api.dart';

class StudentProfileController extends GetxController {
  var isLoading = true.obs;
  var isEmptyData = false.obs;
  var student=Rxn<StudentProfileModel>();

  @override
  void onInit() {
    getStudents();
    super.onInit();
  }

  void getStudents() async {
    try {
      isLoading(true);
      StudentProfileApi proifleInstance = await ApiService.fetchStudentProfile();
      if(proifleInstance.student !=null){
        student.value=proifleInstance.student;
        isLoading(false);
      }
    } finally {
      isLoading(false);
      isEmptyData(true);
    }
  }
}