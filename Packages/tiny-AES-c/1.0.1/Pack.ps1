Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/kokke/tiny-AES-c/archive/23856752fbd139da0b8ca6e471a13d5bcc99a08d.zip'
$PublishedHash = '8dccb5b4af2cc8bec9d7196e435963a74bfec6af933518e3fd0284957c5fb908'
$SourceRootName = 'tiny-AES-c-23856752fbd139da0b8ca6e471a13d5bcc99a08d'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
