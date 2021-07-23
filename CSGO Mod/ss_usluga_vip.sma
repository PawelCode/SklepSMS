#include <amxmodx>
#include <nvadmins>
#include <smsshop>
#include <csgo>

new services;

#define NAME_SERVICE "VIP"
#define DESC_SERVICE "vip"
#define FLAGS "t"

static const service_days[][][] = 
{
	{ "7", "7 Dni" },		// 1
	{ "14", "14 Dni" },		// 2
	{ "30", "30 Dni" },		// 3
	{ "50", "50 Dni" },		// 4
	{ "75", "75 Dni" },		// 5
	{ "90", "90 Dni" },		// 6
	{ "120", "120 Dni" }	// 7
};

static const service_cost[][][] = 
{
	{ "2,46", "\wSMS:\y 2,46zl" },	// 7 Dni
	{ "4,92", "\wSMS:\y 4,92zl.\d|\w Przelew:\y 2,00zl\d|\w PSC:\y 3,00zl." 	},	// 14 Dni
	{ "6,15", "\wSMS:\y 6,15zl.\d|\w Przelew:\y 4,00zl\d|\w PSC:\y 5,00zl." 	},	// 30 Dni
	{ "11,07", "\wSMS:\y 11,07zl.\d|\w Przelew:\y 8,00zl\d|\w PSC:\y 9,00zl." 	},	// 50 Dni
	{ "17,22", "\wSMS:\y 17,22zl.\d|\w Przelew:\y 15,00zl\d|\w PSC:\y 16,00zl." },	// 75 Dni
	{ "23,37", "\wSMS:\y 23,37zl.\d|\w Przelew:\y 22,00zl\d|\w PSC:\y 23,00zl." },	// 90 Dni
	{ "30,75", "\wSMS:\y 30,75zl.\d|\w Przelew:\y 29,00zl\d|\w PSC:\y 29,00zl."	}	// 120 Dni
};

public plugin_init() 
{
	register_plugin(
		fmt("SklepSMS: Service - %s", NAME_SERVICE), "0.1", "");
	
	services = ss_register_service(NAME_SERVICE, DESC_SERVICE, 0);

	ForArray(i, service_days)
	{
		ss_add_service_qu(services, service_days[i][1], service_days[i][0], service_cost[i][1], service_cost[i][0]);
	}
}

public ss_buy_service_post(index, service, amount)
{
	if(service != services)
	{
		return SS_CONTINUE;
	}

	new date[32],
		player_name[33];
	get_user_name(index, player_name, charsmax(player_name));
	
	if(equal(service_days[amount][0], "-1")) 
	{
		copy(date, charsmax(date), service_days[amount][0]);
	}
	else
	{
		na_get_data_after_days(str_to_num(service_days[amount][0]), date, charsmax(date));
	}
	
	na_add_admin(player_name, 1, "", FLAGS, date, DESC_SERVICE);
	ss_finalize_user_service(index);

	return SS_CONTINUE;
}