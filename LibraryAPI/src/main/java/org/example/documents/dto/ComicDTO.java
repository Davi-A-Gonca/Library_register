package org.example.documents.dto;

import lombok.Getter;
import lombok.Setter;
import org.example.documents.PaperMedia;

@Getter @Setter
public class ComicDTO extends PaperMedia {
    private String author;
    private String artist;
}
