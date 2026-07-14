import os
import shutil

wsl_dir = r"C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable\wsl"
win_dir = r"C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable\windows"
old_dir = r"C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable"
cable_toml = r"C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable.toml"

if os.path.exists(cable_toml):
    os.remove(cable_toml)

if os.path.exists(old_dir):
    for f in os.listdir(old_dir):
        path = os.path.join(old_dir, f)
        if os.path.isfile(path):
            os.remove(path)

os.makedirs(wsl_dir, exist_ok=True)
os.makedirs(win_dir, exist_ok=True)

wsl = [
    {"name": "git-repos", "command": 'fd -H -t d "^\\.git$" "${PROJECTS_DIR:-$HOME/projects}" | sed "s/\\/.git$//"', "preview": "ls -la {}"},
    {"name": "git-worktree", "command": "git worktree list --porcelain | grep '^worktree ' | awk '{print $2}'", "preview": "git -C {} log --oneline -5"},
    {"name": "docker-containers", "command": "command -v docker >/dev/null && docker ps --format '{{.Names}}' || echo 'Docker not installed'", "preview": "command -v docker >/dev/null && docker inspect {} | jq '.[0] | {Status: .State.Status, Ports: .NetworkSettings.Ports}'"},
    {"name": "docker-images", "command": "command -v docker >/dev/null && docker images --format '{{.Repository}}:{{.Tag}}' || echo 'Docker not installed'", "preview": "command -v docker >/dev/null && docker inspect {} | jq '.[0] | {Created: .Created, Size: .Size}'"},
    {"name": "env-vars", "command": "env | grep -Ev '(KEY|TOKEN|SECRET|PASSWORD|PASS|CREDENTIALS|AUTH)'", "preview": "echo {}"},
    {"name": "snippets", "command": 'fd -e md -e txt . "${VAULT_DIR:-$HOME/vault-memory}/snippets"', "preview": "bat --color=always {}"},
    {"name": "process-manager", "command": "ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 50", "preview": "echo 'Kill with: kill -9 '$(echo {} | awk '{print $1}')"},
    {"name": "pr-checkout", "command": "command -v gh >/dev/null && gh pr list --limit 30 --json number,title --jq '.[] | \"\\(.number) \\(.title)\"' || echo 'gh cli not found'", "preview": "command -v gh >/dev/null && gh pr view $(echo {} | awk '{print $1}')"},
    {"name": "mise-envs", "command": "command -v mise >/dev/null && mise ls || echo 'mise not found'", "preview": "echo {}"},
    {"name": "ssh-hosts", "command": "grep -E '^Host ' ~/.ssh/config 2>/dev/null | awk '{print $2}' | grep -v '*'", "preview": "grep -A 5 -E \"^Host {}$\" ~/.ssh/config"},
    {"name": "tldr", "command": "command -v tldr >/dev/null && tldr --list || echo 'tldr not found'", "preview": "command -v tldr >/dev/null && tldr --color always {}"},
    {"name": "chezmoi-managed", "command": "command -v chezmoi >/dev/null && chezmoi managed || echo 'chezmoi not found'", "preview": "command -v chezmoi >/dev/null && chezmoi cat {} | head -n 30"}
]

win = [
    {"name": "git-repos", "command": "if (Test-Path $env:PROJECTS_DIR) { (Get-ChildItem -Path $env:PROJECTS_DIR -Directory -Recurse -Depth 3 -Filter '.git' -Hidden).Parent.FullName } else { 'PROJECTS_DIR not set' }", "preview": "Get-ChildItem -Path '{}'"},
    {"name": "wsl-distros", "command": "if (Get-Command wsl.exe -ErrorAction SilentlyContinue) { wsl.exe -l -q } else { 'WSL not found' }", "preview": "wsl.exe -d {} -- uname -a"},
    {"name": "docker-containers", "command": "if (Get-Command docker -ErrorAction SilentlyContinue) { docker ps --format '{{.Names}}' } else { 'Docker not found' }", "preview": "if (Get-Command docker -ErrorAction SilentlyContinue) { docker inspect {} } else { 'Docker not found' }"},
    {"name": "docker-images", "command": "if (Get-Command docker -ErrorAction SilentlyContinue) { docker images --format '{{.Repository}}:{{.Tag}}' } else { 'Docker not found' }", "preview": "if (Get-Command docker -ErrorAction SilentlyContinue) { docker inspect {} } else { 'Docker not found' }"},
    {"name": "env-vars", "command": "Get-ChildItem Env: | Where-Object Name -notmatch '(KEY|TOKEN|SECRET|PASSWORD|PASS|CREDENTIALS|AUTH)' | Select-Object -ExpandProperty Name", "preview": "Get-Content Env:\\{}"},
    {"name": "process-manager", "command": "Get-Process | Sort-Object CPU -Descending | Select-Object -First 50 -ExpandProperty Name", "preview": "Get-Process -Name {} | Format-List *"},
    {"name": "snippets", "command": "if (Test-Path $env:VAULT_DIR) { Get-ChildItem -Path \"$env:VAULT_DIR\\snippets\" -Recurse -Include *.md,*.txt -File | Select-Object -ExpandProperty FullName } else { 'VAULT_DIR not set' }", "preview": "Get-Content '{}' -TotalCount 30"},
    {"name": "clipboard-history", "command": "Get-Clipboard -Raw", "preview": "Get-Clipboard -Raw"},
    {"name": "powershell-history", "command": "if (Get-PSReadLineOption) { Get-Content (Get-PSReadLineOption).HistorySavePath -Tail 100 | Select-Object -Unique } else { 'History unavailable' }", "preview": "echo '{}'"},
    {"name": "mise-envs", "command": "if (Get-Command mise -ErrorAction SilentlyContinue) { mise ls } else { 'mise not found' }", "preview": "echo '{}'"},
    {"name": "ssh-hosts", "command": "if (Test-Path ~/.ssh/config) { Select-String -Path ~/.ssh/config -Pattern '^Host ' | ForEach-Object { $_.Line -replace 'Host ', '' } | Where-Object { $_ -ne '*' } } else { 'SSH config not found' }", "preview": "Select-String -Path ~/.ssh/config -Pattern '^Host {}' -Context 0,5"},
    {"name": "chezmoi-managed", "command": "if (Get-Command chezmoi -ErrorAction SilentlyContinue) { chezmoi managed } else { 'chezmoi not found' }", "preview": "if (Get-Command chezmoi -ErrorAction SilentlyContinue) { chezmoi cat {} } else { 'chezmoi not found' }"}
]

template = '''[[channels]]
name = "{name}"
command = """{command}"""
preview = """{preview}"""
'''

for ch in wsl:
    with open(os.path.join(wsl_dir, ch["name"] + ".toml"), "w", encoding="utf-8") as f:
        f.write(template.format(**ch))

for ch in win:
    with open(os.path.join(win_dir, ch["name"] + ".toml"), "w", encoding="utf-8") as f:
        f.write(template.format(**ch))
