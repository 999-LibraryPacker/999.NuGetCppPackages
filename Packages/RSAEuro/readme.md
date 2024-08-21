## diff文件说明

* extern_c_fix.diff

这是一个纯C库，但是个别头文件又没有C修饰。C++ include时会认为是 C++ 声明。会导致找不到符号。
该diff提高了对C++的兼容性。

* IDOK_Fix

Windows SDK本身也恰好有一个IDOK宏。但值并不一致。这导致一些异常。所以我们把IDOK改个名字。
> 注意：官方1.4其实已经解决了这个问题。我们也按官方的修改制作了diff应用于老版本。

* Custom_MAX_RSA_MODULUS_BITS

改库默认的RSA密钥长度为1024，现在来说比较容易被攻击。
所以我们允许自定义 MAX_RSA_MODULUS_BITS 值，以提高安全性。