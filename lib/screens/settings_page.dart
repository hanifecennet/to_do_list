import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/color_theme_data.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('Tema Seçimi ', style: TextStyle(color: Colors.white, fontSize: 25, ),),),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SwitchCard(),
    );
  }
}

class SwitchCard extends StatefulWidget {
  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  bool _value=true;

  @override
  Widget build(BuildContext context) {
  //Text widget ı olustur
  Text purpleText = Text('Purple', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20));
  Text orangeText = Text('Orange', style: TextStyle(color: Colors.orange[800], fontSize: 20));

    return Card(
      child: SwitchListTile(
        title: Text('Tema rengini degis',
        style: TextStyle(color: Colors.black, fontSize: 25),),
        subtitle: _value ? purpleText : orangeText, 
        value: _value,
        onChanged: (bool value) {
        setState(() {
          _value = value;
        });
        Provider.of<ColorThemeData>(context, listen: false).switchTheme(value);
         //fonk cagirdgimiz icin listen:false
        },
        
      ),
    );
  }
}