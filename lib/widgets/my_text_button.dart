import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const MyTextButton({
    super.key, required this.label, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        ),
        child: Center(
          child: Text(
            label,style: TextStyle(color: Colors.white,fontSize: 16),)
        )
         ,),
    );
  }
}