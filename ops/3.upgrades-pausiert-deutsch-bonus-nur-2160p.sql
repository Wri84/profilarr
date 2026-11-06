-- 1) Upgrades voruebergehend pausiert (fehlender Speicher nach HDD-Defekt, Stand 2026-11-06).
--    Es werden nur Filme/Episoden ohne Datei geladen. Wieder einschalten: upgrades_allowed = 1.
UPDATE quality_profiles SET upgrades_allowed = 0 WHERE name = '4K DE-EN';

-- 2) Deutsch-Bonus (und der LD-Ausgleich) nur noch fuer 2160p:
--    keine 1080p -> 1080p Upgrades mehr, auch nicht wegen fehlender deutscher Spur.
--    Sperren (weder DE noch EN, nur Synchro) gelten weiterhin fuer alle Aufloesungen.
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE German DL (Deutsch + Englisch)', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE German DL (Deutsch + Englisch)', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE German DL (Deutsch + Original)', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE German DL (Deutsch + Original)', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE German DL (nur Titel)', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE German DL (nur Titel)', 'Nur 2160p', '2160p');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE Line/Mic Dubbed', 'Nur 2160p', 'resolution', 'all', 0, 1);
INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ('DE Line/Mic Dubbed', 'Nur 2160p', '2160p');
