
class Pakan{
  int? id;
  String? tanggalPakan;
  int? jumlahPakan;
  int? hargaPakan;
  String? catatanPakan;
  String? bulanPakan;
  // int?jumlahPakanBulan;
  // String?pakanBulanan;

    Pakan( {
      this.id,
      this.tanggalPakan,
      this.jumlahPakan,
      this.hargaPakan,
      this.catatanPakan,
      this.bulanPakan,
      // this.jumlahPakanBulan,
      // this.pakanBulanan,
    });
  Pakan.fromJson(Map<String,dynamic> json){
      id = json['id'];
      tanggalPakan = json['tanggalPakan'];
      jumlahPakan = json['jumlahPakan'];
      hargaPakan = json['hargaPakan'];
      catatanPakan = json['catatanPakan'];
      bulanPakan = json['bulanPakan'];
      // jumlahPakanBulan = json['jumlahPakanBulan'];
      // pakanBulanan = json['pakanBulanan'];
    }  

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> datapakan = <String, dynamic>{};
      datapakan['id']= id;
      datapakan['tanggalPakan']=tanggalPakan;
      datapakan['jumlahPakan']= jumlahPakan;
      datapakan['hargaPakan']= hargaPakan;
      datapakan['catatanPakan']= catatanPakan;
      datapakan['bulanPakan']= bulanPakan;
      // datapakan['jumlahPakanBulan']= jumlahPakanBulan;
      // datapakan['pakanBulanan']= pakanBulanan;

      return datapakan;

}

  
}