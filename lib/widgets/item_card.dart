import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/to_do_list_model.dart';

class CardDesign extends StatelessWidget 
{
  final String? work;
  final bool? isDone;
  final Function? toggleStatus;
  CardDesign({this.work, this.isDone, this.toggleStatus});

  @override
  Widget build(BuildContext context) 
  {
    return Card(
      elevation: 5,
      shadowColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child:  ListTile(
        title: Text(
          'Flutter eğitimini tamamla ', 
          style: TextStyle(
            color: Colors.black),
        ),
        trailing: Checkbox(
          onChanged: null, 
          value: isDone, 
          activeColor: Colors.purple[700],
        ),
      ),
    );
  }
}