# Projet Tutoré
## Master 1 Santé Publique – Informatique Biomédicale

**Université Sorbonne Paris Nord – UFR SMBH**

*Sujet : Impact des déserts médicaux sur la surcharge des urgences hospitalières en France*

---

## Prérequis

- Serveur local PHP/MySQL : XAMPP, WAMP ou MAMP (de préférence XAMPP)
- Installation de la seconde application web (partie_2) :nécessaires pour exploiter toutes les fonctionnalités; c'est une application indépendante dont le guide d'installation se trouve dans son propre README
- Navigateur web moderne
- Navigateur compatible JavaScript
- Navigateur conseillé : Chrome, Firefox ou Edge

### Problème fréquent avec le lancement de MySQL (XAMPP)
Il arrive que MySQL ne parvienne pas à démarrer correctement via le panneau de contrôle de XAMPP, généralement en raison d’un port déjà occupé (3306 ou 80) par un autre processus.

### Solution proposée
**Ouvrir l’invite de commande en tant qu’administrateur :**
Clic droit sur “Invite de commande” → Exécuter en tant qu’administrateur

**Identifier les processus qui bloquent les ports :**
```bash
   netstat -ano | findstr :3306
   netstat -ano | findstr :80
```

Vous verrez une ligne avec le mot LISTENING. Notez le numéro indiqué en fin de ligne : c’est le PID du processus (exemple : 6040).

**Terminer le processus fautif :**
```bash
    taskkill /PID 6040 /F
```
Remplacez 6040 par le PID récupéré à l’étape précédente (netstat -ano | findstr :3306).

**Relancer MySQL dans XAMPP :**
Retourne sur le panneau de contrôle XAMPP
Clique sur Start pour MySQL → il devrait maintenant démarrer correctement


---

## Structure du projet

/
├── index.html  
├── styles/  
│   ├── style_index.css  
│   └── style_dashboard.css  
├── scripts/  
│   ├── script_index.js  
│   └── script_dashboard.js  
├── visualisation/  
│   └── dashboard.php  
├── base/  
│   ├── structure.sql  
│   └── donnees.sql  
└── README.md  

---

## Étapes d’installation

### 1. Téléchargement et déploiement

- Copiez l’ensemble du dossier du projet dans le dossier `htdocs` de **XAMPP** (ou `www` si vous utilisez WAMP/MAMP).
  Exemple : `C:\xampp\htdocs\projet/`

### 2. Création de la base de données

- Lancez **phpMyAdmin** via `http://localhost/phpmyadmin` dans un navigateur
- Créez une base de données en exécutant dans la partie **SQL** de **phpMyAdmin** le code suivant : - `/Code/sql/base.sql`
- Importez les données dans la base en exécutant dans la partie **SQL** de **phpMyAdmin** le code suivant :  - `/Code/sql/donnees.sql`

### 3. Configuration du serveur

- Assurez-vous que **Apache et MySQL** sont bien démarrés dans le panneau de XAMPP
- Lancement : Vérifiez que le dossier `projet/` est accessible à l’adresse - `http://localhost/projet/index.html`


### 4. Test du bon fonctionnement

- L’interface d’accueil doit s’afficher avec navigation
- Le tableau de bord doit permettre de :
  -- Sélectionner un ou deux indicateurs
  -- Générer un graphique dynamique
  -- Télécharger les résultats en PNG ou Excel
  -- Afficher les régions concernées par le désert médical et/ou surcharge des urgences

---

## Technologies utilisées

- Front-end : HTML, CSS, JavaScript
- Back-end : PHP
- Base de données : MySQL (via PhpMyAdmin)
- Librairies : Chart.js (visualisation), JSZip + FileSaver.js (export Excel)

---

## Auteurs

- Dieu-Donné Fianko
- Formation : Master 1 Santé Publique – Parcours Informatique Biomédicale  
- Année académique 2024–2025

---

## Remarques

- Les données utilisées sont issues de sources publiques : DREES, INSEE
- Ce projet a été réalisé à des fins pédagogiques uniquement


