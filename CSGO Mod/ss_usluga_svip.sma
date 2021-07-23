#include <amxmodx>
#include <nvadmins>
#include <smsshop>
#include <csgo>

new services;

#define NAME_SERVICE "SuperVIP"
#define DESC_SERVICE "svip"
#define FLAGS "s"

static const service_days[][][] = 
{
	{ "20", "20 Dni" },
	{ "45", "45 Dni" },
	{ "65", "65 Dni" },
	{ "90", "90 Dni" }
};

static const service_cost[][][] = 
{
	{ "11,07", "\wSMS:\y 11,07zl.\d|\w Przelew:\y 8,00zl\d|\w PSC:\y 9,00zl." 	},	// 24 Dni
	{ "17,22", "\wSMS:\y 17,22zl.\d|\w Przelew:\y 15,00zl\d|\w PSC:\y 16,00zl." },	// 45 Dni
	{ "23,37", "\wSMS:\y 23,37zl.\d|\w Przelew:\y 22,00zl\d|\w PSC:\y 23,00zl." },	// 65 Dni
	{ "30,75", "\wSMS:\y 30,75zl.\d|\w Przelew:\y 29,00zl\d|\w PSC:\y 29,00zl."	}	// 90 Dni
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