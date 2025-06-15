import 'package:flutter/material.dart';
import 'package:label_craft/components/app_button.dart';
import 'package:label_craft/components/header_preview.dart';
import 'package:label_craft/models/header_provider.dart';
import 'package:label_craft/models/label_header.dart';
import 'package:provider/provider.dart';

class HeaderFormPage extends StatefulWidget {
  const HeaderFormPage({super.key});

  @override
  State<HeaderFormPage> createState() => _LabelFormPageState();
}

class _LabelFormPageState extends State<HeaderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      await Provider.of<HeaderProvider>(
        context,
        listen: false,
      ).saveHeader(_formData);
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
        final header = argument as LabelHeader;
        _formData['id'] = header.id;
        _formData['name'] = header.name;
        _formData['image'] = header.image!;
        _formData['displayName'] = header.displayName!;
        _formData['aditionalInfo'] = header.aditionalInfo!;
      }
      if (argument != null && argument is Map<String, dynamic>) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final headerPreview = LabelHeader(
      id: 'preview',
      name: 'preview',
      displayName:
          _formData['displayName'] != null
              ? _formData['displayName'].toString()
              : '',
      image: _formData['image'] != null ? _formData['image'].toString() : '',
      aditionalInfo:
          _formData['aditionalInfo'] != null
              ? _formData['aditionalInfo'].toString()
              : '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Cabeçalho'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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

                  const SizedBox(height: 20),

                  HeaderPreview(headerPreview),

                  const SizedBox(height: 20),

                  TextFormField(
                    initialValue: _formData['displayName']?.toString() ?? '',
                    decoration: InputDecoration(labelText: 'Nome de Exibição'),
                    onChanged:
                        (displayName) => setState(
                          () => _formData['displayName'] = displayName,
                        ),
                    onSaved:
                        (displayName) =>
                            _formData['displayName'] = displayName ?? '',
                    textInputAction: TextInputAction.next,
                    maxLength: 20,
                  ),

                  SizedBox(height: 10),

                  TextFormField(
                    initialValue: _formData['aditionalInfo']?.toString() ?? '',
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Informações Adicionais',
                    ),
                    onChanged:
                        (aditionalInfo) => setState(
                          () => _formData['aditionalInfo'] = aditionalInfo,
                        ),
                    onSaved:
                        (aditionalInfo) =>
                            _formData['aditionalInfo'] = aditionalInfo ?? '',
                    textInputAction: TextInputAction.next,
                    maxLength: 50,
                  ),

                  SizedBox(height: 10),

                  TextFormField(
                    initialValue: _formData['image']?.toString() ?? '',
                    decoration: InputDecoration(labelText: 'URL da imagem'),
                    onChanged:
                        (image) => setState(() => _formData['image'] = image),
                    onSaved: (image) => _formData['image'] = image ?? '',
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: 20),

                  AppButton('Salvar Cabeçalho', Icon(Icons.save), function: _submitForm,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
