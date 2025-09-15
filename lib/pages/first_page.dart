import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:cropwatchv2/custom_widgets/actuator_button.dart';
//import 'package:cropwatchv2/custom_widgets/weather_box.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _fanIsPressed = false;
  bool _pumpIsPressed = false;
  bool _heaterIsPressed = false;
  bool _bulbIsPressed = false;

  bool fanButtonEnabled = true;
  bool pumpButtonEnabled = true;
  bool heaterButtonEnabled = true;
  bool bulbButtonEnabled = true;

  double temperature = 0;
  double humidity = 0;
  double soilMoisture = 0;

  /*final bulbRef = FirebaseDatabase.instance.ref("control/light");
  final fanRef = FirebaseDatabase.instance.ref("control/fan");
  final waterRef = FirebaseDatabase.instance.ref("control/water");
  final heaterRef = FirebaseDatabase.instance.ref("actuators/HEATER");*/

  void _toggleButton(String device) {
    setState(() {
      switch (device) {
        case "fan":
          _fanIsPressed = !_fanIsPressed;
          //fanRef.set(_fanIsPressed);
          setState(() {
            fanButtonEnabled = false;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              fanButtonEnabled = true;
            });
          });
          break;
        case "water":
          _pumpIsPressed = !_pumpIsPressed;
          //waterRef.set(_pumpIsPressed);
          setState(() {
            pumpButtonEnabled = false;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              pumpButtonEnabled = true;
            });
          });
          break;
        case "heater":
          _heaterIsPressed = !_heaterIsPressed;
          //heaterRef.set(_heaterIsPressed);
          setState(() {
            heaterButtonEnabled = false;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              heaterButtonEnabled = true;
            });
          });
          break;
        case "led":
          _bulbIsPressed = !_bulbIsPressed;
          //bulbRef.set(_bulbIsPressed);
          setState(() {
            bulbButtonEnabled = false;
          });
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              bulbButtonEnabled = true;
            });
          });
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //temperature listener
    /*final tempRef = FirebaseDatabase.instance.ref("latest/temperature");
    tempRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;
      final double temp = (s.value as num).toDouble();

      setState(() {
        temperature = temp;
      });
    });*/

    //humidity listener
    /*final humidityRef = FirebaseDatabase.instance.ref("latest/humidity");
    humidityRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;
      final double hum = (s.value as num).toDouble();

      setState(() {
        humidity = hum;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      endDrawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "Cropwatch",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 123, 127),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.365,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 30, left: 10, right: 11),

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(0, 3),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                    ],
                    color: const Color.fromARGB(255, 0, 123, 127),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(39),
                      bottomRight: Radius.circular(39),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 0, 98, 101),
                        ),
                        /*child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherBox(
                                  label: "Temperature",
                                  backColor: const Color.fromARGB(
                                    255,
                                    0,
                                    123,
                                    127,
                                  ),
                                  foreColor: Colors.white,
                                  reading: temperature,
                                  unit: '⁰C',
                                ),
                                WeatherBox(
                                  label: "Humidity",
                                  backColor: Colors.white,
                                  foreColor: const Color.fromARGB(
                                    255,
                                    0,
                                    123,
                                    127,
                                  ),
                                  reading: humidity,
                                  unit: "%",
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment(-1, 1),
                              child: WeatherBox(
                                label: "Soil Moisture",
                                backColor: const Color.fromARGB(
                                  255,
                                  0,
                                  123,
                                  127,
                                ),
                                foreColor: Colors.white,
                                reading: soilMoisture,
                                unit: "%",
                              ),
                            ),
                          ],
                        ),*/
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
              ),
              child: Text(
                "View Trends",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 98, 101),
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/secondpage');
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.047),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            /*child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActuatorButton(
                      label: "Fan",
                      assetpath: 'assets/images/fan.png',
                      isPressed: _fanIsPressed,
                      isEnabled: fanButtonEnabled,
                      onToggle: () => _toggleButton("fan"),
                      color: const Color.fromARGB(255, 66, 227, 128),
                    ),

                    ActuatorButton(
                      label: "Water",
                      assetpath: 'assets/images/water.png',
                      isPressed: _pumpIsPressed,
                      isEnabled: pumpButtonEnabled,
                      onToggle: () => _toggleButton("water"),
                      color: const Color.fromARGB(255, 0, 162, 255),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0005),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActuatorButton(
                      label: "Heater",
                      assetpath: 'assets/images/heater.png',
                      isPressed: _heaterIsPressed,
                      isEnabled: heaterButtonEnabled,
                      onToggle: () => _toggleButton("heater"),
                      color: Colors.red,
                    ),

                    ActuatorButton(
                      label: "LED",
                      assetpath: 'assets/images/bulb.png',
                      isPressed: _bulbIsPressed,
                      isEnabled: bulbButtonEnabled,
                      onToggle: () => _toggleButton("led"),
                      color: const Color.fromARGB(255, 255, 219, 17),
                    ),
                  ],
                ),
              ],
            ),*/
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }
}
