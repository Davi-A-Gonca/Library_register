package org.example.controllers;

import org.example.constants.Constant;
import org.example.documents.dto.LibraryDTO;
import org.example.documents.places.Library;
import org.example.services.BookService;
import org.example.services.LibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class LibraryController {
    @Autowired
    private LibraryService lService;

    @Autowired
    private BookService bService;

    //Create
    @PostMapping(Constant.API_LIBRARY)
    public ResponseEntity<Library> createLibrary(@RequestBody LibraryDTO dto){
        Library savedLibrary = lService.save(new Library(dto));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedLibrary);
    }

    //Uptdate

    //Read
    @GetMapping(Constant.API_LIBRARY)
    public ResponseEntity<List<Library>> findAll(){
        return ResponseEntity.ok(lService.findAll());
    }

    @GetMapping(Constant.API_LIBRARY + "/{id}")
    public ResponseEntity<Optional<Library>> findById(@PathVariable("id") String id){
        return ResponseEntity.ok(lService.findById(id));
    }

    //Delete
    @DeleteMapping(Constant.API_LIBRARY + "/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable String id){
        lService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
