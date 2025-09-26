# Linea de comandos para Kernel standard
```sh
sudo xbps-install base-devel git bc kmod elfutils elfutils-devel cpio xz lz4 zstd flex bison libelf openssl-devel
VERSION="6.12.48"
wget "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$VERSION.tar.xz"
tar -xf "linux-$VERSION.tar.xz"
cd "linux-$VERSION"
make oldconfig
make prepare
wget -O ../0001-cachyos-base-all.patch "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.12/all/0001-cachyos-base-all.patch"
wget -O ../0001-bore-cachy.patch "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.12/sched/0001-bore-cachy.patch"
patch -p1 < ../0001-cachyos-base-all.patch
patch -p1 < ../0001-bore-cachy.patch
# Activa BORE
./scripts/config -e SCHED_BORE
# Tick rate 1000 Hz
./scripts/config -d HZ_300 -e HZ_1000 --set-val HZ 1000
# Full tickless
./scripts/config -d HZ_PERIODIC -d NO_HZ_IDLE -e NO_HZ_FULL -e NO_HZ
# Preempt full
./scripts/config -e PREEMPT -e PREEMPT_DYNAMIC
# O3
./scripts/config -d CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_PERFORMANCE_O3
# THP always
./scripts/config -d TRANSPARENT_HUGEPAGE_MADVISE -e TRANSPARENT_HUGEPAGE_ALWAYS
# CachyOS config flag
./scripts/config -e CACHY
# User namespaces
./scripts/config -e USER_NS
make -j2 bzImage modules
sudo make modules_install
sudo cp arch/x86_64/boot/bzImage /boot/vmlinuz-6.12.48 
sudo dracut --force --kver 6.12.48
```
# Linea de comandos para custom kernel
```sh
sudo xbps-install base-devel git bc kmod elfutils elfutils-devel cpio xz lz4 zstd flex bison libelf openssl-devel
VERSION="6.12.48"
wget "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$VERSION.tar.xz"
tar -xf "linux-$VERSION.tar.xz"
cd "linux-$VERSION"
make localmodconfig 
make menuconfig
wget -O ../0001-cachyos-base-all.patch "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.12/all/0001-cachyos-base-all.patch"
wget -O ../0001-bore-cachy.patch "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.12/sched/0001-bore-cachy.patch"
patch -p1 < ../0001-cachyos-base-all.patch
patch -p1 < ../0001-bore-cachy.patch
# Activa BORE
./scripts/config -e SCHED_BORE
# Tick rate 1000 Hz
./scripts/config -d HZ_300 -e HZ_1000 --set-val HZ 1000
# Full tickless
./scripts/config -d HZ_PERIODIC -d NO_HZ_IDLE -e NO_HZ_FULL -e NO_HZ
# Preempt full
./scripts/config -e PREEMPT -e PREEMPT_DYNAMIC
# O3
./scripts/config -d CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_PERFORMANCE_O3
# THP always
./scripts/config -d TRANSPARENT_HUGEPAGE_MADVISE -e TRANSPARENT_HUGEPAGE_ALWAYS
# CachyOS config flag
./scripts/config -e CACHY
# User namespaces
./scripts/config -e USER_NS
make -j2 bzImage modules
sudo make modules_install
sudo cp arch/x86_64/boot/bzImage /boot/vmlinuz-6.12.48-cachyos-jc 
sudo dracut --force --kver 6.12.48-cachyos-jc
```
