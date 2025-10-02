import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Aplikasi ini dibuat untuk mendata warga-wargi unsika yang masih hidup'
          ' dengan mudah dan cepat.\n\n'
          'Dibuat untuk projek Tugas dan UTS Mata Kuliah \n PEMROGRAMAN PERANGKAT BERGERAK. \n\noleh \n\bSri Novellaputri Ramadhany \nNPM 2310631250078 \nKelas 5A-Sistem Informasi\b',
          style: TextStyle(fontSize: 16, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
