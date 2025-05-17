import 'package:flutter/material.dart';
import 'package:label_craft/components/label_preview.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/pdf_provider.dart';

class PdfGeneratorPage extends StatelessWidget {
  const PdfGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final label = ModalRoute.of(context)?.settings.arguments as Label;

    // Gera o PDF com loading
    generatePdf(Label label) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      await PdfProvider.generateLabelPdf(label);

      Navigator.of(context).pop(); // Fecha o loading
    }

    final int labelsPerPage = PdfProvider.calculateLabelsPerPage(label);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar e Gerar PDF'),
        actions: [
          IconButton(
            onPressed: () => generatePdf(label),
            icon: const Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              'Pré-visualização da etiqueta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
              
            ),
            const SizedBox(height: 20),

            // Preview da etiqueta
            Center(child: LabelPreview(label)),

            const SizedBox(height: 12),

            // Texto com quantidade de etiquetas por página
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'Será gerado um PDF com '),
                  TextSpan(
                    text: '$labelsPerPage',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    
                  ),
                  TextSpan(text: ' etiquetas')
                ],
              ),
            ),

            const Spacer(),

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
