import 'package:flutter/material.dart';
import 'Book.dart';
import 'Library.dart';
import 'Magazine.dart';
import 'Comic.dart';
import 'Newspaper.dart';


class MockDataProvider {
  final Library exampleLibrary = Library(
    id: "LIB001",
    name: "Biblioteca Central",
    cep: "12345-678",
  );

  List<Book> generateBooks(int count) {
    return List.generate(count, (index) {
      return Book(
        id: "BOOK$index",
        title: "Livro Exemplo $index",
        summary: "Resumo do livro $index",
        publisher: "Editora $index",
        place: exampleLibrary,
        author: "Autor $index",
        nPages: 100 + index,
      );
    });
  }

  List<Comic> generateComics(int count) {
    return List.generate(count, (index) {
      return Comic(
        id: "COMIC$index",
        title: "Quadrinho Exemplo $index",
        summary: "Resumo do quadrinho $index",
        publisher: "HQ Editora $index",
        place: exampleLibrary,
        author: "Desenhista $index",
        artist: "Artista $index",
      );
    });
  }

  List<Magazine> generateMagazines(int count) {
    return List.generate(count, (index) {
      return Magazine(
        id: "MAG$index",
        title: "Revista Exemplo $index",
        summary: "Resumo da revista $index",
        publisher: "Editora Magazine $index",
        place: exampleLibrary,
      );
    });
  }

  List<Newspaper> generateNewspapers(int count) {
    return List.generate(count, (index) {
      return Newspaper(
        id: "NEWS$index",
        title: "Jornal Exemplo $index",
        summary: "Resumo do jornal $index",
        publisher: "Editora Notícias $index",
        place: exampleLibrary,
        date: DateTime(2024, 12, 25).add(Duration(days: index)),
      );
    });
  }

  List<Library> generateLibraries(int count) {
    return List.generate(count, (index) {
      return Library(
        id: "LIB$index",
        name: "Biblioteca $index",
        cep: "00000-00$index",
      );
    });
  }
}
