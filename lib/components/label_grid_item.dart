import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/utils/app_routes.dart';

class LabelGridItem extends StatelessWidget {
  const LabelGridItem(this.label, {super.key});

  final Label label;

  @override
  Widget build(BuildContext context) {
    String showWeight() {
      if (!label.hasWeight) {
        return '';
      } else if (label.weight == '' || label.weight == null) {
        return 'Peso:______';
      } else {
        return 'Peso: ${label.weight}';
      }
    }

    String showPrice() {
      if (!label.hasPrice) {
        return '';
      } else if (label.price == '' || label.price == null) {
        return 'Preço: R\$ ______';
      } else {
        return 'Preço: R\$ ${label.price}';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.PDF_GENERATOR, arguments: label);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            if (label.hasWeight) Text(showWeight()),
            if (label.hasPrice) Text(showPrice()),
            if (label.hasFab)
              const Text(
                'Data de fabricação: ____/____/_____',
                style: TextStyle(fontSize: 11),
              ),
            if (label.hasExpDate)
              const Text(
                'Validade: 02 meses (sob congelamento)',
                style: TextStyle(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
