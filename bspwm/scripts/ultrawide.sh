#!/bin/sh
restart_polybar()
{
killall polybar
polybar top &
}

add_uw_resolution()
{
xrandr --newmode "uw" 230.00 2560 2720 2992 3424  1080 1083 1093 1120 -hsync +vsync
xrandr --addmode HDMI1 uw 
}

choose_coorect_xrandrsetup()
{
I=1
M=$(bspc query -M | wc -l)
if [[ "$M" == 1 ]]; then
	xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
elif [[ "$M" == 2 ]]; then
	xrandr --output eDP1 --primary --mode 1920x1080 --pos 396x1080 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --mode uw --pos 0x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off
fi
}

create_workspaces()
{
I=1
M=$(bspc query -M | wc -l)
if [[ "$M" == 1 ]]; then
	bspc monitor -d I II III IV V VI VII VIII IX X
elif [[ "$M" == 2 ]]; then
	bspc monitor $(bspc query -M | awk NR==1) -d I II III IV V
	bspc monitor $(bspc query -M | awk NR==2) -d VI VII VIII IX X
elif [[ "$M" == 3 ]]; then
	bspc monitor $(bspc query -M | awk NR==1) -d I II III IV 
	bspc monitor $(bspc query -M | awk NR==2) -d V VI VII 
	bspc monitor $(bspc query -M | awk NR==3) -d VIII IX X
else 
	for monitor in $(bspc query -M); do
		bspc monitor $monitor \
			-n "$I" \
			-d $/{a,b,c}
		let I++
	done
fi
}

# Adds 2560x1080 60hz resolution
add_uw_resolution

# Chooses 2560x1080 as resolution for external display HDMI1
choose_coorect_xrandrsetup

# Set up workspaces on monitors using external script
create_workspaces

# Restarts polybar 
restart_polybar
echo "Ultrawide monitor activated."


