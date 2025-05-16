package org.example.repositories;

import org.example.documents.media.Comic;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComicRepository extends MongoRepository<Comic, String> {
}
