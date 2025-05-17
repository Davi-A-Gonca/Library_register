package org.example.documents.media;

import lombok.Getter;
import lombok.Setter;
import org.example.documents.PaperMedia;
import org.example.documents.dto.MagazineDTO;
import org.example.documents.places.Library;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Getter @Setter
public class Magazine extends PaperMedia {
    @Id
    private String id;

    public Magazine(MagazineDTO dto){
        super(dto.getTitle(), dto.getSummary(), dto.getPublisher(), dto.getPlace());
    }

}
