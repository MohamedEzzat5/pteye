import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[50],
      child: const Icon(Icons.person,size: 80,color: Colors.grey,),
    );
  }
}
