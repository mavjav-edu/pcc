#Requires -PSEdition Core
$TESTING = $true
$MDs = Get-ChildItem -Filter *.md -Recurse
foreach($MD in $MDs) {
    $MDcontent = Get-Content $MD
    $mentionsPYfile = $MDcontent | Select-String -Pattern '(?<=[^\/\*\[\w\(])\*?([^\s\[\]]+\.py)\*?(?=[^\*\]\w\)])?' -AllMatches
    foreach ($mention in $mentionsPYfile) {
        $pathToPyPossible = Join-Path $MD.Directory $mention.Matches.Groups[1].Value
        if(Test-Path $pathToPyPossible -ErrorAction SilentlyContinue) {
            Push-Location $MD.Directory
            $relPathToPy = (Resolve-Path $pathToPyPossible -Relative) -replace '^\.\\',''
            $changedLine = ($mention) -replace $mention.Pattern,"[`$0]($relPathToPy)"
            if($changedLine -ne  $MDcontent[($mention.LineNumber)-1]){
                $MDcontent[($mention.LineNumber)-1] = $changedLine
            }
            $MDcontent[($mention.LineNumber)-1] = ($mention) -replace $mention.Pattern,"[`$0]($relPathToPy)"
            if(-not $TESTING) {
                Set-Content -Path $MD -Value $MDcontent
            } else {
                Write-Host "'$MD' would get:`t$($MDcontent[($mention.LineNumber)-1])"
            }
            Pop-Location
        }
    }
}