<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestionnaire de Tâches - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); height: 100vh; display: flex; align-items: center; justify-content: center; color: white; }
        .hero-card { background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.2); padding: 3rem; border-radius: 20px; text-align: center; }
        .btn-start { background-color: #fff; color: #764ba2; font-weight: bold; padding: 12px 30px; border-radius: 50px; transition: 0.3s; text-decoration: none; }
        .btn-start:hover { background-color: #f8f9fa; transform: scale(1.05); color: #667eea; }
    </style>
</head>
<body>
    <div class="hero-card shadow-lg">
        <h1 class="display-3 mb-4">Bienvenue sur TodoApp</h1>
        <p class="lead mb-5">Organisez vos tâches, gérez vos priorités et suivez vos progrès simplement.</p>
        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
            <a href="/taches" class="btn-start">Accéder à mes tâches</a>
        </div>
    </div>
</body>
</html>
