import 'package:flutter/material.dart';

class FormMahasiswaPage extends StatelessWidget {
  const FormMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Mahasiswa Baru')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // biar button ikut full
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Fakultas',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'FASILKOM', child: Text('Fakultas Ilmu Komputer')),
                DropdownMenuItem(value: 'FE', child: Text('Fakultas Ekonomi')),
                DropdownMenuItem(value: 'FH', child: Text('Fakultas Hukum')),
                DropdownMenuItem(value: 'FISIP', child: Text('Fakultas Sosial dan Ilmu Politik')),
              ],
              onChanged: (value) {
              },
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form disubmit!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
