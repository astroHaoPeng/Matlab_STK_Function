function y = CreatePlanetObjectFun(scenario,CentralBodyName,EphemerisSource)

% IAgScenario scenario: Scenario object
planet = scenario.Children.New('ePlanet',CentralBodyName);
if(nargin==2)
    EphemerisSource='eEphemDefault';
end
planet.CommonTasks.SetPositionSourceCentralBody(CentralBodyName,EphemerisSource); %星历选项
y=planet;
end

%% Key Word  星历选项
%eEphemAnalytic 0 Analytic ephemeris: use an analytic propagator. Available when orbital elements are known for the Central Body about its parent.  
%eEphemDefault 2 Default: use STK's internal definition of the Central Body to generate ephemeris. By default, STK's internal definition uses the DE file if available.  
%eEphemSpice 3 SPICE: use the SPICE toolkit to generate ephemeris. Available only if a SPICE ephemeris file (*.bsp) has been loaded for the selected planet.  
%eEphemJPLDE 4 Default JPL DE file.  
%% 中心体
% Ariel 
% Callisto 
% Ceres 
% Charon 
% Deimos 
% Earth 
% Earth-Moon System 
% Enceladus 
% Europa 
% Ganymede 
% Hyperion 
% Papetus 
% Io 
% Jupiter 
% Jupiter System 
% Mars 
% Mercury 
% Mimas 
% Moon 
% Neptune 
% Neptune System 
% Phobos 
% Phoebe 
% Pluto 
% Pluto System 
% Rhea 
% Saturn 
% Saturn System 
% Sun 
% Tethys 
% Titan 
% Titania 
% Triton 
% Uranus 
% Uranus System 
% Venus 
