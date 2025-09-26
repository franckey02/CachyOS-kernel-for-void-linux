#! /bin/sh
sudo xbps-install base-devel git bc kmod elfutils cpio xz lz4 zstd flex bison libelf openssl-devel
git clone https://github.com/CachyOS/linux-cachyos.git
cd linux-cachyos
cp config-bore .config
cd linux-cachyos-bore
VERSION="6.16.8"
wget "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$VERSION.tar.xz"
tar -xf "linux-$VERSION.tar.xz"
cd "linux-$VERSION"
wget -O ../0001-cachyos-base-all.patch "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.16/all/0001-cachyos-base-all.patch"
wget -O ../0001-bore-cachy.patch "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.16/sched/0001-bore-cachy.patch"
patch -p1 < ../0001-cachyos-base-all.patch
patch -p1 < ../0001-bore-cachy.patch
cp ../config .config
ls -la .config
scripts/config -e CACHY
scripts/config -e SCHED_BORE
scripts/config -d CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_PERFORMANCE_O3
scripts/config -d HZ_300 -e HZ_1000 --set-val HZ 1000
scripts/config -d HZ_PERIODIC -d NO_HZ_IDLE -e NO_HZ_FULL_NODEF -e NO_HZ_FULL -e NO_HZ -e NO_HZ_COMMON -e CONTEXT_TRACKING
scripts/config -e PREEMPT_DYNAMIC -e PREEMPT -d PREEMPT_VOLUNTARY -d PREEMPT_LAZY -d PREEMPT_NONE
scripts/config -d TRANSPARENT_HUGEPAGE_MADVISE -e TRANSPARENT_HUGEPAGE_ALWAYS
scripts/config -e USER_NS
make olddefconfig
make prepare
make -j$(nproc) bzImage modules
