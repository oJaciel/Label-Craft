import 'package:flutter/material.dart';
import 'package:label_craft/components/label_preview.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/pdf_provider.dart';

class PdfGeneratorPage extends StatelessWidget {
  const PdfGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final label = ModalRoute.of(context)?.settings.arguments as Label;

    generatePdf(Label label) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      await PdfProvider.generateLabelPdf(label);

      Navigator.of(context).pop(); // Fecha o loading
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar e Gerar PDF'),
        actions: [
          IconButton(
            onPressed: () => generatePdf(label),
            icon: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              'Pré-visualização da etiqueta',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),

            // Expande o espaço do preview de forma proporcional
            Center(child: LabelPreview(label)),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => generatePdf(label),
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Gerar PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
