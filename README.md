# 💸 Smart Expense Management Application

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F.svg?style=for-the-badge&logo=Spring-Boot&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)

**Smart Expense** est une application mobile complète développée avec **Flutter** et **Spring Boot**, conçue pour aider les utilisateurs (et notamment les étudiants) à gérer efficacement leurs finances personnelles, suivre leurs dépenses, et analyser leurs revenus mensuels.

---

## ✨ Fonctionnalités Principales

- 📊 **Tableau de Bord Intuitif** : Visualisation claire du solde actuel, des dépenses et des revenus.
- 💳 **Gestion des Transactions** : Ajout, modification et suppression simplifiés de vos revenus et dépenses.
- 📈 **Statistiques & Graphiques** : Analyse détaillée de vos habitudes de consommation grâce à des graphiques interactifs (via `fl_chart`).
- 🎯 **Suivi Budgétaire** : Définition d'un budget mensuel personnalisé et suivi en temps réel.
- 🎨 **Interface Moderne** : UI/UX soignée, réactive et facile à prendre en main.
- 🗄️ **Base de Données Intégrée** : Gestion sécurisée des données grâce à Spring Data JPA et la base de données H2.

---

## 🛠️ Stack Technique

### Frontend (Application Mobile)
- **Framework** : Flutter
- **Langage** : Dart
- **Bibliothèques clés** : `fl_chart` (pour les graphiques), requêtes API HTTP.

### Backend (API REST)
- **Framework** : Spring Boot 3
- **Langage** : Java 21
- **Composants** : Spring Data JPA, Spring Web
- **Base de données** : H2 Database (In-Memory pour un développement et test rapides)

---

## 🚀 Guide d'Installation

### 📋 Prérequis
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installé sur votre machine.
- [Java Development Kit (JDK) 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) ou supérieur.
- Un émulateur (iOS Simulator / Android Emulator) ou un appareil physique configuré.

### ⚙️ 1. Configuration du Backend (Spring Boot)
Le backend sert d'API REST pour l'application mobile et gère toute la logique de la base de données.

```bash
# Naviguez vers le dossier du backend
cd Smart-App-gestion-depenses

# Lancez l'application via le wrapper Maven
./mvnw spring-boot:run
```
L'API Backend sera accessible à l'adresse locale : `http://localhost:8080`
*(La console H2 est également disponible sur `http://localhost:8080/h2-console`)*

### 📱 2. Configuration du Frontend (Flutter)
Assurez-vous que le backend est en cours d'exécution avant de tester l'application mobile.

```bash
# Ouvrez un nouveau terminal et naviguez vers le dossier Flutter
cd smart_app_flutter_gestion_depandence

# Téléchargez les dépendances du projet
flutter pub get

# Lancez l'application sur votre émulateur iOS ou Android
flutter run
```
> **Astuce iOS** : Si vous utilisez un Mac, vous pouvez démarrer le simulateur rapidement avec la commande `open -a Simulator` avant d'exécuter `flutter run -d ios`.

---

## 📁 Structure du Projet

```text
📂 expense-tracker
 ┣ 📂 Smart-App-gestion-depenses       # Code source du Backend (Java / Spring Boot)
 ┃ ┣ 📂 src/main/java                  # Logique métier, Contrôleurs, Entités, Services
 ┃ ┗ 📂 src/main/resources             # Configuration (application.properties)
 ┗ 📂 smart_app_flutter_gestion_depandence # Code source du Frontend (Dart / Flutter)
   ┣ 📂 lib/screens                    # Vues et interface utilisateur
   ┣ 📂 lib/services                   # Appels réseaux vers l'API
   ┗ 📂 lib/models                     # Modèles de données Dart
```

---

## 👨‍💻 Développé par
- **SIDI MED NABGHA Abd Latif**
- **BEN TALEB Ilyasse**
- **KHABOU Omar**

Projet de fin d'année pour le cours "développement Mobile" à l'ENSET Mohammedia - Morocco
