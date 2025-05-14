import 'package:flutter/material.dart';
import 'package:label_craft/components/label_preview.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:provider/provider.dart';

class LabelFormPage extends StatefulWidget {
  const LabelFormPage({super.key});

  @override
  State<LabelFormPage> createState() => _LabelFormPageState();
}

class _LabelFormPageState extends State<LabelFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Adicionando os valores booleanos manualmente
    _formData['hasWeight'] = _hasWeight;
    _formData['hasPrice'] = _hasPrice;
    _formData['hasFab'] = _hasFab;
    _formData['hasExpDate'] = _hasExpDate;

    try {
      await Provider.of<LabelProvider>(
        context,
        listen: false,
      ).saveLabel(_formData);
    } catch (error) {
      await showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Erro!'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok'),
                ),
              ],
            ),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final label = argument as Label;
        _formData['id'] = label.id;
        _formData['name'] = label.name;
        _formData['hasWeight'] = label.hasWeight;
        _formData['weight'] = label.weight!;
        _formData['hasPrice'] = label.hasPrice;
        _formData['price'] = label.price!;
        _formData['hasFab'] = label.hasFab;
        _formData['hasExpDate'] = label.hasExpDate;
      }
      if (argument != null && argument is Map<String, dynamic>) {}
    }
  }

  // Dados do formulário
  String _name = '';
  String? _weight;
  String? _price;
  bool _hasWeight = false;
  bool _hasPrice = false;
  bool _hasFab = false;
  bool _hasExpDate = false;

  // Modelos disponíveis
  final List<String> _labelModels = [
    'Modelo A',
    'Modelo B',
  ]; // futuro: modelos reais
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
      appBar: AppBar(
        title: Text('Nova Etiqueta'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
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
                  items:
                      _labelModels.map((model) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Text(model),
                        );
                      }).toList(),
                ),
              ],
            ),

            SizedBox(height: 10),

            LabelPreview(labelPreview),

            const SizedBox(height: 20),

            // Formulário
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration: InputDecoration(labelText: 'Nome'),
                    onChanged: (val) => setState(() => _name = val),
                    onSaved: (name) => _formData['name'] = name ?? '',
                    textInputAction: TextInputAction.next,
                  ),

                  SwitchListTile(
                    title: Text('Incluir Peso'),
                    value: _hasWeight,
                    onChanged: (val) => setState(() => _hasWeight = val),
                  ),

                  if (_hasWeight)
                    TextFormField(
                      initialValue: _formData['weight']?.toString(),
                      decoration: InputDecoration(labelText: 'Peso'),
                      onChanged: (val) => setState(() => _weight = val),
                      onSaved: (weight) => _formData['weight'] = weight ?? '',
                      textInputAction: TextInputAction.next,
                    ),

                  SwitchListTile(
                    title: Text('Incluir Preço'),
                    value: _hasPrice,
                    onChanged: (val) => setState(() => _hasPrice = val),
                  ),

                  if (_hasPrice)
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      onChanged: (val) => setState(() => _price = val),
                      onSaved: (price) => _formData['price'] = price ?? '',
                      textInputAction: TextInputAction.next,
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
                      _submitForm();
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
}
