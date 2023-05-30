
Function DownloadAndVerifySha256($FileUrl, $PublishedHash, $FilePath)
{
    # 校验文件是否需要下载
    do
    {
        if (Test-Path $FilePath)
        {
            $FileHash = Get-FileHash $FilePath -Algorithm SHA256
            if ($FileHash.Hash -eq $PublishedHash)
            {
                break;
            }
        }

        Invoke-WebRequest -Uri $FileUrl -OutFile $FilePath
        $FileHash = Get-FileHash $FilePath -Algorithm SHA256
        if ($FileHash.Hash -ne $PublishedHash)
        {
            throw "下载到的文件Sha256不一致！"
        }
    }while(0)
}

Function ExpandFile($FilePath, $ExpandRoot)
{
    $7ZipPath = '7z.exe'
    # 初始化7zip
    $7ZipKey = Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip"
    if ($7ZipKey.Path -ne '')
    {
        $7ZipPath =$7ZipKey.Path + '\' + '7z.exe'
    }

    &$7ZipPath x $FilePath "-o$ExpandRoot"
    if($lastexitcode -ne 0)
    {
        throw "$FilePath 解压失败！退出代码：$lastexitcode"
    }
}

Function SimplePack($FileUrl, $PublishedHash, $FileName, $SourceRootName)
{
    if ($FileName.Length -eq 0)
    {
        $FileName = $FileUrl.Substring($FileUrl.LastIndexOf("/")+1)
    }

    if ($FileName.Length -eq 0)
    {
        throw "文件名找不到！"
    }

    $TmpFileRoot = '.tmp'

    if (-not (Test-Path $TmpFileRoot))
    {
        mkdir -p $TmpFileRoot
    }

    $SourceRoot = $TmpFileRoot + '\Source'
    $SourceSuccess = $SourceRoot + '\__Successe__'

    if (-not (Test-Path $SourceSuccess))
    {
        $TmpZipFilePath = $TmpFileRoot + '\' + $FileName
        # 下载源代码
        DownloadAndVerifySha256 $FileUrl $PublishedHash $TmpZipFilePath

        if (Test-Path $SourceRoot)
        {
            Remove-Item -Recurse $SourceRoot
        }

        # 解压源代码
        ExpandFile $TmpZipFilePath  $SourceRoot
        mkdir -p $SourceSuccess
    }
    
    # 生成nuget包
    $SourceRoot += '\' + $SourceRootName;
    &nuget pack package.nuspec -p "Root=$SourceRoot" "@..\metadata.txt"
    if($lastexitcode -ne 0)
    {
        throw "nuget pack package.nuspec失败！退出代码：$lastexitcode"
    }
}