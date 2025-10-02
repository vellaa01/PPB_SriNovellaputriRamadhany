import 'package:flutter/material.dart';

class FormStaff extends StatefulWidget {
  const FormStaff({super.key});

   State<FormStaff> createState() => _FormStaff();
}

class _FormStaff extends State<FormStaff> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // --- Controller
  final cKode = TextEditingController();
  final cNama = TextEditingController();
  final cJabatan = TextEditingController();
  

  @override
  void dispose() {
    cNama.dispose();
    cKode.dispose();
    cJabatan.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
   

    final data = {
      'Nama': cNama.text.trim(),
      'Kode': cKode.text.trim(),
      'Jabatan': cJabatan.text.trim(),
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Staff'),
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

  // ignore: unused_element
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
        title: const Text('Detail Staff'),
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
                  (v == null || v.trim().isEmpty) ? 'Nama Lengkap wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cKode,
              decoration: const InputDecoration(
                labelText: 'Kode Pegawai',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Kode wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cJabatan,
              decoration: const InputDecoration(
                labelText: 'Jabatan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Jabatan wajib diisi' : null,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Staff'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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