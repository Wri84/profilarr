# 4K DE-EN – Profilarr-Datenbank

Eigenes Qualitätsprofil für Radarr und Sonarr (Profilarr 2.x, PCD-Format).

## Regeln

**Qualität** (oben = bevorzugt, Upgrades bis Remux-2160p):
Remux-2160p > Bluray-2160p > WEBDL-2160p — **Minimum 4K WEB-DL**, kein WEBRip, kein 1080p.

> **Upgrades sind derzeit pausiert** (`ops/3`, Speicher fehlt). Es werden nur Titel ohne Datei geladen.

**Sprache**
| Tonspuren | Ergebnis |
|---|---|
| Deutsch + Englisch / Originalsprache | bevorzugt (+3000, nur 2160p) |
| Nur Englisch | ok |
| Nur Deutsch, Deutsch ist Originalsprache | ok |
| Nur Deutsch (Synchro ohne Original) | gesperrt |
| Weder Deutsch noch Englisch | gesperrt |
| Deutsche Spur Line-/Mic-Dubbed (LD/MD) | gesperrt |

**Innerhalb einer 2160p-Qualitätsstufe:** Dolby Vision mit Fallback +1500, HDR10+ +1000, HDR +800
(UHD-BluRay ohne HDR-Tag +800), Atmos +500, Lossless-Audio +200.

**Gesperrt:** DV ohne HDR-Fallback, CAM/TS/TC/Screener, LD/MD, Stereo/Mono (wenn im Titel ausdrücklich genannt), 3D, Upscales, AV1, Extras, TRaSH-LQ-Gruppen.

Mindestscore 0, Upgrade bis Score 5000, Mindestschritt 500.

## Pflege
`ops/` wird mit `tools/gen.py` erzeugt. Neue Änderungen als neue Op-Datei (`ops/2.<beschreibung>.sql`) anlegen,
bestehende Ops nicht mehr ändern, sobald Profilarr sie angewendet hat.

## Serienprofil „4K DE-EN TV“
Gleiche Custom Formats und Scores wie oben, aber mit 1080p-Fallback:
Remux-2160p > Bluray-2160p > WEBDL-2160p > [1080p: Remux / Bluray / WEBDL gleichwertig] — kein WEBRip.
German DL wird auch bei 1080p bevorzugt; HDR/DV/Audio-Boni zählen nur bei 4K. Upgrades derzeit pausiert.

## Medienverwaltung & Delay-Profil
Profilarr verlangt für den Profil-Sync eine Auswahl unter *Media Management* und *Delay Profile*.
`ops/6` enthält dafür **„Aktuell (Radarr)“** und **„Aktuell (Sonarr)“**: eine 1:1-Kopie der Einstellungen,
die am 2026-11-06 in Radarr/Sonarr aktiv waren (Benennung, Propers/Repacks, MediaInfo, Qualitätsgrößen, Delay).
Ein Sync damit ändert also nichts.
