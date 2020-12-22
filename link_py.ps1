#Requires -PSEdition Core
$TESTING = $false
$MDs = Get-ChildItem -Filter *.md -Recurse
foreach($MD in $MDs) {
    $MDcontent = Get-Content $MD
    $mentionsPYfile = $MDcontent | Select-String -Pattern '(?<=[^\/\*\[\w\(])\*?([^\s\[\]]+\.py)\*?(?=[^\*\]\w\)])?' -AllMatches
    foreach ($mention in $mentionsPYfile) {
        $pathToPyPossible = Resolve-Path '.';
        if($MD.Name -like 'chapter_*.md') {
            $backChPath = Resolve-Path ".\$($MD.Name -replace '_(\d{1})\.md$','_0$1' -replace '\.md$','' )"
            $pathToPyPossible = Join-Path $backChPath $mention.Matches.Groups[1].Value
        } else {
            $pathToPyPossible = Join-Path $MD.Directory $mention.Matches.Groups[1].Value
        }
        if(Test-Path $pathToPyPossible -ErrorAction SilentlyContinue) {
            Push-Location $MD.Directory
            $relPathToPy = (Resolve-Path $pathToPyPossible -Relative) -replace '^\.\\','' -replace '\\','/'
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