import 'package:flutter/material.dart';
import 'package:untitled/custom_widgets/sensor_chart.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sensor Charts")),
      body: Column(
        children: [
          Expanded(child: SensorChart(sensorType: "temperature", title: "Temperature")),
          Expanded(child: SensorChart(sensorType: "humidity", title: "Humidity")),
          Expanded(child: SensorChart(sensorType: "soil_moisture", title: "Soil Moisture")),
        ],
      ),
    );
  }
}
