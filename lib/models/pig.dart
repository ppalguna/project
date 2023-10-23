
class Pig{
  int? id;
  String? jenisTernak;
  String? tipeUpdate;
  String? catatanPig;
  int? jumlah;
  String?tanggal;
  int?color;

    Pig( {
      this.id,
      this.jenisTernak,
      this.tipeUpdate,
      this.catatanPig,
      this.jumlah,
      this.tanggal,
      this.color
    });
  Pig.fromJson(Map<String,dynamic> json){
      id = json['id'];
      jenisTernak = json['jenisTernak'];
      tipeUpdate = json['tipeUpdate'];
      catatanPig = json['catatanPig'];
      jumlah = json['jumlah'];
      tanggal = json['tanggal'];
      color = json['color'];
    }  

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> datapig = <String, dynamic>{};
      datapig['id']= id;
      datapig['jenisTernak']=jenisTernak;
      datapig['tipeUpdate']= tipeUpdate;
      datapig['catatanPig']= catatanPig;
      datapig['jumlah']= jumlah;
      datapig['tanggal']= tanggal;
      datapig['color']= color;
      return datapig;

}
}