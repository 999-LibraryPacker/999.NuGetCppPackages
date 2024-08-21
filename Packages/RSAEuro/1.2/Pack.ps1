Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/mort666/RSAEuro/archive/4bca493591620ffa4008ac1bbb6f431669286ea1.zip'
$PublishedHash = '06e025a38fc0fd56917b94c4c95d57e05a634a2a21197f534fb63f23584e065c'
$SourceRootName = 'RSAEuro-4bca493591620ffa4008ac1bbb6f431669286ea1'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
