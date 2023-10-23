class Task{
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  String? repeat;
  String? tanggalLahir;
  String? tanggalKebiri;
  String? tanggalSapih;

    Task({
      this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.repeat,
      this.tanggalLahir,
      this.tanggalKebiri,
      this.tanggalSapih,
    });
  Task.fromJson(Map<String,dynamic> json){
      id = json['id'];
      title = json['title'];
      note = json['note'];
      isCompleted = json['isCompleted'];
      date = json['date'];
      startTime = json['startTime'];
      endTime = json['endTime'];
      color = json['color'];
      repeat = json['repeat'];
      tanggalLahir = json['tanggalLahir'];
      tanggalKebiri = json['tanggalKebiri'];
      tanggalSapih = json['tanggalSapih'];
    }  

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
      data['id']= id;
      data['title']=title;
      data['date']= date;
      data['note']= note;
      data['isCompleted']= isCompleted;
      data['startTime']= startTime;
      data['endTime']= endTime;
      data['color']= color;
      data['repeat']= repeat;
      data['tanggalLahir']= tanggalLahir;
      data['tanggalKebiri']= tanggalKebiri;
      data['tanggalSapih']= tanggalSapih;
      return data;

}
}