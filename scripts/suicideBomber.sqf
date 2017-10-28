//[bomber,[CIVILIAN,WEST,EAST,RESISTANCE],"grenadeHand",radius] execVM "scripts\suicideBomber.sqf"; //The unit you want to be the bomber, the sides you want the bomber to attack, classname of explosive you want to use

_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveClass = _this select 2;
_radius = _this select 3;
_deadManSwtich = this select 4;
_runCode = 1;

//while {alive _bomber && _runCode == 1} do
while {_runCode == 1} do
{
	if (!(isNull _bomber) && !(alive _bomber) && _deadManSwtich) then
	{
		_explosive = _explosiveClass createVehicle (position _bomber);
		[_explosive] spawn {
			_explosive = _this select 0; 
			_explosive setDamage 1; 
		};
		[_explosive] spawn {
			_explosive = _this select 0; 
			deleteVehicle _explosive; 
		};
		_runCode = 0;
	}
	elseif (alive _bomber)
	{
		_nearUnits = nearestObjects [_bomber,["CAManBase"],70];
		_nearUnits = _nearUnits - [_bomber];
		{
			if(!(side _x in _targetSide)) then {_nearUnits = _nearUnits - [_x];};
		} forEach _nearUnits;
		if(count _nearUnits != 0) then
		{
			_pos = position (_nearUnits select 0);
			_bomber doMove _pos;
			waitUntil {(_bomber distance _pos < _radius) or (!alive _bomber) or (!alive(_nearUnits select 0))};
			if(_bomber distance (_nearUnits select 0) < _radius)
			exitWith
			{
			_runCode = 0;
			_explosive = _explosiveClass createVehicle (position _bomber);
			[_bomber,_explosive] spawn {
				_bomber = _this select 0; 
				_explosive = _this select 1; 
				_bomber say3D "shout";
				sleep 0.25; 
				_explosive setDamage 1; 
				_bomber addRating -10000000;
				};
			[_explosive,_bomber] spawn {
				_explosive = _this select 0; 
				_bomber = _this select 1; 
				waitUntil {!alive _bomber};
				deleteVehicle _explosive; 
				};
			};
		};
	};
	sleep 1;
};
