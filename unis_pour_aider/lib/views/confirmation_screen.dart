import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? method;
  String name = '';
  String phone = '';
  String amount = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    method = args?['method'];
  }

  void confirmDonation() {
    if (_formKey.currentState!.validate()) {
      // TODO: envoyer les données au backend ou afficher un message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Don confirmé via $method pour $amount FCFA')),
      );

      // Tu peux rediriger vers une page de succès ici
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A92A5),
      appBar: const CustomAppBar(title: 'Confirmation du Don'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Méthode de paiement : ${method?.toUpperCase() ?? 'Inconnue'}',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Entrez votre nom' : null,
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Entrez votre numéro' : null,
                onChanged: (value) => phone = value,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Montant (FCFA)',
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Entrez un montant' : null,
                onChanged: (value) => amount = value,
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: confirmDonation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF3A92A5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.check_circle),
                label: const Text(
                  'Confirmer le don',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ AppBar réutilisable directement ici
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
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
