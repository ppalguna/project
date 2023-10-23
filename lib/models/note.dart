
import 'dart:typed_data';

class Note{
  int? id;
  String? judul;
  String? keterangan;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  String? repeat;
  Uint8List?image;


    Note({
      this.id,
      this.judul,
      this.keterangan,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.repeat,
      this.image,

    });
  Note.fromJson(Map<String,dynamic> json){
      id = json['id'];
      judul = json['judul'];
      keterangan = json['keterangan'];
      isCompleted = json['isCompleted'];
      date = json['date'];
      startTime = json['startTime'];
      endTime = json['endTime'];
      color = json['color'];
      repeat = json['repeat'];
      image = json['image'];
    }  

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> datanote = <String, dynamic>{};
      datanote['id']= id;
      datanote['judul']=judul;
      datanote['date']= date;
      datanote['keterangan']= keterangan;
      datanote['isCompleted']= isCompleted;
      datanote['startTime']= startTime;
      datanote['endTime']= endTime;
      datanote['color']= color;
      datanote['repeat']= repeat;
      datanote['image']= image;
      return datanote;

}
}