import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/pdf_provider.dart';

class LabelPreview extends StatelessWidget {
  const LabelPreview(this.label, {super.key});

  final Label label;

  @override
  Widget build(BuildContext context) {
    final double? sizedBoxHeight = 4;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          //Coluna da imagem, CPF e Fone
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/label_logo.png',
                width: 120,
                height: 55,
                alignment: Alignment.center,
              ),
              Text(
                'CNPJ: 08.601.406/0001-31',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
              ),
              Text(
                'Fone: (54) 9 9957-5514 / 9 9616-8921',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ],
          ),

          SizedBox(height: sizedBoxHeight),

          //Coluna das informações
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label.hasWeight)
                Text(
                  PdfProvider.showWeight(label),
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
              SizedBox(height: sizedBoxHeight),

              if (label.hasPrice)
                Text(
                  PdfProvider.showPrice(label),
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
              SizedBox(height: (sizedBoxHeight! + 1)),

              if (label.hasFab)
                Text(
                  'Fabricação: _____/_____/______',
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
              SizedBox(height: sizedBoxHeight),

              if (label.hasExpDate)
                Text(
                  'Validade: 02 meses (sob congelamento)',
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
