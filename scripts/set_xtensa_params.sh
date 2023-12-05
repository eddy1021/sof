# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2023 Intel Corporation. All rights reserved.

### XTENSA_ toolchain configuration shared across projects ###

# These variables are currently used in/by:
#
# - xtensa-build-all.sh (XTOS)
# - script/rebuild-testbench.sh
# - before Zephyr's `twister` or `west build`
#
# Not all variables are used in all use cases. Some are.
#
# The variables used by Zephyr are duplicated in
# xtensa-build-zephyr.py, please keep in sync!

# To maximize reuse, keep this script very basic and minimal and don't
# `export`: leave which the decision for each variable to the caller.


# Sourced script argument $1 is a non-standard bash extension
[ -n "$1" ] || {
    >&2 printf 'Missing platform argument\n'
    return 1 # Not exit!
}
platform=$1

case "$platform" in

    # Intel
    tgl)
	PLATFORM="tgplp"
	XTENSA_CORE="cavs2x_LX6HiFi3_2017_8"
	HOST="xtensa-cnl-elf"
	XTENSA_TOOLS_VERSION="RG-2017.8-linux"
	HAVE_ROM='yes'
	IPC4_CONFIG_OVERLAY="tigerlake_ipc4"
	# default key for TGL
	PLATFORM_PRIVATE_KEY="-D${SIGNING_TOOL}_PRIVATE_KEY=$SOF_TOP/keys/otc_private_key_3k.pem"
	;;
    tgl-h)
	PLATFORM="tgph"
	XTENSA_CORE="cavs2x_LX6HiFi3_2017_8"
	HOST="xtensa-cnl-elf"
	XTENSA_TOOLS_VERSION="RG-2017.8-linux"
	HAVE_ROM='yes'
	# default key for TGL
	PLATFORM_PRIVATE_KEY="-D${SIGNING_TOOL}_PRIVATE_KEY=$SOF_TOP/keys/otc_private_key_3k.pem"
	;;
    mtl|lnl)
	PLATFORM="$platform"
	XTENSA_CORE="ace10_LX7HiFi4_2022_10"
	XTENSA_TOOLS_VERSION="RI-2022.10-linux"
	# TODO: to reduce duplication, make rebuild-testbench "smarter"
	# and able to decode ZEPHYR_TOOLCHAIN_VARIANT (even when it does
	# not care about Zephyr)
	COMPILER="xt-clang"
	;;

    # NXP
    imx8)
	PLATFORM="imx8"
	XTENSA_CORE="hifi4_nxp_v3_3_1_2_2017"
	HOST="xtensa-imx-elf"
	XTENSA_TOOLS_VERSION="RG-2017.8-linux"
	;;
    imx8x)
	PLATFORM="imx8x"
	XTENSA_CORE="hifi4_nxp_v3_3_1_2_2017"
	HOST="xtensa-imx-elf"
	XTENSA_TOOLS_VERSION="RG-2017.8-linux"
	;;
    imx8m)
	PLATFORM="imx8m"
	XTENSA_CORE="hifi4_mscale_v0_0_2_2017"
	HOST="xtensa-imx8m-elf"
	XTENSA_TOOLS_VERSION="RG-2017.8-linux"
	;;
    imx8ulp)
	PLATFORM="imx8ulp"
	XTENSA_CORE="hifi4_nxp2_ulp_prod"
	HOST="xtensa-imx8ulp-elf"
	XTENSA_TOOLS_VERSION="RG-2017.8-linux"
	;;

    # AMD
    rn)
	PLATFORM="renoir"
	XTENSA_CORE="ACP_3_1_001_PROD_2019_1"
	HOST="xtensa-rn-elf"
	XTENSA_TOOLS_VERSION="RI-2019.1-linux"
	;;
    rmb)
	PLATFORM="rembrandt"
	ARCH="xtensa"
	XTENSA_CORE="LX7_HiFi5_PROD"
	HOST="xtensa-rmb-elf"
	XTENSA_TOOLS_VERSION="RI-2019.1-linux"
	;;
    vangogh)
	PLATFORM="vangogh"
	ARCH="xtensa"
	XTENSA_CORE="ACP_5_0_001_PROD"
	HOST="xtensa-vangogh-elf"
	XTENSA_TOOLS_VERSION="RI-2019.1-linux"
	;;
    acp_6_3)
	PLATFORM="acp_6_3"
	ARCH="xtensa"
	XTENSA_CORE="ACP_6_3_HiFi5_PROD_Linux"
	HOST="xtensa-acp_6_3-elf"
	XTENSA_TOOLS_VERSION="RI-2021.6-linux"
	;;

    # Mediatek
    mt8186)
	PLATFORM="mt8186"
	XTENSA_CORE="hifi5_7stg_I64D128"
	HOST="xtensa-mt8186-elf"
	XTENSA_TOOLS_VERSION="RI-2020.5-linux"
	;;
    mt8188)
	PLATFORM="mt8188"
	XTENSA_CORE="hifi5_7stg_I64D128"
	HOST="xtensa-mt8188-elf"
	XTENSA_TOOLS_VERSION="RI-2020.5-linux"
	;;
    mt8195)
	PLATFORM="mt8195"
	XTENSA_CORE="hifi4_8195_PROD"
	HOST="xtensa-mt8195-elf"
	XTENSA_TOOLS_VERSION="RI-2019.1-linux"
	;;

    *)
	>&2 printf 'Unknown xtensa platform=%s\n' "$platform"
	return 1
	;;
esac
