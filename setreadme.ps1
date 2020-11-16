$TESTING = $true

$book = [System.IO.File]::ReadAllBytes("C:\Users\MavaddatJavid\Calibre Portable\Calibre Library\Eric Matthes\Python Crash Course_ A Hands-On, Pr (112)\Python Crash Course_ A Hands-On - Eric Matthes.epub")
[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression')
$zipStream = New-Object System.IO.Memorystream
$zipStream.Write($book,0,$book.Count) | Out-Null
$zipFile = [System.IO.Compression.ZipArchive]::new($zipStream)
$htmlFiles = $zipFile.Entries | Where-Object -Property FullName -Match "ch\d+\.html"
foreach($htmlFile in $htmlFiles){
    $chapter  = $zipFile.GetEntry($htmlFile) 
    $chapter.Open().Read(($chContentBytes = [byte[]]::new($chapter.Length)),0,$($chapter.Length))
    $chContentStr = [System.Text.Encoding]::Default.GetString($chContentBytes)
    $HTML = New-Object -Com "HTMLFile"
    $HTML.write([ref]$chContentStr) | Out-Null
    $tiys = $HTML.getElementsByClassName('sidebar')
    if($TESTING){
        foreach($tiy in $tiys){
            "<BR/>" + $tiy.innerHTML -creplace '<STRONG>TRY IT YOURSELF</STRONG>','<H2>TRY IT YOURSELF</H2>' -replace '\[([^\]]+)\]\{\.literal\}','`$1`' | pandoc @("--from=HTML", "--to=MARKDOWN")  
        }
    }else{
        foreach($tiy in $tiys){
            "<BR/>" + $tiy.innerHTML -creplace '<STRONG>TRY IT YOURSELF</STRONG>','<H2>TRY IT YOURSELF</H2>' -replace '\[([^\]]+)\]{.literal}','`$1`' | pandoc @("--from=HTML", "--to=MARKDOWN")  | Out-File -FilePath "chapter_$((Select-String -InputObject $htmlFile.Name -Pattern "(\d+)").Matches.Value)\README.md" -Append -Encoding utf8
        }
    }
}