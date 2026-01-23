Import-Module "..\..\public.psm1"

$FileUrl = 'https://codeload.github.com/open-source-parsers/jsoncpp/zip/refs/tags/1.7.2'
$PublishedHash = '90618516abaed488d23f7b7e358341075073cbdce3d1ed0329bb23cdaaa66183'
$SourceRootName = 'jsoncpp-1.7.2'

SimplePack $FileUrl $PublishedHash $null $SourceRootName
