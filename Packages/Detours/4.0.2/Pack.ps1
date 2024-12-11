Import-Module "..\..\public.psm1"

$FileUrl = 'https://github.com/microsoft/Detours/archive/4b8c659f549b0ab21cf649377c7a84eb708f5e68.zip'
$PublishedHash = '08d965a8374ca1e56bcf05380d2ee7daa846080b85d568223a41c20b5913bbf8'
$SourceRootName = 'Detours-4b8c659f549b0ab21cf649377c7a84eb708f5e68'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
