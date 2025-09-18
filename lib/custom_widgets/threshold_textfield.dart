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
    required this.mycontroller,
  });

  @override
  State<ThresholdTextfield> createState() => _ThresholdTextfieldState();
}

class _ThresholdTextfieldState extends State<ThresholdTextfield> {
  num? current;

  @override
  void initState() {
    super.initState();
    _loadCurrentValue();
  }

  void _loadCurrentValue() async {
    final ref = FirebaseDatabase.instance.ref(
      "threshold/${widget.label}/${widget.end}",
    );
    final snapshot = await ref.get();
    if (snapshot.exists) {
      setState(() {
        current = (snapshot.value as num);
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    final String label = widget.label;
    final String unit = widget.unit;
    final String end = widget.end;

    return Row(
      children: [
        Text("$label $end: ",style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.017,fontWeight: FontWeight.bold),),
        Expanded(
          child: TextField(
            controller: widget.mycontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // show placeholder only after loading
              hintText: current == null ? "..." : "$current$unit",hintStyle: TextStyle(color: Colors.black.withAlpha(130)),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            final value = num.tryParse(widget.mycontroller.text);
            if (value != null) {
              FirebaseDatabase.instance
                  .ref("threshold/$label/$end")
                  .set(value);
              setState(() {
                current = value; // update local state
              });
              widget.mycontroller.clear();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
