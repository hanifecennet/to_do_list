import 'package:flutter/src/widgets/framework.dart';

class ToDoListModel {
  String? id;
  String? work;
  String? isDone; //true || false
  String? time;

  ToDoListModel({this.id, this.work, this.isDone, this.time});

  ToDoListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    work = json['work'];
    isDone = json['isDone']; //isDone - bool
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work'] = this.work;
    data['isDone'] = this.isDone;
    data['time'] = this.time;
    return data;
  }
}
