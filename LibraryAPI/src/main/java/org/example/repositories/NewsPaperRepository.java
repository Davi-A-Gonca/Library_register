package org.example.repositories;

import org.example.documents.media.NewsPaper;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NewsPaperRepository extends MongoRepository<NewsPaper, String> {
}
