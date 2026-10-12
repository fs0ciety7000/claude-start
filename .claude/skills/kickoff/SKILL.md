---
name: kickoff
description: Démarre un nouveau projet à partir du template Claude-start. À utiliser quand CLAUDE.md contient encore des {{…}}, ou quand l'utilisateur dit « nouveau projet », « on démarre », « kickoff ». Cadre le besoin, choisit la stack, remplit CLAUDE.md et docs/*, puis orchestre le squelette, le design system et l'infra.
---
# Kickoff — nouveau projet

Tu es chef de projet. Objectif : passer d'une idée à un squelette vert, documenté, déployable.

## 1. Cadrage (une seule salve de questions, via AskUserQuestion)
Demande uniquement ce que tu ne peux pas déduire :
- Pitch (quoi, pour qui), nom du projet, sous-domaine `*.fs0ciety.org`.
- Type : site vitrine / app web / API / CLI / autre.
- Données : aucune, fichiers, Supabase/Postgres, API externe.
- Direction artistique souhaitée (3 mots, références) — sinon le design-lead propose.
Propose des défauts recommandés (stack web par défaut de CLAUDE.md, Coolify + Cloudflare).

## 2. Socle (toi)
1. Remplir `CLAUDE.md` (pitch, stack, commandes) et supprimer la note template.
2. `docs/ARCHITECTURE.md` : vue d'ensemble, stack justifiée, contrat d'API initial.
3. `docs/ROADMAP.md` : Session 0 + backlog v1 + décisions.
4. Adapter `.claude/settings.json` (permissions des commandes réelles du projet) et
   `.claude/hooks/session-start.sh` si la stack n'est pas Node/pnpm.

## 3. Délégation parallèle (un seul message, plusieurs Agent)
- `architect` → plan v1 en lots (attendre si la demande est structurante).
- `design-lead` → `/design-system` : DESIGN.md complet + tokens + primitives + `/design`.
- `backend` → squelette (types partagés, /api/health, config lint/test/check).
- `devops` → Dockerfile, CI, DEPLOYMENT.md, `.env.example`.
Puis `frontend` une fois tokens + contrat posés.

## 4. Intégration et clôture
`check` + `build` + `docker build` verts → `qa-reviewer` → `/ship`.
Rends à l'utilisateur : ce qui existe, comment lancer, prochaines étapes, actions manuelles
(DNS, Coolify, création du repo si nécessaire).
