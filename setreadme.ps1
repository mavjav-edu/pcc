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
    $chNum = (Select-String -InputObject $htmlFile.Name -Pattern "(\d+)").Matches.Value
    $README_md = "chapter_$chNum\README.md"
    $tiys = $HTML.getElementsByClassName('sidebar')
    if($TESTING){
        foreach($tiy in $tiys){
            ("<BR/>" + $tiy.innerHTML -creplace '<STRONG>TRY IT YOURSELF</STRONG>','<H2>TRY IT YOURSELF</H2>' | pandoc @("--from=HTML", "--to=markdown_mmd+backtick_code_blocks")) -replace '\[([^\]]+)\]\{\.literal\}','`$1`' -replace 'ch(\d+)\.html','../chapter_$1/README.md' | Out-Host
            pause
        }
    }else{
        foreach($tiy in $tiys){
            ("<BR/>" + $tiy.innerHTML -creplace '<STRONG>TRY IT YOURSELF</STRONG>','<H2>TRY IT YOURSELF</H2>' | pandoc @("--from=HTML-native_divs-native_spans", "--to=markdown_mmd+backtick_code_blocks") ) -replace '\[([^\]]+)\]\{\.literal\}','`$1`'  -replace 'ch(\d+)\.html','../chapter_$1/README.md'| Out-File -FilePath  -Append $README_md -Encoding utf8
        }
    }
}