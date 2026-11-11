-- Upgrades fuer Serien wieder an (Variante b): 1080p -> 4K und Score-Upgrades (z.B. fehlende deutsche Spur)
-- bis Remux-2160p / Score 5000. Filmprofil bleibt pausiert (Speicher).
UPDATE quality_profiles SET upgrades_allowed = 1,
  description = REPLACE(description, '- Upgrades derzeit pausiert (Speicher)', '- Upgrades aktiv bis Remux-2160p / Score 5000')
WHERE name = '4K DE-EN TV';
