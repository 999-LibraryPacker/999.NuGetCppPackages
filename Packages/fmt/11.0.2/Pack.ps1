Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/fmtlib/fmt/archive/refs/tags/11.0.2.zip'
$PublishedHash = '7aa4b58e361de10b8e5d7b6c18aebd98be1886ab3efe43e368527a75cd504ae4'
$SourceRootName = 'fmt-11.0.2'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
