import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class SensorChart extends StatefulWidget {
  final String sensorType; // e.g. "temperature", "humidity"
  final String title; // chart title

  const SensorChart({Key? key, required this.sensorType, required this.title})
    : super(key: key);

  @override
  State<SensorChart> createState() => _SensorChartState();
}

class _SensorChartState extends State<SensorChart> {
  List<SensorData> _data = [];
  String _timeSpan = "24h";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final ref = FirebaseDatabase.instance.ref(
      "sensor_logging/${widget.sensorType}",
    );
    ref.onValue.listen((event) {
      final Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values == null) return;

      final now = DateTime.now();
      Duration cutoff;
      if (_timeSpan == "24h") {
        cutoff = Duration(hours: 24);
      } else if (_timeSpan == "3d") {
        cutoff = Duration(days: 3);
      } else {
        cutoff = Duration(days: 7);
      }
      final cutoffDate = now.subtract(cutoff);
      final offset = Duration(hours: 5, minutes: 30);

      final tempList = values.entries
          .map((e) {
            final val = e.value as Map;
            return SensorData(
              value: (val["value"] as num).toDouble(),
              timestamp: DateTime.fromMillisecondsSinceEpoch((val["timestamp"] as int) * 1000).add(offset)
            );
          })
          .where((d) => d.timestamp.isAfter(cutoffDate))
          .toList();

          tempList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      setState(() {
        _data = tempList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _timeSpan,
          items: const [
            DropdownMenuItem(value: "24h", child: Text("Last 24 Hours")),
            DropdownMenuItem(value: "3d", child: Text("Last 3 Days")),
            DropdownMenuItem(value: "7d", child: Text("Last 7 Days")),
          ],
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _timeSpan = val;
              });
              _loadData();
            }
          },
        ),
        Expanded(
          child: SfCartesianChart(
            title: ChartTitle(text: widget.title),
            primaryXAxis: DateTimeAxis(),
            series: <CartesianSeries>[
              LineSeries<SensorData, DateTime>(
                dataSource: _data,
                xValueMapper: (d, _) => d.timestamp,
                yValueMapper: (d, _) => d.value,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SensorData {
  final double value;
  final DateTime timestamp;
  SensorData({required this.value, required this.timestamp});
}
