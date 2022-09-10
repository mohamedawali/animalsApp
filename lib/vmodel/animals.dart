import 'package:animals/model/animals.dart';
import 'package:animals/repository/webApi.dart';

class VMAnimals{
  WebApi webApi;
  VMAnimals(this.webApi);
  Future<List<Animals>> getAnimals()async{
    var animals =await webApi.getAnimals();
    var list = animals.map((e) => Animals.fromJson(e)).toList();
    print('viewmodel${list.toString()}');
    return list;
  }
}