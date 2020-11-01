$book = [System.IO.File]::ReadAllBytes("C:\Users\MavaddatJavid\Calibre Portable\Calibre Library\Eric Matthes\Python Crash Course_ A Hands-On, Pr (112)\Python Crash Course_ A Hands-On - Eric Matthes.epub")
[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression');  $zipStream = New-Object System.IO.Memorystream;   $zipStream.Write($book,0,$book.Count)
$zipFile = [System.IO.Compression.ZipArchive]::new($zipStream)
$htmlFiles = $zipFile.Entries | Where-Object -Property FullName -Match "ch\d+\.html"
foreach($htmlFile in $htmlFiles){
    $chapter  = $zipFile.GetEntry($htmlFile) 
    $chapter.Open().Read(($chContentBytes = [byte[]]::new($chapter.Length)),0,$($chapter.Length))
    $chContentStr = [System.Text.Encoding]::Default.GetString($chContentBytes)
    $HTML = New-Object -Com "HTMLFile"
    $HTML.write([ref]$chContentStr)
    $HTML.getElementsByClassName('sidebar')
}
