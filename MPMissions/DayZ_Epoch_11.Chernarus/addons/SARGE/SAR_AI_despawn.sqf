
private ["_timeout","_triggername","_tmparr","_markername","_valuearray","_grps_band","_grps_sold","_grps_surv","_trigger"];
if (!isServer) exitWith {}; 
_timeout = SAR_DESPAWN_TIMEOUT;
_trigger = _this select 1;
_triggername = _this select 2;
_tmparr=toArray (_triggername);
_tmparr set[4,97];
_tmparr set[5,114];
_tmparr set[6,101];
_tmparr set[7,97];
_markername = toString _tmparr;
sleep _timeout;
if !(triggerActivated _trigger) then {
if (SAR_DEBUG) then {
diag_log format["SAR DEBUG: Despawning groups in: %1", _markername];
};
if (SAR_EXTREME_DEBUG) then {
diag_log "SAR EXTREME DEBUG: Content of the Monitor before despawn deletion";
call SAR_DEBUG_mon;
};
_valuearray= [["grps_band","grps_sold","grps_surv"],_markername] call SAR_AI_mon_read; 
_grps_band=_valuearray select 0;
_grps_sold=_valuearray select 1;
_grps_surv=_valuearray select 2;
{
{deleteVehicle _x} forEach (units _x);
sleep 0.5;
deleteGroup _x;
} forEach (_grps_band);
{
{deleteVehicle _x} forEach (units _x);
sleep 0.5;
deleteGroup _x;
} forEach (_grps_sold);
{
{deleteVehicle _x} forEach (units _x);
sleep 0.5;
deleteGroup _x;
} forEach (_grps_surv);
[["grps_band","grps_sold","grps_surv"],[[],[],[]],_markername] call SAR_AI_mon_upd; 
if (SAR_EXTREME_DEBUG) then {
diag_log "SAR EXTREME DEBUG: Content of the Monitor after despawn deletion";
call SAR_DEBUG_mon;
};
};
