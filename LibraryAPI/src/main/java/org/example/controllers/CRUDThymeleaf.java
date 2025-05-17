package org.example.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Optional;

public interface CRUDThymeleaf<T, D> {
    ResponseEntity<T> create(@RequestBody D dto);

    ResponseEntity<List<T>> findAll();

    ResponseEntity<Optional<T>> findById(@PathVariable("id") String id);

    ResponseEntity<Void> deleteById(@PathVariable String id);
}
