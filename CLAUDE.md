# CLAUDE.md — leap-tv
# LEAP BoxTV — WOD-scherm in de gym

---

## Wat dit project is
TV-scherm dat dagelijkse workouts toont in de gym.
Live op: tv.leaphasselt.be
GitHub: pieterjan-leap/leap-tv (in leap-data repo, submap leap-tv/)

## Tech stack
- Frontend: vanilla HTML/JS
- SugarWOD API: workouts vandaag (via Netlify proxy function)
- Supabase: historische workouts (tabel: workouts)
- Netlify: hosting + serverless functions

## Structuur
```
leap-tv/
├── index.html
├── netlify/functions/sugarwod.js   ← SugarWOD API proxy (CORS fix)
└── netlify.toml
```

## LEAP Branding (ALTIJD toepassen)
- Primair: `#ff5b35` (oranje)
- Achtergrond: `#152024` (donkergrijs)
- Font: TT Autonomous Mono (fallback: system monospace)
- Toon: motiverend, kort, direct

## SugarWOD API
- API key: in Netlify environment variables (SUGARWOD_API_KEY)
- NOOIT hardcoden in index.html
- Proxy via netlify function om CORS te vermijden

## Deploy
- Push naar GitHub → Netlify deployt automatisch
- Base directory: `leap-tv/`
- Custom domain: tv.leaphasselt.be

## Veiligheidsregels
- API keys altijd in Netlify env vars
- Geen Supabase service_role key in frontend
- Voor kleine wijzigingen: Accept Edits mode ok
