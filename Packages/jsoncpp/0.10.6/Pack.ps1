Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/0.10.6.zip'
$PublishedHash = '7f1f2a8c5f3c20c46900d154fb0c8180bd4ada3dc9de9e67e16d4b974fb2d4f5'
$SourceRootName = 'jsoncpp-0.10.6'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
