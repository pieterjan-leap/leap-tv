# LEAP TV Display

TV-scherm voor LEAP Functional Fitness — toont slides, events, facts en review QR-code.
Draait op Supabase + Netlify.

## Setup

### 1. Supabase

- Voer `supabase/schema.sql` uit in **SQL Editor** (Supabase Dashboard)
- Maak een **Storage bucket** `tv-fotos` aan (public)

### 2. Credentials invullen

- `public/tv.html` — `SUPABASE_URL` en `SUPABASE_ANON_KEY` (al ingevuld)
- `public/admin.html` — `SUPABASE_SERVICE_KEY` invullen (service role key)

### 3. Deploy

Push naar GitHub → Netlify deployt automatisch.

### 4. Gebruiken

| URL | Functie |
|-----|---------|
| `/tv` | TV Display (volledig scherm) |
| `/admin` | Beheer (wachtwoord: `leap2024`) |
| `/` | Box TV WOD pagina (index.html) |

### 5. TV openen

Open `/tv` in Chrome kiosk mode:

```bash
google-chrome --kiosk --start-fullscreen "https://jouw-site.netlify.app/tv"
```

## Structuur

```
public/tv.html       TV display (Supabase anon key, read-only)
public/admin.html    Admin dashboard (Supabase service key, CRUD)
supabase/schema.sql  Database schema + seed data
netlify/functions/   Netlify serverless functions (SugarWOD proxy)
index.html           Box TV WOD pagina
```
