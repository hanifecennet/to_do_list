import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/to_do_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/screens/settings_page.dart';
import '../widgets/item_card.dart';
import '../screens/add_work.dart';
import '../widgets/count_work.dart';
import 'package:to_do_list/services.dart';
import './settings_page.dart';


List <ToDoListModel> liste = [];

class HomePage extends StatefulWidget 
{
 HomePage({ Key? key, this.countt }) : super(key: key);
 final String? countt; //gorev eklendiginde uyari vermeden sayinin gelmesi icin degisken tanimladik

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> 
{
  String count = '0'; //null hatasi vermemesi icin 
  String? boxCheck;
  IconButton? boxIcon;
  //List <ToDoListModel>? data =[];

  bool refresh=false; //checkbox a isaretleme-gorev sayisinin degismesi->sayfanin guncellenmesi

  workCount() async
  {
  await Api.getCountWork().then((value) async //sunucuya baglandiktan sonra veriyi atama
    {  //getCount dan gelen veri-> value-> count a atanir
      setState(() 
      {
        print('value: $value'); 
        count = value.toString();
        print(count);
      }); 
     });
    await Api.getList();
  }
  
  @override
  void initState() //uygulamanin yeniden baslamasi
  {
    count = Api.getCountWork().toString();
    super.initState();
     if(widget.countt==null) //tanimladigimiz degisken bir widget / sayi guncellenmediyse
     { 
      workCount(); //fonk nunda dönen degeri yazdir
      
     }
     else{ //eger yeni gorev eklendiyse 
        setState(() { 
        count = widget.countt!; //yeni gorev widget i
      });
     }
       //guncel gorev sayisini ekrana yazdirir

     
    //Api.getList();
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,//add butonunu ortalama
      appBar: AppBar(
        actions: [Padding(
          padding: const EdgeInsets.all(3.0),
          child: IconButton(icon: Icon(Icons.settings, size: 25, color: Colors.white,), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
          },),
        )],
        title: Align(
          alignment: Alignment.center, 
          child: Text(
            'Yapılacaklar', 
            style: TextStyle(
              color: Colors.white,
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
                  child: FutureBuilder(
                    future:Api.getList(), //gorev listesini getiren fonk
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
                  ),
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
              /*onpress: (){
                sdlfksşdlkfsdf
              }*/
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
    child: Dismissible ( //karti kaydirma islemi
      background: Container (
        color: Colors.grey,
        
      ),
      key: UniqueKey() , //null hatasini engellemek icin ValueKey yerine
      // key: ValueKey<ToDoListModel>(data[index]),
      onDismissed: (DismissDirection direction) 
      {
        print('yana cekildi');
        Api.deleteWork(data, index);  //deleteWork cagrilir
        //Api.updateWork(data, index) ;
        //Api.getList();
        setState(()  {
          //gorev silindikten sonra sayfayi yeniler
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),); 
          //refresh!=refresh;
         
        //Api.getCountWork();
        });
        workCount();
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
          onPressed: () async {
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
            
              Api.updateWork(data, index); //updateWork cagrilir
              Api.getList();
              //workCount();
              setState(() 
              {
                refresh!=refresh;
                //data[index].isDone = isDone; //db ye atama
                print("tiklandi ${data[index].work}");
              });
              await workCount();
            
           /* Api.getCountWork(); //updateWork cagrilir
              setState(() {
                  //data[index].isDone = isDone; //db ye atama
                  print("tiklandi ");
            });*/
          },
        ):
            IconButton(
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () async 
              {
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
                  
                Api.updateWork(data, index,); //updateWork cagrilir
                Api.getList();

                setState(() 
                {
                  //data[index].isDone = isDone;
                  // print('isaret');
                  refresh!=refresh;
                  //checkbox degistiginde sayfayi gunceller, gorev sayisini yenileme
                });
                await workCount(); // await beklemeyi ifade eder
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
}

 

    
