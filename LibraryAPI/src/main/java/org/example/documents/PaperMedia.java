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
    private String place;

    public PaperMedia(){

    }

    public PaperMedia(String title, String summary, String publisher, String place){
        this.title = title;
        this.summary = summary;
        this.publisher = publisher;
        this.place = place;
    }
}
