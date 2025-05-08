import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';

class LabelFormPage extends StatefulWidget {
  const LabelFormPage({super.key});

  @override
  State<LabelFormPage> createState() => _LabelFormPageState();
}

class _LabelFormPageState extends State<LabelFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Dados do formulário
  String _name = '';
  String? _weight;
  String? _price;
  bool _hasWeight = false;
  bool _hasPrice = false;
  bool _hasFab = false;
  bool _hasExpDate = false;

  // Modelos disponíveis
  final List<String> _labelModels = ['Modelo A', 'Modelo B']; // futuro: modelos reais
  String _selectedModel = 'Modelo A';

  @override
  Widget build(BuildContext context) {
    final labelPreview = Label(
      id: 'preview',
      name: _name,
      hasWeight: _hasWeight,
      weight: _weight,
      hasPrice: _hasPrice,
      price: _price,
      hasFab: _hasFab,
      hasExpDate: _hasExpDate,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Nova Etiqueta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Dropdown de modelo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Modelo:', style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: _selectedModel,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedModel = value);
                    }
                  },
                  items: _labelModels.map((model) {
                    return DropdownMenuItem<String>(
                      value: model,
                      child: Text(model),
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Visualização da etiqueta
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12),
              child: _buildLabelPreview(labelPreview),
            ),

            const SizedBox(height: 20),

            // Formulário
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    onChanged: (val) => setState(() => _name = val),
                  ),
                  SwitchListTile(
                    title: Text('Incluir Peso'),
                    value: _hasWeight,
                    onChanged: (val) => setState(() => _hasWeight = val),
                  ),
                  if (_hasWeight)
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Peso'),
                      onChanged: (val) => setState(() => _weight = val),
                    ),
                  SwitchListTile(
                    title: Text('Incluir Preço'),
                    value: _hasPrice,
                    onChanged: (val) => setState(() => _hasPrice = val),
                  ),
                  if (_hasPrice)
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Preço'),
                      onChanged: (val) => setState(() => _price = val),
                    ),
                  SwitchListTile(
                    title: Text('Incluir Data de Fabricação'),
                    value: _hasFab,
                    onChanged: (val) => setState(() => _hasFab = val),
                  ),
                  SwitchListTile(
                    title: Text('Incluir Validade'),
                    value: _hasExpDate,
                    onChanged: (val) => setState(() => _hasExpDate = val),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Salvar...
                      }
                    },
                    child: Text('Salvar Etiqueta'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelPreview(Label label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nome: ${label.name}', style: TextStyle(fontSize: 16)),
        if (label.hasWeight) Text('Peso: ${label.weight ?? '____'}'),
        if (label.hasPrice) Text('Preço: R\$ ${label.price ?? '____'}'),
        if (label.hasFab) Text('Fab: __/__/2025'),
        if (label.hasExpDate) Text('Val: 02 meses'),
      ],
    );
  }
}
