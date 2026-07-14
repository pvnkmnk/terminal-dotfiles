$wslDir = "C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable\wsl"
$winDir = "C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable\windows"
$oldDir = "C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable"
$cableToml = "C:\Users\idols\DevRepos\terminal-dotfiles\dot_config\television\cable.toml"

# Clean up old single files/toml
if (Test-Path $oldDir) {
    Get-ChildItem -Path $oldDir -File | Remove-Item -Force
}
if (Test-Path $cableToml) {
    Remove-Item -Force $cableToml
}

New-Item -ItemType Directory -Force -Path $wslDir
New-Item -ItemType Directory -Force -Path $winDir

$wsl = @(
    @{ n="git-repos"; c='fd -H -t d "^\.git$" "${PROJECTS_DIR:-$HOME/projects}" | sed "s/\/.git$//"'; p='ls -la {}' }
    @{ n="git-worktree"; c="git worktree list --porcelain | grep '^worktree ' | awk '{print `$2}'"; p="git -C {} log --oneline -5" }
    @{ n="docker-containers"; c="command -v docker >/dev/null && docker ps --format '{{.Names}}' || echo 'Docker not installed'"; p="command -v docker >/dev/null && docker inspect {} | jq '.[0] | {Status: .State.Status, Ports: .NetworkSettings.Ports}'" }
    @{ n="docker-images"; c="command -v docker >/dev/null && docker images --format '{{.Repository}}:{{.Tag}}' || echo 'Docker not installed'"; p="command -v docker >/dev/null && docker inspect {} | jq '.[0] | {Created: .Created, Size: .Size}'" }
    @{ n="env-vars"; c="env | grep -Ev '(KEY|TOKEN|SECRET|PASSWORD|PASS|CREDENTIALS|AUTH)'"; p="echo {}" }
    @{ n="snippets"; c='fd -e md -e txt . "${VAULT_DIR:-$HOME/vault-memory}/snippets"'; p="bat --color=always {}" }
    @{ n="process-manager"; c="ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 50"; p='echo "Kill with: kill -9 $(echo {} | awk \"{print \$1}\")"' }
    @{ n="pr-checkout"; c="command -v gh >/dev/null && gh pr list --limit 30 --json number,title --jq '.[] | \"\\(.number) \\(.title)\"' || echo 'gh cli not found'"; p="command -v gh >/dev/null && gh pr view $(echo {} | awk '{print `$1}')" }
    @{ n="mise-envs"; c="command -v mise >/dev/null && mise ls || echo 'mise not found'"; p="echo {}" }
    @{ n="ssh-hosts"; c="grep -E '^Host ' ~/.ssh/config 2>/dev/null | awk '{print `$2}' | grep -v '*'"; p='grep -A 5 -E "^Host {}$" ~/.ssh/config' }
    @{ n="tldr"; c="command -v tldr >/dev/null && tldr --list || echo 'tldr not found'"; p="command -v tldr >/dev/null && tldr --color always {}" }
    @{ n="chezmoi-managed"; c="command -v chezmoi >/dev/null && chezmoi managed || echo 'chezmoi not found'"; p="command -v chezmoi >/dev/null && chezmoi cat {} | head -n 30" }
)

foreach ($ch in $wsl) {
    $content = @"
[[channels]]
name = "$($ch.n)"
command = """$($ch.c)"""
preview = """$($ch.p)"""
"@
    Set-Content -Path "$wslDir/$($ch.n).toml" -Value $content -Encoding UTF8
}

$win = @(
    @{ n="git-repos"; c='if (Test-Path $env:PROJECTS_DIR) { (Get-ChildItem -Path $env:PROJECTS_DIR -Directory -Recurse -Depth 3 -Filter ".git" -Hidden).Parent.FullName } else { "PROJECTS_DIR not set" }'; p='Get-ChildItem -Path "{}"' }
    @{ n="wsl-distros"; c='if (Get-Command wsl.exe -ErrorAction SilentlyContinue) { wsl.exe -l -q } else { "WSL not found" }'; p='wsl.exe -d {} -- uname -a' }
    @{ n="docker-containers"; c='if (Get-Command docker -ErrorAction SilentlyContinue) { docker ps --format "{{.Names}}" } else { "Docker not found" }'; p='if (Get-Command docker -ErrorAction SilentlyContinue) { docker inspect {} } else { "Docker not found" }' }
    @{ n="docker-images"; c='if (Get-Command docker -ErrorAction SilentlyContinue) { docker images --format "{{.Repository}}:{{.Tag}}" } else { "Docker not found" }'; p='if (Get-Command docker -ErrorAction SilentlyContinue) { docker inspect {} } else { "Docker not found" }' }
    @{ n="env-vars"; c='Get-ChildItem Env: | Where-Object Name -notmatch "(KEY|TOKEN|SECRET|PASSWORD|PASS|CREDENTIALS|AUTH)" | Select-Object -ExpandProperty Name'; p='Get-Content Env:\{}' }
    @{ n="process-manager"; c='Get-Process | Sort-Object CPU -Descending | Select-Object -First 50 -ExpandProperty Name'; p='Get-Process -Name {} | Format-List *' }
    @{ n="snippets"; c='if (Test-Path $env:VAULT_DIR) { Get-ChildItem -Path "$env:VAULT_DIR\snippets" -Recurse -Include *.md,*.txt -File | Select-Object -ExpandProperty FullName } else { "VAULT_DIR not set" }'; p='Get-Content "{}" -TotalCount 30' }
    @{ n="clipboard-history"; c='Get-Clipboard -Raw'; p='Get-Clipboard -Raw' }
    @{ n="powershell-history"; c='if (Get-PSReadLineOption) { Get-Content (Get-PSReadLineOption).HistorySavePath -Tail 100 | Select-Object -Unique } else { "History unavailable" }'; p='echo "{}"' }
    @{ n="mise-envs"; c='if (Get-Command mise -ErrorAction SilentlyContinue) { mise ls } else { "mise not found" }'; p='echo "{}"' }
    @{ n="ssh-hosts"; c='if (Test-Path ~/.ssh/config) { Select-String -Path ~/.ssh/config -Pattern "^Host " | ForEach-Object { $_.Line -replace "Host ", "" } | Where-Object { $_ -ne "*" } } else { "SSH config not found" }'; p='Select-String -Path ~/.ssh/config -Pattern "^Host {}" -Context 0,5' }
    @{ n="chezmoi-managed"; c='if (Get-Command chezmoi -ErrorAction SilentlyContinue) { chezmoi managed } else { "chezmoi not found" }'; p='if (Get-Command chezmoi -ErrorAction SilentlyContinue) { chezmoi cat {} } else { "chezmoi not found" }' }
)

foreach ($ch in $win) {
    $content = @"
[[channels]]
name = "$($ch.n)"
command = '$($ch.c)'
preview = '$($ch.p)'
"@
    Set-Content -Path "$winDir/$($ch.n).toml" -Value $content -Encoding UTF8
}
