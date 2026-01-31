package com.example.todoapp.controller;

import com.example.todoapp.model.Statut;
import com.example.todoapp.repository.StatutRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/statuts")
@CrossOrigin(origins = "*")
public class StatutController {

    @Autowired
    private StatutRepository statutRepository;

    @GetMapping
    public List<Statut> getAllStatuts() {
        return statutRepository.findAll();
    }
}
