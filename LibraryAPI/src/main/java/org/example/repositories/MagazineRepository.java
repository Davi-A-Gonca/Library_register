package org.example.repositories;

import org.example.documents.media.Magazine;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface MagazineRepository  extends MongoRepository<Magazine, String> {
}
