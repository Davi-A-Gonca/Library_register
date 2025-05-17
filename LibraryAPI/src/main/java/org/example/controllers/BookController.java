package org.example.controllers;

import org.example.constants.Constant;
import org.example.documents.dto.BookDTO;
import org.example.documents.media.Book;
import org.example.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Optional;

@Controller
public class BookController implements CRUDThymeleaf<Book, BookDTO> {
    @Autowired
    private BookService service;

    @Override
    @PostMapping(Constant.API_BOOK + "/{id}")
    public ResponseEntity<Book> create(BookDTO dto) {
        Book savedBook = service.save(new Book(dto));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedBook);
    }

    @Override
    public ResponseEntity<List<Book>> findAll() {
        return null;
    }

    @Override
    public ResponseEntity<Optional<Book>> findById(String id) {
        return null;
    }

    @Override
    public ResponseEntity<Void> deleteById(String id) {
        return null;
    }
}
