<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ma Liste de Tâches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h2 class="mb-0">Mes Tâches</h2>
                <button class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#addTaskModal">
                    <i class="bi bi-plus-circle"></i> Nouvelle Tâche
                </button>
            </div>
            <div class="card-body">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Titre</th>
                            <th>Description</th>
                            <th>Priorité</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tache" items="${taches}">
                            <tr>
                                <td><strong>${tache.titre}</strong></td>
                                <td>${tache.description}</td>
                                <td>
                                    <span class="badge ${tache.priorite == 'HAUTE' ? 'bg-danger' : (tache.priorite == 'MOYENNE' ? 'bg-warning text-dark' : 'bg-info')}">
                                        ${tache.priorite}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-secondary">${tache.statut.nom}</span>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-outline-primary" 
                                                onclick="editTache('${tache.id}', '${tache.titre}', '${tache.description}', '${tache.priorite}', '${tache.statut.id}')"
                                                data-bs-toggle="modal" data-bs-target="#editTaskModal">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <form action="/taches/supprimer" method="POST" style="display:inline;">
                                            <input type="hidden" name="id" value="${tache.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Supprimer cette tâche ?')">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty taches}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">Aucune tâche trouvée.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="mt-3">
            <a href="/" class="btn btn-link text-decoration-none text-muted"><i class="bi bi-arrow-left"></i> Retour à l'accueil</a>
        </div>
    </div>

    <!-- Modal Ajouter -->
    <div class="modal fade" id="addTaskModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Ajouter une tâche</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="/taches/ajouter" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Titre</label>
                            <input type="text" name="titre" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Priorité</label>
                            <select name="priorite" class="form-select">
                                <option value="BASSE">BASSE</option>
                                <option value="MOYENNE" selected>MOYENNE</option>
                                <option value="HAUTE">HAUTE</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Statut</label>
                            <select name="statutId" class="form-select">
                                <c:forEach var="statut" items="${statuts}">
                                    <option value="${statut.id}">${statut.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Enregistrer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Modifier -->
    <div class="modal fade" id="editTaskModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title">Modifier la tâche</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="/taches/modifier" method="POST">
                        <input type="hidden" name="id" id="edit-id">
                        <div class="mb-3">
                            <label class="form-label">Titre</label>
                            <input type="text" name="titre" id="edit-titre" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" id="edit-description" class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Priorité</label>
                            <select name="priorite" id="edit-priorite" class="form-select">
                                <option value="BASSE">BASSE</option>
                                <option value="MOYENNE">MOYENNE</option>
                                <option value="HAUTE">HAUTE</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Statut</label>
                            <select name="statutId" id="edit-statutId" class="form-select">
                                <c:forEach var="statut" items="${statuts}">
                                    <option value="${statut.id}">${statut.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Mettre à jour</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editTache(id, titre, description, priorite, statutId) {
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-titre').value = titre;
            document.getElementById('edit-description').value = description;
            document.getElementById('edit-priorite').value = priorite;
            document.getElementById('edit-statutId').value = statutId;
        }
    </script>
</body>
</html>
