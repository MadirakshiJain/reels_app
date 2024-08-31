import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: const Color.fromARGB(221, 46, 45, 45),
    title: Text('Profile',style: TextStyle(color: Colors.white),),),
      body: 
      
      Column(

        children: [
          SizedBox(height: 200,),
          Center(child: Text('THANKS !' ,style: TextStyle(color: Colors.blue,fontSize: 30),)),
          Center(child: Text('I hope you like it.' ,style: TextStyle(color: Colors.blue.shade200,fontSize: 30),)),
        ],
      ),
    );
  }
}