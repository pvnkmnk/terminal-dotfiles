# run_once: Install core terminal packages via Scoop
$packages = @(
    "wezterm",
    "zellij",
    "helix",
    "television",
    "mise"
)

foreach ($pkg in $packages) {
    if (-not (Get-Command $pkg -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $pkg..."
        scoop install $pkg
    } else {
        Write-Host "$pkg already installed, skipping."
    }
}
