package org.example;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//http://localhost:8080/swagger-ui/index.html

@SpringBootApplication
@OpenAPIDefinition(info = @Info(title = "Library-Searcher", version = "1.0", description = "sla"))
public class Main {
    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }
}