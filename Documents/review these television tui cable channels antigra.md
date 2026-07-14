<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# review these television tui cable channels antigravity created in this pr. are they any good? are there much better existing ones? give me your top ten [https://github.com/pvnkmnk/terminal-dotfiles/pull/2/changes](https://github.com/pvnkmnk/terminal-dotfiles/pull/2/changes)

Here's a full review of the 10 cable channels in [PR \#2](https://github.com/pvnkmnk/terminal-dotfiles/pull/2/changes), plus how they stack up against the broader television ecosystem.

## Channel-by-Channel Review

The PR adds exactly 10 custom cable channels — here's an honest assessment of each :


| Channel | What It Does | Quality | Notes |
| :-- | :-- | :-- | :-- |
| **alias-explorer** | Lists shell aliases, previews expansion | ✅ Solid | Clean awk pipeline; genuinely useful daily |
| **clipboard-history** | Gets current clipboard via PowerShell | ⚠️ Weak | Only gets *current* clipboard, not history — misleadingly named; also WSL-only |
| **docker-compose** | Finds docker-compose.yml under `~/projects` | ✅ Good | `bat` preview is nice; hardcoded path limits portability |
| **env-vars** | Lists env vars, filters secrets | ✅ Great | The secret-scrubbing regex is a smart security touch |
| **git-worktree** | Lists git worktrees, previews recent commits | ✅ Excellent | Compact, practical for multi-worktree workflows |
| **pr-checkout** | Lists open PRs via `gh`, previews details | ✅ Excellent | Best channel in the set — `gh pr view` preview is slick |
| **process-manager** | Lists processes sorted by CPU | ⚠️ Mediocre | Preview just echoes a kill command string — not interactive |
| **snippets** | Finds markdown/txt files in `~/vault-memory/snippets` | ✅ Good | Path is personal/hardcoded — others need to adapt it |
| **ssh-hosts** | Parses `~/.ssh/config` for hosts | ✅ Good | Wildcard exclusion is thoughtful; solid everyday utility |
| **wsl-distro** | Lists WSL distros, previews `uname -a` | ⚠️ WSL-only | Niche; not useful outside Windows/WSL setups |

## How They Compare to Built-In Channels

Television ships with strong built-in channels covering files, text search, git repos, env vars, and shell history. Several of these PR channels overlap with or are weaker than what already exists:[^1_1][^1_2]

- **env-vars** already exists as a built-in — this version adds the secret filter, which is the only meaningful improvement
- **git-worktree** and **pr-checkout** are genuinely additive since they address specific Git workflows not covered by the built-in `git-repos` channel
- The official [`cable/` directory](https://github.com/alexpasmantier/television/tree/main/cable) in the upstream repo has grown to cover many common scenarios with better-structured TOML (including `[metadata]`, `[source]`, `[preview]`, and `[keybindings]` sections) that these channels don't use[^1_3]


## Structural Issue Worth Noting

The newer television channel format uses sectioned TOML blocks (`[source]`, `[preview]`, `[keybindings]`, `[actions]`) rather than the flat `command =` / `preview =` style used in all 10 of these channels. That older flat format may still work but it's worth updating for forward-compatibility and to enable keybinding/action hooks.[^1_3]

## My Top 10 Ranking

Ranked by uniqueness + practical daily value:

1. **pr-checkout** — genuinely irreplaceable for GitHub-heavy workflows
2. **git-worktree** — fills a real gap, great for monorepo/branch juggling
3. **alias-explorer** — simple and something you'll reach for constantly
4. **ssh-hosts** — clean implementation, everyday utility
5. **env-vars** — the secret-scrubbing makes it better than the built-in
6. **docker-compose** — useful if you work with Docker; path needs generalization
7. **snippets** — good concept, but the hardcoded `~/vault-memory/snippets` path makes it personal rather than shareable
8. **process-manager** — interesting idea but the preview is mostly useless as-is; a `ps -p $(echo {} | awk '{print $1}') -o pid,user,%cpu,%mem,cmd` would be far more useful
9. **wsl-distro** — works fine but extremely niche
10. **clipboard-history** — the name is a lie; it's just clipboard-current, and it's the weakest of the bunch

The **pr-checkout** and **git-worktree** channels are genuinely worth upstreaming to the official television `cable/` directory — they're not covered there and would be broadly useful.
<span style="display:none">[^1_10][^1_11][^1_12][^1_13][^1_14][^1_15][^1_4][^1_5][^1_6][^1_7][^1_8][^1_9]</span>

<div align="center">⁂</div>

[^1_1]: https://alexpasmantier.github.io/television/

[^1_2]: https://rustutils.com/tools/television/

[^1_3]: https://github.com/alexpasmantier/television

[^1_4]: https://crates.io/crates/television-channels/0.0.11

[^1_5]: https://www.reddit.com/r/commandline/comments/1hp2gjd/television_080/

[^1_6]: https://news.ycombinator.com/item?id=42651487

[^1_7]: https://www.youtube.com/watch?v=wwJA9mDqIVc

[^1_8]: https://laravel-news.com/television-tui

[^1_9]: https://www.freshports.org/textproc/television/

[^1_10]: https://www.reddit.com/r/linux/comments/1lyuybu/television_012_search_anything_from_your_terminal/

[^1_11]: https://terminaltrove.com/television/

[^1_12]: https://github.com/topics/television

[^1_13]: https://imfing.com/til/television-modern-fuzzy-finder-terminal/

[^1_14]: https://github.com/alexpasmantier/television/discussions

[^1_15]: https://github.com/topics/television?l=go\&o=asc\&s=stars


---

# okay now include popular community  channels in a top ten including the ones from the pr if they make it

Now I have the full picture of the official upstream [cable/unix](https://github.com/alexpasmantier/television/tree/main/cable/unix) directory — over 80 channels contributed by 96 contributors. Here's the definitive merged top 10:

## All-Time Top 10 Television Cable Channels

Ranked across the PR's 10 channels and the full upstream community library, judged on uniqueness, daily utility, and quality of implementation:

### 1. [gh-prs](https://github.com/alexpasmantier/television/blob/main/cable/unix/gh-prs.toml) — Upstream ⭐

The official upstream version of your PR's `pr-checkout` — it uses the full modern TOML format with `[source]`, `[preview]`, and `[actions]` sections, including a keybinding to open the PR in browser. Your PR's version does the same job but with a flat, older config style and no keybinding actions. This is the gold standard for GitHub workflow integration.

### 2. **pr-checkout** — Your PR 🔵

Your channel still earns the \#2 spot because the concept is independently strong and yours works today in your dotfiles. It's worth updating to match the upstream `[source]`/`[preview]` structure and adding a `ctrl-o` action to open in browser.

### 3. [git-log](https://github.com/alexpasmantier/television/blob/main/cable/unix/git-log.toml) — Upstream ⭐

One of the most-used community channels. Full syntax-highlighted commit log with fuzzy search — replaces `git log --oneline | fzf` entirely and is miles ahead of anything in the PR.

### 4. **git-worktree** — Your PR 🔵

Your PR's best original channel. The upstream has [git-worktrees.toml](https://github.com/alexpasmantier/television/blob/main/cable/unix/git-worktrees.toml) as well, but yours adds a `git log --oneline -5` preview that makes it genuinely more useful for quick context.

### 5. [man-pages](https://github.com/alexpasmantier/television/blob/main/cable/unix/man-pages.toml) — Upstream ⭐

Fuzzy search all installed man pages with a live rendered preview — one of the most universally loved channels in the community. Nothing in the PR touches this territory.

### 6. [zoxide](https://github.com/alexpasmantier/television/blob/main/cable/unix/zoxide.toml) — Upstream ⭐

Pairs television with zoxide's frecency-ranked directory history. If you use zoxide (and you should), this is your `cd` replacement and one of the highest-praised channels in discussions.

### 7. [todo-comments](https://github.com/alexpasmantier/television/blob/main/cable/unix/todo-comments.toml) — Upstream ⭐

Greps all `TODO`, `FIXME`, and `HACK` comments across a project, previews the file context, and lets you jump directly to the line in `$EDITOR`. Extremely practical for any codebase.

### 8. **alias-explorer** — Your PR 🔵

The upstream [alias.toml](https://github.com/alexpasmantier/television/blob/main/cable/unix/alias.toml) exists but the community version adds a `ctrl-e` action to edit the alias definition. Your version is leaner but functionally equivalent for daily lookup. Still earns a spot for being genuinely reach-for-it-daily useful.

### 9. [tldr](https://github.com/alexpasmantier/television/blob/main/cable/unix/tldr.toml) — Upstream ⭐

Fuzzy-search the entire TLDR pages library with live rendered previews. Replaces `tldr --search` entirely and is one of the most-appreciated community additions, especially for the kind of power-user terminal workflow you're building.

### 10. **env-vars** — Your PR 🔵

Edges out several upstream alternatives specifically because of the secret-scrubbing regex. The upstream [env.toml](https://github.com/alexpasmantier/television/blob/main/cable/unix/env.toml) doesn't filter secrets by default — that one security-conscious `grep -Ev` makes your version meaningfully better.

***

**Your PR contributes 4 channels to this top 10** — `pr-checkout`, `git-worktree`, `alias-explorer`, and `env-vars` — which is a solid hit rate. The channels that don't make the cut (`clipboard-history`, `wsl-distro`, `process-manager`, `snippets`, `docker-compose`, `ssh-hosts`) are either too niche, superseded by richer upstream versions, or have structural weaknesses worth fixing before they'd compete.

---

# okay produce another top ten that doesnt include anything sofar mentioned

Here’s a **second top 10**, excluding every channel named so far: all 10 PR channels, their upstream counterparts, plus `gh-prs`, `git-log`, `git-worktrees`, `man-pages`, `zoxide`, `todo-comments`, `tldr`, and the previously mentioned categories. These are the next most broadly useful community channels.

## Next 10 to Install

| Rank | Channel | Why it is strong | Best for |
| --: | :-- | :-- | :-- |
| 1 | **git-branch** | Fuzzy-select local branches with the appropriate Git context and actions. It is a more useful daily companion than memorizing branch names. | Any Git workflow |
| 2 | **git-diff** | Makes changed files and diffs searchable from a dedicated picker instead of forcing you to parse a full terminal diff. | Reviewing current work |
| 3 | **git-stash** | Turns forgotten stashes into discoverable, inspectable items rather than opaque `stash@{n}` entries. | Context-switching safely |
| 4 | **git-reflog** | Lets you search Git’s recovery history—particularly valuable after a bad rebase, reset, or accidental branch deletion. | Git recovery and investigation |
| 5 | **tmux-sessions** | Fuzzy-select existing tmux sessions, which is excellent if you maintain separate sessions for music, writing, research, and code. | Terminal multitasking |
| 6 | **recent-files** | Surfaces files by recent access, solving the common problem of knowing you worked on something “recently” but not remembering its path. | Notes, projects, drafts |
| 7 | **bash-history** | Searches shell-command history through Television’s interface; equivalent alternatives exist for Fish, Nushell, and Zsh. | Reusing long commands |
| 8 | **unicode** | Searches Unicode characters by name and copies/selects symbols—surprisingly useful for writing, documentation, commit messages, and creative work. | Writing and symbols |
| 9 | **pdf-files** | Searches PDF documents and gives you a focused document picker rather than manually navigating a file tree. | Research and archives |
| 10 | **trash** | Provides a searchable view of deleted files, making recovery less error-prone than browsing the trash directory manually. | Safer file management |

## Best Fits for You

For a mixed research, social-service, and music/creative workflow, I would install these first:

- **`recent-files`**: probably the strongest non-code option—good for bouncing among notes, lyrics, PDFs, client-safe templates, and project drafts.
- **`pdf-files`**: useful for literature, reports, funding documents, manuals, or reference material that is already locally archived.
- **`unicode`**: practical for typography, lyric sheets, structured notes, arrows, bullets, music-adjacent symbols, and general writing.
- **`tmux-sessions`**: worthwhile if you already use tmux or want a clean separation between ongoing environments.
- **`git-reflog`** and **`git-stash`**: especially worth adding if Antigravity is generating or changing code across multiple branches, because they make undoing and locating prior states far less stressful.


## Honourable Mentions

- **`git-files`** for fast filtering of only tracked project files.
- **`git-tags`** for browsing releases or checkpoints.
- **`npm-scripts`** for projects with numerous package scripts.
- **`make-targets`** or **`just-recipes`** if your projects use Makefiles or `justfile`s.
- **`docker-containers`**, **`docker-images`**, and **`docker-volumes`** if Docker is a regular part of your development setup.
- **`journal`** for browsing systemd logs, useful on Linux/WSL when troubleshooting services.
- **`ports`** for seeing which processes own network ports—excellent when a local server refuses to start because its port is busy.

The most compelling “third batch” for your particular setup would be **`recent-files`**, **`unicode`**, **`pdf-files`**, **`git-reflog`**, and **`tmux-sessions`**.

---

# okay now do a top ten music focus

For a musician, the most valuable Television channels are less about playback and more about **finding material, managing a library, starting sessions, and navigating creative assets**. Since the upstream community library has relatively few dedicated music channels, the strongest top ten is a practical mix of existing community channels and music-specific channels worth adding to your dotfiles. Television is designed for custom searchable data sources, so this is exactly the right kind of use case.[^4_1][^4_2]

## Music-Focused Top Ten

| Rank | Channel | Status | Why it matters |
| --: | :-- | :-- | :-- |
| 1 | **sample-library** | New custom channel | Fuzzy-search samples, loops, stems, one-shots, field recordings, and presets across your library; preview metadata or play the selection. This is the highest-value music channel by far. |
| 2 | **project-sessions** | New custom channel | Lists Ableton, REAPER, Bitwig, FL Studio, Logic, or other project files and opens a selected session in its associated DAW. |
| 3 | **recent-files** | Community | Excellent for reopening the last song session, exported mix, lyric draft, contract, reference file, or sample you touched. |
| 4 | **audio-files** | New custom channel | A focused browser for `.wav`, `.aif`, `.aiff`, `.flac`, `.mp3`, `.m4a`, and `.ogg`, with duration, bitrate, and tags in preview. Use it for quick listening and cataloguing. |
| 5 | **lyrics-notes** | New custom channel | Searches lyrics, song ideas, chord charts, artist statements, release plans, and set-list notes—especially useful if they live as Markdown, plain text, or Obsidian notes. |
| 6 | **spotify-playlists** | New custom channel | Searches your playlists, albums, or saved tracks through Spotify’s CLI/API tooling and opens or queues the selected result. Best if Spotify is part of your reference-listening workflow. |
| 7 | **reference-tracks** | New custom channel | A curated picker for tracks used to assess arrangement, loudness, vocal treatment, mixing choices, or genre conventions. Much better than hunting through a giant music library mid-session. |
| 8 | **unicode** | Community | Useful for lyric sheets, credits, promotional copy, social captions, arrows/bullets in notes, and finding special typographic characters without memorising Unicode code points. |
| 9 | **pdf-files** | Community | A good home for sheet music, lead sheets, contracts, grant materials, production manuals, release checklists, and research PDFs. |
| 10 | **git-reflog** | Community | If you version lyrics, configs, code for music tools, generative patches, Max/MSP projects, or project metadata, this is a powerful recovery interface after an accidental reset or rebase. |

## The Four to Build First

These would deliver the most immediate value in a musician’s terminal workflow:

1. **`sample-library`** — build it around the directories that hold your samples and presets, not your whole home folder. Use `fd` for discovery, `ffprobe` for metadata, and `mpv` or your preferred audio player for a preview/action.
2. **`project-sessions`** — scan only your music-project roots and include extensions matching your DAW. This becomes a fast “open the song I was working on” launcher.
3. **`lyrics-notes`** — point it at a dedicated folder or vault subfolder, with `ripgrep` to search file contents rather than merely filenames. That lets you find a song from one remembered lyric line.
4. **`reference-tracks`** — keep a small, intentionally curated folder or text/CSV manifest. The point is not to search every track you own; it is to instantly surface reliable sonic references while producing or mixing.

## Recommended Stack

For your WSL/terminal-oriented setup, I would use this division of responsibility:

- **Television**: discovery and selection—projects, samples, lyrics, reference tracks, releases, documents.
- **`fd`**: fast filename collection for sample and project directories.
- **`ripgrep`**: full-text lyric, note, credit, and metadata search.
- **`ffprobe`**: audio duration, codec, sample-rate, channel count, and tag previews.
- **`mpv`**: terminal-triggerable auditioning of a selected sound or reference track.
- **`playerctl`**: optional control of an existing desktop player; useful if you do not want Television launching a separate audio player.
- **Git**: version lyrics, notes, preset text files, session templates, generative-music code, and release documentation—not necessarily huge binary DAW project folders.

This complements the technical, keyboard-first workspace you are already building: Television acts as the searchable front door, while the DAW remains the actual creation environment.[^4_2]

## One Caution

Do not make a channel scan your entire audio archive on every invocation. Music folders can contain tens of thousands of files, and recursive metadata extraction—especially `ffprobe` for every item—will make the picker feel slow. Instead, use `fd` for immediate candidate discovery, calculate rich metadata only in the preview for the currently highlighted item, and keep large sample packs separated from your actively used library.
<span style="display:none">[^4_3][^4_4][^4_5][^4_6][^4_7][^4_8][^4_9]</span>

<div align="center">⁂</div>

[^4_1]: https://github.com/alexpasmantier/television/blob/main/docs/channels.md

[^4_2]: https://github.com/alexpasmantier/television

[^4_3]: https://github.com/alexpasmantier/television/discussions

[^4_4]: https://github.com/alexpasmantier/television/pulls

[^4_5]: https://github.com/alexpasmantier/television/wiki

[^4_6]: https://github.com/alexpasmantier/television/blob/main/README.md

[^4_7]: https://github.com/alexpasmantier/television/issues/16

[^4_8]: https://github.com/alexpasmantier/television/issues

[^4_9]: https://github.com/alexpasmantier/television/activity


---

# okay now list top ten for personal kknowledge management, including already existing popular community solutions

For your `vault-memory` / Obsidian-style setup, the best Television channels are ones that make **retrieval**, **capture targets**, **task triage**, and **reference lookup** fast. Television’s strength is searching arbitrary local data sources in real time, while community cable channels are intended to extend it beyond the built-ins.[^5_1][^5_2]

## PKM Top Ten

| Rank | Channel | Existing or custom | Why it belongs |
| --: | :-- | :-- | :-- |
| 1 | **vault-search** | Custom | Full-text search across Markdown notes using `rg`, with contextual previews and an action that opens the selected note at the matching line in Neovim or Obsidian. This should be your primary PKM channel. |
| 2 | **recent-files** | Community | Brings forward the notes, PDFs, lyric drafts, research files, and project documents you actually touched lately, solving the “where was that?” problem. |
| 3 | **backlinks** | Custom | Given a selected note, list every note that links to it via `[[wiki links]]` or Markdown links. This is one of the most valuable ways to expose a vault’s implicit structure. |
| 4 | **tasks** | Custom | Search unchecked tasks across the vault, grouped or filtered by due date, project, context, or tag. A Markdown-based `- [ ]` convention is enough to make this immediately useful. |
| 5 | **tags** | Custom | Extract and fuzzy-search tags from your notes, then list the notes containing the selected tag. It turns a loose tag system into a navigable index. |
| 6 | **daily-notes** | Custom | Lists daily notes by date and opens today’s note or a previous day’s entry. It is a low-friction bridge between journalling, work logs, meetings, and idea capture. |
| 7 | **bookmarks** | Community/custom | Searches a bookmark store such as Buku, Linkding exports, browser bookmarks, or a Markdown/CSV link list, then opens the selected URL. This is ideal for research and reference collection. |
| 8 | **snippets** | Your PR | Your existing `snippets` channel is a good fit if you turn `~/vault-memory/snippets` into a carefully maintained library of prompts, templates, boilerplate, recurring messages, citations, and commands. Its current implementation searches `.md` and `.txt` files and previews them with `bat`. |
| 9 | **PDF library** | Community/custom | Searches research papers, reports, manuals, scanned documents, and reference material. Pair it with `pdftotext` or a full-text index if filename-only search becomes limiting. |
| 10 | **git-log** | Community | If your vault is versioned with Git, this gives you a searchable history of changed notes and a reliable way to recover overwritten ideas or inspect when a claim changed. |

## Best Existing Solutions

The community-maintained catalog is useful, but for PKM the high-value solutions are often *patterns* rather than a one-size-fits-all channel. Television comes with standard general-purpose discovery channels, and its release history shows ongoing expansion of available channels and actions.[^5_3][^5_4]


| Solution | What it solves | Recommendation |
| :-- | :-- | :-- |
| **`recent-files`** | Finds recently accessed knowledge assets without relying on tags or folder discipline | Install unchanged |
| **`pdf-files`** | Browses a local research/document library | Install if you retain PDFs locally |
| **`unicode`** | Finds symbols for notes, structured outlines, academic writing, and creative work | Nice-to-have |
| **`git-log`** | Finds prior states of versioned notes | Install if `vault-memory` is a Git repo |
| **`snippets`** | Opens reusable note fragments and templates | Keep your PR version, but make its root configurable |
| **`ripgrep`-backed note search** | Searches *inside* notes, not just filenames | Build this even if an upstream file-search channel exists |

## What to Build

The first five custom channels should share one configurable variable—e.g. `VAULT_DIR="$HOME/vault-memory"`—rather than hardcoding paths. Your current `snippets` entry hardcodes `~/vault-memory/snippets`, which is fine for personal use but makes a dotfiles repo less portable.

1. **`vault-search`**: `rg --line-number --no-heading --smart-case . "$VAULT_DIR"`; preview the matching note with surrounding context; open at line on selection.
2. **`tasks`**: search for unchecked Markdown tasks with `rg --line-number '^\s*[-*]\s+\[ \]' "$VAULT_DIR"`; exclude completed `- [x]` items and optionally filter by project folders.
3. **`backlinks`**: select a note name, then search the vault for `[[note-name]]`, plus conventional Markdown links. This turns individual notes into hubs.
4. **`tags`**: extract `#tags` through `rg -o`, deduplicate with `sort -u`, then feed the selected tag back into `rg` to retrieve matching notes.
5. **`daily-notes`**: locate your daily-note directory, sort newest first, preview a selected day, and bind an action for opening or creating today’s file.

## Recommended Order

For your terminal-first, Neovim-connected vault, I would implement them in this order:

1. **`vault-search`** — biggest immediate return.
2. **`tasks`** — converts scattered commitments into a searchable action list.
3. **`daily-notes`** — makes regular capture nearly frictionless.
4. **`backlinks`** — adds navigation based on relationships rather than folders.
5. **`tags`** — only once your tag naming is consistent enough to avoid clutter.
6. **Upgrade `snippets`** — retain it as a curated, reusable knowledge component rather than treating it as a generic note browser.

The key distinction is: **folders hold information, `vault-search` retrieves it, tasks surface commitments, and backlinks reveal relationships**. That is a credible terminal-native PKM system without duplicating what Obsidian and `obsidian.nvim` already do well.[^5_5]
<span style="display:none">[^5_10][^5_11][^5_6][^5_7][^5_8][^5_9]</span>

<div align="center">⁂</div>

[^5_1]: https://github.com/alexpasmantier/television

[^5_2]: https://crates.io/crates/television-channels/0.0.11

[^5_3]: https://alexpasmantier.github.io/television/

[^5_4]: https://github.com/alexpasmantier/television/releases

[^5_5]: https://www.perplexity.ai/search/541479f4-64b0-4fa1-a4e5-e540aa874400

[^5_6]: https://github.com/alexpasmantier/television/discussions

[^5_7]: https://github.com/alexpasmantier/television/activity

[^5_8]: https://github.com/alexpasmantier/television/pulls

[^5_9]: https://github.com/alexpasmantier/television/issues

[^5_10]: https://www.youtube.com/watch?v=wwJA9mDqIVc

[^5_11]: https://www.reddit.com/r/linux/comments/1lyuybu/television_012_search_anything_from_your_terminal/


---

# okay now find the top ten channels for agentic dev workflows

For an agentic development workflow, the best Television channels reduce the “orientation cost” before an agent acts: select the right repository, inspect its state, find the relevant task or failure, and launch a reproducible command. That matches your WSL-first, chezmoi-managed, `mise`-based workspace better than treating Television as a generic file picker.[^6_1]

## Agentic Dev Top Ten

| Rank | Channel | Existing or custom | Why it matters for agents |
| --: | :-- | :-- | :-- |
| 1 | **git-worktree** | Your PR | The strongest channel for parallel agent work: choose an isolated worktree, preview recent commits, then start an agent there without risking the main checkout. Your implementation lists worktree paths and previews the latest five commits. |
| 2 | **repository launcher** | Community/custom | Fuzzy-select a repo, preview its `README`, Git status, and `mise.toml`, then launch the editor, terminal session, or coding agent in the selected root. This is the control-plane channel. |
| 3 | **GitHub pull requests** | Community / your `pr-checkout` | Agents frequently produce branches and PRs; a PR picker lets you inspect title, checks, review state, diff, and then check out or open the selected PR. Your PR already has a useful `gh pr list` source and `gh pr view` preview. |
| 4 | **GitHub issues** | Community/custom | Search open issues with labels, assignees, and titles; preview the body and comments; launch an agent with the issue URL/number as the scoped task. This is much safer than vague “fix the bug” prompts. |
| 5 | **mise tasks** | Custom | Enumerate the project’s declared `mise` tasks, show task definitions or help as preview, and run the selected task. It gives both you and an agent a shared, versioned command surface. [^6_2][^6_3] |
| 6 | **Git status / changed files** | Community | Pick modified, untracked, or staged files and preview the diff. Use it before and after an agent run to review precisely what changed. |
| 7 | **Git diff** | Community | Search changed hunks or files and view the live patch. This should be your first review stop before accepting an agent’s implementation. |
| 8 | **test runner / failed tests** | Custom | Present the last failed test output—or project test targets—then allow rerunning the selected failure. It turns validation into a searchable feedback loop instead of scrolling terminal history. |
| 9 | **GitHub Actions runs** | Custom | List recent CI runs via `gh run list`, preview failed-job logs, and offer actions to open, watch, rerun, or supply failure context to an agent. This closes the local-to-CI loop. |
| 10 | **ports and processes** | Community/custom | Find local services by port or PID, preview the owning command, and offer safe actions such as inspect logs, open the localhost URL, or terminate a stale dev server. This is especially useful when agents spawn servers and leave them behind. |

## The Five Essential Builds

The community catalog provides broad Git, process, and terminal-discovery patterns, while Television’s custom-channel model is intended for exactly these task-specific sources.  For your setup, the biggest missing value is in channels that encode **your project contract**—repos, `mise` tasks, CI, and agent sessions—rather than generic operating-system pickers.[^6_4]

1. **`repos`**: Search a curated projects root, preview `git status --short`, latest commit, `README.md`, plus `mise tasks`; actions should open the folder in Neovim/Zed, start a Zellij layout, or launch your preferred coding agent.
2. **`mise-tasks`**: Source from `mise tasks --json` when available, or `mise tasks`; preview the task description and command; run only explicitly selected tasks. This makes the project’s declared toolchain and task system the agent’s single source of operational truth.[^6_2]
3. **`gh-issues`**: Source from `gh issue list --json number,title,labels,updatedAt`; preview `gh issue view <number> --comments`; an action can copy a structured task brief into the clipboard or invoke the agent with the issue number.
4. **`gh-runs`**: Source from `gh run list`; preview `gh run view <id> --log-failed`; provide actions for browser/open, watch, or rerun. Never default to rerunning workflows automatically.
5. **`agent-sessions`**: List running Zellij/tmux sessions, working directories, and optionally last activity. The action should attach rather than create a duplicate agent process, preventing accidental parallel changes in the same checkout.

## Safer Agent Loop

Use these channels in a deliberate sequence:

1. Select **repository** or **worktree**.
2. Select a bounded task from **GitHub issues** or a locally maintained task source.
3. Run or instruct the agent through a defined **`mise` task**.
4. Inspect **Git status**, then **Git diff**.
5. Run the selected **test task** and inspect failures.
6. Check **GitHub Actions runs** only after pushing or opening a PR.
7. Use **ports and processes** to clean up preview servers, test services, or stuck agent-launched processes.

This produces a workflow where the agent has a scoped working directory and reproducible commands, while you retain deliberate review gates before code is merged. The existing `git-worktree` and PR channels from your PR deserve to remain core parts of that system.[^6_5]
<span style="display:none">[^6_6]</span>

<div align="center">⁂</div>

[^6_1]: https://www.perplexity.ai/search/541479f4-64b0-4fa1-a4e5-e540aa874400

[^6_2]: https://www.perplexity.ai/search/872de872-9223-4c4d-a00e-787c3e24b51c

[^6_3]: https://www.perplexity.ai/search/224cc9f5-d437-4252-a858-43f1885ac3cd

[^6_4]: https://github.com/alexpasmantier/television

[^6_5]: https://www.perplexity.ai/search/1d791f85-7b93-446f-ac30-52a3e18c124e

[^6_6]: https://github.com/alexpasmantier/television/issues


---

# and last but not least find the top ten community channels for homelab applications

For homelab use, prioritize channels that make your infrastructure **observable, selectable, and safe to operate**: containers, Compose stacks, services, logs, ports, SSH targets, and backups. Television’s community channels can be refreshed with `tv update-channels`, and its cable model supports adding the homelab-specific gaps as local configs.[^7_1][^7_2]

## Homelab Top Ten

| Rank | Channel | Existing or custom | Why it earns the spot |
| --: | :-- | :-- | :-- |
| 1 | **docker-containers** | Community | Search containers by name, image, status, and exposed ports; preview `docker inspect` or recent logs; actions should be limited to logs, start/stop, restart, and shell access. This is the single best all-round homelab channel. |
| 2 | **docker-compose** | Your PR / community pattern | Find Compose files, preview them with `bat`, and jump into the stack’s directory. Your PR version does this cleanly but hardcodes `~/projects`; point it at a configurable `HOMELAB_DIR` instead. |
| 3 | **docker-images** | Community | Browse local images, sizes, tags, and creation dates; helpful for identifying stale images before pruning. |
| 4 | **docker-volumes** | Community | Inspect named volumes and their mounts before deleting anything. This is an essential safety channel because homelab data often lives in volumes rather than containers. |
| 5 | **SSH hosts** | Your PR / community pattern | Select a server, NAS, VM, Raspberry Pi, or VPS from `~/.ssh/config`, preview its configuration, then connect. Your channel excludes wildcard entries and previews matching config lines, which is a good baseline. |
| 6 | **systemd services** | Community/custom | Search host services, preview `systemctl status` and recent journal lines, then start/stop/restart only after deliberate selection. Especially useful for reverse proxies, backup timers, media services, and local automation. |
| 7 | **journal / service logs** | Community | Search system logs by unit, severity, or time; live previews are much faster than repeatedly formulating long `journalctl` commands. |
| 8 | **ports** | Community | Find which process owns a listening port, preview its command and PID, and open the service URL when appropriate. It is invaluable for debugging “why can’t I bind to 8080?” and identifying forgotten services. |
| 9 | **Kubernetes contexts and workloads** | Custom/community pattern | Search contexts, namespaces, pods, deployments, and Helm releases; preview `kubectl describe` or recent logs. Keep mutating actions explicitly bound and confirmation-gated. |
| 10 | **backup status** | Custom | Surface the last successful backup, exit status, duration, destination, and age for Restic, Borg, Kopia, or your chosen tool. This is more valuable than another generic picker because it answers the homelab question that matters: “Can I restore?” |

## Install First

For your current WSL2 plus Docker Desktop environment, start with the Docker and SSH layer rather than Kubernetes. Docker Desktop’s `docker-desktop` WSL distribution is an internal appliance and not an appropriate place for personal configuration or routine administration; manage Docker from your normal Ubuntu WSL environment instead.[^7_3]

1. **`docker-containers`** — container health, logs, and controlled operations.
2. **`docker-compose`** — Compose-stack discovery; revise your PR implementation to replace `~/projects` with a configurable homelab root.
3. **`ssh-hosts`** — fastest route from one workstation to the machines that actually host your services.
4. **`ports`** — diagnose local service conflicts and discover running web UIs.
5. **`backup-status`** — build this before sophisticated orchestration channels.

## Safety Rules

A homelab picker should be **read-first and action-second**. A preview should explain the selected resource; destructive actions should never be the default Enter action.

- Make default selection open logs, inspect output, or a status screen.
- Bind start, stop, restart, shell, prune, delete, apply, and rollback to explicit keys.
- Do not expose `docker system prune`, volume deletion, `kubectl delete`, or broad `kubectl apply` as one-keystroke defaults.
- Use your `~/.ssh/config` aliases rather than embedding hostnames, users, and IP addresses in a dotfiles repository.
- Store local roots such as `HOMELAB_DIR` in an environment variable or chezmoi template value, not inside the shared cable definition.


## High-Leverage Additions

After the core ten, the next useful channels are:

- **Compose stack status**: find every Compose project and show `docker compose ps` for the selected directory.
- **Reverse-proxy routes**: list Caddy, Traefik, or Nginx virtual hosts and their upstreams.
- **Uptime monitor status**: query Uptime Kuma or another monitoring API and show failing monitors first.
- **DNS inventory**: search Pi-hole, AdGuard Home, or local DNS records.
- **NAS / mount health**: list mounts and free space with a threshold warning.
- **TLS certificate expiry**: list domains and expiry dates, sorted with the closest expiries first.
- **Infrastructure-as-code targets**: select Terraform/OpenTofu modules or Ansible inventories, preview the relevant plan/inventory, and keep apply/play actions deliberately explicit.

Television is most useful here as a unified selection layer over familiar CLI tools—not as a replacement for Docker, SSH, monitoring, or backup tooling themselves.[^7_4][^7_5]
<span style="display:none">[^7_10][^7_6][^7_7][^7_8][^7_9]</span>

<div align="center">⁂</div>

[^7_1]: https://alexpasmantier.github.io/television/getting-started/quickstart/

[^7_2]: https://news.ycombinator.com/item?id=42651487

[^7_3]: https://www.perplexity.ai/search/a14bfd78-9ba6-4759-9983-2a14ab6736ce

[^7_4]: https://github.com/alexpasmantier/television

[^7_5]: https://crates.io/crates/television-channels/0.0.11

[^7_6]: https://www.reddit.com/r/linux/comments/1lyuybu/television_012_search_anything_from_your_terminal/

[^7_7]: https://www.youtube.com/watch?v=wwJA9mDqIVc

[^7_8]: https://github.com/clabland/go-homelab-cable

[^7_9]: https://github.com/topics/homelab?l=python\&o=desc\&s=forks

[^7_10]: https://daily.dev/posts/fzf-was-enough-then-i-found-television--habgcxw9p


---

```
# <q>RankChannelExisting or customWhy it earns the spot1docker-containersCommunitySearch containers by name, image, status, and exposed ports; preview docker inspect or recent logs; actions should be limited to logs, start/stop, restart, and shell access. This is the single best all-round homelab channel.2docker-composeYour PR / community patternFind Compose files, preview them with bat, and jump into the stack’s directory. Your PR version does this cleanly but hardcodes ~/projects; point it at a configurable HOMELAB_DIR instead.3docker-imagesCommunityBrowse local images, sizes, tags, and creation dates; helpful for identifying stale images before pruning.4docker-volumesCommunityInspect named volumes and their mounts before deleting anything. This is an essential safety channel because homelab data often lives in volumes rather than containers.5SSH hostsYour PR / community patternSelect a server, NAS, VM, Raspberry Pi, or VPS from ~/.ssh/config, preview its configuration, then connect. Your channel excludes wildcard entries and previews matching config lines, which is a good baseline.6systemd servicesCommunity/customSearch host services, preview systemctl status and recent journal lines, then start/stop/restart only after deliberate selection. Especially useful for reverse proxies, backup timers, media services, and local automation.7journal / service logsCommunitySearch system logs by unit, severity, or time; live previews are much faster than repeatedly formulating long journalctl commands.8portsCommunityFind which process owns a listening port, preview its command and PID, and open the service URL when appropriate. It is invaluable for debugging “why can’t I bind to 8080?” and identifying forgotten services.9Kubernetes contexts and workloadsCustom/community patternSearch contexts, namespaces, pods, deployments, and Helm releases; preview kubectl describe or recent logs. Keep mutating actions explicitly bound and confirmation-gated.10backup statusCustomSurface the last successful backup, exit status, duration, destination, and age for Restic, Borg, Kopia, or your chosen tool. This is more valuable than another generic picker because it answers the homelab question that matters: “Can I restore?”</q> okay now alright now consolidate the whole list to one table like the one you made for the homelab top ten. deduplicate any double entries
```

Below is one consolidated, deduplicated catalogue from every list we discussed: PR channels, upstream/community channels, and the proposed high-value custom channels for music, PKM, agentic development, and homelab work. I merged direct overlaps—for example, `docker-compose`, `ssh-hosts`, `git-worktree`, `pr-checkout`/`gh-prs`, `recent-files`, and the various Git inspection channels—into one entry each. Your existing PR contributes useful foundations in Git worktrees, PRs, snippets, SSH, Docker Compose discovery, and secret-filtered environment variables.

## Consolidated Channel Catalogue

| Priority | Channel | Existing or custom | Primary domain | Why it earns a place |
| --: | :-- | :-- | :-- | :-- |
| 1 | **repository launcher** | Community/custom | Agentic dev | Select a repository; preview Git state, README, `mise.toml`, and available tasks; then open it in your editor, Zellij layout, or coding-agent session. This becomes the main entry point to your workstation. |
| 2 | **git-worktree** | Your PR / community | Agentic dev | Select an isolated checkout and preview recent commits before starting an agent. It is the best guard against multiple agents or experiments colliding in the main working tree. |
| 3 | **GitHub PRs** | Community / your `pr-checkout` | Agentic dev | Browse open pull requests, inspect them, then open or check out the selected PR. Your PR version already sources results through `gh pr list` and previews with `gh pr view`. |
| 4 | **GitHub issues** | Custom | Agentic dev | Select a bounded issue, preview its body and comments, and pass its number or URL to an agent as a clear implementation brief. |
| 5 | **mise tasks** | Custom | Agentic dev | Make versioned project tasks discoverable and executable through a shared interface for you and coding agents. This fits your preference for reproducible, declarative environment orchestration. [^8_1] |
| 6 | **Git status / changed files** | Community | Agentic dev | Choose modified, staged, or untracked files and preview their diffs—your first human review gate after an agent changes code. |
| 7 | **git-diff** | Community | Agentic dev | Search and inspect changed hunks or files before committing or accepting an agent’s work. |
| 8 | **test runner / failed tests** | Custom | Agentic dev | Present project test targets or the last failures; rerun only the selected test or task to shorten the debug-feedback loop. |
| 9 | **GitHub Actions runs** | Custom | Agentic dev | Browse CI runs, preview failed-job logs, and explicitly open, watch, or rerun a selected workflow. |
| 10 | **agent sessions** | Custom | Agentic dev | List active Zellij/tmux sessions, worktrees, and working directories so you attach to existing work rather than accidentally start duplicate agents. Your terminal-first setup makes this unusually high leverage. |
| 11 | **vault-search** | Custom | PKM | Full-text search Markdown notes with a context preview and an action to open the selected note at its matching line. This should be the primary terminal interface to `vault-memory`. |
| 12 | **tasks** | Custom | PKM | Extract unchecked Markdown tasks from across your vault and filter by project, tag, due date, or context. |
| 13 | **daily-notes** | Custom | PKM | Quickly find, open, or create date-based journal, work-log, meeting, and capture notes. |
| 14 | **backlinks** | Custom | PKM | For a selected note, reveal notes that reference it through wiki-style or ordinary Markdown links. |
| 15 | **tags** | Custom | PKM | Search a normalized tag index, then list every note carrying a selected tag. Build it after your tag conventions stabilize. |
| 16 | **snippets** | Your PR | PKM / writing | Browse reusable Markdown and text fragments with `bat` previews. Keep it, but replace the hard-coded `~/vault-memory/snippets` path with a configurable vault variable for portability. |
| 17 | **recent-files** | Community | PKM / general | Surface the notes, documents, media, and project files you used recently—often more useful than a perfect folder taxonomy. |
| 18 | **bookmarks** | Community/custom | PKM / research | Search browser bookmarks, Linkding/Buku data, exports, or a Markdown link file and open the selected research source. |
| 19 | **PDF library** | Community/custom | PKM / research | Find local papers, reports, manuals, scores, contracts, and reference documents; add full-text extraction later if filename search is insufficient. |
| 20 | **git-log** | Community | Dev / PKM | Search project or vault history to understand prior changes and recover a past version of a note or file. |
| 21 | **git-reflog** | Community | Dev / PKM | Search Git’s recovery history after a reset, rebase, lost branch, or mistaken checkout. |
| 22 | **git-branch** | Community | Dev | Quickly choose, inspect, and switch branches without recalling exact names. |
| 23 | **git-stash** | Community | Dev | Inspect forgotten stashes before applying, dropping, or recovering them. |
| 24 | **git-files** | Community | Dev | Restrict file navigation to version-controlled project files. |
| 25 | **git-tags** | Community | Dev | Browse project tags and releases as navigable checkpoints. |
| 26 | **docker-containers** | Community | Homelab | Search containers by name, image, status, and ports; preview inspect data or recent logs; make lifecycle and shell actions explicit rather than default. |
| 27 | **docker-compose** | Your PR / community | Homelab / dev | Discover Compose manifests, preview them with `bat`, and jump to the stack directory. Your version is sound, but its `~/projects` root should become a configurable project or homelab directory. |
| 28 | **docker-images** | Community | Homelab | Inspect local image names, tags, age, and size before deciding what is stale or safe to prune. |
| 29 | **docker-volumes** | Community | Homelab | Inspect persistent named volumes and mount data before any deletion or cleanup operation. |
| 30 | **SSH hosts** | Your PR / community | Homelab / remote dev | Pick SSH aliases from `~/.ssh/config`, preview their declarations, and connect. Your PR correctly filters wildcard host entries. |
| 31 | **systemd services** | Community/custom | Homelab | Search services and preview status plus recent logs; only bind start, stop, or restart to deliberate keys. |
| 32 | **journal / service logs** | Community | Homelab | Search system logs by unit, severity, or recent failure; useful for diagnosing reverse proxies, backup jobs, and local automation. |
| 33 | **ports** | Community | Homelab / dev | Identify the process owning a listening port, inspect its command, and locate stale servers or port conflicts. |
| 34 | **Kubernetes workloads** | Custom/community | Homelab | Browse contexts, namespaces, pods, deployments, and Helm releases; preview details and logs while requiring explicit confirmation for mutations. |
| 35 | **backup status** | Custom | Homelab | Show latest successful backup, age, duration, destination, and result for Restic, Borg, Kopia, or another backup tool. It operationalizes the only question that counts: whether recovery is plausible. |
| 36 | **sample-library** | Custom | Music | Search samples, loops, stems, field recordings, presets, and one-shots. Use fast filename discovery; fetch expensive audio metadata only for the highlighted item. |
| 37 | **project-sessions** | Custom | Music | Locate DAW project files and open a chosen session. Configure extensions and music roots per DAW. |
| 38 | **audio-files** | Custom | Music | Browse audio assets with a preview that can report duration, codec, sample rate, channels, and tags through `ffprobe`. |
| 39 | **lyrics-notes** | Custom | Music / PKM | Full-text search lyric drafts, chord charts, set lists, release copy, and song ideas; this can share the same vault-search machinery with a narrower root. |
| 40 | **reference-tracks** | Custom | Music | Select from a deliberately curated reference collection for production, mix, arrangement, and genre decisions. |
| 41 | **Spotify playlists** | Custom | Music | Search playlists, saved tracks, or albums through a Spotify-compatible CLI/API integration; use it chiefly for reference listening rather than collection management. |
| 42 | **unicode** | Community | Writing / music / PKM | Find symbols for structured notes, lyrics, credits, documentation, and promotional writing. |
| 43 | **alias-explorer** | Your PR / community | Shell | List aliases and preview their definitions. Your implementation is lean, immediately useful, and robust enough to retain. |
| 44 | **env-vars** | Your PR / built-in alternative | Shell / security | Browse environment variables while filtering names that indicate secrets, tokens, passwords, keys, and credentials. The redaction filter is its real advantage. |
| 45 | **process manager** | Your PR / community alternative | System | Search CPU-heavy processes. Improve the current preview—which only prints a `kill -9` suggestion—into a real process-detail preview before relying on it. |
| 46 | **tmux / Zellij sessions** | Community/custom | Terminal workflow | Search and attach to existing sessions for projects, services, agent runs, and long-running work. Prefer this over spawning new workspaces blindly. [^8_1] |
| 47 | **zoxide directories** | Community | Navigation | Select frequently used directories by frecency, then change into them. |
| 48 | **man-pages** | Community | Learning / shell | Search locally installed documentation with rendered live previews. |
| 49 | **tldr** | Community | Learning / shell | Search concise command examples when you know the tool but not its exact invocation. |
| 50 | **todo-comments** | Community | Dev | Search `TODO`, `FIXME`, and `HACK` markers across a project and jump to the relevant file and line. |

## Duplicates Merged

- **`pr-checkout`** and **`gh-prs`** are one channel category: **GitHub PRs**.
- Your **`git-worktree`** and upstream **`git-worktrees`** are one channel category: **git-worktree**.
- Your **`ssh-hosts`** and the community SSH-host pattern are one category: **SSH hosts**.
- Your **`docker-compose`** and community Compose discovery are one category: **docker-compose**.
- **`recent-files`** appears in PKM, music, and general lists but is one shared channel.
- **`git-log`** is useful for both code and a versioned vault, but it remains one shared channel.
- **`ports`** is useful for local development and homelab administration, but it remains one shared channel.
- **`lyrics-notes`** should reuse the same indexing/search approach as **vault-search**, but should remain separate only if you benefit from a focused music root.


## Practical Adoption Order

Do not install or build all 50. For your configuration-first WSL environment, start with this 12-channel core:

1. `repository-launcher`
2. `git-worktree`
3. `GitHub PRs`
4. `mise-tasks`
5. `git-diff`
6. `vault-search`
7. `tasks`
8. `recent-files`
9. `docker-containers`
10. `docker-compose`
11. `SSH hosts`
12. `backup-status`

That leaves you with a coherent system: **projects and worktrees for agent work; vault search and tasks for thinking; Docker/SSH/backups for infrastructure; and `mise` as the reproducible execution layer**. This aligns with your preference for a centralized Television layer sitting alongside rather than replacing Zellij, Neovim, Git, Docker, and your coding-agent tools.[^8_1]

<div align="center">⁂</div>

[^8_1]: https://www.perplexity.ai/search/541479f4-64b0-4fa1-a4e5-e540aa874400


---

# okay so give me 12 for windows and 12 for wsl. also lets try and consolidate channels where we can

Yes—split them by **execution environment**, not by topic. Put Windows-native channels in your PowerShell/Windows Television config; put Linux, Git, Docker, SSH, and most project tooling in WSL. Television supports Windows and PowerShell interactive use, and it can install/switch community channels while retaining local custom channels.[^9_1][^9_2][^9_3]

## Consolidation Rules

These 24 entries are intentionally **multipurpose**. For example, one `workspace` channel replaces separate repo, project-session, Compose-file, and frequently used directory channels; one `search` channel covers notes, lyrics, snippets, tasks, and source code through scoped searches.

- Keep one shared name per concept: `workspace`, `search`, `recent`, `tasks`, `git`, `containers`, `services`, and so on.
- Give each channel a default root and optional query/filter arguments instead of making near-identical variants.
- Keep platform-specific commands separate: PowerShell syntax and Windows paths on Windows; `fd`, `rg`, `systemctl`, `docker`, and Unix paths in WSL.
- Do **not** manage everyday Docker work from the `docker-desktop` distribution; use your normal Ubuntu/WSL distribution with Docker Desktop integration enabled.[^9_4]


## Windows: 12 Channels

These are the channels to use from PowerShell in Windows Terminal: Windows documents, launchers, clipboard, installed apps, Windows services, and your Windows-side project entry points.


| Rank | Consolidated channel | Replaces / absorbs | Why it belongs on Windows |
| --: | :-- | :-- | :-- |
| 1 | **workspace** | Repository launcher, project sessions, Compose discovery | Search configured Windows roots for Git repos, DAW sessions, Obsidian vault roots, and infrastructure folders; preview README and Git status, then open in the appropriate application. |
| 2 | **search** | Vault search, lyrics-notes, code text search, snippet contents | One full-text PowerShell channel over selected folders: vault, lyrics, documents, active projects, or dotfiles. Put the chosen root behind a profile variable such as `$env:TV_SEARCH_ROOTS`. |
| 3 | **recent** | Recent files, recent projects, recent documents | Surface recently accessed notes, `.docx`, PDFs, DAW sessions, exports, and source files. Windows is the natural place for desktop-first work products. |
| 4 | **tasks** | PKM tasks, todo-comments, personal action lists | Search Markdown checkboxes, TODO markers, and optionally a task-export file. Preview the surrounding lines and open at the selected match. |
| 5 | **bookmarks** | Research links, reference tracks, quick links | Search browser bookmark exports, Linkding/Buku exports, or a Markdown URL index; open the selected URL through `Start-Process`. |
| 6 | **music-library** | Sample library, audio-files, reference tracks | Search selected Windows music/sample folders by name; preview file properties and use a deliberate action to open/audition through the associated application. Keep metadata extraction lazy. |
| 7 | **Windows applications** | App launcher, `winget` package lookup | List installed applications or curated executable shortcuts; launch a selected tool, DAW, editor, browser profile, or administration app. |
| 8 | **clipboard** | Clipboard-history | Your PR’s current channel only reads the present clipboard, so rename it honestly to `clipboard`; use PowerShell’s `Get-Clipboard -Raw` unless you add a real history backend. |
| 9 | **PowerShell history** | Shell history | Search commands previously run in PowerShell, including agent commands, maintenance commands, and repeated project bootstraps. |
| 10 | **Windows services** | Systemd services, Windows service management | Search services with `Get-Service`, preview status and display name, and bind start/stop/restart only to explicit actions. |
| 11 | **processes-and-ports** | Process manager, ports | Merge process and listening-port discovery: surface CPU/memory usage, PID, command, and port ownership in a single diagnostic picker. Your current PR process preview should be upgraded from a kill suggestion to actual details. |
| 12 | **WSL distros** | `wsl-distro` | Keep this only on Windows: list installed distributions, preview basic state/version, and open a selected distro. It is correctly Windows-specific but niche. |

## WSL: 12 Channels

These are the high-leverage channels for your Ubuntu/WSL development surface: agentic work, infrastructure, Git, containers, SSH, and terminal-native knowledge work. Your current architecture already treats Television as a central searchable layer alongside a multiplexer, Neovim, Git, Docker, and coding agents.[^9_5]


| Rank | Consolidated channel | Replaces / absorbs | Why it belongs in WSL |
| --: | :-- | :-- | :-- |
| 1 | **workspace** | Repo launcher, git repos, zoxide directories, project sessions, Compose discovery | Search known development, homelab, and vault roots; preview Git status, last commit, `README`, `mise.toml`, and Compose manifests. Actions open Neovim, attach/create a Zellij session, or start an agent in the selected root. |
| 2 | **worktrees** | Git worktree, branch picker | Use your `git-worktree` channel as the foundation, but consolidate branch selection into it. Preview the branch, path, status, and recent commits before entering or assigning an agent to it. |
| 3 | **GitHub work** | PR checkout, GitHub issues, Actions runs | One `gh`-backed channel with a mode/filter for PRs, issues, and CI runs. Preview PR/issue detail or failed logs; bind checkout, browser open, and rerun actions explicitly. Your PR’s PR source/preview is a good starting component. |
| 4 | **Git review** | Git status, git diff, git log, reflog, stash, tags | One Git inspection channel with selectable modes rather than six separate daily launch points. Default to read-only review; only expose mutation as explicit actions. |
| 5 | **run** | Mise tasks, test runner, failed tests, Make/Just/npm scripts | Make `mise tasks` the primary source, with project fallbacks for Make, Just, npm, or test targets. This is the shared, reproducible command interface for you and agents. |
| 6 | **search** | Vault search, lyrics-notes, snippets, todo-comments, tag search | A scoped `rg` channel over the active project or selected vault root. Use filters/presets for code, Markdown, lyrics, tasks, and snippets instead of maintaining five copy-paste TOML files. |
| 7 | **recent** | Recent files, daily notes | Search recently touched files across configured WSL mounts and your vault; a `daily` preset can restrict this to journal/daily-note folders. |
| 8 | **sessions** | Zellij/tmux sessions, agent sessions | List active multiplexer sessions and their directories; attach to an existing agent workspace rather than creating duplicate agents in the same checkout. |
| 9 | **containers** | Docker containers, images, volumes, Compose stack status | One Docker channel with modes for containers, images, volumes, and Compose projects. Preview logs/inspect/status; ensure prune, removal, and volume deletion require intentional bound actions. |
| 10 | **hosts** | SSH hosts, Kubernetes contexts/workloads | Make SSH aliases the default mode and add Kubernetes contexts/namespaces/pods as a separate mode only if you actually run Kubernetes. Your PR’s SSH parser provides a clean, usable base. |
| 11 | **services** | Systemd services, journal logs, ports, reverse-proxy diagnostics | One operational diagnostic channel that selects a systemd unit, journal stream, process, or listening port, then previews health and ownership. Keep restart/kill actions explicit. |
| 12 | **backups** | Backup status, storage/mount health, certificate expiry | One homelab-health picker: latest Restic/Borg/Kopia result, filesystem space, mount state, and optional TLS-expiry checks. It is more useful operationally than a separate channel for every check. |

## The Net Result

This reduces the earlier 50-channel catalogue to **24 practical channels**, with fewer overlapping files and less muscle-memory burden:


| Surface | Main purpose | Channels |
| :-- | :-- | --: |
| **Windows / PowerShell** | Desktop assets, Windows administration, launchers, clipboard, DAW/media work | 12 |
| **WSL / Ubuntu** | Git, agentic projects, Docker, SSH, homelab, terminal-native PKM | 12 |

Use the same conceptual names where the behaviour is shared—especially `workspace`, `search`, `recent`, and `tasks`—but maintain distinct `.toml` implementations because Windows PowerShell and WSL commands, path formats, applications, and service managers differ. Television’s built-in model already supports searching files, text, Git repositories, environment variables, and Docker containers; these channel groups build a small task-oriented layer around that foundation rather than replacing it.[^9_6][^9_3]
<span style="display:none">[^9_10][^9_11][^9_12][^9_13][^9_14][^9_15][^9_16][^9_17][^9_7][^9_8][^9_9]</span>

<div align="center">⁂</div>

[^9_1]: https://learn.microsoft.com/en-us/powershell/dsc/configurations/configurations?view=dsc-1.1

[^9_2]: https://github.com/alexpasmantier/television/releases

[^9_3]: https://alexpasmantier.github.io/television/getting-started/quickstart/

[^9_4]: https://www.perplexity.ai/search/a14bfd78-9ba6-4759-9983-2a14ab6736ce

[^9_5]: https://www.perplexity.ai/search/541479f4-64b0-4fa1-a4e5-e540aa874400

[^9_6]: https://github.com/alexpasmantier/television

[^9_7]: https://learn.microsoft.com/en-us/powershell/

[^9_8]: https://account.cablelabs.com/server/alfresco/e5f40384-c38f-4c03-93f7-954eef7e1fc2

[^9_9]: https://www.dell.com/support/kbdoc/en-us/000177240/dell-command-powershell-provider

[^9_10]: https://drexel.edu/it/help/a-z/resnet-hd-cabletv/connect-and-configure/

[^9_11]: https://laravel-news.com/television-tui

[^9_12]: https://learn.microsoft.com/en-us/powershell/sccm/overview?view=sccm-ps

[^9_13]: https://github.com/alexpasmantier/television/issues

[^9_14]: https://rustutils.com/tools/television/

[^9_15]: https://docs.crestron.com/en-us/8989/

[^9_16]: https://www.powershellgallery.com/packages/AWS.Tools.KinesisVideoSignalingChannels/5.0.213/Content/AWS.Tools.KinesisVideoSignalingChannels.XML

[^9_17]: https://github.com/alexpasmantier/television/discussions


---

# okay give me a prompt that will get antigravity cli to build these configs and update the repo it was already working on that i showed you earlier. make it concise as i am on the free plan.

Paste this into Antigravity CLI:

```text
Continue working in the existing `pvnkmnk/terminal-dotfiles` repo and current `feat/television-channels` branch / PR #2. Update the Television cable-channel config; do not change unrelated dotfiles.

Goal: replace the current scattered/single-purpose additions with 24 consolidated, portable channels: 12 Windows/PowerShell and 12 WSL/Linux. Keep the existing flat `[[channels]]` TOML format already used in `dot_config/television/cable/`.

Create platform folders:
- `dot_config/television/cable/windows/`
- `dot_config/television/cable/wsl/`

Windows channels:
1. workspace
2. search
3. recent
4. tasks
5. bookmarks
6. music-library
7. windows-apps
8. clipboard
9. pwsh-history
10. windows-services
11. processes-and-ports
12. wsl-distros

WSL channels:
1. workspace
2. worktrees
3. gh-work
4. git-review
5. run
6. search
7. recent
8. sessions
9. containers
10. hosts
11. services
12. backups

Requirements:
- Consolidate overlaps: do not retain separate channels for `pr-checkout`, `git-worktree`, `docker-compose`, `ssh-hosts`, `process-manager`, `snippets`, `wsl-distro`, or `clipboard-history`; absorb their capabilities into the new names.
- Reuse/improve useful existing logic from PR #2, especially worktrees, PRs, SSH parsing, secret-safe env filtering, Docker Compose discovery, snippets, and process inspection.
- Make roots configurable with environment variables and safe defaults: `TV_WORKSPACE_ROOTS`, `TV_VAULT_DIR`, `TV_MUSIC_DIR`, `TV_HOMELAB_DIR`. Never hardcode `~/projects` or `~/vault-memory`.
- Use Windows-native PowerShell commands in `windows/`; use POSIX tools (`fd`, `rg`, `git`, `gh`, `docker`, `systemctl`, `journalctl`, `ss`, etc.) only in `wsl/`.
- Design previews as read-only. Do not make destructive commands (`kill -9`, Docker deletion/prune, restarts, kubectl mutations) default actions.
- Where an integration is optional/unavailable, make the channel degrade gracefully with command checks or clear messages; do not require Kubernetes, Docker, tmux, Zellij, Restic, Borg, or Spotify.
- `workspace`, `search`, `recent`, and `tasks` should have comparable intent on both platforms, adapted to native shell/path conventions.
- Add concise comments/docs in `README.md`: dependency list, env vars, Windows vs WSL placement, install/update steps, and example invocations.
- Validate TOML syntax, shell quoting, and paths. Preserve or improve portability and do not commit secrets.

Make the edits directly, delete superseded channel files, then give me a compact summary: files added/removed, dependencies, assumptions, and any channels needing local customization.
```

This explicitly targets the existing PR branch and its current 10 flat-format channel files, while asking Antigravity to supersede rather than accumulate overlapping configurations.

---

# hmm actually, if i publish this conversation the agent will be able to read it right? so actually give me a prompt that will tell it how to read this convo in order to create these, fully

Yes—if the published/share link is publicly reachable, give Antigravity the exact URL and explicitly instruct it to read it before touching the repo. Shared Perplexity threads can be accessed through a share link, while public Pages are intended to be externally shareable.[^11_1][^11_2]

```text
Continue work in the existing `pvnkmnk/terminal-dotfiles` repository and the current Television-channels PR/branch.

First, read this published conversation in full, from earliest to latest:
PASTE_PUBLIC_PERPLEXITY_CONVERSATION_URL_HERE

Treat it as the complete design brief. Extract:
- the reviewed existing PR #2 channels and their strengths/weaknesses;
- the consolidated-channel approach;
- the required Windows vs WSL split;
- portability, safety, and deduplication requirements;
- the user’s WSL2, PowerShell, Docker Desktop, chezmoi, `mise`, terminal-first, agentic-development, PKM, music, and homelab context.

Then implement the final design in the repo—do not merely summarize it.

Deliverable:
- Replace/supersede the existing scattered Television cable channels with 24 consolidated channels: 12 under `dot_config/television/cable/windows/`, and 12 under `dot_config/television/cable/wsl/`.
- Preserve the repo’s current flat `[[channels]]` TOML style unless the conversation establishes a better compatible format.
- Delete or replace superseded duplicate channel files rather than keeping old overlapping versions.
- Use configurable environment variables and safe defaults; do not hardcode personal roots such as `~/projects` or `~/vault-memory`.
- Use Windows-native PowerShell commands only in `windows/`; use Linux/WSL commands only in `wsl/`.
- Default behaviour must be read-only: destructive actions must never be bound to Enter or run implicitly.
- Handle missing optional dependencies gracefully.
- Update the README with a concise platform/dependency/env-var/install guide.
- Validate TOML, quoting, commands, paths, and compatibility with a clean machine.

Before editing, state the extracted final 12 Windows and 12 WSL channel names in a short implementation plan. Then make the changes, remove superseded files, and report: changed files, removed files, dependencies, environment variables, assumptions, and manual local setup still required.
```

Replace only `PASTE_PUBLIC_PERPLEXITY_CONVERSATION_URL_HERE` with the published link. Avoid publishing it if it contains personal paths, hostnames, tokens, IP addresses, private repository URLs, or other secrets; sharing makes the conversation readable to whoever can access that link.[^11_2]
<span style="display:none">[^11_3][^11_4][^11_5][^11_6][^11_7][^11_8][^11_9]</span>

<div align="center">⁂</div>

[^11_1]: https://www.perplexity.ai/hub/blog/perplexity-pages

[^11_2]: https://itsupport.umd.edu/itsupport/?id=kb_article_view\&sysparm_article=KB0020467

[^11_3]: https://www.perplexity.ai/hub/blog/getting-started-with-perplexity

[^11_4]: https://www.reddit.com/r/perplexity_ai/comments/1k9tcf9/perplexity_pro_space_cannot_read/

[^11_5]: https://www.youtube.com/watch?v=YoWdogtZRw8

[^11_6]: https://www.perplexity.ai/help-center/en/articles/10352961-what-are-spaces.html

[^11_7]: https://aigoestocollege.substack.com/p/pages-perplexityais-hidden-superpower

[^11_8]: https://www.datastudios.org/post/perplexity-ai-pdf-uploading-pdf-reading-capabilities-text-extraction-accuracy-layout-support-and-1

[^11_9]: https://www.facebook.com/groups/703007927897194/posts/815557096642276/


---

# [https://www.perplexity.ai/search/ecdd8dda-7998-47a3-bf12-3189f41e03de](https://www.perplexity.ai/search/ecdd8dda-7998-47a3-bf12-3189f41e03de) heres the link, add it in and then at the bottom of your response welcome antigravity and give it instruction

```text
Continue work in the existing `pvnkmnk/terminal-dotfiles` repository and the current Television-channels PR/branch.

First, read this published conversation completely, from earliest to latest:

https://www.perplexity.ai/search/ecdd8dda-7998-47a3-bf12-3189f41e03de

Treat it as the authoritative design brief. Extract and follow its final decisions on:
- review of the existing PR #2 cable channels;
- community-channel research and useful patterns;
- the consolidated, deduplicated channel approach;
- the final Windows versus WSL split;
- portability, safety, configuration, and dependency requirements;
- the user’s WSL2, PowerShell, Docker Desktop, chezmoi, `mise`, terminal-first, agentic-dev, PKM, music, and homelab workflow.

Then implement the result in the repo; do not merely summarize the conversation.

Deliverable:
- Replace/supersede scattered Television cable channels with 24 consolidated channels: 12 in `dot_config/television/cable/windows/` and 12 in `dot_config/television/cable/wsl/`.
- Preserve the repo’s current compatible Television TOML style unless the conversation establishes a better supported format.
- Delete superseded/duplicative old channels rather than retaining overlapping versions.
- Reuse and improve the useful PR #2 logic where appropriate.
- Use configurable environment variables and safe defaults; never hardcode personal paths such as `~/projects` or `~/vault-memory`.
- Use PowerShell-native commands only in `windows/`; use Linux/WSL commands only in `wsl/`.
- Keep default selection and previews read-only. Destructive actions must never execute by default.
- Make optional dependencies degrade gracefully with useful messages.
- Update README documentation with concise dependencies, environment variables, platform separation, install/update instructions, and examples.
- Validate TOML, shell quoting, paths, and a clean-machine installation scenario.
- Do not commit secrets.

Before editing, show a brief plan listing the extracted final 12 Windows and 12 WSL channel names. Then make the changes and report changed/removed files, dependencies, environment variables, assumptions, and remaining local customization.
```

Welcome, Antigravity. Read the linked conversation fully before changing anything; use its final consolidated Windows/WSL design as the source of truth, implement it directly in the existing PR, and favor portable, safe, low-duplication Television channels over adding more one-off configs.

