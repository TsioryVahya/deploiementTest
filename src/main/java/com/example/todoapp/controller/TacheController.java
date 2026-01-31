package com.example.todoapp.controller;

import com.example.todoapp.model.Tache;
import com.example.todoapp.repository.TacheRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/taches")
@CrossOrigin(origins = "*")
public class TacheController {

    @Autowired
    private TacheRepository tacheRepository;

    @GetMapping
    public List<Tache> getAllTaches() {
        return tacheRepository.findAll();
    }

    @PostMapping
    public Tache createTache(@RequestBody Tache tache) {
        return tacheRepository.save(tache);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Tache> getTacheById(@PathVariable Long id) {
        return tacheRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Tache> updateTache(@PathVariable Long id, @RequestBody Tache tacheDetails) {
        return tacheRepository.findById(id)
                .map(tache -> {
                    tache.setTitre(tacheDetails.getTitre());
                    tache.setDescription(tacheDetails.getDescription());
                    tache.setDateEcheance(tacheDetails.getDateEcheance());
                    tache.setStatut(tacheDetails.getStatut());
                    tache.setPriorite(tacheDetails.getPriorite());
                    Tache updatedTache = tacheRepository.save(tache);
                    return ResponseEntity.ok(updatedTache);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTache(@PathVariable Long id) {
        return tacheRepository.findById(id)
                .map(tache -> {
                    tacheRepository.delete(tache);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
