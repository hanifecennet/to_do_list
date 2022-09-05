import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/to_do_list_model.dart';
import 'package:http/http.dart' as http;
import '../widgets/item_card.dart';
import '../screens/add_work.dart';
import '../widgets/count_work.dart';
import 'package:to_do_list/services.dart';

class ycy extends StatefulWidget 
{
  @override
  State<ycy> createState() => _ycyState();
}
class _ycyState extends State<ycy> 
{
  String? count;
  String? boxCheck;
  IconButton? boxIcon;
     List <ToDoListModel>? data =[];

  workCount()
  {
    Api.getCountWork().then((value) async //sunucuya baglandiktan sonra veriyi atama
    {  
      setState(() 
      {
        print('value: $value');
        count = value.toString();
        print(count);
      }); 
     });
  }

  vericek()async{
    Api.getList().then((value) {
      setState(() {
        data = value;
      });
    });
  }
  
  @override
  void initState() 
  {
    count = Api.getCountWork().toString();
    super.initState();
    workCount();
    vericek();
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,//add butonunu ortalama
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center, 
          child: Text(
            'Yapılacaklar', 
            style: TextStyle(
              fontSize: 25, 
            ), 
          ),
        ),
      ),     
      body: Column(
        children: [
          SizedBox(height: 30,),
          Expanded(
            flex: 1,
            child: Container(
              height: 150,
              child: Padding( //diger ögelerle arasina bosluk
                padding: const EdgeInsets.all(20.0),
                child: Text('$count görev kaldı',
                 //Api.getCount(countIndex),
                  style: Theme.of(context).textTheme.headline3, //baslik yazi tipi
                ),
              //  print(data[index].count),
              ),
            ),
          ), 
          Expanded( //genisleye bildigi kadar genisler
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration( //kutu tasarımı
                  color: Colors.white,
                  borderRadius: BorderRadius.all( //kenarlari yuvarlak
                    Radius.circular(60),
                  ),
                  boxShadow:[ //golgelendirme
                    BoxShadow(
                      color: Color.fromARGB(255, 90, 88, 88).withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 7,
                      offset: Offset(0, 3), // golgenin pozisyonunu degisme
                    ),
                  ],
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: 
                      
                     
                         ListView.builder(
                          itemCount: data!.length, //card sayisini belirliyoruz
                          itemBuilder: (context, index) 
                          {
                          //  List list = snapshot.data;
                            return kart1(data!,index); //kart1 e gider
                          }
                        )
                      
                   
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(width: 60,
      height: 60,
        child: FloatingActionButton( //+ butonu
          
          onPressed: () 
          {
            showModalBottomSheet( //acilir pencere
              context: context, 
              builder: (context) => AddWork());
          },
              
          child: Icon(Icons.add, size: 30,),
        ),
      ),
    );
  }
  
  //kart1 card sablonu
  Card kart1(List <ToDoListModel> data,int index) 
  {
    bool? _value = true;
    return Card(
      elevation: 25, //kartin 3b gorunmesini saglar
      shadowColor: Theme.of(context).primaryColor, //golge
    child: Dismissible( //karti kaydirma islemi
      background: Container(
        color: Colors.purple,
        
      ),
      key: UniqueKey(), //null hatasini engellemek icin ValueKey yerine
      // key: ValueKey<ToDoListModel>(data[index]),
      onDismissed: (DismissDirection direction) 
      {
        print('yana cekildi');
        Api.deleteWork(data, index);  //deleteWork cagrilir
         setState(() {
          //gorev silindikten sonra sayfayi yeniler
          Navigator.push(context, MaterialPageRoute(builder: (context) => ycy(),),); 
         });
      },
      
        child: ListTile(
        title: Text( 
          data[index].work.toString(), //eklenen is
          style: TextStyle(
            color: Colors.black, fontSize: 22,
          ),
        ), 
        subtitle: Text( 
          data[index].time.toString(), //kayit zamani
          style: TextStyle(
            color: Colors.purple[900], fontSize: 18,
          ),
        ),
        trailing: GestureDetector( //alani dokunmatik hale getirir
        child: data[index].isDone.toString() =='1' ? IconButton( 
          icon: data[index].isDone.toString() != "1"
              ? Icon(Icons.check_box_outline_blank)
              : Icon(Icons.check_box),
          onPressed: () async{
            print(data[index].isDone);
            //String isDone = "0";
            /* if(data[index].isDone=='1')
             {
                isDone = "0";
              }
              else 
              {
                isDone = "1";
              }*/
            //update1
            vericek();
            workCount();
           // Api.getList();
            Api.updateWork(data, index) ; //updateWork cagrilir
              setState(() {
                  //data[index].isDone = isDone; //db ye atama
                  print("tiklandi ${data[index].work}");
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ycy(),),);
                  
                  //checkbox degistiginde sayfayi gunceller, gorev sayisini yenileme
            });
          
            
           /* Api.getCountWork(); //updateWork cagrilir
              setState(() {
                  //data[index].isDone = isDone; //db ye atama
                  print("tiklandi ");
            });*/
          },
          
        ):
        
        IconButton(
          icon: Icon(Icons.check_box_outline_blank),
          onPressed: () async {
           /* String isDone = "0";
             if(data[index].isDone=='1')
             {
              isDone = "0";
             }
             else 
             {
              isDone = "1";
             }*/
           // print(isDone);
              //update2
              Api.updateWork(data, index,);
              vericek(); //updateWork cagrilir
 workCount();
              setState(() {
                  //data[index].isDone = isDone;
                 // print('isaret');
                 //Navigator.push(context, MaterialPageRoute(builder: (context) => ycy(),),);
                 


                 //checkbox degistiginde sayfayi gunceller, gorev sayisini yenileme
                });
                //Api.getList();
              /*  Api.getCountWork();
                setState(() {
                  //data[index].isDone = isDone;
                 // print('isaret');
                });*/
              },
              
            ),
          ),
        ),
      )
    );
  }
  



 
//sayigetir

  
}

 

    
