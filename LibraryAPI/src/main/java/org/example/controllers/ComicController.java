package org.example.controllers;

import org.example.constants.Constant;
import org.example.documents.dto.ComicDTO;
import org.example.documents.media.Comic;
import org.example.documents.places.Library;
import org.example.services.ComicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class ComicController implements CRUDThymeleaf<Comic, ComicDTO> {
    @Autowired
    ComicService service;

    //Create / Update
    @Override
    @PostMapping(Constant.API_COMIC)
    public ResponseEntity<Comic> create(@RequestBody ComicDTO dto) {
        Comic savedComic = service.save(new Comic(dto));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedComic);
    }

    //Read
    @Override
    @GetMapping(Constant.API_COMIC)
    public ResponseEntity<List<Comic>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @Override
    @GetMapping(Constant.API_COMIC + "/{id}")
    public ResponseEntity<Optional<Comic>> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(service.findById(id));
    }

    //Delete
    @Override
    @DeleteMapping(Constant.API_COMIC + "/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable("id") String id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
