#!/usr/bin/env bash
# Démarrage de session : installe les dépendances (si projet Node) et rappelle le protocole.
set -euo pipefail
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

if [ -f package.json ]; then
  if [ -f pnpm-lock.yaml ] && command -v pnpm >/dev/null 2>&1; then
    pnpm install --frozen-lockfile --prefer-offline >/dev/null 2>&1 || pnpm install >/dev/null 2>&1 || true
  elif [ -f package-lock.json ]; then
    npm ci >/dev/null 2>&1 || true
  elif [ -f bun.lockb ] && command -v bun >/dev/null 2>&1; then
    bun install >/dev/null 2>&1 || true
  fi
fi

if grep -q '{{' CLAUDE.md 2>/dev/null; then
  echo "[claude-start] Projet non initialisé : lance le skill /kickoff (CLAUDE.md contient des {{…}})."
fi

cat <<'MSG'
[claude-start] Protocole : lire CLAUDE.md puis docs/WORKFLOW.md et docs/ROADMAP.md.
Tu es chef de projet / orchestrateur : cadre (contrat + docs), délègue en parallèle aux agents
de .claude/agents/ (architect, design-lead, frontend, backend, devops, qa-reviewer) sur des
fichiers disjoints, intègre, vérifie (check + build), puis /ship (ROADMAP, commit, push).
Skills : /kickoff, /orchestrate, /design-system, /ship, /deploy-coolify.
MSG
