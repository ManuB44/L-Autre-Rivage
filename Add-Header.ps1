# ==========================================
# Script : Add-Header.ps1
# Projet : L’Autre Rivage
# Ajoute automatiquement header + footer
# ==========================================

$root = Get-Location

$header = Get-Content "$root\header.html" -Raw
$footer = Get-Content "$root\footer.html" -Raw

$files = Get-ChildItem -Recurse -Filter *.html

foreach ($file in $files) {

    if ($file.Name -eq "header.html") { continue }
    if ($file.Name -eq "footer.html") { continue }

    $content = Get-Content $file.FullName -Raw

    if ($content -match "<body>") {

        $content = $content -replace "<body>", "<body>`n$header"

    }

    if ($content -match "</body>") {

        $content = $content -replace "</body>", "$footer`n</body>"

    }

    Set-Content $file.FullName $content

    Write-Host "Header/Footer ajouté à $($file.Name)"

}

Write-Host ""
Write-Host "✔ Script terminé"