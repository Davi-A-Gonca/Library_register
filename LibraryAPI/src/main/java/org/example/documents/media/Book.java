package org.example.documents.media;

import lombok.Getter;
import lombok.Setter;
import org.example.documents.PaperMedia;
import org.example.documents.dto.BookDTO;
import org.example.documents.places.Library;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Getter @Setter
public class Book extends PaperMedia {
    @Id
    private String id;

    private String author;
    private int nPages;

    public Book(BookDTO dto){
        super(dto.getTitle(), dto.getSummary(), dto.getPublisher(), dto.getPlace());
        this.author = dto.getAuthor();
        this.nPages = dto.getNPages();
    }

}
