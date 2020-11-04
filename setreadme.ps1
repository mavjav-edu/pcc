$book = [System.IO.File]::ReadAllBytes("Python Crash Course_ A Hands-On - Eric Matthes.epub")
[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression')
$zipStream = New-Object System.IO.Memorystream
$zipStream.Write($book,0,$book.Count)
$zipFile = [System.IO.Compression.ZipArchive]::new($zipStream)
$htmlFiles = $zipFile.Entries | Where-Object -Property FullName -Match "ch\d+\.html"
foreach($htmlFile in $htmlFiles){
    $chapter  = $zipFile.GetEntry($htmlFile) 
    $chapter.Open().Read(($chContentBytes = [byte[]]::new($chapter.Length)),0,$($chapter.Length))
    $chContentStr = [System.Text.Encoding]::Default.GetString($chContentBytes)
    $HTML = New-Object -Com "HTMLFile"
    $HTML.write([ref]$chContentStr)
    $HTML.getElementsByClassName('sidebar')
    $tiy = $HTML.getElementsByClassName('sidebar')     
    "<BR/>" + $tiy[0].innerHTML -creplace '<STRONG>TRY IT YOURSELF</STRONG>','<H2>TRY IT YOURSELF</H2>' | pandoc @("--from=HTML", "--to=MARKDOWN") | Out-File -FilePath "C:\Users\MavaddatJavid\Documents\GitHub\pcc\chapter_$((Select-String -InputObject $htmlFile.Name -Pattern "(\d+)").Matches.Value)\README.md" -Append -Encoding utf8
}
