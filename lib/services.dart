import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/to_do_list_model.dart';
import 'package:http/http.dart' as http;
import './screens/home_page.dart';

class Api  
{ 
  //gorev listesini getiren servis
  static Future<List<ToDoListModel>> getList() async 
  {
    var uri = Uri.parse("http://172.16.45.76/to_do_list/to_do_list.php");
    var data = [];
    try 
    {
      final response = await http.get(uri); //adrese baglanma
      if (response.statusCode == 200)  //baglanti gerceklesti ? gerceklesmedi ? kntrl
      {
        data = json.decode(response.body);
        print(response.body);
        print("islem basarili" );
      } 
      else 
      {
        print("api hatası");
      }
    } 
    catch (err) 
    {
      print(err);
    }
    return data.map((data) => ToDoListModel.fromJson(data)).toList(); //jsondaki verileri liste haline getir
  }

  //delete service
  static deleteWork(data, int index) async
  {
    http.post(Uri.parse('http://172.16.45.76/to_do_list/delete.php'),body: {
              'id' : data[index].id, //id numarasina gore gorevi silme islemi
            });
            debugPrint('gorev silindi');
  }

  //update checkbox
  static updateWork(data, int index) async
  {
    // String isDone='1';
    String isDone = "0";
    if(data[index].isDone=='1')
    {
      isDone = "0";
    }
    else 
    {
      isDone = "1";
    }
    print(data[index].isDone);
    http.post(Uri.parse('http://172.16.45.76/to_do_list/update.php'),body: {
                'id' : data[index].id, //
                'isDone' :isDone //
              });
  }

  //yapilmamis gorev sayisini belirleme
  static  getCountWork() async 
  {
    var uri = Uri.parse('http://172.16.45.76/to_do_list/count_data.php');
    try 
    {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) 
      {
        String data = response.body;
        var decodedData = jsonDecode(data);
        print('decodedData:$decodedData');
        return decodedData;
      } 
      else 
      {
        return 'failed';
      }
    } 
    catch (e) 
    {
      return 'failed';
    }
  }



//yapilmamis gorev sayisini ekrana yazdirir
/*static Future<void> sayiGetir () async {
  late Future<void> bosSayisi=Api.sayiGetir();
 var request = http.MultipartRequest('POST', Uri.parse('http://172.16.39.86/to_do_list/count_data.php'));
  request.fields.addAll({
  'id': '69',
  'work': 'gorevi tamamla',
  'isDone': '1'
});


http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());

 setState(() {
 bosSayisi=response.stream.bytesToString();
    
  });
  
}
else {
  print(response.reasonPhrase);
}
}*/
/*static getCount(count) async 
    {
      http.post(Uri.parse('http://172.16.45.250/to_do_list/count_data.php'),body: {
          'isDone' : count //gorev sayisi belirleme
          });
          print(count);

      /*//late Future<void> bosSayisi=Api.getCount();
      var uri = Uri.parse("http://172.16.39.86/to_do_list/count_data.php");
      //var data = [];
      try 
      {
        final response = await http.get(uri); //adrese baglanma
        if (response.statusCode == 200)  //baglanti gerceklesti ? gerceklesmedi ? kntrl
        {
          //data = json.decode(response.body);
          //print(data[0].isDone.runtimeType);
          print('count' );
          
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
      }*/
      //return data.map((data) => ToDoListModel.fromJson(data)).toList(); //jsondaki verileri liste haline getir
    }
*/

}