package com.example.todoapp;

import com.example.todoapp.model.Statut;
import com.example.todoapp.repository.StatutRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.List;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initDatabase(StatutRepository statutRepository) {
        return args -> {
            List<String> statuts = Arrays.asList("A FAIRE", "EN COURS", "TERMINE", "ANNULE");
            for (String nom : statuts) {
                if (statutRepository.findByNom(nom).isEmpty()) {
                    statutRepository.save(new Statut(null, nom));
                }
            }
        };
    }
}
