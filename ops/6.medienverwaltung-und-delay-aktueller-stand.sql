-- Spiegel der aktuellen Radarr/Sonarr-Einstellungen (Stand 2026-11-06), damit Profilarr den Profil-Sync zulaesst,
-- ohne Benennung, Dateigroessen oder Delay zu veraendern. Generiert mit tools/gen_mm.py.

-- radarr: Delay-Profil
INSERT INTO delay_profiles (name, preferred_protocol, usenet_delay, torrent_delay, bypass_if_highest_quality, bypass_if_above_custom_format_score, minimum_custom_format_score) VALUES ('Aktuell (Radarr)', 'prefer_torrent', 600, 600, 0, 0, NULL);
-- radarr: Benennung
INSERT INTO radarr_naming (name, rename, movie_format, movie_folder_format, replace_illegal_characters, colon_replacement_format) VALUES ('Aktuell (Radarr)', 1, '{Movie CleanTitle} {(Release Year)} {tmdb-{TmdbId}} {edition-{Edition Tags}} {[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[Mediainfo VideoCodec]}{-Release Group}', '{Movie CleanTitle} ({Release Year}) {tmdb-{TmdbId}}', 0, 'smart');
-- radarr: Media-Einstellungen
INSERT INTO radarr_media_settings (name, propers_repacks, enable_media_info) VALUES ('Aktuell (Radarr)', 'doNotPrefer', 1);
-- radarr: Qualitaetsdefinitionen (max 0 = unbegrenzt, wie in den Dictionarry-Vorlagen)
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Unknown', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WORKPRINT', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'CAM', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'TELESYNC', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'TELECINE', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'REGIONAL', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'DVDSCR', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'SDTV', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'DVD', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'DVD-R', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBDL-480p', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBRip-480p', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Bluray-480p', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Bluray-576p', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'HDTV-720p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBDL-720p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBRip-720p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Bluray-720p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'HDTV-1080p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBDL-1080p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBRip-1080p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Bluray-1080p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Remux-1080p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'HDTV-2160p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBDL-2160p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'WEBRip-2160p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Bluray-2160p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Remux-2160p', 0, 0, 1999);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'BR-DISK', 0, 0, 1990);
INSERT INTO radarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Radarr)', 'Raw-HD', 0, 0, 1990);

-- sonarr: Delay-Profil
INSERT INTO delay_profiles (name, preferred_protocol, usenet_delay, torrent_delay, bypass_if_highest_quality, bypass_if_above_custom_format_score, minimum_custom_format_score) VALUES ('Aktuell (Sonarr)', 'prefer_torrent', 600, 600, 0, 0, NULL);
-- sonarr: Benennung
INSERT INTO sonarr_naming (name, rename, standard_episode_format, daily_episode_format, anime_episode_format, series_folder_format, season_folder_format, replace_illegal_characters, colon_replacement_format, custom_colon_replacement_format, multi_episode_style) VALUES ('Aktuell (Sonarr)', 1, '{Series CleanTitleWithoutYear} ({Series Year}) - S{season:00}E{episode:00} - {Episode CleanTitle} {[Custom Formats]}{[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}', '{Series CleanTitleWithoutYear} ({Series Year}) - {Air-Date} - {Episode CleanTitle} {[Custom Formats]}{[Quality Full]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}', '{Series CleanTitleWithoutYear} ({Series Year}) - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle} {[Custom Formats]}{[Quality Full]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{MediaInfo AudioLanguages}{[MediaInfo VideoDynamicRangeType]}[{Mediainfo VideoCodec }{MediaInfo VideoBitDepth}bit]{-Release Group}', '{Series CleanTitleWithoutYear} ({Series Year}) {tvdb-{TvdbId}}', 'Season {season:00}', 0, 4, NULL, 5);
-- sonarr: Media-Einstellungen
INSERT INTO sonarr_media_settings (name, propers_repacks, enable_media_info) VALUES ('Aktuell (Sonarr)', 'doNotPrefer', 1);
-- sonarr: Qualitaetsdefinitionen (max 0 = unbegrenzt, wie in den Dictionarry-Vorlagen)
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Unknown', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'SDTV', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBRip-480p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBDL-480p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'DVD', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Bluray-480p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Bluray-576p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'HDTV-720p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'HDTV-1080p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Raw-HD', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBRip-720p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBDL-720p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Bluray-720p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBRip-1080p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBDL-1080p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Bluray-1080p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Remux-1080p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'HDTV-2160p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBRip-2160p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'WEBDL-2160p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Bluray-2160p', 5, 0, 999);
INSERT INTO sonarr_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ('Aktuell (Sonarr)', 'Remux-2160p', 5, 0, 999);
