import 'dart:convert';

import 'package:apiexemplocall23032025/Library.dart';
import 'package:http/http.dart' as http;

class Interactionsapi {
  static const String URI = "http://localhost:8080/projeto/api/v1/";

  static Future<void> sendLibrary(Library l) async{
    final urlLibrary = Uri.parse(URI + "library");

    try{
      final response = await http.post(
        urlLibrary,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(
          {
          'name' : l.name,
          'cep' : l.cep
          }
        )
      );

      if(response.statusCode == 201 || response.statusCode == 200){
        print("Envido da Biblioteca ${l.name} Sucesso");
      }else{
        print("Erro ao enviar a Biblioteca ${l.name}, erro:\n ${response.statusCode}");
      }
    }catch(e){
      print("Erro: ${e}");
    }
  }

  Future<List<Library>> getLibraries() async{
    List<Library> list;
    
    final urlLibrary = Uri.parse("${URI}library/");

    final response = await http.get(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      String data = utf8.decode(response.bodyBytes);
      list = json.decode(data);
      return list;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
    
  }

  Future<Library> getLibraryById(String id) async{
    Library l;

    final urlLibrary = Uri.parse("${URI}library/$id");
    
    final response = await http.get(
        urlLibrary,
        headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
      );

    if(response.statusCode == 200){
    
      String data = utf8.decode(response.bodyBytes);
      l = json.decode(data);
      return l;
    
    }else{
      throw Exception("Falha ao Tentar Recuperar biblioteca");
    }
  }
}