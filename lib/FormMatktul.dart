import 'package:flutter/material.dart';

class FormMatkul extends StatefulWidget {
  const FormMatkul({super.key});

   State<FormMatkul> createState() => _FormMatkul();
}

class _FormMatkul extends State<FormMatkul> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // --- Controller
  final cKode = TextEditingController();
  final cNama = TextEditingController();
  final cSKS = TextEditingController();
  

  @override
  void dispose() {
    cNama.dispose();
    cKode.dispose();
    cSKS.dispose();
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
      'SKS': cSKS.text.trim(),
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Mata Kuliah'),
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
        title: const Text('Detail Mata Kuliah'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Data Mata Kuliah'),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama Mata Kuliah',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama Mata Kuliah wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cKode,
              decoration: const InputDecoration(
                labelText: 'Kode Mata Kuliah',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Kode wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cSKS,
              decoration: const InputDecoration(
                labelText: 'SKS',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'SKS wajib diisi' : null,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Mata Kuliah'), titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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