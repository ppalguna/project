import 'dart:typed_data';

class Profil{
  int? id;
  String? namaPeternak;
  String? namaPeternakan;
  Uint8List? foto;

    Profil({
      this.id,
      this.namaPeternak,
      this.namaPeternakan,
      this.foto
    });
  Profil.fromJson(Map<String,dynamic> json){
      id = json['id'];
      namaPeternak = json['namaPeternak'];
      namaPeternakan = json['namaPeternakan'];
      foto = json['foto'];
   
    }  

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> dataprofil = <String, dynamic>{};
      dataprofil['id']= id;
      dataprofil['namaPeternak']=namaPeternak;
      dataprofil['namaPeternakan']= namaPeternakan;
      dataprofil['foto']= foto;
      
      return dataprofil;

}
}