import 'package:json_annotation/json_annotation.dart';

part 'total_data_pakan.g.dart';

@JsonSerializable()
class TotalDataPakan {
  final String pakanBulanan;
  final int jumlahPakanBulan;

  const TotalDataPakan(
      {required this.pakanBulanan, required this.jumlahPakanBulan});

  factory TotalDataPakan.fromJson(Map<String, dynamic> json) =>
      _$TotalDataPakanFromJson(json);
  Map<String, dynamic> toJson() => _$TotalDataPakanToJson(this);
}
