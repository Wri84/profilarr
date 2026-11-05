"""Generates the PCD op file for the '4K DE-EN' profile.
Usage: python gen.py <dumpstarr.sqlite> <out.sql>
TRaSH LQ group lists are copied from the Dumpstarr DB at generation time."""
import sqlite3, sys

PROFILE = "4K DE-EN"
BAN = -100000

def q(s):
    return "NULL" if s is None else "'" + str(s).replace("'", "''") + "'"

ds = sqlite3.connect(sys.argv[1])
def ds_regex(name):
    return ds.execute("select pattern from regular_expressions where name=?", (name,)).fetchone()[0]

REGEX = {
    "DE Atmos": r"\b(ATMOS|DDPA)(\b|\d)",
    "DE TrueHD": r"True[ .-]?HD[ .-]?",
    "DE DTS-HD MA": r"\b(dts[-_. ]?(ma|hd([-_. ]?ma)?|xll))(\b|\d)",
    "DE DTS-X": r"\b(dts[-_. :]?x)\b(?!\d)",
    "DE Dolby Vision": r"\b(DV|Dovi|Dolby[ .]?Vision)\b",
    "DE Dolby Vision (Without Fallback)": r"(?<=^(?!.*(HDR|HULU|REMUX|BLU[-]?RAY)).*?)\b(DV|Dovi|Dolby[ .]?Vision)\b",
    "DE HDR": r"\b(HDR(10|(?!\d))|HLG|PQ(10)?)\b",
    "DE HDR10+": r"\bHDR10.?(\+|P(lus)?\b)",
    "DE SDR": r"\bSDR\b",
    "DE 3D": r"(?<=\b[12]\d{3}\b).*\b((Blu[-]?ray|BD)?3D|((H(alf)?|F(ull)?).?)?(O(ver)?.?U(nder)?|S(ide)?[\W_]?B(y)?.?S(ide)?))\b",
    "DE Movie Upscale": r"(?<=\b[12]\d{3}\b).*\b(AI(US)?[ ._-]?(Enhanced)?|Up[ ._-]?scale(d)?|Re[ ._-]?Grade(d)?|Topaz[ ._-]?Enhanced)\b",
    "DE TV Upscale": r"(?<=\b(?:S\d{1,3}|\d{3,4}p)\b).*\b(AI(US)?[ ._-]?(Enhanced)?|Up[ ._-]?scale(d)?|Re[ ._-]?Grade(d)?|Topaz[ ._-]?Enhanced)\b",
    "DE LQ Sources": r"\b(CAM|CAMRip|DVDSCR|HDCAM|HDSCR|HDTC|HDTS|PDVD|PreDVDRip|SCREENER|TELECINE|TELESYNC|TSRip|WORKPRINT)\b",
    "DE Line/Mic Dubbed": r"\b(LD|MD|AC3LD|AC3MD|E?AC3LD|E?AC3MD|DTSLD|DTSMD|Line[ .-]?Dubbed|Mic[ .-]?Dubbed)\b",
    "DE German DL Title": r"(?=.*\bGERMAN\b)(?=.*\b((?<!WEB[ ._-])[DM]L|MULTi|ENG(lish)?|KOR(ean)?|JPN|JAP|FRE(nch)?|ITA|SPA)\b)",
    "DE AV1": r"\bAV1\b",
    "DE Movie Extras": r"(?<=\b[12]\d{3}\b).*\b(Extra(s)?|Bonus|Deleted[ ._-]?Scene(s)?|Extended[ ._-]?Clip(s)?|Special[ ._-]?Feature(s)?)\b",
    "DE LQ Groups (Radarr)": ds_regex("TRaSH LQ (Radarr)"),
    "DE LQ Groups (Sonarr)": ds_regex("TRaSH LQ (Sonarr)"),
}

# Custom formats: name -> (description, score, [conditions])
# condition: (name, type, value, negate, required, arr_type)
C = lambda n, t, v, neg=0, req=1, arr="all": (n, t, v, neg, req, arr)
CFS = {
    # ---- Sprache ----
    "DE Weder Deutsch noch Englisch": ("Weder deutsche noch englische Tonspur -> nicht laden", BAN, [
        C("Kein Englisch", "language", "English", neg=1),
        C("Kein Deutsch", "language", "German", neg=1)]),
    "DE Nur Deutsch (Synchro)": ("Nur deutsche Tonspur, weder Englisch noch Originalsprache -> nicht laden. Deutsche Originalfilme sind nicht betroffen.", BAN, [
        C("Deutsch", "language", "German"),
        C("Kein Englisch", "language", "English", neg=1),
        C("Kein Original", "language", "Original", neg=1),
        C("Kein DL-Tag im Titel", "release_title", "DE German DL Title", neg=1)]),
    # Radarr/Sonarr werten Bedingungen gleichen Typs als Gruppe aus (alle required + mind. eine passend),
    # deshalb zwei getrennte CFs statt einem mit optionalem Englisch/Original.
    "DE German DL (Deutsch + Englisch)": ("Deutsch und Englisch", 3000, [
        C("Deutsch", "language", "German"),
        C("Englisch", "language", "English")]),
    "DE German DL (Deutsch + Original)": ("Deutsch und Originalsprache (nicht-englische Filme)", 3000, [
        C("Deutsch", "language", "German"),
        C("Original", "language", "Original"),
        C("Kein Englisch", "language", "English", neg=1)]),
    "DE German DL (nur Titel)": ("DL-Tag im Titel, aber Radarr/Sonarr hat nur Deutsch erkannt", 3000, [
        C("DL-Tag", "release_title", "DE German DL Title"),
        C("Kein Englisch", "language", "English", neg=1),
        C("Kein Original", "language", "Original", neg=1)]),
    "DE Line/Mic Dubbed": ("Deutsche Tonspur aus dem Kino mitgeschnitten -> hebt den Deutsch-Bonus auf", -3000, [
        C("Line/Mic Dubbed", "release_title", "DE Line/Mic Dubbed")]),
    # ---- HDR / DV ----
    "DE Dolby Vision": ("Dolby Vision (ohne Fallback wird separat gesperrt)", 1500, [
        C("Dolby Vision", "release_title", "DE Dolby Vision")]),
    "DE HDR10+": ("HDR10+", 1000, [C("HDR10+", "release_title", "DE HDR10+")]),
    "DE HDR": ("HDR10 / HDR / HLG / PQ (ohne HDR10+)", 800, [
        C("HDR", "release_title", "DE HDR"),
        C("Nicht HDR10+", "release_title", "DE HDR10+", neg=1)]),
    "DE UHD BluRay ohne HDR-Tag": ("UHD-BluRays sind praktisch immer HDR, deutsche Releases taggen das oft nicht", 800, [
        C("2160p", "resolution", "2160p"),
        C("BluRay", "source", "bluray", req=0),
        C("BluRay Raw", "source", "bluray_raw", req=0),
        C("Nicht HDR", "release_title", "DE HDR", neg=1),
        C("Nicht HDR10+", "release_title", "DE HDR10+", neg=1),
        C("Nicht SDR", "release_title", "DE SDR", neg=1)]),
    # ---- Audio ----
    "DE Atmos": ("Dolby Atmos", 500, [C("Atmos", "release_title", "DE Atmos")]),
    "DE Lossless Audio": ("TrueHD / DTS-HD MA / DTS:X", 200, [
        C("TrueHD", "release_title", "DE TrueHD", req=0),
        C("DTS-HD MA", "release_title", "DE DTS-HD MA", req=0),
        C("DTS-X", "release_title", "DE DTS-X", req=0)]),
    # ---- Sperren ----
    "DE Dolby Vision ohne Fallback": ("DV ohne HDR10-Fallback (lila/gruene Farben auf Nicht-DV-Geraeten)", BAN, [
        C("DV ohne Fallback", "release_title", "DE Dolby Vision (Without Fallback)"),
        C("Nicht HDR", "release_title", "DE HDR", neg=1),
        C("Nicht HDR10+", "release_title", "DE HDR10+", neg=1)]),
    "DE CAM / Screener": ("Kino-Mitschnitte", BAN, [
        C("LQ Source", "release_title", "DE LQ Sources")]),
    "DE 3D": ("3D", BAN, [C("3D", "release_title", "DE 3D")]),
    "DE Upscale": ("AI-/Upscales", BAN, [
        C("Movie Upscale", "release_title", "DE Movie Upscale", arr="radarr"),
        C("TV Upscale", "release_title", "DE TV Upscale", arr="sonarr")]),
    "DE AV1": ("AV1 (eingeschraenkte Abspielkompatibilitaet)", BAN, [C("AV1", "release_title", "DE AV1")]),
    "DE Extras": ("Bonusmaterial statt Film", BAN, [
        C("Movie Extras", "release_title", "DE Movie Extras", arr="radarr")]),
    "DE LQ Groups": ("TRaSH LQ-Gruppenliste (Kopie aus Dumpstarr)", BAN, [
        C("LQ Radarr", "release_group", "DE LQ Groups (Radarr)", req=0, arr="radarr"),
        C("LQ Sonarr", "release_group", "DE LQ Groups (Sonarr)", req=0, arr="sonarr")]),
}

ALL_Q = ["BR-DISK","Bluray-1080p","Bluray-2160p","Bluray-480p","Bluray-576p","Bluray-720p","CAM","DVD","DVD-R","DVDSCR",
         "HDTV-1080p","HDTV-2160p","HDTV-480p","HDTV-720p","REGIONAL","Raw-HD","Remux-1080p","Remux-2160p","SDTV","TELECINE",
         "TELESYNC","Unknown","WEBDL-1080p","WEBDL-2160p","WEBDL-480p","WEBDL-720p","WEBRip-1080p","WEBRip-2160p",
         "WEBRip-480p","WEBRip-720p","WORKPRINT"]
ENABLED = ["Remux-2160p","Bluray-2160p","WEBDL-2160p","WEBRip-2160p","Remux-1080p","Bluray-1080p","WEBDL-1080p","WEBRip-1080p"]

DESC = """4K bevorzugt (Remux > BluRay > WEB-DL > WEBRip), 1080p nur als Fallback.
- German DL bevorzugt, sonst Englisch; weder Deutsch noch Englisch wird nicht geladen
- Deutsch ohne Englisch nur, wenn Deutsch die Originalsprache ist oder die Originalspur dabei ist
- Dolby Vision (mit Fallback) > HDR10+ > HDR10, Atmos bevorzugt
- Keine Gruppen-Tiers: unbekannte (deutsche) Gruppen sind gleichberechtigt"""

out = ["-- 4K DE-EN: eigenes Profil fuer Radarr und Sonarr", "-- generiert mit gen.py", ""]
w = out.append
w("-- Regular expressions")
for n, p in REGEX.items():
    w(f"INSERT INTO regular_expressions (name, pattern) VALUES ({q(n)}, {q(p)});")
w("\n-- Custom formats")
for cf, (desc, score, conds) in CFS.items():
    w(f"INSERT INTO custom_formats (name, description) VALUES ({q(cf)}, {q(desc)});")
    for (n, t, v, neg, req, arr) in conds:
        w(f"INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ({q(cf)}, {q(n)}, {q(t)}, {q(arr)}, {neg}, {req});")
        if t == "language":
            w(f"INSERT INTO condition_languages (custom_format_name, condition_name, language_name) VALUES ({q(cf)}, {q(n)}, {q(v)});")
        elif t in ("release_title", "release_group"):
            w(f"INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ({q(cf)}, {q(n)}, {q(v)});")
        elif t == "source":
            w(f"INSERT INTO condition_sources (custom_format_name, condition_name, source) VALUES ({q(cf)}, {q(n)}, {q(v)});")
        elif t == "resolution":
            w(f"INSERT INTO condition_resolutions (custom_format_name, condition_name, resolution) VALUES ({q(cf)}, {q(n)}, {q(v)});")
        else:
            raise SystemExit(f"unknown type {t}")

w("\n-- Quality profile")
w(f"INSERT INTO quality_profiles (name, description, upgrades_allowed, minimum_custom_format_score, upgrade_until_score, upgrade_score_increment) "
  f"VALUES ({q(PROFILE)}, {q(DESC)}, 1, 0, 5000, 500);")
w(f"INSERT INTO quality_profile_languages (quality_profile_name, language_name, type) VALUES ({q(PROFILE)}, 'Any', 'simple');")
pos = 0
for qual in ENABLED + [x for x in ALL_Q if x not in ENABLED]:
    en = 1 if qual in ENABLED else 0
    uu = 1 if qual == ENABLED[0] else 0
    w(f"INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, position, enabled, upgrade_until) VALUES ({q(PROFILE)}, {q(qual)}, {pos}, {en}, {uu});")
    pos += 1
for cf, (_, score, _) in CFS.items():
    w(f"INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ({q(PROFILE)}, {q(cf)}, 'all', {score});")

open(sys.argv[2], "w").write("\n".join(out) + "\n")
