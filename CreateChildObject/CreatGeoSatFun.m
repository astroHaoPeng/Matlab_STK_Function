function y = CreatGeoSatFun( scenario,SatName,Lon)
try
    satellite = scenario.Children.New('eSatellite',SatName);
    PropagatorType='ePropagatorJ2Perturbation';
    satellite.SetPropagatorType(PropagatorType);
    propagator=satellite.Propagator;
    initialState=propagator.InitialState;
    representation=initialState.Representation;
    % 轨道六要素定义卫星初始轨道
    keplerian = representation.ConvertTo('eOrbitStateClassical');
    keplerian.SizeShapeType = 'eSizeShapeAltitude';  % Changes from Ecc/Inc to Perigee/Apogee Altitude
    keplerian.LocationType = 'eLocationTrueAnomaly'; % Makes sure True Anomaly is being used  eLocationMeanAnomaly
    keplerian.Orientation.AscNodeType = 'eAscNodeLAN'; %Changes from eAscNodeLAN  eAscNodeRAAN  eAscNodeUnknown
    keplerian.SizeShape.PerigeeAltitude = 35788.1;
    keplerian.SizeShape.ApogeeAltitude =  35788.1;
    keplerian.Orientation.Inclination =   0;
    keplerian.Orientation.AscNode.Value = Lon;
    keplerian.Orientation.ArgOfPerigee =  0;
    keplerian.Location.Value =            0;
    % Apply the changes made to the satellite's state and propagate:
    representation.Assign(keplerian);
    satellite.Propagator.Propagate;
    y=satellite;
catch
    y=0;
end

end
