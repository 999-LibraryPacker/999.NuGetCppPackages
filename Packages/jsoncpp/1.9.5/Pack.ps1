Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/1.9.5.zip'
$PublishedHash = 'a074e1b38083484e8e07789fd683599d19da8bb960959c83751cd0284bdf2043'
$SourceRootName = 'jsoncpp-1.9.5'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
