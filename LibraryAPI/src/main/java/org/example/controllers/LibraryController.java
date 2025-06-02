package org.example.controllers;

import org.example.constants.Constant;
import org.example.documents.dto.LibraryDTO;
import org.example.documents.places.Library;
import org.example.services.LibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class LibraryController implements CRUDThymeleaf<Library, LibraryDTO>{
    @Autowired
    private LibraryService service;

    //Create / Uptdate
    @Override
    @PostMapping(Constant.API_LIBRARY)
    public ResponseEntity<Library> create(@RequestBody LibraryDTO dto) {
        System.out.println("Chegou");
        Library savedLibrary = service.save(new Library(dto));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedLibrary);
    }

    //Read
    @Override
    @GetMapping(Constant.API_LIBRARY)
    public ResponseEntity<List<Library>> findAll(){
        System.out.println("Foi-se");
        return ResponseEntity.ok(service.findAll());
    }

    @Override
    @GetMapping(Constant.API_LIBRARY + "/{id}")
    public ResponseEntity<Optional<Library>> findById(@PathVariable("id") String id){
        return ResponseEntity.ok(service.findById(id));
    }

    //Delete
    @Override
    @DeleteMapping(Constant.API_LIBRARY + "/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable("id") String id){
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    /*
    @DeleteMapping(Constant.API_LIBRARY + "DELETEALL")
    public ResponseEntity<Void> deleteAll(){
        for(Library l : lService.listAll()){
            lService.deleteById(l.getId());
        }
        return ResponseEntity.noContent().build();
    }*/
}
