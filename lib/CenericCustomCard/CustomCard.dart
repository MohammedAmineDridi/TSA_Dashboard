import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget childWidget;
  final Widget leftWidget;
  final Widget rightWidget;
  final double spaceUnderText;

  const CustomCard({
    super.key, 
    required this.childWidget,
    required this.leftWidget,
    required this.rightWidget,
    required this.spaceUnderText
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 110, 171, 218), Color.fromARGB(255, 255, 244, 183)], // old values : [Color.fromARGB(255, 110, 171, 218), Color.fromARGB(255, 255, 244, 183)]
          begin: Alignment.topLeft, // [Color.fromARGB(255, 0, 54, 71), Color.fromARGB(255, 6, 119, 141)]
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color:Colors.black.withOpacity(0.7),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftWidget,
                rightWidget,
              ],
            ),
          ),
          SizedBox(height: spaceUnderText),
          Center(child:childWidget)
        ],
      ),
    );
  }
}
