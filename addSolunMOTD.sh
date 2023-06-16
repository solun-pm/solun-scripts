#!/bin/sh

# This script will add the MOTD for the Solun Network servers.
# Use *chmod +x addSolunMOTD.sh* to execute

echo 'This script will add the MOTD for the Solun Network servers.'
echo ''
echo 'Please enter the server name and environment.'
echo 'Format: | SOLUN - AUTH - PRODUCTION | so, SOLUN - SERVERNAME - ENVIRONMENT |'
echo 'Available environments: | PRODUCTION | DEVELOPMENT |'
read -p 'Enter the server name: ' serverName
read -p 'Enter the environment: ' environment
if [ "$environment" = "PRODUCTION" ]; then
    environment="PRODUCTION"
    color='$(color 1)'
elif [ "$environment" = "DEVELOPMENT" ]; then
    environment="DEVELOPMENT"
    color='$(color 4)'
else
    echo 'Invalid environment, please try again.'
    exit 1
fi

sudo apt-get update && apt-get upgrade -y
sudo apt-get install neofetch -y

mkdir /etc/neofetch/
touch /etc/neofetch/config.conf
echo '
print_info() {
    info underline
    prin "'${color}'SOLUN - '${serverName}' - '${environment}'"
    info underline
    info title
    info underline

    info "OS" distro
    info "Uptime" uptime
    info "DE" de
    info "WM" wm
    info "WM Theme" wm_theme
    info "Theme" theme
    info "Icons" icons
    info "Terminal Font" term_font
    info "Memory" memory
    info "Local IP" local_ip
}
title_fqdn="off"
kernel_shorthand="on"
distro_shorthand="off"
os_arch="on"
uptime_shorthand="on"
memory_percent="off"
memory_unit="mib"
package_managers="on"
shell_path="off"
shell_version="on"
speed_type="bios_limit"
speed_shorthand="off"
cpu_brand="on"
cpu_speed="on"
cpu_cores="logical"
cpu_temp="off"
gpu_brand="on"
gpu_type="all"
refresh_rate="off"
gtk_shorthand="off"
gtk2="on"
gtk3="on"
public_ip_host="http://ident.me"
public_ip_timeout=2
local_ip_interface=('auto')
de_version="on"
disk_show=('/')
disk_subtitle="mount"
disk_percent="on"
music_player="auto"
song_format="%artist% - %album% - %title%"
song_shorthand="off"
mpc_args=()
colors=(distro)
bold="on"
underline_enabled="on"
underline_char="-"
separator=":"
block_range=(0 15)
color_blocks="on"
block_width=3
block_height=1
col_offset="auto"
bar_char_elapsed="-"
bar_char_total="="
bar_border="on"
bar_length=15
bar_color_elapsed="distro"
bar_color_total="distro"
memory_display="off"
battery_display="off"
disk_display="off"
image_backend="ascii"
image_source="auto"
ascii_distro="auto"
ascii_colors=(distro)
ascii_bold="on"
image_loop="off"
thumbnail_dir="${XDG_CACHE_HOME:-${HOME}/.cache}/thumbnails/neofetch"
crop_mode="normal"
crop_offset="center"
image_size="auto"
catimg_size="2"
gap=3
yoffset=0
xoffset=0
background_color=
stdout="off"
' >> /etc/neofetch/config.conf

touch /etc/neofetch/solun
echo '
${c1}
                         !
                      : !5
          :7.        .P^JP~
           !PJ^.     ^B5YPY.
          .!7YP5?~:. :BBGP5?
           ~P5YPPP5Y7 JBGP55! 7YJ~
            :JPGPP55Y~.YGP5YY^?G!.
              .!?YYYY!:PPP5YY7.^
                  :?JJ^?GP55Y^.
                   .^~^ ?G5?^^7
               :7JJ7!^^.:7~~?Y~
             :JPJ~^!?!^^!JYY7:
          .~JPY^ !55~~YPY!:
      .^!?YY7:  !P5^?BJ:
       ...     :PP~^G^
              ^55~ ::
            :7Y!.
           :^:

' >> /etc/neofetch/solun

rm -rf /etc/motd
touch /etc/motd

touch /etc/profile.d/motd.sh
chmod +x /etc/profile.d/motd.sh

echo '
#!/bin/sh
printf "\n"
/usr/bin/neofetch --config /etc/neofetch/config.conf --ascii /etc/neofetch/solun --ascii_colors 4
printf "\n"
' >> /etc/profile.d/motd.sh

echo 'MOTD has been added, please login again to see the changes.'

exit 0
