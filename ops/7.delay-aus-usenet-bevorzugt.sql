-- Kein Delay, Usenet bevorzugt (einziger Indexer ist Usenet).
UPDATE delay_profiles SET preferred_protocol = 'prefer_usenet', usenet_delay = 0, torrent_delay = 0
WHERE name IN ('Aktuell (Radarr)', 'Aktuell (Sonarr)');
