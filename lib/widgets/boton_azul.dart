import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  
  final Function()? onPressed;
  final String text;

  const BotonAzul({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.blue,
          shape: const StadiumBorder(),
        ),
        onPressed: this.onPressed, 
        child: Center(
          child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17),),
        ),
      ),
    );
  }
}