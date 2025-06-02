import 'dart:convert';

import 'package:apiexemplocall23032025/Book.dart';
import 'package:apiexemplocall23032025/Comic.dart';
import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/Magazine.dart';
import 'package:apiexemplocall23032025/Newspaper.dart';
import 'package:http/http.dart' as http;

class Interactionsapi {
  static const String URI = "http://localhost:8080/projeto/api/v1/";

  //Library CRUD

  static const int POST = 1;
  static const int GET = 2;
  static const int DELETE = 3;

  static Future<void> sendLibrary(Library l) async{
    print("Chegou a Biblioteca ${l.name}");
    final urlLibrary = Uri.parse("${URI}library");

    print("Tentando enviar para a URL: $urlLibrary"); 
    print("Corpo da requisição: ${jsonEncode({'name': l.name, 'cep': l.cep})}");

    try {
      final response = await http.post(
        urlLibrary,
        headers: 
        {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            'name': l.name,
            'cep': l.cep
          }
        )
      ).timeout(const Duration(seconds: 10));

      print("Status da resposta: ${response.statusCode}");
      print("Corpo da resposta: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Envio da Biblioteca ${l.name} Sucesso");
      } else {
        print("Erro ao enviar a Biblioteca ${l.name}, erro:\n Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {      
      print("Erro na requisição: ${e.toString()}");

      if (e is FormatException) {
        print("Verifique se a URI está correta: $urlLibrary");
      }
    }
  }

  static Future<List<Library>> getLibraries() async{
    List<dynamic> list;
    
    final urlLibrary = Uri.parse("${URI}library");

    final response = await http.get(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      String data = utf8.decode(response.bodyBytes);
      list = json.decode(data);
      return list.map((json) => Library.fromJson(json)).toList();
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
    
  }

  static Future<Library> getLibraryById(String id) async{
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
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  static Future<void> deleteLibraries(String id) async{
    final urlLibrary = Uri.parse("${URI}library/$id");

    final response = await http.delete(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      return;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }
  
  //Book
  static Future<void> sendBook(Book b) async{
    print("Chegou o Livro ${b.title}");
    
    final urlBook = Uri.parse("${URI}book");
    print("Tentando enviar para a URL: $urlBook"); 
    
    try{
      final response = await http.post(
        urlBook,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(
          {
            'title' : b.title,
            'summary' : b.summary,
            'publisher' : b.publisher,
            'place' : b.place,
            'author' : b.author,
            'nPages' : b.nPages
          }
        )
      ).timeout(const Duration(seconds: 10));

      print("Status da resposta: ${response.statusCode}");
      print("Corpo da resposta: ${response.body}");

      if(response.statusCode == 201 || response.statusCode == 200){
        print("Envido da Biblioteca ${b.title} Sucesso");
      }else{
        print("Erro ao enviar a Biblioteca ${b.title}, erro:\n ${response.statusCode}");
      }
    }catch(e){
      print("Erro na requisição: ${e.toString()}");

      if (e is FormatException) {
        print("Verifique se a URI está correta: $urlBook");
      }
    }
  }

  static Future<List<Book>> getBook() async{
    List<Book> list;
    
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

  static Future<Book> getBookById(String id) async{
    Book b;

    final urlLibrary = Uri.parse("${URI}library/$id");
    final response = await http.get(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      String data = utf8.decode(response.bodyBytes);
      b = json.decode(data);
      return b;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  static Future<void> deleteBookbyId(String id) async{
    final urlLibrary = Uri.parse("${URI}library/$id");

    final response = await http.delete(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      return;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  //Comic
  static Future<void> sendComic(Comic c) async{
    print("Chegou a Biblioteca ${c.title}");
    final urlLibrary = Uri.parse("${URI}magazine");

    print("Tentando enviar para a URL: $urlLibrary"); 
    print("Corpo da requisição: ${jsonEncode(
          {
            'title' : c.title,
            'summary' : c.summary,
            'publisher' : c.publisher,
            'place' : c.place,
            'author' : c.author,
            'artist' : c.artist
          }
        )}");

    try{
      final response = await http.post(
        urlLibrary,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(
          {
            'title' : c.title,
            'summary' : c.summary,
            'publisher' : c.publisher,
            'place' : c.place,
            'author' : c.author,
            'artist' : c.artist
          }
        )
      );

      print("Status da resposta: ${response.statusCode}");
      print("Corpo da resposta: ${response.body}");

      if(response.statusCode == 201 || response.statusCode == 200){
        print("Envido da Biblioteca ${c.title} Sucesso");
      }else{
        print("Erro ao enviar a Biblioteca ${c.title}, erro:\n ${response.statusCode}");
      }
    }catch(e){
      print("Erro na requisição: ${e.toString()}");

      if (e is FormatException) {
        print("Verifique se a URI está correta: $urlLibrary");
      }
    }
  }

  static Future<List<Comic>> getComic() async{
    List<Comic> list;
    
    final urlLibrary = Uri.parse("${URI}comic/");

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

  static Future<Comic> getComicById(String id) async{
    Comic c;

    final urlLibrary = Uri.parse("${URI}comic/$id");
    final response = await http.get(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      String data = utf8.decode(response.bodyBytes);
      c = json.decode(data);
      return c;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  static Future<void> deleteComicbyId(String id) async{
    final urlLibrary = Uri.parse("${URI}comic/$id");

    final response = await http.delete(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      return;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }
  
  //Magazie
  static Future<void> sendMagazine(Magazine m) async{
    print("Chegou a Biblioteca ${m.title}");
    final urlMagazine = Uri.parse("${URI}magazine");

    print("Tentando enviar para a URL: $urlMagazine"); 
    print("Corpo da requisição: ${jsonEncode(
          {
            'title' : m.title,
            'summary' : m.summary,
            'publisher' : m.publisher
          }
        )}");

    try{
      final response = await http.post(
        urlMagazine,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(
          {
            'title' : m.title,
            'summary' : m.summary,
            'publisher' : m.publisher
          }
        )
      );

      print("Status da resposta: ${response.statusCode}");
      print("Corpo da resposta: ${response.body}");

      if(response.statusCode == 201 || response.statusCode == 200){
        print("Envido da Biblioteca ${m.title} Sucesso");
      }else{
        print("Erro ao enviar a Biblioteca ${m.title}, erro:\n ${response.statusCode}");
      }
    }catch(e){
      print("Erro na requisição: ${e.toString()}");

      if (e is FormatException) {
        print("Verifique se a URI está correta: $urlMagazine");
      }
    }
  }

  static Future<List<Magazine>> getMagazine() async{
    List<Magazine> list;
    
    final urlLibrary = Uri.parse("${URI}magazine/");

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

  static Future<Magazine> getMagazineById(String id) async{
    Magazine c;

    final urlLibrary = Uri.parse("${URI}magazine/$id");
    final response = await http.get(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      String data = utf8.decode(response.bodyBytes);
      c = json.decode(data);
      return c;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  static Future<void> deleteMagazinebyId(String id) async{
    final urlLibrary = Uri.parse("${URI}magazine/$id");

    final response = await http.delete(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      return;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  //News Paper
  static Future<void> sendNewsPaper(Newspaper n) async{
    print("Chegou a Biblioteca ${n.title}");
    final urlNewsPaper = Uri.parse("${URI}newspaper");

    print("Tentando enviar para a URL: $urlNewsPaper"); 
    print("Corpo da requisição: ${jsonEncode(
          {
            'title' : n.title,
            'summary' : n.summary,
            'publisher' : n.publisher,
            'place' : n.place,
            'date' : n.date
          }
        )}");

    try{
      final response = await http.post(
        urlNewsPaper,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(
          {
            'title' : n.title,
            'summary' : n.summary,
            'publisher' : n.publisher,
            'place' : n.place,
            'date' : n.date
          }
        )
      ).timeout(const Duration(seconds: 10));

      if(response.statusCode == 201 || response.statusCode == 200){
        print("Envido da Biblioteca ${n.title} Sucesso");
      }else{
        print("Erro ao enviar a Biblioteca ${n.title}, erro:\n ${response.statusCode}");
      }
    }catch(e){
      print("Erro na requisição: ${e.toString()}");

      if (e is FormatException) {
        print("Verifique se a URI está correta: $urlNewsPaper");
      }
    }
  }

  static Future<List<Newspaper>> getNewsPaper() async{
    List<Newspaper> list;
    
    final urlLibrary = Uri.parse("${URI}newspaper/");

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

  static Future<Newspaper> getNewspaperById(String id) async{
    Newspaper c;

    final urlLibrary = Uri.parse("${URI}newspaper/$id");
    final response = await http.get(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      String data = utf8.decode(response.bodyBytes);
      c = json.decode(data);
      return c;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }

  static Future<void> deleteNewsPaperbyId(String id) async{
    final urlLibrary = Uri.parse("${URI}newspaper/$id");

    final response = await http.delete(
      urlLibrary,
      headers: {
          'Content-Type' : 'application/json; charset=utf8'
        }
    );

    if(response.statusCode == 200){
      return;
    }else{
      throw Exception("Falha ao Tentar recuperar recurso");
    }
  }
}