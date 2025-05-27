import 'package:flutter/material.dart';
import 'package:label_craft/components/label_preview.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/pdf_provider.dart';
import 'package:label_craft/theme/app_theme.dart';

class PdfGeneratorPage extends StatefulWidget {
  const PdfGeneratorPage({super.key});

  @override
  State<PdfGeneratorPage> createState() => _PdfGeneratorPageState();
}

class _PdfGeneratorPageState extends State<PdfGeneratorPage> {
  final TextEditingController _labelQuantityController =
      TextEditingController();
  late Label label;
  late int defaultQuantity;
  bool useRecommended = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    label = ModalRoute.of(context)?.settings.arguments as Label;
    defaultQuantity = calculateRecommendedLabels(label);
    _labelQuantityController.text =
        useRecommended
            ? defaultQuantity.toString()
            : _labelQuantityController.text;
  }

  int calculateRecommendedLabels(Label label) {
    int activeFields = 0;
    if (label.hasWeight) activeFields++;
    if (label.hasPrice) activeFields++;
    if (label.hasFab) activeFields++;
    if (label.hasExpDate) activeFields++;

    switch (activeFields) {
      case 1:
        return 27;
      case 2:
        return 24;
      case 3:
        return 21;
      case 4:
      default:
        return 18;
    }
  }

  void generatePdf(Label label, int quantity) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await PdfProvider.generateLabelPdf(label, quantity);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar e Gerar PDF'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed:
                () => generatePdf(
                  label,
                  int.tryParse(_labelQuantityController.text) ??
                      defaultQuantity,
                ),
            icon: const Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Text(
                  'Pré-visualização da etiqueta',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),

                Center(child: LabelPreview(label)),

                const SizedBox(height: 12),

                Text(
                  'Selecione a quantidade de etiquetas para gerar:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),

                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: 'Etiquetas por página nesse modelo: ',
                      ),
                      TextSpan(
                        text: '$defaultQuantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        useRecommended
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onSecondary,
                    foregroundColor:
                        useRecommended
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                    iconColor:
                        useRecommended
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    shadowColor: Colors.black38,
                  ),
                  onPressed: () {
                    setState(() {
                      useRecommended = true;
                    });
                  },
                  label: Text('Quantidade recomendada'),
                  icon: Icon(Icons.recommend),
                ),

                SizedBox(height: 20),

                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        !useRecommended
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onSecondary,
                    foregroundColor:
                        !useRecommended
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                    iconColor:
                        !useRecommended
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    shadowColor: Colors.black38,
                  ),
                  onPressed: () {
                    setState(() {
                      useRecommended = false;
                    });
                  },
                  label: Text('Quantidade personalizada'),
                  icon: Icon(Icons.edit_square),
                ),

                const SizedBox(height: 8),

                useRecommended
                    ? const SizedBox.shrink()
                    : SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _labelQuantityController,
                        enabled: !useRecommended,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Ex: $defaultQuantity',
                        ),
                      ),
                    ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      final quantity =
                          useRecommended
                              ? defaultQuantity
                              : int.tryParse(_labelQuantityController.text) ??
                                  defaultQuantity;
                      generatePdf(label, quantity);
                    },
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text('Gerar PDF'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
