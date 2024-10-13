# インタープリタとコンパイラにおける処理速度の差

このリポジトリでは、プログラミング言語の実行速度を比較し、インタープリタとコンパイラの実行方法の違いを検証した。

対象とした言語は、Python、Ruby、JavaScript、Shell Script、C、C++、Java、Swift、Go、C#、アセンブリ言語の10つ。これらの言語は、インタープリタとコンパイラの両方で実行され、その特性を比較した。

比較する方法として、三角関数の積の和を一億回計算するプログラムと、ライプニッツの公式で円周率を一億回計算するプログラムを用意した。 2つのプログラムの実行時間の差から特性を比較した。これらのタスクは、計算量が多く、実行速度の違いを明確に示すことができると考えたからである。測定環境は、AMD Ryzen 7 5700U with Radeon Graphics (16) @ 4.372GHz プロセッサ、16GB メモリ、Ubuntu 22.04.5 LTS オペレーティングシステムである。なお、timeコマンドを使用し、ビルド時間も含めて計測した。

`System:
  Host: yuuki-ubuntu Kernel: 6.8.0-45-generic x86_64 bits: 64
    Desktop: GNOME 42.9 Distro: Ubuntu 22.04.5 LTS (Jammy Jellyfish)
Machine:
  Type: Convertible System: LENOVO product: 82R9 v: IdeaPad Flex 5 14ALC7
    serial: <superuser required>
  Mobo: LENOVO model: LNVNB161216 v: SDK0T76463 WIN
    serial: <superuser required> UEFI: LENOVO v: JCCN38WW date: 12/20/2023
Battery:
  ID-1: BAT0 charge: 47.6 Wh (99.2%) condition: 48.0/52.5 Wh (91.4%)
CPU:
  Info: 8-core model: AMD Ryzen 7 5700U with Radeon Graphics bits: 64
    type: MT MCP cache: L2: 4 MiB
  Speed (MHz): avg: 738 min/max: 400/4372 cores: 1: 400 2: 400 3: 400
    4: 400 5: 400 6: 1397 7: 400 8: 400 9: 2097 10: 400 11: 400 12: 400
    13: 3129 14: 400 15: 400 16: 400
Graphics:
  Device-1: AMD Lucienne driver: amdgpu v: kernel
  Device-2: IMC Networks Integrated Camera type: USB driver: uvcvideo
  Display: wayland server: X.Org v: 1.22.1.1 with: Xwayland v: 22.1.1
    compositor: gnome-shell driver: gpu: amdgpu resolution: 1920x1200~60Hz
  OpenGL: renderer: RENOIR (renoir LLVM 15.0.7 DRM 3.57 6.8.0-45-generic)
    v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.2
Audio:
  Device-1: AMD Renoir Radeon High Definition Audio driver: snd_hda_intel
  Device-2: AMD Raven/Raven2/FireFlight/Renoir Audio Processor driver: N/A
  Device-3: AMD Family 17h HD Audio driver: snd_hda_intel
  Sound Server-1: ALSA v: k6.8.0-45-generic running: yes
  Sound Server-2: PulseAudio v: 15.99.1 running: yes
  Sound Server-3: PipeWire v: 0.3.48 running: yes
Network:
  Device-1: Realtek RTL8822CE 802.11ac PCIe Wireless Network Adapter
    driver: rtw_8822ce
  IF: wlp2s0 state: up mac: b8:1e:a4:9b:7b:ef
  IF-ID-1: docker0 state: down mac: 02:42:d6:fb:dc:c7
  IF-ID-2: lxcbr0 state: down mac: 00:16:3e:00:00:00
Bluetooth:
  Device-1: Realtek Bluetooth Radio type: USB driver: btusb
  Report: hciconfig ID: hci0 rfk-id: 0 state: down
    bt-service: enabled,running rfk-block: hardware: no software: yes
    address: B8:1E:A4:9B:7B:F0
Drives:
  Local Storage: total: 476.94 GiB used: 66.76 GiB (14.0%)
  ID-1: /dev/nvme0n1 vendor: KIOXIA model: N/A size: 476.94 GiB
Partition:
  ID-1: / size: 115.54 GiB used: 66.72 GiB (57.7%) fs: ext4
    dev: /dev/nvme0n1p7
  ID-2: /boot/efi size: 256 MiB used: 43.7 MiB (17.1%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  Alert: No swap data was found.
Sensors:
  System Temperatures: cpu: 61.0 C mobo: 45.0 C
  Fan Speeds (RPM): N/A
Info:
  Processes: 381 Uptime: 1h 23m Memory: 14.96 GiB used: 3.75 GiB (25.1%)
  Shell: Bash inxi: 3.3.13
`
