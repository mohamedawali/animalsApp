import 'package:animals/constant/url.dart';
import 'package:animals/model/animals.dart';
import 'package:dio/dio.dart';
class WebApi{
  Dio? dio;
  List<Animals>? k;
  BaseOptions baseOptions=BaseOptions(baseUrl: baseUrl,headers: {'X-RapidAPI-Key':'b7dd3ff57emsheae97c4c17a41b6p151ec2jsn4be12d132bd8'});

  Future <List<dynamic>>getAnimals()async{
    dio=Dio(baseOptions);
    var respons =await dio!.get('animals/rand/10');
    print('api${respons.data.toString()}');
    return  respons.data;


  }
}