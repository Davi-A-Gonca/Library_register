import 'dart:convert';

import 'package:apiexemplocall23032025/LibraryRegister.dart';
import 'package:http/http.dart' as http;

class Interactionsapi {

  static String regex = r"^[0-9]{8}$";

  static String getURL(String cep){
    return "https://viacep.com.br/ws/${cep}/json/?callback=meu_callback";
  }

  static Future<Map<String, dynamic>> searchCEP(String cep) async{
    final url = Uri.parse(getURL(cep));

    try{
      final response = await http.get(url);

      if(response.statusCode == 200){
        String responseBody = utf8.decode(response.bodyBytes);

        final Map<String, String> data = json.decode(responseBody);

        if(data.containsKey('erro') && data['erro'] == "true"){
          throw Exception("CEP $cep invalido\n");
        }

        return data;
      }else{
        throw Exception("Failure to get CEP via URL");
      }
    }catch(e){
      print("Erro ao consultar CEP\n${e}");
      throw Exception("Error trying to get CEP");
    }
  }

  static Address verifyCallback(Map<String, String> content){
    Address newAddress = new Address();

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