#include <sourcemod>
#pragma semicolon 1
#pragma newdecls required
bool Kontrol[MAXPLAYERS];
public Plugin myinfo = 
{
	name = "...", 
	author = "phiso", 
	description = "...", 
	version = "1.0", 
	url = "phiso#3331"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_ocsay", OzelHudsay);
	RegConsoleCmd("sm_omcsay", Ozel_Hudsay);
}
public Action Ozel_Hudsay(int client, int args)
{
	if (Kontrol[client])
	{
		Kontrol[client] = false;
		PrintToChat(client, "[SM] \x02Özel Csay \x04ların kapandı.");
	}
	else
	{
		Kontrol[client] = true;
		PrintToChat(client, "[SM] \x02Özel Csay \x04ların açıldı.");
	}
}
public Action OzelHudsay(int client, int args)
{
	if (args < 2)
	{
		PrintToChat(client, "[SM] \x0BKullanım: !ocsay <kisi> <mesaj>.");
	}
	
	char hedef[32];
	char mesaj[128];
	GetCmdArg(1, hedef, sizeof(hedef));
	GetCmdArg(2, mesaj, sizeof(mesaj));
	int Target = FindTarget(client, hedef);
	if (Target == -1)
	{
		PrintToChat(client, "[SM] \x0BHedef Bulunamadı.");
	}
	else
	{
		if (Kontrol[Target])
		{
			char isim[32], name[32], buffer2[32], buffer3[32];
			GetClientName(Target, isim, sizeof(isim));
			GetClientName(client, name, sizeof(name));
			GetCmdArgString(mesaj, sizeof(mesaj));
			ReplaceStringEx(mesaj, sizeof(mesaj), hedef, "");
			Format(buffer2, sizeof(buffer2), "%s Kişisinden:", name);
			Format(buffer3, sizeof(buffer3), "%s Kişisine:", isim);
			PrintCenterText(Target, "%s: %s", buffer2, mesaj);
			PrintCenterText(client,"%s: %s", buffer3, mesaj);
		}
		else
		{
			PrintToChat(client, "[SM] \x02Csay \x04atmak istediğin kişi \x02Özel Csayları \x04kapatmış.");
		}
	}
} 