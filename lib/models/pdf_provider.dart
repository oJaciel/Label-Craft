import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:label_craft/models/label.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdfProvider {
  static Future<void> generateLabelPdf(Label label) async {
    final pdf = pw.Document();

    final double? sizedBoxHeight = 2;

    final ByteData imageData = await rootBundle.load(
      'assets/images/label_logo.png',
    );
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(8),
        build: (pw.Context context) {
          return [
            pw.Wrap(
              spacing: 0,
              runSpacing: 0,
              children: List.generate(18, (index) {
                return pw.Container(
                  width: (PdfPageFormat.a4.width - 20) / 3,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 1),
                  ),
                  child: pw.Column(
                    children: [
                      //Coluna da imagem, CPF e Fone
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(
                            image,
                            width: 92,
                            height: 42,
                            alignment: pw.Alignment.center,
                          ),
                          pw.Text(
                            'CNPJ: 08.601.406/0001-31',
                            style: pw.TextStyle(fontSize: 9),
                            textAlign: pw.TextAlign.start,
                          ),
                          pw.Text(
                            'Fone: (54) 9 9957-5514 / 9 9616-8921',
                            style: pw.TextStyle(fontSize: 9),
                            textAlign: pw.TextAlign.start,
                          ),
                        ],
                      ),

                      pw.SizedBox(height: sizedBoxHeight),

                      //Coluna das informações
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            label.hasWeight
                                ? 'Peso: ${label.weight}'
                                : 'Peso: ______',
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: sizedBoxHeight),
                          pw.Text(
                            label.hasPrice
                                ? 'Preço: R\$ ${label.price}'
                                : 'Preço: R\$ ______',
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: (sizedBoxHeight! + 1)),
                          if (label.hasFab)
                            pw.Text(
                              'Fabricação: _____/_____/______',
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          pw.SizedBox(height: sizedBoxHeight),
                          if (label.hasExpDate)
                            pw.Text(
                              'Validade: 02 meses (sob congelamento)',
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ];
        },
      ),
    );
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final Uint8List pdfData = await pdf.save();

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/etiquetas.pdf');
      await file.writeAsBytes(pdfData);

      final result = await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'Etiquetas geradas',
          title: 'Compartilhar etiquetas',
        ),
      );

      if (result.status == ShareResultStatus.success) {
        print("Compartilhado com sucesso");
      } else if (result.status == ShareResultStatus.dismissed) {
        print("Compartilhamento cancelado");
      } else {
        print("Compartilhamento não disponível");
      }
    } else if (kIsWeb ||
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    }
  }
}
