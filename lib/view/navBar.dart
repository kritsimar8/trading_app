
import 'package:flutter/material.dart';
import 'package:multithreaded_trading_app/view/home.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  
  List<Widget> pages=[
    Home(),
    Home(),
    Home(),
    Home(),
  ];
  
  @override
  Widget build(BuildContext context) {
    double h= MediaQuery.of(context).size.height;
    double w= MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: ((value){
            setState((){
              _currentIndex=value;
            });
          }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,size: 30,),label: '',
              activeIcon: Icon(Icons.home,color: const Color.fromARGB(255, 126, 68, 68),size: 30,)
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner,color: Colors.black,size: 30,),label: '',
              activeIcon: Icon(Icons.document_scanner,color: const Color.fromARGB(255, 163, 84, 84),size: 30,)
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ring_volume,color: Colors.black,size: 30,),label: '',
              activeIcon: Icon(Icons.ring_volume,color: const Color.fromARGB(255, 170, 90, 90),size: 30,)
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: Colors.black,size: 30,),label: '',
              activeIcon: Icon(Icons.settings,color: const Color.fromARGB(255, 163, 89, 89),size: 30,)
              ),
          ],
        ),
      ),
    );
  }
}