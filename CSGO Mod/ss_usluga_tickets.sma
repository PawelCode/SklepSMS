#include <amxmodx>
#include <smsshop>
#include <csgo>

new services;

#define NAME_SERVICE "Dolary"
#define NAZWA_KR "dollar"

new const service_amount[][][] =
{
	{ "10", "10 bonow" },	// 1
	{ "20", "20 bonow" },	// 2
	{ "30", "30 bonow" },	// 3
	{ "50", "50 bonow" },	// 4
	{ "65", "65 bonow" },	// 5
	{ "80", "80 bonow" } 	// 6
};

new const service_cost[][][] = 
{
	{ "3,69",  "\wSMS:\y 3,69zl." },	// 10bonow
	{ "7,38",  "\wSMS:\y 7,38zl.\d|\w Przelew:\y 5,00zl\d|\w PSC:\y 6,00zl."    },	// 20 bonow
	{ "11,07", "\wSMS:\y 11,07zl.\d|\w Przelew:\y 9,00zl\d|\w PSC:\y 10,00zl."  },	// 30 bonow
	{ "17,22", "\wSMS:\y 17,22zl.\d|\w Przelew:\y 15,00zl\d|\w PSC:\y 16,00zl." },	// 50 bonow
	{ "24,60", "\wSMS:\y 24,60zl.\d|\w Przelew:\y 22,00zl\d|\w PSC:\y 23,00zl." },	// 65 bonow
	{ "30,75", "\wSMS:\y 30,75zl.\d|\w Przelew:\y 28,00zl\d|\w PSC:\y 29,00zl." },	// 80 bonow
};

public plugin_init() 
{
	register_plugin(
		fmt("SklepSMS: Service - %s", NAME_SERVICE), "0.1", "");
	
	services = ss_register_service(NAME_SERVICE, DESC_SERVICE, 0);
	
	ForArray(i, service_amount)
	{
		ss_add_service_qu(services, service_amount[i][1], service_amount[i][0], service_cost[i][1], service_cost[i][0]);
	}
}

public ss_buy_service_post(index, service, amount)
{
	if(service != services)
	{
		return SS_CONTINUE;
	}

	csgo_add_ticket(index, str_to_num(service_amount[amount][0]));
	ss_finalize_user_service(index);

	return SS_CONTINUE;
}
