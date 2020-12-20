$TESTING = $false
$MDs = Get-ChildItem -Filter *.md -Recurse
foreach($MD in $MDs) {
    $MDcontent = Get-Content $MD
    $mentionsPYfile = $MDcontent | Select-String -Pattern '\*([^\.]+\.py)\*(?=\s)'
    foreach ($mention in $mentionsPYfile) {
        if(Test-Path ($pathToPyPossible = Join-Path $MD.Directory $mention.Matches.Groups[1].Value)) {
            Push-Location "$pathToPyPossible\.."
            $relPathToPy = Resolve-Path $pathToPyPossible -Relative
            $MDcontent[($mention.LineNumber)-1] = ($mention) -replace $mention.Pattern,"[`$0]($relPathToPy)"
            if(-not $TESTING) {
                Set-Content -Path $MD -Value $MDcontent
            } else {
                Write-Host "'$MD' would get: $($MDcontent[($mention.LineNumber)-1])"
                pause
            }
            Pop-Location
        }
    }
}