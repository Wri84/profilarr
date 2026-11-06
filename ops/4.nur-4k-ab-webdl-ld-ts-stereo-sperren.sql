-- Mindestqualitaet 4K WEB-DL: WEBRip-2160p und die 1080p-Gruppe deaktiviert.
-- LD/MD (Kino-Tonspur) wird immer gesperrt, CAM-Sperre um TS/TC ergaenzt,
-- ausdruecklich als Stereo/Mono getaggte Releases ohne Surround-Hinweis gesperrt.

-- ---- Qualitaeten ----
UPDATE quality_profile_qualities SET enabled = 0
WHERE quality_profile_name = '4K DE-EN' AND quality_name = 'WEBRip-2160p';
UPDATE quality_profile_qualities SET enabled = 0
WHERE quality_profile_name = '4K DE-EN' AND quality_group_name = '1080p';

UPDATE quality_profiles SET description = '4K ab WEB-DL (Remux > BluRay > WEB-DL), kein 1080p, kein WEBRip.
- German DL bevorzugt, sonst Englisch; weder Deutsch noch Englisch wird nicht geladen
- Deutsch ohne Englisch nur, wenn Deutsch die Originalsprache ist oder die Originalspur dabei ist
- Dolby Vision (mit Fallback) > HDR10+ > HDR10, Atmos bevorzugt
- Gesperrt: CAM/TS/TC, LD/MD, Stereo/Mono, DV ohne Fallback, 3D, Upscales, AV1, LQ-Gruppen'
WHERE name = '4K DE-EN';

-- ---- LD/MD: Sperre statt Ausgleich, fuer alle Aufloesungen ----
DELETE FROM condition_resolutions WHERE custom_format_name = 'DE Line/Mic Dubbed' AND condition_name = 'Nur 2160p';
DELETE FROM custom_format_conditions WHERE custom_format_name = 'DE Line/Mic Dubbed' AND name = 'Nur 2160p';
UPDATE custom_formats SET description = 'Deutsche Tonspur aus dem Kino mitgeschnitten (Line-/Mic-Dubbed) -> nicht laden'
WHERE name = 'DE Line/Mic Dubbed';
UPDATE quality_profile_custom_formats SET score = -100000
WHERE quality_profile_name = '4K DE-EN' AND custom_format_name = 'DE Line/Mic Dubbed';

-- ---- CAM/Screener: TS/TC als Kurzform (nur hinter der Jahreszahl, trifft nicht DTS) ----
INSERT INTO regular_expressions (name, pattern) VALUES ('DE TS/TC', '(?<=\b[12]\d{3}\b.*)\b(TS|TC)\b');
UPDATE custom_format_conditions SET required = 0
WHERE custom_format_name = 'DE CAM / Screener' AND name = 'LQ Source';
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE CAM / Screener', 'TS/TC', 'release_title', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('DE CAM / Screener', 'TS/TC', 'DE TS/TC');

-- ---- Stereo/Mono ----
INSERT INTO regular_expressions (name, pattern) VALUES ('DE Stereo/Mono', '(?<=\b([12]\d{3}|\d{3,4}p|S\d{1,3}(E\d{1,3})?)\b.*)((?<![0-9])[12][ ._]0(?![0-9])|\b(Stereo|Mono)\b)');
INSERT INTO regular_expressions (name, pattern) VALUES ('DE Surround', '(?<![0-9])[5-7][ ._]1(?![0-9])|\b(Atmos|DDPA|TrueHD|DTS[ ._-]?(HD|MA|X)|DTSHD|DTSMA)\b');
INSERT INTO custom_formats (name, description) VALUES ('DE Stereo/Mono', 'Titel nennt ausdruecklich 2.0/1.0/Stereo/Mono und keinen Surround-Ton -> nicht laden');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE Stereo/Mono', 'Stereo/Mono', 'release_title', 'all', 0, 1);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('DE Stereo/Mono', 'Stereo/Mono', 'DE Stereo/Mono');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('DE Stereo/Mono', 'Kein Surround', 'release_title', 'all', 1, 1);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('DE Stereo/Mono', 'Kein Surround', 'DE Surround');
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('4K DE-EN', 'DE Stereo/Mono', 'all', -100000);
