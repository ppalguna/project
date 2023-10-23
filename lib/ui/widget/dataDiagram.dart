// import 'package:flutter/material.dart';

// class dataRekap extends StatefulWidget {
//   const dataRekap({super.key});

//   @override
//   State<dataRekap> createState() => _dataRekapState();
// }

// class _dataRekapState extends State<dataRekap> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//         title: Text("Data Table Example"),
//       ),

//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columns: <DataColumn>[
//             DataColumn(label: Text("Dessert (100g serving)")),
//             DataColumn(label: Text("Calories")),
//             DataColumn(label: Text("Fat (g)")),
//             DataColumn(label: Text("Protein (g)")),
//           ],
//           rows: <DataRow>[
//             DataRow(
//                 cells: <DataCell>[
//                   DataCell(Text("Frozen Yogurt")),
//                   DataCell(Text("159")),
//                   DataCell(Text("6.0")),
//                   DataCell(Text("4.0")),
//                 ],
//             ),
//             DataRow(
//                 cells: <DataCell>[
//                   DataCell(Text("Ice Cream Sandwich")),
//                   DataCell(Text("237")),
//                   DataCell(Text("9.0")),
//                   DataCell(Text("4.3")),
//                 ],
//             ),
//             DataRow(
//                 cells: <DataCell>[
//                   DataCell(Text("Eclair")),
//                   DataCell(Text("262")),
//                   DataCell(Text("16.0")),
//                   DataCell(Text("6.0")),
//                 ],
//             ),
//           ],
//         ),
//       ),

//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/diagram_controller.dart';
// import 'package:intl/intl.dart';
import 'package:my_piggy_app/controllers/pakan_controller.dart';
import 'package:my_piggy_app/controllers/pig_controller.dart';
import 'package:my_piggy_app/models/total_data_pakan.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/pakan.dart';
import '../theme.dart';

// import 'input_field.dart';
//import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class dataDiagram extends StatefulWidget {
  const dataDiagram({
    super.key,
  });

  @override
  State<dataDiagram> createState() => _dataDiagramState();
}

class _dataDiagramState extends State<dataDiagram> {
  // DateTime _firstDate= DateTime.now();
  //  DateTime _lastDate= DateTime.now();
  final _pakanControler = Get.put(PakanController());
  final _pigController = Get.put(PigController());
  final _diagramController = Get.put(DiagramController());

  @override
  void initState() {
    super.initState();
    _pakanControler.getPakan();
    _pigController.getPig();
    // _pakanControler.calculatePakanBulanan();
    print(_pakanControler.pakanList.length);
  }

  @override
  Widget build(BuildContext context) {
    //final List<ChartData<Pakan,String>> seties;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Diagram Rekap',
            style: subStyle.copyWith(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: context.theme.dialogBackgroundColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios),
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //
              Container(
                color: context.theme.dialogBackgroundColor,
                height: MediaQuery.of(context).size.height / 3,
                child: dataChartTernak(),
              ),
              // SizedBox(  height: MediaQuery.of(context).size.height/20,),

              Container(
                color: context.theme.dialogBackgroundColor,
                height: MediaQuery.of(context).size.height / 2.5,
                child: dataChart(),
              ),
            ],
          ),
        ));
  }

//
  dataChart() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (_, context) {
            List<Pakandata> dataPakan = [];
            for (int index = 0;
                index < _pakanControler.pakanList.length;
                index++) {
              Pakan pakan = _pakanControler.pakanList[index];
              dataPakan.add(Pakandata.fromMap(pakan.toJson()));
              print(pakan.toJson());
            }
            return Column(
              children: [
                GetBuilder(builder: (DiagramController controller) {
                  return SfCartesianChart(
                    title: ChartTitle(
                      text: 'Rekap Data Pakan',
                      alignment: ChartAlignment.far,
                      textStyle: subtitle.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(
                      autoScrollingDelta: 4,
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: const MajorTickLines(width: 0),
                    ),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                    ),
                    series: <ChartSeries<TotalDataPakan, String>>[
                      ColumnSeries<TotalDataPakan, String>(
                        dataSource: _diagramController.totalDataPakan,
                        xValueMapper: (data, _) {
                          return DateFormat('MMMM', 'id').format(DateTime(
                              0, int.parse(data.pakanBulanan.substring(0, 2))));
                        },
                        yValueMapper: (data, _) => data.jumlahPakanBulan,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  );
                }),
              ],
            );
          }),
    );
  }

  dataChartTernak() {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (_, context) {
          return SfCircularChart(
              title: ChartTitle(
                text: 'Rekap Data Ternak',
                alignment: ChartAlignment.near,
                textStyle: subtitle.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
              legend: const Legend(
                  isVisible: true,
                  // Legend will be placed at the left
                  position: LegendPosition.right),
              // margin: EdgeInsets.all(20),
              series: <CircularSeries>[
                PieSeries<TernakData, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    dataSource: <TernakData>[
                      TernakData(
                          'Babi Terjual', _pigController.jumJual.toString()),
                      TernakData(
                          'Babi Beli', _pigController.jumBeli.toString()),
                      TernakData(
                          'Babi Mati', _pigController.jumMati.toString()),
                      TernakData(
                          'Babi Lahir', _pigController.jumMasuk.toString()),
                    ],
                    xValueMapper: (TernakData data, _) => data.xku,
                    yValueMapper: (TernakData data, _) =>
                        int.tryParse(data.yku)),
              ]);
        });
  }
}

class Pakandata {
  Pakandata(this.xValue, this.yValue);
  Pakandata.fromMap(Map<String, dynamic> dataMap)
      : xValue = dataMap['tanggalPakan'],
        yValue = dataMap['hargaPakan'];

  String xValue;
  num yValue;
}

class TernakData {
  TernakData(
    this.xku,
    this.yku,
  );
  final String xku;
  final String yku;
}
//Container(
//    padding: const EdgeInsets.fromLTRB(40, 0 , 40, 10),
//    color: context.theme.dialogBackgroundColor,
//    child:
//      Row(
//        children: [
//          Expanded(
//            child: MyInputField(
//              title: "Tanggal awal",
//              hint: DateFormat.yMd().format(_firstDate),
//              widget: IconButton(
//                onPressed: (){
//                    _firstDateUser();

//                },
//                icon: const Icon(
//                  Icons.calendar_month,
//                  color: Colors.grey,
//                ),
//              ),
//            ),
//            ),
//            const SizedBox(width: 10,),
//             Expanded(
//            child: MyInputField(
//              title: "Tanggal akhir",
//              hint: DateFormat.yMd().format(_lastDate),
//              widget: IconButton(
//                onPressed: (){
//                 _lastDateUser();
//                },
//                icon: const Icon(
//                  Icons.calendar_month,
//                  color: Colors.grey,
//                ),
//              ),
//            ),
//          )
//        ],
//      ),
//  ),
