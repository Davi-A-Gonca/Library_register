package org.example.controllers;

import org.example.constants.Constant;
import org.example.documents.dto.NewsPaperDTO;
import org.example.documents.media.NewsPaper;
import org.example.services.NewsPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class NewsPaperController implements CRUDThymeleaf<NewsPaper, NewsPaperDTO>{
    @Autowired
    private NewsPaperService service;

    @Override
    @PostMapping(Constant.API_NEWS)
    public ResponseEntity<NewsPaper> create(@RequestBody NewsPaperDTO newsPaperDTO) {
        NewsPaper savedNP = service.save(new NewsPaper(newsPaperDTO));
        return ResponseEntity.status(HttpStatus.CREATED).body(savedNP);
    }

    @Override
    @GetMapping(Constant.API_NEWS)
    public ResponseEntity<List<NewsPaper>> findAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @Override
    @GetMapping(Constant.API_NEWS + "/{id}")
    public ResponseEntity<Optional<NewsPaper>> findById(@PathVariable("id") String id) {
        return ResponseEntity.ok(service.findById(id));
    }

    @Override
    @DeleteMapping(Constant.API_NEWS + "/{id}")
    public ResponseEntity<Void> deleteById(@PathVariable("id") String id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
