package com.example.todoapp.controller;

import com.example.todoapp.model.Tache;
import com.example.todoapp.repository.TacheRepository;
import com.example.todoapp.repository.StatutRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/taches")
public class TacheViewController {

    @Autowired
    private TacheRepository tacheRepository;

    @Autowired
    private StatutRepository statutRepository;

    @GetMapping
    public String listTaches(Model model) {
        model.addAttribute("taches", tacheRepository.findAll());
        model.addAttribute("statuts", statutRepository.findAll());
        return "taches";
    }

    @PostMapping("/ajouter")
    public String addTache(@ModelAttribute Tache tache, @RequestParam(required = false) Long statutId) {
        if (statutId != null) {
            statutRepository.findById(statutId).ifPresent(tache::setStatut);
        } else if (tache.getStatut() == null) {
            statutRepository.findByNom("A FAIRE").ifPresent(tache::setStatut);
        }
        tacheRepository.save(tache);
        return "redirect:/taches";
    }

    @PostMapping("/modifier")
    public String updateTache(@ModelAttribute Tache tache, @RequestParam Long id, @RequestParam Long statutId) {
        tacheRepository.findById(id).ifPresent(existingTache -> {
            existingTache.setTitre(tache.getTitre());
            existingTache.setDescription(tache.getDescription());
            existingTache.setPriorite(tache.getPriorite());
            statutRepository.findById(statutId).ifPresent(existingTache::setStatut);
            tacheRepository.save(existingTache);
        });
        return "redirect:/taches";
    }

    @PostMapping("/supprimer")
    public String deleteTache(@RequestParam Long id) {
        tacheRepository.deleteById(id);
        return "redirect:/taches";
    }
}
