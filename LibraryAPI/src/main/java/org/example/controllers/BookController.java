package org.example.controllers;

import org.apache.tomcat.util.bcel.Const;
import org.example.constants.Constant;
import org.example.documents.dto.BookDTO;
import org.example.documents.media.Book;
import org.example.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class BookController implements CRUDThymeleaf<Book, BookDTO> {
    @Autowired
    private BookService service;

    @Override
    @PostMapping(Constant.API_BOOK + "/{id}")
    public ResponseEntity<Book> create(@RequestBody BookDTO dto) {
        Book savedBook = service.save(new Book(dto));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedBook);
    }

    @Override
    @GetMapping(Constant.API_BOOK)
    public ResponseEntity<List<Book>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @Override
    @GetMapping(Constant.API_BOOK + "/{id}")
    public ResponseEntity<Optional<Book>> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @Override
    @DeleteMapping(Constant.API_BOOK + "/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable("id") String id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
