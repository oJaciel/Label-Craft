import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/pdf_provider.dart';


class LabelGridItem extends StatelessWidget {
  const LabelGridItem(this.label, {super.key});

  final Label label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PdfProvider.generateLabelPdf(label);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // alinha à esquerda
          children: [
            Text(
              label.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(label.hasWeight ? 'Peso: ${label.weight}' : 'Peso:______'),
            Text(
              label.hasPrice
                  ? 'Preço: R\$ ${label.price}'
                  : 'Preço: R\$ ______',
            ),
            if (label.hasFab)
              const Text(
                'Data de fabricação: ____/____/_____',
                style: TextStyle(fontSize: 13),
              ),
            if (label.hasExpDate)
              const Text(
                'Validade: 02 meses (sob congelamento)',
                style: TextStyle(fontSize: 13),
              ),
          ],
        ),
      ),
    );
  }
}
