package org.example.controllers;

import org.example.constants.Constant;
import org.example.documents.dto.MagazineDTO;
import org.example.documents.media.Magazine;
import org.example.services.MagazineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class MagazineController implements CRUDThymeleaf<Magazine, MagazineDTO> {

    @Autowired
    private MagazineService service;

    @Override
    @PostMapping(Constant.API_MAG)
    public ResponseEntity<Magazine> create(@RequestBody MagazineDTO magazineDTO) {
        Magazine savedMag = service.save(new Magazine(magazineDTO));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedMag);
    }

    @Override
    @GetMapping(Constant.API_MAG)
    public ResponseEntity<List<Magazine>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @Override
    @GetMapping(Constant.API_MAG + "/{id}")
    public ResponseEntity<Optional<Magazine>> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @Override
    @DeleteMapping(Constant.API_MAG + "/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable("id") String id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
