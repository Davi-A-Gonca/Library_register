import 'dart:convert';

import 'package:apiexemplocall23032025/LibraryRegister.dart';
import 'package:http/http.dart' as http;

class InteractionsCEP {

  static String regex = r"^[0-9]{8}$";

  static String getURL(String cep){
    return "https://viacep.com.br/ws/${cep}/json/";
  }

  static Future<Address> searchCEP(String cep) async{
final url = Uri.parse(getURL(cep)); // certifique-se de implementar getURL

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(responseBody);

      if (data.containsKey('erro') && data['erro'] == true) {
        throw Exception("CEP $cep inválido");
      }

      return Address.fromMap(data);
    } else {
      throw Exception("Falha ao obter CEP pela URL");
    }
  } catch (e) {
    print("Erro ao consultar CEP: $e");
    throw Exception("Erro ao tentar obter o CEP");
  }  }

  static Address verifyCallback(Map<String, dynamic> content){
    Address newAddress = new Address.fromMap(content);

    newAddress.logradouro = content['logradouro']!;
    newAddress.numero = content['numero']!;
    newAddress.bairro = content['bairro']!;
    newAddress.complemento = content['complemento']!;
    newAddress.cidade = content['cidade']!;
    newAddress.estado = content['UF']!;
    newAddress.cep = content['cep']!;

    return newAddress;
  }

  
}