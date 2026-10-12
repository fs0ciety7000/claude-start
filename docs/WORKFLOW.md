# WORKFLOW — Méthode de travail (toutes les sessions)

La session principale agit en **chef de projet / orchestrateur** : elle cadre, découpe,
délègue aux agents experts, intègre et vérifie. Elle n'écrit elle-même que le socle
(contrats, docs, intégration).

## 1. Démarrage de session

1. Lire `CLAUDE.md`, puis `docs/ROADMAP.md` (état + backlog).
2. Si `CLAUDE.md` contient des `{{…}}` → lancer `/kickoff` et s'arrêter là.
3. Installer et lancer `check` : l'état de départ doit être vert, sinon c'est la 1re tâche.
4. Reformuler la demande, la découper en lots **indépendants** (fichiers disjoints).

## 2. Cadrage (orchestrateur)

- Mettre à jour le **contrat** (types partagés + section API de `docs/ARCHITECTURE.md`)
  avant toute délégation : c'est l'interface entre agents.
- Si l'UI change : s'assurer que `docs/DESIGN.md` couvre le besoin (sinon `design-lead` d'abord).
- Ajouter les tâches dans `docs/ROADMAP.md` avec leur agent propriétaire.
- Demande ambiguë ou structurante → plan par `architect`, validé avant d'exécuter.

## 3. Délégation aux agents experts

| Agent | Périmètre (fichiers possédés) |
|---|---|
| `architect` | Plans, contrats, revues d'architecture. **Lecture seule.** |
| `design-lead` | `docs/DESIGN.md`, tokens (CSS/thème), `src/components/ui/**` |
| `frontend` | Pages, layouts, `src/components/**` (hors `ui/` si design-lead actif) |
| `backend` | `src/lib/**` (hors UI), `src/app/api/**` ou équivalent, scripts/CLI |
| `devops` | `Dockerfile`, `.dockerignore`, `.github/**`, `docs/DEPLOYMENT.md`, `scripts/*.sh` |
| `qa-reviewer` | Revue de diff, tests, a11y, perf, sécu. Ne modifie que les tests. |

Règles :
- Lancer en **parallèle** (un seul message, plusieurs appels Agent) les lots indépendants.
- Un agent = un périmètre de fichiers. Hors périmètre → il **signale**, ne modifie pas.
- Chaque brief contient : **objectif, fichiers possédés, contrat, critères d'acceptation,
  commande de vérification**. Gabarit :

```
Objectif : …
Fichiers possédés : …
Contrat à respecter : <chemin types> / docs/ARCHITECTURE.md §…
Design : docs/DESIGN.md §… (tokens/primitives à utiliser)
Critères d'acceptation : 1) … 2) …
Vérification : <commande check> (+ build / test manuel)
Rends : résumé des changements, fichiers touchés, points hors périmètre signalés.
```

## 4. Intégration (orchestrateur)

1. Relire chaque livrable (diff), résoudre les conflits de contrat.
2. `check` + `build` (+ `docker build` si infra touchée).
3. Lancer l'app et vérifier le parcours réel (skill `run` / Playwright si dispo).
4. `qa-reviewer` sur le diff final ; corriger tout point **bloquant**.

## 5. Clôture → skill `/ship`

- `docs/ROADMAP.md` : fait / reste à faire / décisions.
- Commits conventionnels, push sur la branche de travail.
- Résumé à l'utilisateur : livré, vérifié, actions manuelles restantes.

## Definition of Done

- `check` et `build` verts ; image Docker qui build et démarre (healthcheck 200) si applicable.
- UI conforme à `docs/DESIGN.md`, `prefers-reduced-motion` respecté, navigable au clavier.
- Docs à jour (ARCHITECTURE si contrat modifié, DEPLOYMENT si infra modifiée, ROADMAP toujours).
- Aucun secret commité ; `.env.example` à jour.
