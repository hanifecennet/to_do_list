
/*import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/to_do_list_model.dart';
import 'package:http/http.dart' as http;
import '../screens/home_page.dart';
/*
class CountWork extends StatefulWidget {
  CountWork({Key? key}) : super(key: key);

  @override
  State<CountWork> createState() => _CountWorkState();
}

class _CountWorkState extends State<CountWork> {

  countWork()
  {
    http.post(
    Uri.parse('http://172.16.45.250/to_do_list/count_data.php'), //php sayfasi ile baglanti kurar
    
  );
  }
@override
  void initState() 
  { //tum veriler baslatilir kayit alinir
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




/*Future countWork(countIndex) async
  {
    var uri = Uri.parse("http://172.16.39.86/to_do_list/to_do_list.php");
    //var data = [];
    http.post(
    Uri.parse('http://172.16.39.86/to_do_list/count_data.php'),body: //php sayfasi ile baglanti kurar
    {
      'count' : countIndex,
    }
  );
    try 
    {
      final response = await http.get(uri); //adrese baglanma
      if (response.statusCode == 200)  //baglanti gerceklesti ? gerceklesmedi ? kntrl
      {
      var  data = json.decode(response.body);
        //print(data[0].isDone.runtimeType);
        print(countIndex);
      } 
      else 
      {
        print("api hatası");
      }
    } 
    catch (err) 
    {
      print(err);
      //return data;
    }
    //return data.map((data) => ToDoListModel.fromJson(data)).toList(); //jsondaki verileri liste haline getir
  }

  /*FutureBuilder(
                    future: getList(), //gorev listesini getiren fonk
                    builder: (BuildContext context, AsyncSnapshot snapshot) 
                    {
                      if (snapshot.hasData)
                      { 
                        List <ToDoListModel> data =snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length, //card sayisini belirliyoruz
                          itemBuilder: (context, index) 
                          {
                            List list = snapshot.data;
                            return kart1(data,index); //kart1 e gider
                          }
                        );
                      }
                      else
                      {
                        return Container();
                      }
                    }
                  ),*/

  @override
  Widget build(BuildContext context) 


  {
    return Container();
  }*/
*/
/*
getCountWork() async 
{

var url = Uri.parse("http://172.16.44.206/to_do_list/count_data.php");
http.Response response = await http.get(url);
try {
  if (response.statusCode == 200) {
    String data = response.body;
    var decodedData = jsonDecode(data);
    print('decodedData:$decodedData');
    return decodedData;
  } else {
    return 'failed';
  }
} catch (e) {
  return 'failed';
}*/
}*/