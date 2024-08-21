Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/kokke/tiny-AES-c/archive/refs/tags/v1.0.0.zip'
$PublishedHash = 'b1c28e0f6bd77785faf078f4519955d17f6bceab4b235cd9df445f6f0a93f644'
$SourceRootName = 'tiny-AES-c-1.0.0'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
