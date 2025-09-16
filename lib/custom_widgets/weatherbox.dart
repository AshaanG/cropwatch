import 'package:flutter/material.dart';

class WeatherBox extends StatelessWidget {
  final String label;
  final Color backColor;
  final Color foreColor;
  final double reading;
  final String unit;

  const WeatherBox({
    super.key,
    required this.label,
    required this.backColor,
    required this.foreColor,
    required this.reading,
    required this.unit,
  });
  String getStatus() {
    if (label == "Humidity") {
      if (reading < 40) return "Dry";
      if (reading <= 60) return "Optimal";
      return "Humid";
    } else if (label == "Temperature") {
      if (reading < 20) return "Cold";
      if (reading <= 30) return "Optimal";
      return "Hot";
    } else if (label == "Soil Moisture") {
      if (reading < 30) return "Dry";
      if (reading < 60) return "Moist/Optimal";
      if (reading < 80) return "Wet";
      return "Saturated";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backColor,
      ),
      padding: EdgeInsets.only(top: 12, left: 20, bottom: 12, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: foreColor,
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$reading$unit",
            style: TextStyle(fontSize: 37, color: foreColor,fontWeight: FontWeight.bold),
            
          ),
          Align(
            alignment: Alignment(0.7, 1),
            child: Text(
              getStatus(),
              style: TextStyle(fontSize: 15, color: foreColor),
            ),
          ),
        ],
      ),
    );
  }
}
