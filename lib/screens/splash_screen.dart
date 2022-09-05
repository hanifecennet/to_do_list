import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_page.dart';

class ScreenSplash extends StatefulWidget 
{
  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> 
{
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
    (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    );
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Stack( 
        
        children: [
         Container( 
          decoration: BoxDecoration(color: Colors.white, 
                      image: DecorationImage(
                        image: AssetImage("assets/tik.jpeg"),
                        fit: BoxFit.contain //fotonun zeminde kaplayacagi alan
                      
                        ),
                    
                      ),
                  
                    
                  ),
                  SizedBox(height: 10,),
                  Positioned(bottom:100, left: 80,
                  child: Container(
                    
                    child: Text("Yapılacaklar", style: TextStyle(fontSize: 40),)),)
        
        ],
        
      ),
    );
  }
}