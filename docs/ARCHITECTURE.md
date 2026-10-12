# ARCHITECTURE

> Rempli par `/kickoff`, maintenu par l'orchestrateur et `architect`.
> **Le contrat (§3) est modifié AVANT toute implémentation.**

## 1. Vue d'ensemble

{{Schéma texte : client → app → services externes. Ce qui est rendu côté serveur / client.}}

## 2. Stack

| Couche | Choix | Pourquoi |
|---|---|---|
| Framework | {{Next.js App Router, output standalone}} | |
| Langage | {{TypeScript strict}} | |
| Styles | {{Tailwind v4, tokens @theme}} | |
| Motion | {{GSAP + Motion + Lenis}} | |
| Validation | {{zod}} | |
| Données | {{aucune BDD / Supabase / Postgres…}} | |
| Tests | {{Vitest + Playwright}} | |
| Lint/format | {{Biome}} | |

## 3. Contrat d'API (source de vérité : `{{src/lib/types.ts}}`)

| Méthode | Route | Entrée | Sortie | Erreurs |
|---|---|---|---|---|
| GET | `/api/health` | — | `{ ok: true }` | — |

Conventions : erreurs JSON `{ error: { code, message } }`, codes HTTP sémantiques,
validation zod de toute entrée externe.

## 4. Intégrations externes

{{Service, auth, limites, cache, gestion d'erreur.}}

## 5. Sécurité

- Aucune URL arbitraire proxifiée ; entrées validées ; en-têtes de sécurité (CSP…).
- Secrets uniquement en variables d'env.

## 6. Arborescence

```
src/app/            pages + route handlers
src/components/ui/  primitives du design system
src/components/     sections / composants métier
src/lib/            logique, clients, types partagés
scripts/            CLI et scripts d'infra
docs/               documentation
.claude/            agents, skills, hooks, permissions
```
