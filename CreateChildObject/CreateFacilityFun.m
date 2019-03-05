function facility = CreateFacilityFun(scenario,FacName,LLA,MinElevation)
if nargin==2
    MinElevation=0;
end
facility=scenario.Children.New('eFacility', FacName);
facility.Position.AssignGeodetic(LLA(1), LLA(2), 0) % Latitude, Longitude, Altitude    deg , deg , km
FacAccessConstraints=facility.AccessConstraints;
ConsElevationAngle=FacAccessConstraints.AddConstraint('eCstrElevationAngle');
ConsElevationAngle.EnableMin=1;
ConsElevationAngle.Min=MinElevation;          %Setting MinElevation
end

