# Leexi Pricing Calculator

Leexi Pricing Calculator est une application web composée de deux parties :

- Une API backend développée avec Ruby on Rails (mode API only)
- Une interface frontend développée avec Nuxt 3 (Vue.js)

Cette application permet de calculer le prix total d'un abonnement à la plateforme Leexi, en fonction :

- du plan choisi (`ai_meeting` ou `enterprise`),
- du nombre de licences demandées,
- de la périodicité (`monthly` ou `annually`).

## Table des matières

- [Spécifications métier](#spécifications-métier)
- [Architecture](#architecture)
- [Installation](#installation)
  - [Backend (Ruby on Rails)](#backend-ruby-on-rails)
  - [Frontend (Nuxt)](#frontend-nuxt)
- [Utilisation de l’API](#utilisation-de-lapi)
- [Tests](#tests)
- [Structure du projet](#structure-du-projet)

## Spécifications métier

| Plan         | < 10 licences   | 10 ≤ licences < 50 | ≥ 50 licences |
|--------------|------------------|----------------------|----------------|
| AI Meeting   | 29€/licence      | 25€/licence          | 15€/licence    |
| Enterprise   | Non disponible   | 55€/licence          | 40€/licence    |

> Un abonnement annuel bénéficie d’une réduction de 10 % sur le coût mensuel total.

## Architecture

- **Backend** : Ruby on Rails API-only, port 8080
- **Frontend** : Nuxt 3 (Vue.js), port 3000
- Communication via requêtes HTTP (JSON)

## Installation

### Prérequis

- Ruby 3.2 ou +
- Rails 7 ou 8
- Node.js 18+
- Yarn ou npm
- PostgreSQL ou SQLite (par défaut)

### Backend (Ruby on Rails)

```bash
cd backend

bundle install

# Lancer les tests
bundle exec rspec

# Démarrer le serveur Rails sur le port 8080
rails server -p 8080
```

### Frontend (Nuxt 3)

#### Installation et démarrage

1. Se rendre dans le dossier du projet frontend :

```bash
cd frontend

npm install

# Démarrer le serveur
npm run dev
```

Accéder à l'application depuis le navigateur :

http://localhost:3000


## Auteurs

Ce projet a été réalisé dans le cadre du test technique proposé par Leexi.

- Développeur : [Quentin de la Meilleure]
- Technologies utilisées :
  - Ruby on Rails (API mode)
  - Nuxt 3 (Vue.js)
  - RSpec pour les tests backend

# leexi_test
# leexi_test
