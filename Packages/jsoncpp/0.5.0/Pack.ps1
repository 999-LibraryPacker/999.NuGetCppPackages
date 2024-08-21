Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/svn-release-0.5.0.zip'
$PublishedHash = '2d920cda0cd44c43b513854c60a0c04928b5ed0dbb035a5f9909f7c33db1664f'
$SourceRootName = 'jsoncpp-svn-release-0.5.0'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
