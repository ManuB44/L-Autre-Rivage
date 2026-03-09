Write-Host ""
Write-Host "DEPLOIEMENT DU SITE L'AUTRE RIVAGE"
Write-Host ""

# vérifier git
git --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "Git n'est pas installé."
    exit
}

# initialisation si nécessaire
if (!(Test-Path ".git")) {
    Write-Host "Initialisation du dépôt..."
    git init
}

# branche principale
git branch -M main

# ajouter tous les fichiers
Write-Host "Ajout des fichiers..."
git add .

# commit
Write-Host "Création du commit..."
git commit -m "Mise a jour du site"

# dépôt GitHub
$repo = "https://github.com/manub44/L-Autre-Rivage.git"

# vérifier si remote existe
$remote = git remote
if ($remote -notcontains "origin") {
    git remote add origin $repo
}

# push
Write-Host "Envoi vers GitHub..."
git push -u origin main

Write-Host ""
Write-Host "DEPLOIEMENT TERMINE"
Write-Host ""
Write-Host "Le site sera visible dans quelques minutes :"
Write-Host "https://manub44.github.io/L-Autre-Rivage/"