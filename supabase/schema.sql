-- ============================================================
-- LEAP TV Display — Supabase Schema
-- ============================================================

-- Facts (wist-je-dat)
CREATE TABLE IF NOT EXISTS facts (
  id SERIAL PRIMARY KEY,
  tekst TEXT NOT NULL,
  actief BOOLEAN DEFAULT TRUE,
  volgorde INT DEFAULT 0
);

-- Events (agenda)
CREATE TABLE IF NOT EXISTS events (
  id SERIAL PRIMARY KEY,
  datum DATE NOT NULL,
  naam TEXT NOT NULL,
  tijd TIME,
  kleur TEXT DEFAULT '#ff5b35'
);

-- Nieuws (ticker / announcements)
CREATE TABLE IF NOT EXISTS nieuws (
  id SERIAL PRIMARY KEY,
  titel TEXT NOT NULL,
  body TEXT,
  actief BOOLEAN DEFAULT TRUE
);

-- Slides (spotlight rotatie)
CREATE TABLE IF NOT EXISTS slides (
  id SERIAL PRIMARY KEY,
  type TEXT NOT NULL CHECK (type IN ('tekst', 'foto-full', 'foto-split')),
  label TEXT,
  headline TEXT,
  subtext TEXT,
  foto_url TEXT,
  actief BOOLEAN DEFAULT TRUE,
  volgorde INT DEFAULT 0
);

-- Instellingen (key-value)
CREATE TABLE IF NOT EXISTS instellingen (
  sleutel TEXT PRIMARY KEY,
  waarde TEXT
);

-- ============================================================
-- INDEXES
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_events_datum ON events (datum);
CREATE INDEX IF NOT EXISTS idx_slides_volgorde ON slides (volgorde);
CREATE INDEX IF NOT EXISTS idx_facts_volgorde ON facts (volgorde);

-- ============================================================
-- RLS — publiek leesbaar, schrijven alleen service role
-- ============================================================
ALTER TABLE facts ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE nieuws ENABLE ROW LEVEL SECURITY;
ALTER TABLE slides ENABLE ROW LEVEL SECURITY;
ALTER TABLE instellingen ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Publiek lezen" ON facts FOR SELECT USING (true);
CREATE POLICY "Publiek lezen" ON events FOR SELECT USING (true);
CREATE POLICY "Publiek lezen" ON nieuws FOR SELECT USING (true);
CREATE POLICY "Publiek lezen" ON slides FOR SELECT USING (true);
CREATE POLICY "Publiek lezen" ON instellingen FOR SELECT USING (true);

-- ============================================================
-- SEED DATA
-- ============================================================

-- Facts
INSERT INTO facts (tekst, volgorde) VALUES
  ('LEAP werd opgericht in 2017 en is uitgegroeid tot de grootste CrossFit box in Limburg.', 1),
  ('Onze coaches hebben samen meer dan 40 certificaten en specialisaties.', 2),
  ('Een gemiddelde LEAP-atleet traint 3x per week en verbrandt zo''n 1.800 kcal.', 3);

-- Events
INSERT INTO events (datum, naam, tijd, kleur) VALUES
  ('2026-03-22', 'Partner WOD', '10:00', '#ff5b35'),
  ('2026-03-29', 'Weightlifting Clinic', '09:00', '#3a8fb5'),
  ('2026-04-05', 'LEAP Games — Kwalificatie', '08:00', '#ff5b35'),
  ('2026-04-19', 'Nutrition Workshop', '11:00', '#3a8fb5');

-- Nieuws
INSERT INTO nieuws (titel, body) VALUES
  ('Paasvakantie uurrooster', 'Van 7 t.e.m. 18 april geldt het vakantie-uurrooster. Check SugarWOD voor de aangepaste tijden.');

-- Slides
INSERT INTO slides (type, label, headline, subtext, volgorde) VALUES
  ('tekst', 'COMMUNITY', 'Train harder together', 'Elke dag opnieuw pushen we elkaar naar een hoger niveau. Geen ego''s, alleen resultaten.', 1),
  ('tekst', 'PROGRAMMA', 'Competitor Track', 'Nieuw: volg het Competitor-programma voor wie zich wil voorbereiden op competities.', 2),
  ('tekst', 'WELKOM', 'Nieuwe leden maart', 'Welkom aan alle nieuwe atleten die deze maand zijn gestart. Let''s go!', 3);

-- Instellingen
INSERT INTO instellingen (sleutel, waarde) VALUES
  ('qr_url', 'https://g.page/r/leaphasselt/review'),
  ('slide_interval', '8');
