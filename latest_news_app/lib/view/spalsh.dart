import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            height: 200,
          ),
          FadeInImage(
            placeholder: AssetImage("assets/images/latest_news_logo.png"),
            image: AssetImage("assets/images/latest_news_logo.png"),
            height: 300,
            width: 300,
          ),
          Spacer(),
          Text(
            "Developed By\nJatin",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 125, 30, 31),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
