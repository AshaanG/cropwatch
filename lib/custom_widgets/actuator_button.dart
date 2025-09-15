import 'package:flutter/material.dart';

class ActuatorButton extends StatefulWidget {
  final String label;
  final String assetpath;
  final bool isPressed;

  final bool isManual;

  final VoidCallback onToggle;
  final Color color;

  const ActuatorButton({
    super.key,
    required this.label,
    required this.assetpath,
    required this.isPressed,

    required this.isManual,

    required this.onToggle,
    required this.color,
  });

  @override
  State<ActuatorButton> createState() => _ActuatorButtonState();
}

class _ActuatorButtonState extends State<ActuatorButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.135,
      width: MediaQuery.of(context).size.width * 0.425,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(2, 2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),

      child: ElevatedButton(
        onPressed: widget.isManual ? widget.onToggle : () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: widget.isPressed ? widget.color : Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              height: 70,
              image: AssetImage(widget.assetpath),
              color: widget.isPressed ? Colors.white : widget.color,
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 25,
                color: widget.isPressed ? Colors.white : widget.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
