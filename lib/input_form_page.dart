import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/view_data_page.dart';
import 'package:flutter/material.dart';

class InputFormPage extends StatefulWidget {
  const InputFormPage({super.key});

  @override
  State<InputFormPage> createState() => _InputFormPageState();
}

class _InputFormPageState extends State<InputFormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();

  void saveData() async {
    final String name = nameController.text;
    final int age = int.parse(ageController.text);
    final String hobby = hobbyController.text;

    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'age': age,
        'hobby': hobby,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: hobbyController,
              decoration: const InputDecoration(labelText: 'Favourite Hobby'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData,
              child: const Text('Save Data'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewDataPage()),
                );
              },
              child: const Text('View Data'),
            ),
          ],
        ),
      ),
    );
  }
}
