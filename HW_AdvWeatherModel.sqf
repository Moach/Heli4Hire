
_condition = random 1;

enablesimulweather true;

simulsetatmospherethickness 20;

simulsetcloudbasez (1000 - (1000 * _condition)) + random 100;
simulsetcloudheight ((2800 + (random 300)) - (1000 * _condition));


// simulsetfractalamplitude 1 + _condition * .5;
// simulsetfractalwavelength 120 + _condition * 200;

simulsetambientlightresponse 2.5;


simulsethumidity _condition;
1 setOvercast _condition;


simulsetcentrex = random 60e3;
simulsetcentrey = random 60e3;