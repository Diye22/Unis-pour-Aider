import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unis_pour_aider/models/categorie_data.dart';
import 'package:unis_pour_aider/models/categorie_model.dart';
import 'package:unis_pour_aider/widgets/custom_bottom_nav_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A92A5),
      appBar: const CustomAppBar(title: 'Catégories de Campagnes'), // ✅ AppBar perso
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final Categorie cat = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/list', arguments: cat.code);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(cat.image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.darken,
                  ),
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              child: Text(
                cat.nom,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}

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
          backgroundImage: AssetImage('assets/images/logo.jpg'), // ✅ logo rond
          radius: 20,
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
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
