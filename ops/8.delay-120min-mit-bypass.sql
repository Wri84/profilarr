-- 120 Minuten Delay, damit nicht das erste (z.B. englische 1080p) Release gewinnt.
-- Sofort laden: hoechste Qualitaet oder Score >= 3800 (z.B. German DL 4K mit HDR/DV).
UPDATE delay_profiles SET preferred_protocol = 'prefer_usenet', usenet_delay = 120, torrent_delay = 120,
  bypass_if_highest_quality = 1, bypass_if_above_custom_format_score = 1, minimum_custom_format_score = 3800
WHERE name IN ('Aktuell (Radarr)', 'Aktuell (Sonarr)');
