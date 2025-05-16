package org.example.documents.places;

import lombok.Getter;
import lombok.Setter;
import org.example.documents.dto.LibraryDTO;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Getter @Setter
public class Library {
    private String id;
    private String name;
    private String cep;

    public Library(){

    }

    public Library(LibraryDTO dto){
        this.name = dto.getName();
        this.cep = dto.getCep();
    }
}
