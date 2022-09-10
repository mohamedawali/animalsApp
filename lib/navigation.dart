import 'package:animals/model/animals.dart';
import 'package:animals/repository/webApi.dart';
import 'package:animals/view/mainHome.dart';
import 'package:animals/view/petDetails.dart';
import 'package:animals/vmodel/animals.dart';
import 'package:flutter/material.dart';

class AppRouter{

  Route? navigator(RouteSettings routeSettings){
 switch(routeSettings.name){
   case '/':
     return MaterialPageRoute(builder: (BuildContext context)=>MainHome());
   case '/toDetails':
     var animalDetails = routeSettings.arguments as Animals;
     return MaterialPageRoute(builder: (BuildContext context)=>AnimalDetails(animals:animalDetails,),);
   case '/backToMain':
     var petDetails = routeSettings.arguments as Animals;
     return MaterialPageRoute(builder: (BuildContext context)=>MainHome());
 }

  }
}