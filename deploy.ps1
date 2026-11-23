# deploy.ps1 — commit and push MythBridge to GitHub Pages in one command
# Usage: .\deploy.ps1 ["optional commit message"]
$git = "C:\Program Files\Git\cmd\git.exe"
$repo = "C:\Users\azlan\.ilmucode\workspace\default"

Set-Location $repo

$status = & $git status --porcelain
if (-not $status) {
    Write-Host "No changes to deploy — index.html is already up to date on GitHub." -ForegroundColor Yellow
    exit 0
}

$msg = if ($args.Count -gt 0) { $args[0] } else { "Update MythBridge content" }
& $git add index.html
& $git commit -m $msg
& $git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Deployed! GitHub Pages will rebuild in ~1 minute." -ForegroundColor Green
    Write-Host "Live site: https://zlanu.github.io/mythbridge/" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Push failed — check your token permissions." -ForegroundColor Red
}
