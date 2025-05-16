package org.example.documents.dto;

import lombok.Getter;
import lombok.Setter;
import org.example.documents.PaperMedia;

import java.util.Date;

@Getter @Setter
public class NewsPaperDTO extends PaperMedia {
    private Date date;
}
