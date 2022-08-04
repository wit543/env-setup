
problem glib
```
pamac: /usr/lib/libc.so.6: version `GLIBC_2.34' not found (required by /usr/lib/libstdc++.so.6)
pamac: /usr/lib/libc.so.6: version `GLIBC_2.35' not found (required by /usr/lib/libgcc_s.so.1)
pamac: /usr/lib/libc.so.6: version `GLIBC_2.34' not found (required by /usr/lib/libgcc_s.so.1)
```
answer:
```
> sudo pacman -S glibc lib32-glibc
```
