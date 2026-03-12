# ==========================================
# Script : Generer-Sitemap.ps1
# Projet : L’Autre Rivage
# Génère automatiquement sitemap.xml
# ==========================================

Write-Host ""
Write-Host "==============================================="
Write-Host "   GENERATION DU SITEMAP"
Write-Host "==============================================="
Write-Host ""

# URL de base du site
$baseUrl = "https://manub44.github.io/L-Autre-Rivage"

# Dossier racine du projet
$root = Get-Location

# Fichier de sortie
$outputFile = Join-Path $root "sitemap.xml"

# Récupérer tous les fichiers HTML
$htmlFiles = Get-ChildItem -Path $root -Recurse -Filter *.html | Where-Object {
    $_.Name -notin @("header.html", "footer.html")
}

# Début du XML
$xmlLines = @()
$xmlLines += '<?xml version="1.0" encoding="UTF-8"?>'
$xmlLines += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

foreach ($file in $htmlFiles) {

    # Chemin relatif depuis la racine
    $relativePath = $file.FullName.Replace($root.Path, "").TrimStart("\")
    
    # Remplacer les \ Windows par /
    $relativePath = $relativePath -replace "\\", "/"

    # Cas spécial pour index.html à la racine
    if ($relativePath -eq "index.html") {
        $url = "$baseUrl/"
    }
    else {
        $url = "$baseUrl/$relativePath"
    }

    $xmlLines += "  <url>"
    $xmlLines += "    <loc>$url</loc>"
    $xmlLines += "  </url>"

    Write-Host "Ajoute : $url"
}

# Fin du XML
$xmlLines += '</urlset>'

# Écriture du fichier
$xmlLines | Set-Content -Path $outputFile -Encoding UTF8

Write-Host ""
Write-Host "Sitemap genere : $outputFile"
Write-Host "URL finale : $baseUrl/sitemap.xml"
Write-Host ""
Write-Host "==============================================="
Write-Host "   GENERATION TERMINEE"
Write-Host "==============================================="
Write-Host ""