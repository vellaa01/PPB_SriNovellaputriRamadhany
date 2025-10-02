import 'package:flutter/material.dart';
import 'pengaturan.dart';
import 'form_mahasiswa.dart';
import 'tentang_aplikasi.dart';
import 'FormDosen.dart';
import 'FormMatktul.dart';
import 'FormStaff.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Informasi Unsika',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 211, 61, 136),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/list': (_) => const DaftarWargaUnsika(),
        '/tentang': (_) => const TentangAplikasiPage(),
        '/pengaturan': (_) => const PengaturanPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fakultas Ilmu Komputer'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Sri Novellaputri Ramadhany'),
              accountEmail: const Text('2310631250078'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Daftar Warga Unsika'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/list');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tentang');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/pengaturan');
              },
            ),
          ],
        ),
      ),
      body: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 224, 225),
      appBar: AppBar(
        title: const Text("Selamat Datang \ndi Sistem Informasi Unsika"),
        centerTitle: false,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2, // jumlah kolom
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _MenuCard(
              icon: Icons.person,
              color: Colors.blue,
              title: "Formulir Dosen",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormDosen()),
                );
              },
            ),
            _MenuCard(
              icon: Icons.book,
              color: Colors.green,
              title: "Formulir Mata Kuliah",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormMatkul()),
                );
              },
            ),
            _MenuCard(
              icon: Icons.school,
              color: const Color.fromARGB(255, 243, 33, 163),
              title: "Formulir Mahasiswa",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormMahasiswaPage()),
                );
              },
            ),
            _MenuCard(
              icon: Icons.work,
              color: const Color.fromARGB(255, 243, 65, 33),
              title: "Formulir Staff",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormStaff()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DaftarWargaUnsika extends StatelessWidget {
  const DaftarWargaUnsika({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Warga Unsika")),
      body: const Center(
        child: Text("Halaman daftar ini masih kosong."),
      ),
    );
  }
}
