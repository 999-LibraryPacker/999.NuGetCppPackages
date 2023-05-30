Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/madler/zlib/releases/download/v1.2.13/zlib1213.zip'
$PublishedHash = 'd233fca7cf68db4c16dc5287af61f3cd01ab62495224c66639ca3da537701e42'
$SourceRootName = 'zlib-1.2.13'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
