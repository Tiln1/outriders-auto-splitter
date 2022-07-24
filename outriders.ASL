state("OUTRIDERS-Win64-Shipping")
{
	int combat : "OUTRIDERS-Win64-Shipping.exe", 0x05F3B7F0, 0xDC8, 0x20, 0x3F8;
	int triesRemaining : "OUTRIDERS-Win64-Shipping.exe", 0x05F3B7F0, 0xDD0, 0x20, 0x794;
	int loading : "OUTRIDERS-Win64-Shipping.exe", 0x61F1738
}

startup
{
	settings.Add("STS", true, "Start on trial start?");
	settings.Add("SCS", true, "Start on combat start?");
	settings.Add("CC", true, "Split on combat change?");
	settings.Add("CS", false, "Split on combat start?");
	settings.Add("CE", false, "Split on combat end?");
}

isLoading
{
	return (current.loading == 1);
}

start
{
	bool start = false;
	if (settings["STS"])
	{
		if (current.triesRemaining == 3 && old.triesRemaining != 3)
		{
			start = true;
		}
	}
	if (settings["SCS"])
	{
		if (current.combat > old.combat)
		{
			start = true;
		}
	}
	return start;
}

split
{
	if (current.triesRemaining == old.triesRemaining)
	{
		if (settings["CC"])
		{
			return (current.combat != old.combat);
		}
		if (settings["CE"])
		{
			return (current.combat < old.combat);
		}
		if (settings["CS"])
		{
			return (current.combat > old.combat);
		}
	}
}