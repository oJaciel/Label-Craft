import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:label_craft/models/label_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:label_craft/models/label.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class PdfProvider {
  static Future<pw.ImageProvider> loadNetworkImage(String url) async {
    if (url.isEmpty) {
      throw Exception('URL da imagem vazia');
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Erro ao baixar imagem: ${response.statusCode}');
    }

    final bytes = response.bodyBytes;

    // Aqui você cria a imagem para o pdf
    return pw.MemoryImage(bytes);
  }

  static showWeight(Label label) {
    if (label.hasWeight == false) {
      return '';
    } else if (label.hasWeight == true &&
        (label.weight == '' || label.weight == null)) {
      return 'Peso:______';
    } else if (label.hasWeight == true && (label.weight != null)) {
      return 'Peso: ${label.weight}';
    }
  }

  static showPrice(Label label) {
    if (label.hasPrice == false) {
      return '';
    } else if (label.hasPrice == true &&
        (label.price == '' || label.price == null)) {
      return 'Preço: R\$ ______';
    } else if (label.hasPrice == true && (label.price != null)) {
      return 'Preço: R\$ ${label.price}';
    }
  }

  static Future<void> generateLabelPdf(
    Label label,
    LabelHeader? header,
    int labelsQuantity,
  ) async {
    final year = DateTime.now().year;

    final pdf = pw.Document();

    final double? sizedBoxHeight = 2;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(8),
        build: (pw.Context context) {
          return [
            pw.Wrap(
              spacing: 0,
              runSpacing: 0,
              children: List.generate(labelsQuantity, (index) {
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
                          pw.Text(
                            header?.displayName ?? '',
                            style: pw.TextStyle(fontSize: 12),
                            textAlign: pw.TextAlign.start,
                          ),
                          pw.Text(
                            header?.aditionalInfo ?? '',
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
                          if (label.hasWeight)
                            pw.Text(
                              showWeight(label),
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          pw.SizedBox(height: sizedBoxHeight),
                          if (label.hasPrice)
                            pw.Text(
                              showPrice(label),
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          pw.SizedBox(height: (sizedBoxHeight! + 1)),
                          if (label.hasFab)
                            pw.Text(
                              'Fabricação: _____/_____/$year',
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
