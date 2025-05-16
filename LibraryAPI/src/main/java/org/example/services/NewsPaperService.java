package org.example.services;

import org.example.documents.media.NewsPaper;
import org.example.repositories.NewsPaperRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Service
public class NewsPaperService {
    @Autowired
    NewsPaperRepository repository;

    public NewsPaper save(NewsPaper np){
        repository.save(np);
        return np;
    }

    public List<NewsPaper> findAll(){
        return repository.findAll();
    }

    public Optional<NewsPaper> findById(String id){
        return repository.findById(id);
    }

    public void deleteById(String id){
        repository.deleteById(id);
    }
}
