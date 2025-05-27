package org.example;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//http://localhost:8080/swagger-ui/index.html

@SpringBootApplication
@OpenAPIDefinition(
        info = @Info(
                title = "Library-Searcher",
                version = "1.0",
                description = "sla"
        )
)
public class Main {
    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // Aplica para todas as rotas da sua API
                        .allowedOrigins("http://localhost:54354") // Adicione a origem exata do seu Flutter Web
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD") // Permite todos os métodos necessários
                        .allowedHeaders("*") // Permite todos os cabeçalhos
                        .allowCredentials(true) // Se você for usar cookies, sessões ou cabeçalhos de autorização como "Authorization"
                        .maxAge(3600); // Cache da preflight por 1 hora
            }
        };
    }
}