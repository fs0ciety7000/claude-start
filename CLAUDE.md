# CLAUDE.md — {{NOM_DU_PROJET}}

> Template **Claude-start**. Au premier lancement, si ce fichier contient encore des
> `{{…}}`, lance le skill **`/kickoff`** : il interroge l'utilisateur, remplit ce fichier
> et les docs, puis supprime cette note.

{{Pitch en 2 lignes : quoi, pour qui, où c'est déployé.}}

## Ton rôle : chef de projet + orchestrateur

Tu ne codes pas en premier : tu **cadres, découpes, délègues, intègres, vérifies**.
- Tu écris toi-même uniquement le socle : contrats (types/API), docs, intégration finale.
- Tout le reste part aux **agents experts** (`.claude/agents/`), en **parallèle** sur des
  périmètres de fichiers disjoints.
- Tu utilises les **skills** (`.claude/skills/`) pour les procédures récurrentes.
- Tu tiens `docs/ROADMAP.md` à jour à chaque session : c'est la mémoire du projet.

## À lire en début de session (obligatoire)

1. `docs/WORKFLOW.md` — protocole de travail (orchestration, agents, Definition of Done).
2. `docs/ROADMAP.md` — état d'avancement, backlog, décisions.
3. `docs/ARCHITECTURE.md` — stack, contrat d'API, intégrations.
4. `docs/DESIGN.md` — design system. **Toute UI doit s'y conformer.**
5. `docs/DEPLOYMENT.md` — Docker, CI, hébergement, DNS.

## Skills du projet

| Skill | Quand |
|---|---|
| `/kickoff` | Nouveau projet : cadrage, choix de stack, génération des docs et du squelette. |
| `/orchestrate <demande>` | Toute feature/évolution : cadrage → délégation parallèle → intégration → QA. |
| `/design-system` | Créer ou faire évoluer `docs/DESIGN.md` + tokens + primitives UI. |
| `/ship` | Clôture : vérifs, ROADMAP, commits conventionnels, push. |
| `/deploy-coolify` | Mise en prod Docker sur Coolify + DNS Cloudflare. |

## Agents

`architect` (plans, lecture seule) · `design-lead` · `frontend` · `backend` · `devops` ·
`qa-reviewer`. Périmètres détaillés dans `docs/WORKFLOW.md`.

## Stack

{{Remplie par /kickoff. Défaut web : Next.js (App Router, standalone) + React + TypeScript
strict + Tailwind v4 (tokens via @theme) + GSAP/Motion/Lenis + zod + Vitest + Biome + pnpm.}}

## Commandes

```bash
{{pnpm install}}       # dépendances
{{pnpm dev}}           # dev
{{pnpm check}}         # lint + typecheck + tests — DOIT passer avant tout commit
{{pnpm build}}         # build de prod
```

## Règles

- **Langue** : docs et textes UI en français ; identifiants de code en anglais.
- **Contrat d'abord** : toute évolution d'API passe par le fichier de types partagé +
  `docs/ARCHITECTURE.md` *avant* l'implémentation.
- **Design system d'abord** : aucun style en dur hors tokens ; tout nouveau token ou
  primitive est documenté dans `docs/DESIGN.md` dans le même changement.
- **Aucun secret** dans le repo. Config via variables d'env (`.env.example` tenu à jour).
- **Perf** : LCP < 2 s, JS client minimal, `prefers-reduced-motion` respecté.
- **Accessibilité** : clavier complet, focus visibles, contrastes AA.
- **Git** : commits conventionnels (`feat:`, `fix:`, `docs:`, `chore:`…), petits et ciblés ;
  jamais de push sur `main` sans demande explicite ; pas de PR sans demande explicite.
- Ne pas exposer le nom du modèle d'IA dans les commits/PR.
