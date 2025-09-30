import 'package:flutter/material.dart';

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // --- Controller
  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();

  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;

  // --- Dropdown value
  String? selectedProdi;
  String? selectedFakultas;

  final List<String> listProdi = [
    'Sistem Informasi',
    'Teknik Informatika',
  ];

  final List<String> listFakultas = [
    'Ilmu Komputer',
    'Ekonomi Bisnis',
    'Hukum',
    'Teknik',
  ];

  String get tglLahirLabel => tglLahir == null
      ? 'Pilih tanggal'
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';

  String get jamLabel =>
      jamBimbingan == null ? 'Pilih jam' : jamBimbingan!.format(context);

  @override
  void dispose() {
    cNama.dispose();
    cNpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(now.year + 1),
      initialDate: DateTime(now.year - 18, now.month, now.day),
    );
    if (res != null) setState(() => tglLahir = res);
  }

  Future<void> _pickTime() async {
    final res = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (res != null) setState(() => jamBimbingan = res);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
    if (tglLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir belum dipilih')),
      );
      return;
    }
    if (jamBimbingan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jam bimbingan belum dipilih')),
      );
      return;
    }

    final data = {
      'nama': cNama.text.trim(),
      'npm': cNpm.text.trim(),
      'email': cEmail.text.trim(),
      'alamat': cAlamat.text.trim(),
      'prodi': selectedProdi ?? '-',
      'fakultas': selectedFakultas ?? '-',
      'tglLahir': tglLahirLabel,
      'jamBimbingan': jamLabel,
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data (Bagian 1)'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${e.key}: ${e.value}'),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final steps = <Step>[
      Step(
        title: const Text('Identitas'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Data Pribadi'),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNpm,
              decoration: const InputDecoration(
                labelText: 'NPM',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'NPM wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Email wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedProdi,
              decoration: const InputDecoration(
                labelText: 'Program Studi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
              items: listProdi
                  .map((prodi) => DropdownMenuItem(
                        value: prodi,
                        child: Text(prodi),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => selectedProdi = val),
              validator: (v) =>
                  v == null ? 'Program studi wajib dipilih' : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedFakultas,
              decoration: const InputDecoration(
                labelText: 'Fakultas',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance),
              ),
              items: listFakultas
                  .map((fak) => DropdownMenuItem(
                        value: fak,
                        child: Text(fak),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => selectedFakultas = val),
              validator: (v) => v == null ? 'Fakultas wajib dipilih' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cAlamat,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Alamat wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.cake_outlined),
                    label: Text(tglLahirLabel),
                    onPressed: _pickDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.schedule),
                    label: Text(jamLabel),
                    onPressed: _pickTime,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Form Mahasiswa — Bagian 1')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          steps: steps,
          onStepContinue: _simpan,
          onStepCancel: null,
          controlsBuilder: (context, details) {
            return Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Simpan'),
                  onPressed: details.onStepContinue,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
