package org.example.services;

import org.example.documents.media.Magazine;
import org.example.repositories.MagazineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MagazineService {
    @Autowired
    MagazineRepository repository;

    public Magazine save(Magazine m){
        repository.save(m);

        return m;
    }

    public List<Magazine> listAll(){
        return repository.findAll();
    }

    public Optional<Magazine> listById(String id){
        return repository.findById(id);
    }

    public void deleteById(String id){
        repository.deleteById(id);
    }
}
