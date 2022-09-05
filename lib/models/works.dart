


class ToDoListModel{
  String? work;
  bool isDone;

  ToDoListModel({this.work, this.isDone=false});
void toggleStatus()
  {
    isDone=!isDone;
  }
}

