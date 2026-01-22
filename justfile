# ==============================================================================
#  Default
# ==============================================================================

# List all available commands
default:
    @just --list

# ==============================================================================
#  Lede Config
# ==============================================================================
lede-config_image_name := "kyxie/lede-config:latest"
lede-config_output_dir := "openwrt"

# Generate OpenWrt .config
lede-config:
    @mkdir -p {{lede-config_output_dir}}
    docker run --rm -it \
        -v $(pwd)/{{lede-config_output_dir}}:/mnt/output \
        {{lede-config_image_name}} \
        bash -c "cp -f .config /mnt/output/.config 2>/dev/null || true; make menuconfig && cp .config /mnt/output/.config && echo 'Done: .config saved to {{lede-config_output_dir}}/'"
