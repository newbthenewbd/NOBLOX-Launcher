#!/bin/sh
noblox() {
	if [ -z "$WINEPREFIX" ]; then
		local WINEPREFIX=~/.wine
	fi
	case "$1" in
		--uninstall)
			cd "$WINEPREFIX/drive_c/users/$(whoami)/Local Settings/Application Data/Roblox/Versions/" >/dev/null 2>&1 || cd "$WINEPREFIX/drive_c/users/$(whoami)/AppData/Local/Roblox/Versions/" >/dev/null 2>&1
			wine */RobloxPlayerLauncher.exe -uninstall >/dev/null 2>&1 && rm */RobloxPlayerLauncher.exe
			wine */RobloxStudioLauncherBeta.exe -uninstall >/dev/null 2>&1 && rm */RobloxStudioLauncherBeta.exe
			cd "$(xdg-user-dir DESKTOP)"
			rm Roblox\ Player.desktop >/dev/null 2>&1
			rm Roblox\ Studio.desktop >/dev/null 2>&1
			rm ~/.local/share/applications/Roblox\ Player.desktop >/dev/null 2>&1
			rm ~/.local/share/applications/Roblox\ Studio.desktop >/dev/null 2>&1
			exit 0
			;;
		--*)
			echo -e "NOBLOX Unofficial Launcher of Roblox\n\nUsage: /bin/sh nobloxLauncher.sh [options]\nIf you need to, you may set the WINEPREFIX prior to launching this script, like:\n\tWINEPREFIX=~/.myawesomewineprefixname\n\nOptions:\n\t--help: Display this help\n\t--uninstall: Uninstall Roblox if it is installed on your computer\n\nDonations may or may not help keep this project up to date; if you wish to make\na donation, you can do so here:\n\thttps://github.com/newbthenewbd/NOBLOX-Launcher#nagging-for-donations\n\nNotice: ROBLOX is a registered trademark of Roblox Corporation. We are not in\n\tany way affiliated with, authorized nor endorsed by Roblox Corporation."
			exit 0
			;;
	esac
	if [ ! -f "$WINEPREFIX/drive_c/users/$(whoami)/AppData/Local/Roblox/Versions/"*"/RobloxPlayerLauncher.exe" ] && [ ! -f "$WINEPREFIX/drive_c/users/$(whoami)/Local Settings/Application Data/Roblox/Versions/"*"/RobloxPlayerLauncher.exe" ] || [ ! -f ~/NOBLOX-Launcher/nobloxLauncher.sh ] || [ ! "$(sha1sum $0 | cut -f 1 -d ' ')" = "$(sha1sum ~/NOBLOX-Launcher/nobloxLauncher.sh | cut -f 1 -d ' ')" ] ; then
		mkdir -p ~/NOBLOX-Launcher
		cp $0 ~/NOBLOX-Launcher/ >/dev/null 2>&1
		cd ~/NOBLOX-Launcher
		wget http://setup.roblox.com/RobloxPlayerLauncher.exe -O RobloxPlayerLauncher.exe
		wine RobloxPlayerLauncher.exe
		rm RobloxPlayerLauncher.exe
		cd "$(xdg-user-dir DESKTOP)"
		rm Roblox\ Player.lnk >/dev/null 2>&1
		rm Roblox\ Studio.lnk >/dev/null 2>&1
		sed -i "s|Exec=.*|Exec=env WINEPREFIX=\"$WINEPREFIX\" /bin/sh \"/home/$(whoami)/NOBLOX-Launcher/nobloxLauncher.sh\" %u|g" Roblox\ Player.desktop
		echo -e "Categories=Game;\nMimeType=x-scheme-handler/roblox-player" >> Roblox\ Player.desktop
		echo "Categories=Game;" >> Roblox\ Studio.desktop
		cp Roblox\ Player.desktop ~/.local/share/applications/ >/dev/null 2>&1
		cp Roblox\ Studio.desktop ~/.local/share/applications/ >/dev/null 2>&1
		xdg-mime default Roblox\ Player.desktop x-scheme-handler/roblox-player
	fi
	if [ ! -z "$@" ]; then
		cd "$WINEPREFIX/drive_c/users/$(whoami)/AppData/Local/Roblox/Versions/" >/dev/null 2>&1 || cd "$WINEPREFIX/drive_c/users/$(whoami)/Local Settings/Application Data/Roblox/Versions/" >/dev/null 2>&1
		WINEDLLOVERRIDES="winemenubuilder.exe=d" wine */RobloxPlayerLauncher.exe "$@"
	else
		echo "Roblox has been installed on your computer."
	fi
}
noblox "$@"
