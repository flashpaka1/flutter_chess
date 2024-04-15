import 'package:chess_app/components/sign_in_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override 
  Widget build(BuildContext context){

    return Scaffold(
      
      backgroundColor: Colors.grey[300],
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SquareTile(imagePath: 'assets/Logo-google-icon-PNG.png'),
            
          ],),
          Text('sign in with google'),

        //google sign in button

        
      ],)
    );
  }
}