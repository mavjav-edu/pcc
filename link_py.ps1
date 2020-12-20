$MDs = Get-ChildItem -Filter *.md -Recurse
foreach($MD in $MDs) {
    $MDcontent = Get-Content $MD
    $mentionPYfile = $MDcontent | Select-String -Pattern '\*([^\.]+\.py)\*(?=\s)'
    if(($null -ne $mentionPYfile) -and ($mentionPYfile.Count -gt 0) -and (Test-Path ($pathToPyPossible = Join-Path $MD.Directory $mentionPYfile.Matches.Groups[1].Value))) {
        Push-Location "$pathToPyPossible\.."
        $relPathToPy = Resolve-Path $pathToPyPossible -Relative
        $MDcontent[$mentionPYfile.LineNumber-1] = ($mentionPYfile) -replace $mentionPYfile.Pattern,"[`$0]($relPathToPy)"
        Set-Content -Path $MD -Value $MDcontent
        Pop-Location
    }
}