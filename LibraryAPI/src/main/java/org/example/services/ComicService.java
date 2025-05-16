package org.example.services;

import org.example.documents.media.Comic;
import org.example.repositories.ComicRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComicService {
    @Autowired
    ComicRepository repository;

    public Comic save(Comic c){
        repository.save(c);

        return c;
    }

    public List<Comic> findAll(){
        return repository.findAll();
    }

    public Optional<Comic> findById(String id){
        return repository.findById(id);
    }

    public void deleteById(String id){
        repository.deleteById(id);
    }
}
