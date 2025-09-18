import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/custom_widgets/actuator_button.dart';
import 'package:untitled/custom_widgets/weatherbox.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:untitled/custom_widgets/threshold_textfield.dart';

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

  bool isManual = true;

  double temperature = 0;
  double humidity = 0;
  double soilMoisture = 0;

  final bulbRef = FirebaseDatabase.instance.ref("control/light");
  final fanRef = FirebaseDatabase.instance.ref("control/fan");
  final waterRef = FirebaseDatabase.instance.ref("control/water");
  final heaterRef = FirebaseDatabase.instance.ref("control/heater");

  final modeRef = FirebaseDatabase.instance.ref("mode");

  TextEditingController mycontroller = TextEditingController();

  void _toggleButton(String device) {
    setState(() {
      switch (device) {
        case "fan":
          _fanIsPressed = !_fanIsPressed;
          fanRef.set(_fanIsPressed);
          break;
        case "water":
          _pumpIsPressed = !_pumpIsPressed;
          waterRef.set(_pumpIsPressed);
          break;
        case "heater":
          _heaterIsPressed = !_heaterIsPressed;
          heaterRef.set(_heaterIsPressed);
          break;
        case "led":
          _bulbIsPressed = !_bulbIsPressed;
          bulbRef.set(_bulbIsPressed);
          break;
      }
    });
  }

  //retrieve
  @override
  void initState() {
    super.initState();
    final devicesRef = FirebaseDatabase.instance.ref("control");
    devicesRef.once().then((DatabaseEvent event) {
      final data = event.snapshot.value as Map;
      setState(() {
        _fanIsPressed = data["fan"];
        _pumpIsPressed = data["water"];
        _bulbIsPressed = data["light"];
        _heaterIsPressed = data["heater"];
        isManual = data["manual_mode"];
      });
    });

    //temperature listener
    final tempRef = FirebaseDatabase.instance.ref("latest/temperature");
    tempRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;
      final double temp = (s.value as num).toDouble();

      setState(() {
        temperature = temp;
      });
    });

    //humidity listener
    final humidityRef = FirebaseDatabase.instance.ref("latest/humidity");
    humidityRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;
      final double hum = (s.value as num).toDouble();

      setState(() {
        humidity = hum;
      });
    });
    //soil moisture listener
    final soilRef = FirebaseDatabase.instance.ref("sensor/soil");
    soilRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;
      final double soil = (s.value as num).toDouble();

      setState(() {
        soilMoisture = soil / 4095 * 100;
      });
    });

    //******* ACTUATOR LISTENERS ********

    // fan listener
    fanRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;

      final bool fanState = s.value as bool;

      setState(() {
        _fanIsPressed = fanState;
      });
    });

    // heater listener
    heaterRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;

      final bool heaterState = s.value as bool;

      setState(() {
        _heaterIsPressed = heaterState;
      });
    });

    // water pump listener
    waterRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;

      final bool waterState = s.value as bool;

      setState(() {
        _pumpIsPressed = waterState;
      });
    });
    // bulb listener
    bulbRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;

      final bool bulbState = s.value as bool;

      setState(() {
        _bulbIsPressed = bulbState;
      });
    });
    // manual/automatic listener
    modeRef.onValue.listen((DatabaseEvent event) {
      final DataSnapshot s = event.snapshot;
      if (!s.exists) return;

      final String modeState = s.value.toString();

      setState(() {
        if (modeState == "manual") {
          isManual = true;
        } else if (modeState == "automatic") {
          isManual = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      endDrawer: Drawer(
        //**************************************** drawer ************************************
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "you can change the thresholds in the automatic mode according to your preference using the fields below",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Text(
                      "The fan will remain on as long as the temperature is above this value",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.013,
                      ),
                    ),
                    ThresholdTextfield(
                      label: "Temperature",
                      unit: "⁰C",
                      end: "max",
                      mycontroller: TextEditingController(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "The fan will remain on as long as the temperature is below this value",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.013,
                      ),
                    ),
                    ThresholdTextfield(
                      label: "Temperature",
                      unit: "⁰C",
                      end: "min",
                      mycontroller: TextEditingController(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    Text(
                      "The water pump will remain on as long as the Soil Moisture is below this value",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.013,
                      ),
                    ),
                    ThresholdTextfield(
                      label: "Soil Moisture",
                      unit: "%",
                      end: " ",
                      mycontroller: TextEditingController(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.23),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Designed and Developed by",
                  style: TextStyle(
                    color: Colors.black.withAlpha(170),
                    fontSize: MediaQuery.of(context).size.height * 0.01,
                  ),
                ),
                Text(
                  "Ashaan Gunatilake",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withAlpha(180),
                    fontSize: MediaQuery.of(context).size.height * 0.011,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings, color: Colors.white, size: 35),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        toolbarHeight: 90,
        title: Text(
          "Cropwatch",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 123, 127),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.365,
              child: Container(
                padding: EdgeInsets.only(bottom: 25, left: 10, right: 11),

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
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 0, 98, 101),
                      ),
                      child: Column(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherBox(
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.135,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Image.asset('assets/images/leaf.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Container(
              // ***manual button***
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(0, 3),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.04,
              width:
                  MediaQuery.of(context).size.width * (isManual ? 0.27 : 0.34),
              child: FlutterSwitch(
                value: isManual,
                width: isManual ? 116 : 135,
                height: 50,
                toggleSize: 50,
                borderRadius: 25,
                activeColor: const Color.fromARGB(255, 0, 123, 127),
                inactiveColor: const Color.fromARGB(255, 0, 123, 127),
                activeText: "Manual",
                inactiveText: "Automatic",
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    isManual = val;
                    if (isManual) {
                      modeRef.set("manual");
                    } else {
                      modeRef.set("automatic");
                    }
                  });
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.047,
              child: Text(
                isManual ? "" : "Turn On Manual Mode to control devices",
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.287,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActuatorButton(
                        isManual: isManual,
                        label: "Fan",
                        assetpath: 'assets/images/fan.png',
                        isPressed: _fanIsPressed,

                        onToggle: () => _toggleButton("fan"),
                        color: const Color.fromARGB(255, 66, 227, 128),
                      ),

                      ActuatorButton(
                        isManual: isManual,
                        label: "Water",
                        assetpath: 'assets/images/water.png',
                        isPressed: _pumpIsPressed,

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
                        isManual: isManual,
                        label: "Heater",
                        assetpath: 'assets/images/heater.png',
                        isPressed: _heaterIsPressed,

                        onToggle: () => _toggleButton("heater"),
                        color: Colors.red,
                      ),

                      ActuatorButton(
                        isManual: isManual,
                        label: "LED",
                        assetpath: 'assets/images/bulb.png',
                        isPressed: _bulbIsPressed,

                        onToggle: () => _toggleButton("led"),
                        color: const Color.fromARGB(255, 255, 219, 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
