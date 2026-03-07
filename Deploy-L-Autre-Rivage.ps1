param(
    [string]$ProjectPath = "C:\Users\manub\Desktop\Site\L-Autre-Rivage",
    [string]$RepoUrl = "https://github.com/manub44/L-Autre-Rivage.git",
    [string]$Branch = "main",
    [string]$CommitMessage = "Mise à jour du site"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=== Déploiement de L-Autre-Rivage ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ProjectPath)) {
    Write-Host "Dossier introuvable : $ProjectPath" -ForegroundColor Red
    exit 1
}

Set-Location $ProjectPath

if (-not (Test-Path ".git")) {
    Write-Host "Initialisation du dépôt Git..." -ForegroundColor Yellow
    git init
}

Write-Host "Vérification de la branche..." -ForegroundColor Yellow
git branch -M $Branch

$remoteExists = git remote | Select-String -Pattern "^origin$" -Quiet

if ($remoteExists) {
    Write-Host "Remote origin déjà présent : mise à jour de l'URL..." -ForegroundColor Yellow
    git remote set-url origin $RepoUrl
}
else {
    Write-Host "Ajout du remote origin..." -ForegroundColor Yellow
    git remote add origin $RepoUrl
}

Write-Host "Ajout des fichiers..." -ForegroundColor Yellow
git add .

$status = git status --porcelain

if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "Aucun changement local à commit." -ForegroundColor Green
}
else {
    Write-Host "Création du commit..." -ForegroundColor Yellow
    git commit -m $CommitMessage
}

Write-Host "Envoi vers GitHub..." -ForegroundColor Yellow
git push -u origin $Branch

Write-Host ""
Write-Host "Terminé." -ForegroundColor Green
Write-Host "Dépôt : $RepoUrl"
Write-Host "Site GitHub Pages : https://manub44.github.io/L-Autre-Rivage/"
Write-Host ""
Write-Host "Dans GitHub > Settings > Pages :" -ForegroundColor Cyan
Write-Host "Source : Deploy from a branch"
Write-Host "Branch : main"
Write-Host "Folder : / (root)"
Write-Host ""