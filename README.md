# Claude-start

Template de démarrage pour mes projets avec **Claude Code** : Claude agit en
**chef de projet / orchestrateur**, délègue à des **agents experts** et suit des **skills**
(procédures) standardisés. Chaque projet hérite du même workflow, du même cadre de
design system et des mêmes permissions.

## Contenu

```
CLAUDE.md                     Instructions projet (gabarit à remplir via /kickoff)
PROJECT_INSTRUCTIONS.md       Texte à coller dans claude.ai › Projets › Instructions
docs/
  WORKFLOW.md                 Protocole : cadrage → délégation parallèle → intégration → QA → ship
  ROADMAP.md                  Mémoire du projet entre sessions
  ARCHITECTURE.md             Stack + contrat d'API (modifié AVANT l'implémentation)
  DESIGN.md                   Design system (tokens OKLCH, typo, motion, primitives, checklist)
  DEPLOYMENT.md               Docker, CI, Coolify, Cloudflare
.claude/
  settings.json               Permissions (allow/ask/deny) + hook SessionStart
  hooks/session-start.sh      Installe les deps + rappelle le protocole
  agents/                     architect · design-lead · frontend · backend · devops · qa-reviewer
  skills/                     kickoff · orchestrate · design-system · ship · deploy-coolify
.github/pull_request_template.md
.env.example · .gitignore
```

## Utilisation

### Nouveau projet
1. Sur GitHub : **Use this template** (activer *Template repository* dans les Settings de
   ce repo) → nouveau repo.
2. Ouvrir une session Claude Code sur ce repo et dire « kickoff » (ou `/kickoff`).
   Claude pose quelques questions, remplit `CLAUDE.md` + `docs/`, puis orchestre le
   squelette, le design system et l'infra.

### Projet existant
Copier `CLAUDE.md`, `docs/WORKFLOW.md`, `.claude/` dans le repo, puis `/kickoff`
(il adapte le gabarit à l'existant au lieu de créer un squelette).

### Avec les Projets claude.ai
1. Créer un Projet, y coller `PROJECT_INSTRUCTIONS.md` dans **Instructions**.
2. Ajouter ce repo (et/ou le repo du projet) comme source.
3. Chaque session du Projet démarre alors avec le même rôle d'orchestrateur.

## Skills

| Skill | Rôle |
|---|---|
| `/kickoff` | Cadrage, stack, docs, squelette, design system, infra |
| `/orchestrate <demande>` | Livraison d'une feature via les agents en parallèle |
| `/design-system` | DESIGN.md + tokens + primitives + page `/design` |
| `/ship` | Vérifs, ROADMAP, commits conventionnels, push |
| `/deploy-coolify` | Prod Docker sur Coolify + DNS Cloudflare |

## Permissions

`.claude/settings.json` autorise sans demande l'édition, la recherche, les gestionnaires de
paquets, Docker local, git (hors force-push) et la lecture GitHub ; **demande** avant
`rm -rf`, `git reset --hard`, push sur `main`, création/merge de PR ; **interdit** le
force-push et la lecture des fichiers `.env`. Ajustements perso : `.claude/settings.local.json`
(ignoré par git).
