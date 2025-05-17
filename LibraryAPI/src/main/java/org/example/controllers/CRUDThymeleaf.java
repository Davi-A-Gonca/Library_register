package org.example.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Optional;

public interface CRUDThymeleaf<Media, MediaDTO> {
    ResponseEntity<Media> create(MediaDTO dto);

    ResponseEntity<List<Media>> findAll();

    ResponseEntity<Optional<Media>> findById(String id);

    ResponseEntity<Void> deleteById(String id);
}