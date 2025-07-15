import 'package:flutter/material.dart';
import 'package:unis_pour_aider/utils/session_manager.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: const Color(0xFF3A92A5),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      onTap: (index) async {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/confirmation');
            break;
          case 1:
            Navigator.pushNamed(context, '/donation');
            break;
          case 2:
            Navigator.pushNamed(context, '/detail');
            break;
          case 3:
            Navigator.pushNamed(context, '/list');
            break;
          case 4:
            Navigator.pushNamed(context, '/map');
            break;
          case 5:
            await SessionManager.logout();
            Navigator.pushReplacementNamed(context, '/login');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          label: 'Confirmation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Don',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Détail',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Campagnes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Localisation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Déconnexion',
        ),
      ],
    );
  }
}
