import 'dart:io'; // Required for File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velvetvnaity/model/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _picker = ImagePicker();
  String? _imageUrl;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await SharedPreferenceshelper.getUserName();
    final email = await SharedPreferenceshelper.getUserEmail();
    final image = await SharedPreferenceshelper.getUserImage();

    setState(() {
      _nameController.text = name ?? "";
      _emailController.text = email ?? "";
      _imageUrl = image;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<String?> _uploadImageToFirebase(XFile imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final fileName = 'profile_images/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final storageRef = FirebaseStorage.instance.ref().child(fileName);

        final uploadTask = storageRef.putFile(File(imageFile.path));
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print("Error uploading image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image')),
      );
    }
    return null;
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userId = user.uid;
          String? imageUrl;

          if (_imageFile != null) {
            imageUrl = await _uploadImageToFirebase(_imageFile!);
          } else {
            imageUrl = _imageUrl; // Keep the existing image URL if no new image is picked
          }

          await FirebaseFirestore.instance.collection('users').doc(userId).update({
            'Name': _nameController.text.trim(),
            'Email': _emailController.text.trim(),
            if (imageUrl != null) 'ProfileImage': imageUrl,
          });

          await SharedPreferenceshelper.saveUserName(_nameController.text.trim());
          await SharedPreferenceshelper.saveUserEmail(_emailController.text.trim());
          if (imageUrl != null) {
            await SharedPreferenceshelper.saveUserImage(imageUrl);
          }

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color(0xFFA80C0C),
            content: Text(
              "Profile Updated Successfully",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Failed to update profile: ${e.toString()}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : _imageUrl != null
                            ? NetworkImage(_imageUrl!) as ImageProvider
                            : null,
                    child: _imageFile == null && _imageUrl == null
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _updateProfile,
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
