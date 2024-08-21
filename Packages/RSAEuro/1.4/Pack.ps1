Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/mort666/RSAEuro/archive/2c09173b1ee86826308f3e3fb623e50b3c8cf158.zip'
$PublishedHash = '2b2541f0c879d2af78820aaa27dd7f1ab14a0a7daea4f439d7cf2800ccdd83d6'
$SourceRootName = 'RSAEuro-2c09173b1ee86826308f3e3fb623e50b3c8cf158'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
