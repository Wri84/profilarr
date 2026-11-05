# 4K DE-EN – Profilarr-Datenbank

Eigenes Qualitätsprofil für Radarr und Sonarr (Profilarr 2.x, PCD-Format).

## Regeln

**Qualität** (oben = bevorzugt, Upgrades bis Remux-2160p):
Remux-2160p > Bluray-2160p > WEBDL-2160p > WEBRip-2160p > Remux-1080p > Bluray-1080p > WEBDL-1080p > WEBRip-1080p

**Sprache**
| Tonspuren | Ergebnis |
|---|---|
| Deutsch + Englisch / Originalsprache | bevorzugt (+3000) |
| Nur Englisch | ok |
| Nur Deutsch, Deutsch ist Originalsprache | ok |
| Nur Deutsch (Synchro ohne Original) | gesperrt |
| Weder Deutsch noch Englisch | gesperrt |
| Deutsche Spur Line-/Mic-Dubbed | kein Deutsch-Bonus (−3000) |

**Innerhalb einer Qualitätsstufe:** Dolby Vision mit Fallback +1500, HDR10+ +1000, HDR +800
(UHD-BluRay ohne HDR-Tag +800), Atmos +500, Lossless-Audio +200.

**Gesperrt:** DV ohne HDR-Fallback, CAM/Screener, 3D, Upscales, AV1, Extras, TRaSH-LQ-Gruppen.

Mindestscore 0, Upgrade bis Score 5000, Mindestschritt 500.

## Pflege
`ops/` wird mit `tools/gen.py` erzeugt. Neue Änderungen als neue Op-Datei (`ops/2.<beschreibung>.sql`) anlegen,
bestehende Ops nicht mehr ändern, sobald Profilarr sie angewendet hat.
