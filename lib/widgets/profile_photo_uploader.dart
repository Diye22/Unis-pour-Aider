import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

class ProfilePhotoUploader extends StatefulWidget {
  final int userId;

  const ProfilePhotoUploader({super.key, required this.userId});

  @override
  State<ProfilePhotoUploader> createState() => _ProfilePhotoUploaderState();
}

class _ProfilePhotoUploaderState extends State<ProfilePhotoUploader> {
  File? _image;
  String? _photoFilename;

  @override
  void initState() {
    super.initState();
    fetchUserPhoto();
  }

  Future<void> fetchUserPhoto() async {
    final uri = Uri.parse('http://10.0.2.2:3000/users/${widget.userId}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _photoFilename = data['photo'];
      });
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        _image = file;
      });

      await uploadImage(file);
    }
  }

  Future<void> uploadImage(File file) async {
    final uri = Uri.parse('http://10.0.2.2:3000/users/${widget.userId}/photo');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('photo', file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('✅ Upload réussi');
      fetchUserPhoto(); // 🔁 rafraîchir la photo
    } else {
      print('❌ Erreur upload: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? url = _photoFilename != null
        ? 'http://10.0.2.2:3000/uploads/$_photoFilename'
        : null;

    return Column(
      children: [
        _image != null
            ? CircleAvatar(
          radius: 60,
          backgroundImage: FileImage(_image!),
        )
            : (url != null
            ? CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(url),
        )
            : const CircleAvatar(
          radius: 60,
          backgroundImage:
          AssetImage('assets/images/default_avatar.png'),
          child: Icon(Icons.person, color: Colors.white, size: 50),
        )),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.camera_alt),
          label: const Text("Changer la photo"),
        ),
      ],
    );
  }
}
