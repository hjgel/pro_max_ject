import 'package:get/get.dart';
import 'package:pro_max_ject/models/shelter.dart';
import 'package:pro_max_ject/repositories/disa_statistics_repo.dart';

class Disa_map extends GetxController{

  late Disa_statistics_repository _disa_statistics_repository;
  Rx<Shelter> disaStatistic = Shelter().obs;

  @override
  void onInit() {
    super.onInit();
    _disa_statistics_repository = Disa_statistics_repository();
    fetchDisaState();
  }

  void fetchDisaState() async{
    var result = await _disa_statistics_repository.fetchDisaStatistics();
    if(result!=null) {
      disaStatistic(result);
    }
  }
}