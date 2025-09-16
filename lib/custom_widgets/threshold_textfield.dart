import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ThresholdTextfield extends StatefulWidget {
  final String label;
  final String unit;
  final String end;
  final TextEditingController mycontroller;

  const ThresholdTextfield({
    super.key,
    required this.label,
    required this.unit,
    required this.end,
    required this.mycontroller
  });

  @override
  State<ThresholdTextfield> createState() => _MyWidgetState();
}



class _MyWidgetState extends State<ThresholdTextfield> {
  @override
  Widget build(BuildContext context) {
    final String label = widget.label;
    final String unit = widget.unit;
    final String end = widget.end;
    num current = 0;
    return Row(
      children: [
        Text("$label $end: "),

        Expanded(
          child: TextField(
            controller: widget.mycontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "$current$unit",
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            final value = num.tryParse(widget.mycontroller.text);
            if (value != null) {
              current = value;
              FirebaseDatabase.instance.ref("threshold/$label/$end").set(value);
              widget.mycontroller.clear();
            }
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
