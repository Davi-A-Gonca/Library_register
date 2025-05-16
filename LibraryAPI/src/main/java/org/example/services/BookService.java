package org.example.services;

import org.example.documents.media.Book;
import org.example.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {
    @Autowired
    private BookRepository repository;

    public Book save(Book b){
        repository.save(b);

        return b;
    }

    public List<Book> findAll(){
        return repository.findAll();
    }

    public Optional<Book> findById(String id){
        return repository.findById(id);
    }

    public void deleteById(String id){
        repository.deleteById(id);
    }
}
