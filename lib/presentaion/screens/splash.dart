import 'package:flutter/material.dart';
import 'package:recipe_book_application/presentaion/screens/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.png'),
            opacity: .5,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Image.asset("assets/logolight.png", height: 200),
              CircleAvatar(
                backgroundColor: Color(0xFF00B4BF),
                radius: 140,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/logo.png"),
                  radius: 130,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
