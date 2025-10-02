import 'package:flutter/material.dart';

class FormDosen extends StatefulWidget {
  const FormDosen({super.key});
  
  State<FormDosen> createState() => _FormDosen();
}

class _FormDosen extends State<FormDosen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // --- Controller
  final cNIDN = TextEditingController();
  final cNama = TextEditingController();
  final cEmail = TextEditingController();
  final cNoTelepon = TextEditingController();

  DateTime? TanggalLahir;

  // --- Dropdown value
  String? selectedHomeBase;

  final List<String> listHomeBase = [
    'Sistem Informasi',
    'Teknik Informatika',
  ];


  String get tglLahirLabel => TanggalLahir == null
      ? 'Pilih tanggal'
      : '${TanggalLahir!.day}/${TanggalLahir!.month}/${TanggalLahir!.year}';

  @override
  void dispose() {
    cNIDN.dispose();
    cNama.dispose();
    cEmail.dispose();
    cNoTelepon.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 1),
      initialDate: DateTime(now.year - 18, now.month, now.day),
    );
    if (res != null) setState(() => TanggalLahir = res);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
    if (TanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir belum dipilih')),
      );
      return;
    }

    final data = {
      'Nama': cNama.text.trim(),
      'NIDN': cNIDN.text.trim(),
      'Email': cEmail.text.trim(),
      'Nomor Handphone': cNoTelepon.text.trim(),
      'Tanggal Lahir': tglLahirLabel,
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Dosen'),
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
        title: const Text('Isi Identitas'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          _sectionTitle('Data Pribadi'),
            TextFormField(
              controller: cNIDN,
              decoration: const InputDecoration(
                labelText: 'NIDN',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'NIDN  wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama lengkap wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNoTelepon,
              decoration: const InputDecoration(
                labelText: 'Nomor Handphone',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nomor handphone wajib diisi' : null,
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
              value: selectedHomeBase,
              decoration: const InputDecoration(
                labelText: 'Home Base',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
              items: listHomeBase
                  .map((prodi) => DropdownMenuItem(
                        value: prodi,
                        child: Text(prodi),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => selectedHomeBase = val),
              validator: (v) =>
                  v == null ? ' Home Base wajib dipilih' : null,
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
              ],
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Dosen'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
