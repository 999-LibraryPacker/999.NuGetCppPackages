# 1. 关于
> 以下一切都是初步的，仅供演示使用。

为什么我叫`999`？这表示实在是太厉害了，以至于把`666`都`6`倒了。

我们为什么要创建这个仓库呢？主要原因是`vcpkg`不好用，无法解决我们的需求，比如我手里有多个项目，一共需要使用2个不同版本的`libpng`，我该怎么办呢？

而`NuGet`它可以很轻松的解决这类问题。当然`NuGet`不受微软待见，支持的库不多，需要手工打包。
为了减少重复性的打包工作，所以我们一伙人一起打包。大家彼此相互互通，也欢迎加入我们！

当然，由于微软官方全力推广`vcpkg`，短期从包的数量看是无法比较的。

## 1.1. 如何使用我们上传的包？
> 我们提供的包主要为源码包，也就是它将在您的项目中自动编译，以适应不同编译器、CPU或者操作系统。请放心使用。

只需要在nuget中搜索`999.`即可，所有我们上传的nuget包均已`999`开头，比如说`999.zlib`。

# 2. 导航
某些C/C++库它官方已经提供了`NuGet`支持。我们再次收集罗列了，也感谢那些开发者官方提供NuGet包！

* [官方直接支持的Nuget包](OfficialPackages.md)

# 3. 如何一个C++源码包【入门】
首先我们从[zlib仓库](https://github.com/madler/zlib.git)拉取代码，下面教程都将以zlib为例进行讲解。

## 3.1. 编写第一个C++源码包——zlib
示例地址：[FirstNuGet-zlib](Example/FirstNuGet-zlib)

### 3.1.1. 分析

具体可以参考这个文件，编译过程总体是挺简单的就是编译根目录下特定几个c文件编译以下，而且恰好不依赖其他库。
https://github.com/madler/zlib/blob/master/CMakeLists.txt#L105

但是注意，zconf.h与zlib.h它是公共头文件，我们需要单独存放。

简单说，我们只需要做这几件事：
1. 创建nuspec文件，提供nuget包的描述信息
2. 把跟目录下有用的源代码还有头文件加入nuget包中。
3. 准备一个targets，用于发起源代码编译任务。


### 3.1.2. 编写nuspec清单
nuspec 它描述的NuGet包的一些基本信息（比如说包的名称、描述）以及这个包包含了哪些文件。

```xml
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2013/05/nuspec.xsd">
  <metadata minClientVersion="2.5">
    <id>999.zlib</id>
    <!--版本号？你拉了什么版本你就写啥版本不用我解释把……-->
    <version>1.2.11</version>
    <!--作者填写库的原始作者即可。-->
    <authors>Jean-loup Gailly, Mark Adler</authors>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <license type="expression">Zlib</license>
    <licenseUrl>https://licenses.nuget.org/Zlib</licenseUrl>
    <projectUrl>https://zlib.net/</projectUrl>
    <description>zlib is a general purpose data compression library.  All the code is
      thread safe.  The data format used by the zlib library is described by RFCs
      (Request for Comments) 1950 to 1952 in the files
      http://www.ietf.org/rfc/rfc1950.txt (zlib format), rfc1951.txt (deflate format)
      and rfc1952.txt (gzip format).</description>
    <summary>zlib is a general purpose data compression library.</summary>
    <releaseNotes>- Apply security vulnerability fixes to contrib/infback9 as well
      - Clean up some text files (carriage returns, trailing space)
      - Update testzlib, vstudio, masmx64, and masmx86 in contrib [Vollant]</releaseNotes>
    <copyright>(C) 1995-2010 Jean-loup Gailly and Mark Adler</copyright>
    <!--一般这样就可以了。-->
    <tags>native nativepackage</tags>
    <repository type="git" url="https://github.com/madler/zlib.git" branch="master" commit="cacf7f1d4e3d44d871b605da3b647f07d718623f" />
    <dependencies>
      <!--注意，这里需要有依赖，因为C++导入源码相对不友好，这个库可以大大简化这个流程
      所以不要移除这个依赖包，除非你自己打算写很多代码！-->
      <dependency id="YY.NuGet.Import.Helper" version="1.0.0.4" />
    </dependencies>
  </metadata>
  <files>
    <!--把跟目录的.h .c文件打包到包里 build\native\src 处-->
    <file src=".\zconf.h;.\zlib.h" target="build\native\zlib"/>
    <file src=".\*.h;.\*.c" target="build\native\src" exclude=".\zconf.h;.\zlib.h"/>
    <!--注意，999.zlib.targets，名字必须跟id一样！否则不生效-->
    <file src=".\999.zlib.targets" target="build\native\999.zlib.targets"/>
  </files>
</package>
```
### 3.1.2. 编写999.zlib.targets
targets中，我们把c文件发起编译任务。其内容如下：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <!--把zlib文件夹加入inlcude列表-->
    <IncludePath>$(MSBuildThisFileDirectory)zlib;$(IncludePath)</IncludePath>
  </PropertyGroup>
  <ItemGroup>
    <!--注意，下面的设置仅影响zlib的相关文件，不影响工程本身-->
    <NuGetExConnentFiles Include="$(MSBuildThisFileDirectory)src\*.c">
      <NuGetPackageId>$(MSBuildThisFileName)</NuGetPackageId>
      <BuildAction>ClCompile</BuildAction>
      <!--关闭预编译头-->
      <PrecompiledHeader>NotUsing</PrecompiledHeader>
      <SDLCheck>false</SDLCheck>
      <ConformanceMode>false</ConformanceMode>
      <ObjectFileName>$(IntDir)$(MSBuildThisFileName)\</ObjectFileName>
      <!--关闭视警告为错误，万一项目配置了，这会失败。-->
      <TreatWarningAsError>false</TreatWarningAsError>
      <TreatSpecificWarningsAsErrors></TreatSpecificWarningsAsErrors>
      <!--关闭所有警告，反正是第三方的开源库，你去解决警告吗？-->
      <WarningLevel>TurnOffAllWarnings</WarningLevel>
      <!--保持默认编译行为 .c 编译为 c，其他cpp-->
      <CompileAs>Default</CompileAs>
    </NuGetExConnentFiles>
  </ItemGroup>
</Project>
```
### 3.1.2. 打包
打包过程非常简单，输入：
```
pushd "zlib代码根目录"
nuget pack 你的nuspec路径
```
然后代码根目录会生成一个 `999.zlib.1.2.11.nupkg`。

> 注意：nuspec以及targets记得放在根目录，否则会找不到文件而失败。

>  没有nuget则自己去微软官方下载：https://dist.nuget.org/win-x86-commandline/latest/nuget.exe

现在我们第一个源码包就做好了。

### 3.1.3. 自测
一般来说，人容易犯错，所以需要自测一下，减少包出问题的概率。方法如下：
```
# 先添加到本地测试目录
nuget add "你的nuget包目录" -source "本地测试目录，比如说：D:\NuGetTest"

# 然后把 D:\NuGetTest 添加到NuGet源目录，VS里就可以安装你的nuget包了，它将自动在你的项目里编译，然后你可以直接include使用。

```

## 3.2. 添加contentfiles特性支持
示例地址：[contentfiles-Support](Example/contentfiles-Support)

也许你有疑问，如果我只需要使用zlib的头文件怎么办，有时可能只需要用它的数据结构？这时需要包支持`contentfiles`特性，然后就可以在vcxproj中这样：

```
<PackageReference Include="999.zlib">
  <Version>1.2.11</Version>
  <!--这个ExcludeAssets=contentfiles是关键，它将阻止zlib发生编译。-->
  <ExcludeAssets>contentfiles</ExcludeAssets>
</PackageReference>
```

但是怎么添加`contentfiles`支持呢？由于C++对`contentfiles`支持的不好，我们需要变通一下。

在代码根目录创建一个名字为`999.zlib.txt`的空白文件。

* 999.zlib.nuspec 文件新增的内容如下：
```
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2013/05/nuspec.xsd">
  <metadata minClientVersion="2.5">
    <!--...其他内容-->
    <contentFiles>
      <!--我们将通过它来检测 contentFiles 特性开启以及关闭-->
      <files include="any\any\999.zlib.txt" buildAction="Content" copyToOutput="false"/>
    </contentFiles>
  </metadata>
  <files>
    <!--...其他内容-->

    <!--注意添加2次，第一个是支持NuGet PR模式的contentFiles，第二个是支持NuGet PC模式的 contentFiles-->
    <file src=".\999.zlib.txt" target="contentFiles\any\any\999.zlib.txt"/>
    <file src=".\999.zlib.txt" target="Content\NuGet\999.zlib.txt"/>
  </files>
</package>
```

完毕，然后重新打包验证一下`contentfiles`吧！

## 3.3. 添加动态库支持
示例地址：[DLL-Support](Example/DLL-Support)

比如说，我想把多个库打成一个动态库dll。这可能为了提升重用减少体积，也可以减少重复编译工作。

> 因为我们是源码包，多个项目中包含这势必会导致多次重复性的编译工作。

为了方便开启这个功能，我们额外需要一个GUI设置界面，所以我们需要准备一个`PropertyPageSchema`。
* 999.zlib.ui_AD9F2879-322B-4D9D-A026-47D0B4970444.xml 新增文件，实现GUI的设置能力
具体自行观察示例中的此文件。我们下面提供了三种设置。
1. 以 静态库 使用本库（Static）
2. 以 共享DLL 使用本库（dllimport） -- 使用外部的dll
3. 向 共享DLL 导出本库（dllexport） -- 编译出导出开源库的dll，其他工程可以使用这个dll。

> 注意：设置我们统一安排在 `NuGet程序包设置` - `zlib`，中并且使用`zlib_static_ref_mode`属性中保存设置。

* 999.zlib.targets 为了让`zlib_static_ref_mode`属性生效，此文件也需要修改。
我们主要是增加了`PreprocessorDefinitions`配置，为什么这样增加则需要需要阅读 [zlib/zconf.h](https://github.com/madler/zlib/blob/master/zconf.h#L338)，这很难教……

* 999.zlib.nuspec 文件新增的内容如下：
```xml
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2013/05/nuspec.xsd">
  <!--其他内容-->
  <files>
    <!--其他内容-->

    <!--额外添加设置界面-->
    <file src=".\999.zlib.ui_AD9F2879-322B-4D9D-A026-47D0B4970444.xml" target="build\native"/>
  </files>
</package>
```

可以打包后可以在VS的属性中看到设置界面了。
