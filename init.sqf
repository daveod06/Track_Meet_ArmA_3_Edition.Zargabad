// Civilians & Traffic
//call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
//call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";

//EOS Dynamic Combat System
[]execVM "scripts\eos\OpenMe.sqf";

// IED script
detonateBombs = false;
//iedMkr=["iedMkr0","iedMkr1","iedMkr2"];
//[iedMkr,detonateBombs] execVM "scripts\ied.sqf";
//[] execVM "scripts\ied.sqf";

0 = [] spawn
{
while{true}do
{
playMusic "01";
sleep 140.0; //where xyz the duration of the music file is
};
};