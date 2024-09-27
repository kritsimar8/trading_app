
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multithreaded_trading_app/view/navBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        height: h,
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/1.gif'),
            Column(
              children: [
                 Text(
              'The Future',
              style: TextStyle(
                fontSize: 50,fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Learn more about cryptocurrency, look to',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            Text(
              'The future in IO Crypto',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
              ],
            ),
           
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w*0.14),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFBC700),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Portfolio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(310/360),
                        child: Icon(Icons.arrow_forward_rounded),)
                    ],
                  ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}