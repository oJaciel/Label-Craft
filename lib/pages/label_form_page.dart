import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:label_craft/components/header_select_dropdown.dart';
import 'package:label_craft/components/label_preview.dart';
import 'package:label_craft/models/header_provider.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/label_header.dart';
import 'package:label_craft/models/label_provider.dart';
import 'package:provider/provider.dart';

class LabelFormPage extends StatefulWidget {
  const LabelFormPage({super.key});

  @override
  State<LabelFormPage> createState() => _LabelFormPageState();
}

class _LabelFormPageState extends State<LabelFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  // Variáveis de estado
  bool _hasWeight = false;
  bool _hasPrice = false;
  bool _hasFab = false;
  bool _hasExpDate = false;
  LabelHeader? _selectedHeader;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_hasWeight) _formData['weight'] = '';
    if (!_hasPrice) _formData['price'] = '';

    _formKey.currentState!.save();

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
              title: const Text('Erro!'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Ok'),
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

    final headers = Provider.of<HeaderProvider>(context).headers;
    if (_selectedHeader == null && headers.isNotEmpty) {
      _selectedHeader = headers.first;
    }

    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;
      if (argument != null && argument is Label) {
        _formData['id'] = argument.id;
        _formData['name'] = argument.name;
        _formData['hasWeight'] = argument.hasWeight;
        _formData['weight'] = argument.weight!;
        _formData['hasPrice'] = argument.hasPrice;
        _formData['price'] = argument.price!;
        _formData['hasFab'] = argument.hasFab;
        _formData['hasExpDate'] = argument.hasExpDate;

        _hasWeight = argument.hasWeight;
        _hasPrice = argument.hasPrice;
        _hasFab = argument.hasFab;
        _hasExpDate = argument.hasExpDate;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final headerList = Provider.of<HeaderProvider>(context).headers;

    final labelPreview = Label(
      id: 'preview',
      name: _formData['name']?.toString() ?? '',
      hasWeight: _hasWeight,
      weight: _formData['weight']?.toString() ?? '',
      hasPrice: _hasPrice,
      price: _formData['price']?.toString() ?? '',
      hasFab: _hasFab,
      hasExpDate: _hasExpDate,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Etiqueta'),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Dropdown de modelo
            HeaderSelectDropdown(
              headers: headerList,
              selectedHeader: _selectedHeader!,
              onChanged: (value) {
                setState(() => _selectedHeader = value!);
              },
            ),

            const SizedBox(height: 10),

            LabelPreview(labelPreview),

            const SizedBox(height: 20),

            // Formulário
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration: const InputDecoration(labelText: 'Nome'),
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
                    title: const Text('Incluir Peso'),
                    value: _hasWeight,
                    onChanged: (val) => setState(() => _hasWeight = val),
                  ),

                  if (_hasWeight)
                    TextFormField(
                      initialValue: _formData['weight']?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Peso'),
                      onChanged:
                          (weight) =>
                              setState(() => _formData['weight'] = weight),
                      onSaved: (weight) => _formData['weight'] = weight ?? '',
                      textInputAction: TextInputAction.next,
                    ),

                  SwitchListTile(
                    title: const Text('Incluir Preço'),
                    value: _hasPrice,
                    onChanged: (val) => setState(() => _hasPrice = val),
                  ),

                  if (_hasPrice)
                    TextFormField(
                      initialValue: _formData['price']?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Preço'),
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
                    title: const Text('Incluir Data de Fabricação'),
                    value: _hasFab,
                    onChanged: (val) => setState(() => _hasFab = val),
                  ),

                  SwitchListTile(
                    title: const Text('Incluir Validade'),
                    value: _hasExpDate,
                    onChanged: (val) => setState(() => _hasExpDate = val),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                      onPressed: _submitForm,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar Etiqueta'),
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
