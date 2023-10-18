
import 'package:get/get.dart';
import 'package:my_piggy_app/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController{

  var taskList = <Task>[].obs;

 Future< int > addTask({Future? showDialog, Task? task}) async{ 
  //Task model menjadi task object 
  return await DBHelper.insert(task);
 }
 void getTask() async {
  List<Map<String, dynamic>> tasks =await DBHelper.query();
  taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
 }
 void delete(Task task){
   DBHelper.delete(task);
  getTask();
 }
 void markTaskCompleted(int id) async{
 await DBHelper.update(id);
 getTask();
 }

}