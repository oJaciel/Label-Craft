import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/pdf_provider.dart';

class LabelGridItem extends StatelessWidget {
  const LabelGridItem(this.label, {super.key});

  final Label label;

  @override
  Widget build(BuildContext context) {
    showWeight() {
      if (label.hasWeight == false) {
        return '';
      } else if (label.hasWeight == true &&
          (label.weight == '' || label.weight == null)) {
        return 'Peso:______';
      } else if (label.hasWeight == true && (label.weight != null)) {
        return 'Peso: ${label.weight}';
      }
    }

    showPrice() {
      if (label.hasPrice == false) {
        return '';
      } else if (label.hasPrice == true &&
          (label.price == '' || label.price == null)) {
        return 'Preço: R\$ ______';
      } else if (label.hasPrice == true && (label.price != null)) {
        return 'Preço: R\$ ${label.price}';
      }
    }

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
            if (label.hasWeight) Text(showWeight()!),
            if (label.hasPrice) Text(showPrice()!),
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
