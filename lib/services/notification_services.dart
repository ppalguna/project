
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/models/note.dart';
import 'package:my_piggy_app/ui/widget/notified_page.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

import '../models/task.dart';

class NotifyHelper{
   FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      

  initializeNotification() async {
  _configureLocalTimezone();
  //  // this is for latest iOS settings
  const AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("ppicon");

    // ignore: unused_local_variable,
      const InitializationSettings initializationSettings =
      InitializationSettings(
      android:initializationSettingsAndroid
    );

  await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, 
      onDidReceiveNotificationResponse : (NotificationResponse notificationResponse)async{}
    );
    
  }

  displayNotification({required String title, required String body})async {
    print("test");
    var androidPlatformChannelSpecification = 
    const AndroidNotificationDetails(

      'your chanel id','name',
      importance: Importance.max,
      priority:Priority.high);

    // ignore: unnecessary_new
    var platformChannelSpecification = new NotificationDetails(
      android: androidPlatformChannelSpecification);
      
      await flutterLocalNotificationsPlugin.show(
        0,
        title, 
        body, 
        platformChannelSpecification,
        payload: title 
        );
    
   }
  scheduledNotification(int hour, int minutes,  Task task)async{
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      'Hallo Peternak  ${task.title}',
      'Catatan:  ${task.note}',
      _convertTime(hour, minutes),
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
       const NotificationDetails(
          android: AndroidNotificationDetails('yourd id',
           'your chanel name',)), 
  
       
       // ignore: deprecated_member_use
       androidAllowWhileIdle: true,
       uiLocalNotificationDateInterpretation: 
       UILocalNotificationDateInterpretation.absoluteTime,
       matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}|"
       );
  }
   notescheduledNotification(int hour, int minutes,  Note note)async{
    await flutterLocalNotificationsPlugin.zonedSchedule(
      note.id!.toInt(),
      note.judul,
      note.keterangan,
      _convertTime(hour, minutes),
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
       const NotificationDetails(
          android: AndroidNotificationDetails('yourd id',
           'your chanel name',)), 
  
       
       // ignore: deprecated_member_use
       androidAllowWhileIdle: true,
       uiLocalNotificationDateInterpretation: 
       UILocalNotificationDateInterpretation.absoluteTime,
       matchDateTimeComponents: DateTimeComponents.time,
        payload: "${note.judul}|" "${note.keterangan}|"
       );
  }

  tz.TZDateTime _convertTime(int hour, int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    
    if(scheduleDate.isBefore(now)){

      scheduleDate= scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
    //print(timezone);
  }
 
 Future notificationResponse(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(()=>NotifiedPage(label: payload));
  } 
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
    Get.dialog(const Text("Welcome to Flutter"));
  }

}

