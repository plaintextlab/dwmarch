//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	/*{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},*/
	{"","~/dwmarch/scripts/dwmblocks/recording_status.sh", 1, 0},
	{"", "~/dwmarch/scripts/dwmblocks/current_network.sh", 5,          0},
	{"", "~/dwmarch/scripts/dwmblocks/current_audio_device.sh", 3,          0},
	{"", "~/dwmarch/scripts/dwmblocks/volume_level.sh", 2,          0},
	/*{"", "date '+%b %d (%a) %I:%M%p'",					5,		0},*/
	{" ",   "~/dwmarch/scripts/dwmblocks/clock_calendar.sh",  60,          1},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
