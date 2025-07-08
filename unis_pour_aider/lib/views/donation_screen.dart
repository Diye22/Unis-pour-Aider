import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  void handlePayment(BuildContext context, String method) {
    print('Méthode cliquée : $method'); // ✅ Log temporaire
    Navigator.pushNamed(
      context,
      '/pay',
      arguments: {'method': method},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A92A5),
      appBar: const CustomAppBar(title: 'Page de Don'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choisissez votre méthode de paiement :',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => handlePayment(context, 'orange'),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      child: Image.asset('assets/images/orange_money.png'),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => handlePayment(context, 'wave'),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(8),
                      child: Image.asset('assets/images/wave.png'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => handlePayment(context, 'card'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 120,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/images/card.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

// ✅ AppBar personnalisée locale
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.jpg'),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
