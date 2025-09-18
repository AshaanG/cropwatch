import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class SensorChart extends StatefulWidget {
  final String sensorType;
  final String title;

  const SensorChart({Key? key, required this.sensorType, required this.title}) : super(key: key);

  @override
  _SensorChartState createState() => _SensorChartState();
}

class _SensorChartState extends State<SensorChart> {
  List<SensorData> _data = [];
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
    _listenFirebase();
  }

  void _listenFirebase() {
    final ref = FirebaseDatabase.instance.ref("sensor_logging/${widget.sensorType}");
    ref.onValue.listen((event) {
      final Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values == null) return;

      final tempList = values.entries.map((e) {
        final val = e.value as Map;

        // Parse the "time" string into a DateTime object
        final timeStr = val['time'] as String; // e.g., "14:35:20"
        final now = DateTime.now();
        final parsedTime = DateFormat.Hms().parse(timeStr); // parses HH:mm:ss
        // Combine parsed time with today's date
        final timestamp = DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute, parsedTime.second);

        return SensorData(
          value: (val['value'] as num).toDouble(),
          timestamp: timestamp,
        );
      }).toList();

      tempList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      // Keep only the last 50 readings
      final last50 = tempList.length > 50 ? tempList.sublist(tempList.length - 50) : tempList;

      setState(() {
        _data = last50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfCartesianChart(
            title: ChartTitle(text: widget.title),
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.Hms(), // shows HH:mm:ss
            ),
            primaryYAxis: NumericAxis(),
            zoomPanBehavior: _zoomPanBehavior,
            series: <CartesianSeries>[
              LineSeries<SensorData, DateTime>(
                dataSource: _data,
                xValueMapper: (d, _) => d.timestamp,
                yValueMapper: (d, _) => d.value,
                markerSettings: const MarkerSettings(isVisible: false),
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
