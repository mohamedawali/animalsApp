import 'package:animals/repository/webApi.dart';
import 'package:animals/vmodel/animals.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../model/animals.dart';
class MainHome extends StatefulWidget {

  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<Animals>? animals;
  List<Animals>? searchList;
  VMAnimals? vmAnimals;
final searchText=TextEditingController();
  @override
  void initState() {
    vmAnimals = VMAnimals(WebApi());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Animals App',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 24),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextField(controller: searchText,
                        onChanged: (text)=>search(text),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                            hintText: 'What do you want?',
                            prefixIcon: Icon(Icons.search,color: Colors.deepOrange,),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height - 248,
                        child: FutureBuilder(
                            future: vmAnimals!.getAnimals(),
                            builder:
                                (context, AsyncSnapshot<List<Animals>> animalsData) {
                              if (animalsData.hasData) {
                                animals = animalsData.data;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:searchText!.text.isEmpty ? animals!.length:searchList!.length,

                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    child: InkWell(onTap: ()=> Navigator.pushNamed(context, '/toDetails',arguments: animals![index]),
                                      child: Container(
                                          height: 140,
                                          child: Stack(children: [
                                            Center(
                                                child: Container(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Card(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                color: Colors.white,
                                                child:
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 160),
                                                  child:
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(searchText.text.isEmpty?
                                                        '${animals![index].name}' :'${searchList![index].name}',
                                                       overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          '${animals![index].animalType}',
                                                          style: TextStyle(
                                                              fontSize: 18))
                                                    ],
                                                  ),
                                                ),
                                           ),
                                            )),
                                            Center(
                                                widthFactor: 1.0,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  elevation: 10,
                                                  child: Container(
                                                    height: 140,
                                                    width: 150,
                                                    //     elevation: 10,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        child: Image.network(
                                                          animals![index].imageLink!,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                ))
                                           ])),
                                    ),
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
                            }))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    )
        // SafeArea(child: Container(color: Colors.white,),)
        ;
  }
void  search(String text) {
    searchList=animals!.where((pet) => pet.name!.toLowerCase().startsWith(text)).toList();
    setState(() {

    });
  }


}
