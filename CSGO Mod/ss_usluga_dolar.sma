#include <amxmodx>
#include <smsshop>
#include <csgo>

new services;

#define NAME_SERVICE "Dolary"
#define NAZWA_KR "dollar"

new const service_amount[][][] =
{
	{ "20", "20$"   },	// 1
	{ "45", "45$"   },	// 2
	{ "95", "95$"   },	// 3
	{ "160", "160$" },	// 4
	{ "210", "210$" },	// 5
	{ "299", "299$" }	// 6
};

new const service_cost[][][] = 
{
	{ "3,69",  "\wSMS:\y 3,69zl." },	// $20
	{ "7,38",  "\wSMS:\y 7,38zl.\d|\w Przelew:\y 5,00zl\d|\w PSC:\y 6,00zl."    },	// $45
	{ "11,07", "\wSMS:\y 11,07zl.\d|\w Przelew:\y 9,00zl\d|\w PSC:\y 10,00zl."  },	// $95
	{ "17,22", "\wSMS:\y 17,22zl.\d|\w Przelew:\y 15,00zl\d|\w PSC:\y 16,00zl." },	// $160
	{ "23,37", "\wSMS:\y 23,37zl.\d|\w Przelew:\y 21,00zl\d|\w PSC:\y 22,00zl." },	// $210
	{ "30,75", "\wSMS:\y 30,75zl.\d|\w Przelew:\y 28,00zl\d|\w PSC:\y 29,00zl." },	// $299
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
	
	csgo_add_money(index, float(str_to_num(service_amount[amount][0])));
	ss_finalize_user_service(index);

	return SS_CONTINUE;
}
