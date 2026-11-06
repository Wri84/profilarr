-- 1080p-Qualitaeten gleichwertig (kein Upgrade 1080p -> 1080p ueber die Qualitaet)
-- und HDR/DV/Audio-Boni nur noch fuer 2160p. Innerhalb von 1080p entscheidet damit
-- nur noch die Sprache (German DL), d.h. 1080p->1080p nur bei fehlender deutscher Spur.

-- ---- Qualitaeten ----
DELETE FROM quality_profile_qualities
WHERE quality_profile_name = '4K DE-EN'
  AND quality_name IN ('Remux-1080p', 'Bluray-1080p', 'WEBDL-1080p', 'WEBRip-1080p');

INSERT INTO quality_groups (quality_profile_name, name) VALUES ('4K DE-EN', '1080p');
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN', '1080p', 'Remux-1080p', 0);
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN', '1080p', 'Bluray-1080p', 1);
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN', '1080p', 'WEBDL-1080p', 2);
INSERT INTO quality_group_members (quality_profile_name, quality_group_name, quality_name, position) VALUES ('4K DE-EN', '1080p', 'WEBRip-1080p', 3);

UPDATE quality_profile_qualities SET position = position - 3
WHERE quality_profile_name = '4K DE-EN' AND position > 7;

INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until)
VALUES ('4K DE-EN', NULL, '1080p', 4, 1, 0);

-- ---- Boni nur fuer 2160p ----
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE Dolby Vision', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE Dolby Vision', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE HDR10+', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE HDR10+', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE HDR', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE HDR', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE Atmos', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE Atmos', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE Lossless Audio', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE Lossless Audio', 'Nur 2160p', '2160p');
