"""Erzeugt ops/6 aus den aktuellen Radarr/Sonarr-Einstellungen (Spiegelung, keine Aenderung)."""
import json, sqlite3, sys
db = sqlite3.connect(sys.argv[1]); out = []; w = out.append
def q(v): return "NULL" if v is None else ("'" + str(v).replace("'", "''") + "'" if isinstance(v, str) else str(int(v)))
apimap = {(a, api): qn for qn, a, api in db.execute("select quality_name, arr_type, api_name from quality_api_mappings")}
PROTO = {"usenet": "prefer_usenet", "torrent": "prefer_torrent"}
w("-- Spiegel der aktuellen Radarr/Sonarr-Einstellungen (Stand 2026-11-06), damit Profilarr den Profil-Sync zulaesst,")
w("-- ohne Benennung, Dateigroessen oder Delay zu veraendern. Generiert mit tools/gen_mm.py.")
for arr in ("radarr", "sonarr"):
    name = f"Aktuell ({arr.capitalize()})"
    d = json.load(open(f"cfg_{arr}_delayprofile.json"))
    d = [x for x in d if x["order"] == 2147483647][0]  # Default-Profil
    proto = PROTO[d["preferredProtocol"]]
    if not d["enableTorrent"]: proto = "only_usenet"
    if not d["enableUsenet"]: proto = "only_torrent"
    w(f"\n-- {arr}: Delay-Profil")
    w("INSERT INTO delay_profiles (name, preferred_protocol, usenet_delay, torrent_delay, bypass_if_highest_quality, bypass_if_above_custom_format_score, minimum_custom_format_score) VALUES "
      f"({q(name)}, {q(proto)}, {q(None if proto=='only_torrent' else d['usenetDelay'])}, {q(None if proto=='only_usenet' else d['torrentDelay'])}, "
      f"{q(d['bypassIfHighestQuality'])}, {q(d['bypassIfAboveCustomFormatScore'])}, {q(d['minimumCustomFormatScore'] if d['bypassIfAboveCustomFormatScore'] else None)});")
    n = json.load(open(f"cfg_{arr}_naming.json"))
    w(f"-- {arr}: Benennung")
    if arr == "radarr":
        w("INSERT INTO radarr_naming (name, rename, movie_format, movie_folder_format, replace_illegal_characters, colon_replacement_format) VALUES "
          f"({q(name)}, {q(n['renameMovies'])}, {q(n['standardMovieFormat'])}, {q(n['movieFolderFormat'])}, {q(n['replaceIllegalCharacters'])}, {q(n['colonReplacementFormat'])});")
    else:
        w("INSERT INTO sonarr_naming (name, rename, standard_episode_format, daily_episode_format, anime_episode_format, series_folder_format, season_folder_format, replace_illegal_characters, colon_replacement_format, custom_colon_replacement_format, multi_episode_style) VALUES "
          f"({q(name)}, {q(n['renameEpisodes'])}, {q(n['standardEpisodeFormat'])}, {q(n['dailyEpisodeFormat'])}, {q(n['animeEpisodeFormat'])}, {q(n['seriesFolderFormat'])}, {q(n['seasonFolderFormat'])}, "
          f"{q(n['replaceIllegalCharacters'])}, {q(n['colonReplacementFormat'])}, {q(n.get('customColonReplacementFormat') or None)}, {q(n['multiEpisodeStyle'])});")
    m = json.load(open(f"cfg_{arr}_mediamanagement.json"))
    w(f"-- {arr}: Media-Einstellungen")
    w(f"INSERT INTO {arr}_media_settings (name, propers_repacks, enable_media_info) VALUES ({q(name)}, {q(m['downloadPropersAndRepacks'])}, {q(m['enableMediaInfo'])});")
    w(f"-- {arr}: Qualitaetsdefinitionen (max 0 = unbegrenzt, wie in den Dictionarry-Vorlagen)")
    for qd in json.load(open(f"cfg_{arr}_qualitydefinition.json")):
        qn = apimap.get((arr, qd["quality"]["name"]))
        if not qn: print("skip", arr, qd["quality"]["name"], file=sys.stderr); continue
        w(f"INSERT INTO {arr}_quality_definitions (name, quality_name, min_size, max_size, preferred_size) VALUES ({q(name)}, {q(qn)}, {q(round(qd['minSize']))}, {q(round(qd.get('maxSize') or 0))}, {q(round(qd.get('preferredSize') or 0))});")
open(sys.argv[2], "w").write("\n".join(out) + "\n")
