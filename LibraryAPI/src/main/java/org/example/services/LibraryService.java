package org.example.services;

import org.example.documents.places.Library;
import org.example.repositories.LibraryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Service
public class LibraryService {
    @Autowired
    LibraryRepository repository;

    public Library save(Library l){
        repository.save(l);
        return l;
    }

    public List<Library> findAll(){
        return repository.findAll();
    }

    public Optional<Library> findById(String id){
        return repository.findById(id);
    }

    public void deleteById(String id){
        repository.deleteById(id);
    }
}
