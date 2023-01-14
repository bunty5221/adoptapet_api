import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/model/petshop_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage>  {

  Future <petshopmodel> fetchdata() async{
    final response = await  http.get(Uri.parse('https://api.publicapis.org/entries'));
    var data = json.decode(response.body.toString());

    if (response.statusCode==200) {
      return petshopmodel.fromJson(data);
      }else {
      return petshopmodel.fromJson(data);
    }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PetAdopet"),
      ),
body:FutureBuilder<petshopmodel>(
  future: fetchdata(),
  builder: (context, snapshot){
    if(snapshot.hasData) {

      return ListView.builder(
         scrollDirection: Axis.vertical,
          itemCount: snapshot.data?.data?.length,

          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.red
                    ),

                    child: Card(
                      color: Colors.deepOrange,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(snapshot.data!.entries![index].category.toString(),style: TextStyle(color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(snapshot.data!.entries![index].description.toString(),style: TextStyle(color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(snapshot.data!.entries![index].aPI.toString(),style: TextStyle(color: Colors.white),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(snapshot.data!.entries![index].link.toString(),style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),

                    ),
                  ),
                )
              ],
            );
          });
    }return  CircularProgressIndicator();
    },
)



    );

  }
}
