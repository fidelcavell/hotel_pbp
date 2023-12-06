import 'package:flutter/material.dart';

class FacBox extends StatelessWidget {
  final String text;

  const FacBox({super.key,
  required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 175, 61, 49),
        borderRadius: BorderRadius.circular(10),
      ),
       padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(left: 16),
      child: 
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:
          Text(
            text,
            style: const TextStyle(color: Colors.white,fontSize: 11.0),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          )
        ],
      ),
    );
  }
}
