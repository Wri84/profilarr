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
