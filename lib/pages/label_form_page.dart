import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
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

    // Se os switches estiverem desligados, passa preço e peso como ''
    if (_hasWeight == false) {
      _formData['weight'] = '';
    }

    if (_hasPrice == false) {
      _formData['price'] = '';
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

        _hasWeight = _formData['hasWeight'] as bool? ?? false;
        _hasPrice = _formData['hasPrice'] as bool? ?? false;
        _hasFab = _formData['hasFab'] as bool? ?? false;
        _hasExpDate = _formData['hasExpDate'] as bool? ?? false;
      }
      if (argument != null && argument is Map<String, dynamic>) {}
    }
  }

  // Dados do formulário
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
      name: _formData['name'].toString(),
      hasWeight: _hasWeight,
      weight: _formData['weight'] != null ? _formData['weight'].toString() : '',
      hasPrice: _hasPrice,
      price: _formData['price'] != null ? _formData['price'].toString() : '',
      hasFab: _hasFab,
      hasExpDate: _hasExpDate,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Etiqueta'),
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
                    onChanged:
                        (name) => setState(() => _formData['name'] = name),
                    onSaved: (name) => _formData['name'] = name ?? '',
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O nome é obrigatório';
                      }
                      return null;
                    },
                  ),

                  SwitchListTile(
                    title: Text('Incluir Peso'),
                    value: _hasWeight,
                    onChanged: (val) => setState(() => _hasWeight = val),
                  ),

                  if (_hasWeight)
                    TextFormField(
                      initialValue: _formData['weight']?.toString() ?? '',
                      decoration: InputDecoration(labelText: 'Peso'),
                      onChanged:
                          (weight) =>
                              setState(() => _formData['weight'] = weight),
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
                      initialValue: _formData['price']?.toString() ?? '',
                      decoration: InputDecoration(labelText: 'Preço'),
                      onChanged:
                          (price) => setState(() => _formData['price'] = price),
                      onSaved: (price) => _formData['price'] = price ?? '',
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Period,
                      mantissaLength: 2,
                    ),
                  ],
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
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor: Theme.of(context).colorScheme.onSecondary,
                          iconColor: Colors.white
                      ),
                      onPressed: () {
                        _submitForm();
                      },
                      label: Text('Salvar Etiqueta'),
                      icon: Icon(Icons.save),
                    ),
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
