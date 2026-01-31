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
        return "taches";
    }

    @PostMapping("/ajouter")
    public String addTache(@ModelAttribute Tache tache) {
        // Par défaut, on peut mettre le premier statut si non spécifié
        if (tache.getStatut() == null) {
            statutRepository.findByNom("A FAIRE").ifPresent(tache::setStatut);
        }
        tacheRepository.save(tache);
        return "redirect:/taches";
    }
}
