import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services.dart';
import 'home_page.dart';
import 'package:to_do_list/services.dart';
import 'package:to_do_list/models/to_do_list_model.dart';
import 'dart:convert';
import '../widgets/item_card.dart';
import '../widgets/count_work.dart';

class AddWork extends StatefulWidget 
{ 
  final List? list; 
  final int index;
  const AddWork({this.list, this.index=0});
    
  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> 
{
  TextEditingController? work = TextEditingController(); 
  TextEditingController? isDone = TextEditingController();
  final textController = TextEditingController();

  bool refresh = false;
addWork() async
{
  http.post(
    Uri.parse('http://172.16.45.76/to_do_list/add.php'),body: //php sayfasi ile baglanti kurar
    {
      'work' : work?.text,
      'isDone' : isDone?.text,
    }
  );
  setState(() {
    
  });
}
@override
void initState() 
{ //tum veriler baslatilir kayit alinir
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: work, //gorev eklenir
              style:  TextStyle(color: Colors.black, fontSize: 30),
              decoration: 
              InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Görev Ekle',
                hintText: '....',
              ),
              autofocus: true,
            ),
            SizedBox(height: 10,),
            RaisedButton(
              onPressed: () async
              {
                Api.getList();
                setState(() 
                {
                  addWork(); //gorev ekleme fonk
                  //Api.updateWork(data, index);
                });
                await Api.getCountWork().then((value) async //sunucuya baglandiktan sonra veriyi atama | once yeni veri atanir
                {  
                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(countt: value.toString(),),),); //sonra sayfa homePage e yönlendirme
                });
              }, 
              color: Theme.of(context).primaryColor, 
              child: Text('EKLE',style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
} 
