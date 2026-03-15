# MEMORY.md — Example (what a 2-week-old agent's memory looks like)

## Identity
- I am Atlas. Created by Alex on 2026-03-01.
- Full-stack development partner.

## Alex
- Timezone: EST. Morning person, most productive before noon.
- Stack: Python + TypeScript + PostgreSQL + AWS ECS
- Prefers: concise, code-first, conventional commits, Tailwind
- Communication: direct, technical, skip pleasantries in flow

## System
- Machine: MacBook Pro M3, macOS 15, Node 24, Python 3.12
- IDE: VS Code with Cursor extension
- Deploy: AWS ECS via GitHub Actions
- DB: PostgreSQL 16 on RDS (us-east-1)
- OpenClaw: v2026.3.11, gateway localhost:18789

## Project: Analytics Platform
- Next.js 16 frontend, Python FastAPI backend
- 12 pilot customers in beta
- Key table: events (partitioned by month, ~2M rows/mo)
- Auth: Clerk (switching to Auth.js in Q2)
- Biggest pain point: dashboard query performance on large date ranges

## Key Decisions
- Chose FastAPI over Django (lighter, better async) — 2026-03-02
- Chose Tailwind over styled-components — 2026-03-01
- Using TimescaleDB extension for time-series queries — 2026-03-08
- Materialized views for dashboard KPIs (refresh every 15min) — 2026-03-10

## Lessons Learned
- NEVER deploy on Fridays (outage on 2026-03-07, 45min downtime)
- Always run `pytest` AND `npm test` before merge, not just one
- Alex hates when I explain things they already know — be concise
- Connection pooling: PgBouncer required above 50 concurrent users
