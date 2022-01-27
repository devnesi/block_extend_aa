#include <sourcemod>
#include <sdktools>
 
#define PLUGIN_NAME        "Block extend anti aim"
#define PLUGIN_VERSION    "0.0.1"
 
public Plugin myinfo =
{
    name        = PLUGIN_NAME,
    author        = "nesi",
    description    = "Bloqueia abuso do vetor Z",
    version        = PLUGIN_VERSION,
    url            = "nesi.dev"
}
 
public void OnPluginStart()
{
    CreateTimer(1.0, CheckExtend, _, TIMER_REPEAT);
}

public Action CheckExtend(Handle timer)
{
    for(int i = 1; i <= MaxClients; i++)
    {
        if(IsValidEntity(i) && HasEntProp(i, Prop_Send, "m_vecOrigin") && IsClientConnected(i) && IsClientInGame(i) && IsPlayerAlive(i) && !IsFakeClient(i))
        {
            float pos[3];
            float view_pos[3];
            GetEntPropVector(i, Prop_Send, "m_vecOrigin", pos);
            GetClientEyeAngles(i, view_pos);
                 
            if (view_pos[2] < 0)
            {
                PrintToChat(i, "[ANTI-EXTEND] Não é permitido usar extend/roll anti aim");
                ForcePlayerSuicide(i);
            }
        }
    }
}