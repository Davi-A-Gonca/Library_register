package org.example.documents.dto;


import lombok.Getter;
import lombok.Setter;
import org.example.documents.PaperMedia;

@Getter @Setter
public class BookDTO extends PaperMedia {
    String author;
    int nPages;
}
