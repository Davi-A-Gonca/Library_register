package org.example.documents;

import lombok.Getter;
import lombok.Setter;
import org.example.documents.places.Library;

@Getter
@Setter
public abstract class PaperMedia implements Media {
    private String title;
    private String summary;
    private String publisher;
    private Library place;

    public PaperMedia(){

    }
}
