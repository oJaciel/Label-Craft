import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:label_craft/models/label_header.dart';
import 'package:label_craft/utils/constants.dart';

class HeaderProvider with ChangeNotifier {
  List<LabelHeader> _headers = [];

  List<LabelHeader> get headers => [..._headers];

  //Método para carregar as cabeçalhos do banco
  Future<void> loadHeaders() async {
    _headers.clear();
    final response = await http.get(
      Uri.parse('${Constants.HEADER_BASE_URL}.json'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((headerId, headerData) {
      _headers.add(
        LabelHeader(
          id: headerId,
          name: headerData['name'] ?? '',
          image: headerData['image'] ?? '',
          displayName: headerData['displayName'] ?? '',
          aditionalInfo: headerData['aditionalInfo'] ?? '',
        ),
      );
    });
    notifyListeners();
  }

  //Método para salvar cabeçalho a partir das informações do formulário
  //Dispara o método de salvar ou editar no banco de dados
  Future<void> saveHeader(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final header = LabelHeader(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      image: data['image'] as String,
      displayName: data['displayName'] as String,
      aditionalInfo: data['aditionalInfo'] as String,
    );

    if (hasId == true) {
      return updateHeader(header);
    } else {
      return addHeader(header);
    }
  }

  //Método para salvar cabeçalho no banco e localmente
  Future<void> addHeader(LabelHeader header) async {
    final response = await http.post(
      Uri.parse('${Constants.HEADER_BASE_URL}.json'),
      body: jsonEncode({
        "name": header.name,
        "image": header.image,
        "displayName": header.displayName,
        "aditionalInfo": header.aditionalInfo,
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _headers.add(
      LabelHeader(
        id: id,
        name: header.name,
        image: header.image,
        displayName: header.displayName,
        aditionalInfo: header.aditionalInfo,
      ),
    );
    notifyListeners();
  }

  //Método para editar cabeçalho no banco e localmente
  Future<void> updateHeader(LabelHeader header) async {
    int index = _headers.indexWhere((i) => i.id == header.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.HEADER_BASE_URL}/${header.id}.json'),
        body: jsonEncode({
          "name": header.name,
          "image": header.image,
          "displayName": header.displayName,
          "aditionalInfo": header.aditionalInfo,
        }),
      );
      _headers[index] = header;
      notifyListeners();
    }
  }

  //Método para remover cabeçalho do banco e localmente
  void removeHeader(LabelHeader header) async {
    int index = _headers.indexWhere((i) => i.id == header.id);
    if (index >= 0) {
      final header = _headers[index];

      _headers.remove(header);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.HEADER_BASE_URL}/${header.id}.json'),
      );

      //Se der erro no servidor, o produto é reinserido
      if (response.statusCode >= 400) {
        _headers.insert(index, header);
        notifyListeners();
      }
    }
  }
}
