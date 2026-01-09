Import-Module "..\..\public.psm1"

$FileUrl = 'https://sqlite.org/2025/sqlite-amalgamation-3510100.zip'
# 官网是：856b52ffe7383d779bb86a0ed1ddc19c41b0e5751fa14ce6312f27534e629b64，为何？？？
$PublishedHash = '84a85d6a1b920234349f01720912c12391a4f0cb5cb998087e641dee3ef8ef2e'
$SourceRootName = 'sqlite-amalgamation-3510100'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
