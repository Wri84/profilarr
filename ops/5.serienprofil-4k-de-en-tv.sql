-- Eigenes Serienprofil: 4K bevorzugt, 1080p (WEB-DL/BluRay/Remux) als Fallback.
-- Gleiche Custom Formats und Scores wie das Filmprofil.

-- Deutsch-Bonus wieder fuer alle Aufloesungen: das Filmprofil hat kein 1080p mehr,
-- im Serienprofil soll German DL auch bei 1080p bevorzugt werden.
-- (Bei 1080p->1080p-Upgrades zu beachten, sobald Upgrades wieder aktiviert werden.)
DELETE FROM condition_resolutions WHERE condition_name = 'Nur 2160p' AND custom_format_name IN
  ('DE German DL (Deutsch + Englisch)', 'DE German DL (Deutsch + Original)', 'DE German DL (nur Titel)');
DELETE FROM custom_format_conditions WHERE name = 'Nur 2160p' AND custom_format_name IN
  ('DE German DL (Deutsch + Englisch)', 'DE German DL (Deutsch + Original)', 'DE German DL (nur Titel)');

INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment)
VALUES ('4K DE-EN TV', 'Serienprofil: 4K ab WEB-DL bevorzugt (Remux > BluRay > WEB-DL), 1080p WEB-DL/BluRay/Remux als Fallback.
- German DL bevorzugt (auch bei 1080p), sonst Englisch; weder Deutsch noch Englisch wird nicht geladen
- Dolby Vision (mit Fallback) > HDR10+ > HDR10, Atmos bevorzugt (nur 4K)
- Gesperrt: CAM/TS/TC, LD/MD, Stereo/Mono, DV ohne Fallback, 3D, Upscales, AV1, LQ-Gruppen
- Upgrades derzeit pausiert (Speicher)', 0, 0, 5000, 500);
INSERT INTO quality_profile_languages (quality_profile_name, language_name, type) VALUES ('4K DE-EN TV', 'Any', 'simple');

INSERT INTO quality_groups (quality_profile_name, name) VALUES ('4K DE-EN TV', '1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN TV', '1080p', 'Remux-1080p', 0);
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN TV', '1080p', 'Bluray-1080p', 1);
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN TV', '1080p', 'WEBDL-1080p', 2);

INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('4K DE-EN TV', 'Remux-2160p', NULL, 0, 1, 1);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('4K DE-EN TV', 'Bluray-2160p', NULL, 1, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('4K DE-EN TV', 'WEBDL-2160p', NULL, 2, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('4K DE-EN TV', NULL, '1080p', 3, 1, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until)
SELECT '4K DE-EN TV', q.name, NULL, 3 + ROW_NUMBER() OVER (ORDER BY q.name), 0, 0
FROM qualities q
WHERE q.name NOT IN ('Remux-2160p', 'Bluray-2160p', 'WEBDL-2160p', 'Remux-1080p', 'Bluray-1080p', 'WEBDL-1080p');

INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score)
SELECT '4K DE-EN TV', custom_format_name, arr_type, score
FROM quality_profile_custom_formats WHERE quality_profile_name = '4K DE-EN';
