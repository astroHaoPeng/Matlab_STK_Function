function y = CreateFacObjectFun(scenario,FacName,MinElevation)
%使用STK创建地面站，并设置约束属性属性
%输出为地面站创建的句柄
try
    facility=scenario.Children.New('eFacility', FacName);
    facility.Position.AssignGeodetic(40,    116.0,    0) % Latitude, Longitude, Altitude    deg , deg , km
    % Set altitude to height of terrain
    facility.UseTerrain = true;
    %% 地面站的约束设置
    FacAccessConstraints=facility.AccessConstraints;
    ConsElevationAngle=FacAccessConstraints.AddConstraint('eCstrElevationAngle');
    ConsElevationAngle.EnableMin=1;
    ConsElevationAngle.Min=MinElevation;          %Setting MinElevation
    y=facility;
catch
    y=0;
end

end

%% 可见性的约束设置
% % Member Value Description 
% % eCstrNone 0 None. Use interface IAgAccessConstraint 
% % eCstrImageQuality 1 Image quality. Use interface IAgAccessCnstrMinMax 
% % eCstrAltitude 2 Altitude. Use interface IAgAccessCnstrMinMax 
% % eCstrAngularRate 3 Angular rate. Use interface IAgAccessCnstrMinMax 
% % eCstrApparentTime 4 Apparent time. Use interface IAgAccessCnstrMinMax 
% % eCstrATCentroidElevationAngle 5 Area Target centroid elevation angle. Use interface IAgAccessCnstrMinMax 
% % eCstrAzimuthAngle 6 Azimuth angle. Use interface IAgAccessCnstrMinMax 
% % eCstrBackground 7 Background. Use interface IAgAccessCnstrBackground 
% % eCstrBetaAngle 8 Beta angle. Use interface IAgAccessCnstrMinMax 
% % eCstrCrdnAngle 9 Angle. Use interface IAgAccessCnstrCrdnCn 
% % eCstrCrdnVectorMag 10 Vector magnitude. Use interface IAgAccessCnstrCrdnCn 
% % eCstrCrossTrackRange 11 Cross-track range. Use interface IAgAccessCnstrMinMax 
% % eCstrDopplerConeAngle 12 Doppler cone angle. Use interface IAgAccessCnstrMinMax 
% % eCstrDuration 13 Duration. Use interface IAgAccessCnstrMinMax 
% % eCstrElevationAngle 14 Elevation angle. Use interface IAgAccessCnstrMinMax, IAgAccessCnstrAngle 
% % eCstrExclusionZone 15 Exclusion zone. Use interface IAgAccessCnstrExclZonesCollection, IAgAccessCnstrZone 
% % eCstrGMT 16 GMT. Use interface IAgAccessCnstrMinMax 
% % eCstrGrazingAlt 17 Grazing altitude. Use interface IAgAccessCnstrMinMax 
% % eCstrGrazingAngle 18 Grazing angle. Use interface IAgAccessCnstrMinMax 
% % eCstrGroundElevAngle 19 Ground elevation angle. Use interface IAgAccessCnstrMinMax 
% % eCstrGroundTrack 20 Ground track. Use interface IAgAccessCnstrGroundTrack 
% % eCstrInclusionZone 21 Inclusion zone. Use interface IAgAccessCnstrZone 
% % eCstrIntervals 22 Intervals. Use interface IAgAccessCnstrIntervals 
% % eCstrInTrackRange 23 In-track range. Use interface IAgAccessCnstrMinMax 
% % eCstrLatitude 24 Latitude. Use interface IAgAccessCnstrMinMax 
% % eCstrLighting 25 Lighting. Use interface IAgAccessCnstrCondition 
% % eCstrLineOfSight 26 Line of sight. Use interface IAgAccessConstraint 
% % eCstrLocalTime 27 Local time. Use interface IAgAccessCnstrMinMax 
% % eCstrLOSLunarExclusion 28 Line of sight lunar exclusion. Use interface IAgAccessCnstrAngle 
% % eCstrLOSSunExclusion 29 Line of sight sun exclusion. Use interface IAgAccessCnstrAngle 
% % eCstrLunarElevationAngle 30 Lunar elevation angle. Use interface IAgAccessCnstrMinMax 
% % eCstrMatlab 31 Matlab. Use interface IAgAccessCnstrMinMax 
% % eCstrObjectExclusionAngle 32 Object exclusion angle. Use interface IAgAccessCnstrObjExAngle 
% % eCstrPropagationDelay 33 Propagation delay. Use interface IAgAccessCnstrMinMax 
% % eCstrRange 34 Range. Use interface IAgAccessCnstrMinMax 
% % eCstrRangeRate 35 Range rate. Use interface IAgAccessCnstrMinMax 
% % eCstrSarAreaRate 36 SAR area rate. Use interface IAgAccessCnstrMinMax 
% % eCstrSarAzRes 37 SAR azimuth resolution. Use interface IAgAccessCnstrMinMax 
% % eCstrSarCNR 38 SAR clutter-to-noise ratio. Use interface IAgAccessCnstrMinMax 
% % eCstrSarExternalData 39 SAR external data. Use interface IAgAccessCnstrMinMax 
% % eCstrSarIntTime 40 SAR integration time. Use interface IAgAccessCnstrMinMax 
% % eCstrSarPTCR 41 SAR point target-to-clutter ratio. Use interface IAgAccessCnstrMinMax 
% % eCstrSarSCR 42 SAR signal-to-clutter ratio. Use interface IAgAccessCnstrMinMax 
% % eCstrSarSigmaN 43 SAR sigma N. Use interface IAgAccessCnstrMinMax 
% % eCstrSarSNR 44 SAR signal-to-noise ratio. Use interface IAgAccessCnstrMinMax 
% % eCstrSquintAngle 45 Squint angle. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkClearDoppler 46 Search-track clear doppler. Use interface IAgAccessConstraint 
% % eCstrSrchTrkDwellTime 47 Search-track dwell time. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegratedPDet 48 Search-track integrated probability of detection. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegratedPulses 49 Search-track integrated pulses. Use interface IAgAccessConstraint 
% % eCstrSrchTrkIntegratedSNR 50 Search-track integrated signal-to-noise ratio. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegrationTime 51 Search-track integration time. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkMLCFilter 52 Search-track main lobe clutter filter. Use interface IAgAccessConstraint 
% % eCstrSrchTrkSinglePulsePDet 53 Search-track single-pulse probability of detection. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkSinglePulseSNR 54 Search-track single-pulse signal-to-noise ratio. Use interface IAgAccessCnstrMinMax 
% % eCstrSrchTrkSLCFilter 55 Search-track side lobe clutter filter. Use interface IAgAccessConstraint 
% % eCstrSrchTrkUnambigDoppler 56 Search-track unambiguous doppler. Use interface IAgAccessConstraint 
% % eCstrSrchTrkUnambigRange 57 Search-track unambiguous range. Use interface IAgAccessConstraint 
% % eCstrSunElevationAngle 58 Sun elevation angle. Use interface IAgAccessCnstrMinMax 
% % eCstrSunGroundElevAngle 59 Sun ground angle. Use interface IAgAccessCnstrMinMax 
% % eCstrSunSpecularExclusion 60 Sun specular exclusion. Use interface IAgAccessCnstrAngle 
% % eCstrThirdBodyObstruction 61 Third body obstruction. Use interface IAgAccessCnstrThirdBody 
% % eCstrTimeSlipRange 62 This enumeration is deprecated.  
% % eCstrCentroidAzimuthAngle 63 Centroid azimuth angle. Use interface IAgAccessCnstrMinMax 
% % eCstrCentroidRange 64 Centroid range. Use interface IAgAccessCnstrMinMax 
% % eCstrCentroidSunElevationAngle 65 Centroid sun elevation angle. Use interface IAgAccessCnstrMinMax 
% % eCstrCollectionAngle 66 Collection angle. Use interface IAgAccessCnstrMinMax 
% % eCstrTerrainMask 67 Terrain mask. Use interface IAgAccessConstraint 
% % eCstrAzElMask 68 Azimuth-elevation mask. Use interface IAgAccessConstraint 
% % eCstrAzimuthRate 69 Azimuth rate. Use interface IAgAccessCnstrMinMax 
% % eCstrElevationRate 70 Elevation rate. Use interface IAgAccessCnstrMinMax 
% % eCstrGeoExclusion 71 Geostationary belt exclusion. Use interface IAgAccessCnstrAngle 
% % eCstrGroundSampleDistance 72 Ground sample distance. Use interface IAgAccessCnstrMinMax 
% % eCstrHeightAboveHorizon 73 Height above horizon. Use interface IAgAccessCnstrMinMax 
% % eCstrTerrainGrazingAngle 74 Terrain grazing angle. Use interface IAgAccessCnstrMinMax 
% % eCstrAngleOffBoresight 75 Angle off boresight. Use interface IAgAccessCnstrMinMax 
% % eCstrAngleOffBoresightRate 76 Angle off boresight rate. Use interface IAgAccessCnstrMinMax 
% % eCstrAreaMask 77 Area mask. Use interface IAgAccessConstraint 
% % eCstrBoresightGrazingAngle 78 Boresight grazing angle. Use interface IAgAccessCnstrMinMax 
% % eCstrBSIntersectLightingCondition 79 Boresight Intersection lighting condition. Use interface IAgAccessCnstrMinMax 
% % eCstrBSLunarExclusion 80 Boresight lunar exclusion. Use interface IAgAccessCnstrAngle 
% % eCstrBSSunExclusion 81 Boresight sun exclusion. Use interface IAgAccessCnstrAngle 
% % eCstrFieldOfView 82 Field of view. Use interface IAgAccessConstraint 
% % eCstrFOVSunSpecularExclusion 83 Field of view sun specular exclusion. Use interface IAgAccessConstraint 
% % eCstrFOVSunSpecularInclusion 84 Field of view sun specular inclusion. Use interface IAgAccessConstraint 
% % eCstrHorizonCrossing 85 Horizon crossing. Use interface IAgAccessConstraint 
% % eCstrSensorAzElMask 89 Sensor azimuth-elevation mask. Use interface IAgAccessConstraint 
% % eCstrForeground 90 Foreground. Use interface IAgAccessConstraint 
% % eCstrCbObstruction 91 Central Body Obstruction. Use interface IAgAccessCnstrCbObstruction.  
% % eCstrPlugin 92 Access plugin constraint. Use IAgAccessCnstrPluginMinMax  
% % eCstrDepth 93 Depth constraint. Use IAgAccessCnstrPluginMinMax  
% % eCstrSEETMagFieldLshell 95 Magnetic Dipole L-Shell. The L value is a measure to indicate a particle's drift shell in a dipole-approximated magnetic field. Use IAgAccessCnstrMinMax 
% % eCstrSEETMagFieldLineSeparation 96 Magnetic Field Line Separation; the centric angle between the North footprint of the field line containing the vehicle's location and the North footprint of the field line containing the target's location. Use IAgAccessCnstrMinMax 
% % eCstrSEETImpactFlux 97 Impact Flux; the total impact flux from all types of meteoroid particles. Use IAgAccessCnstrMinMax 
% % eCstrSEETDamageFlux 98 Damage Flux; the total impact flux from all types of meteoroid particles causing damage. Use IAgAccessCnstrMinMax 
% % eCstrSEETDamageMassFlux 99 Damage Mass Flux; the total impact mass flux from all meteoroid particles causing damage. Use IAgAccessCnstrMinMax 
% % eCstrSEETImpactMassFlux 100 Impact Mass Flux; the total impact mass flux ffrom all types of meteoroid particles. Use IAgAccessCnstrMinMax 
% % eCstrSEETSAAFluxIntensity 101 SAA Flux Intensity; SAA Flux Intensity is determined at the vehicle's location and for specified proton-energy flux threshold channel. Use IAgAccessCnstrMinMax 
% % eCstrSEETVehicleTemperature 102 Vehicle Temperature, computed assuming thermal equilibrium. Use IAgAccessCnstrMinMax 
% % eCstrSurfaceObstruction 103 This enumeration is deprecated. Use 'Line of Sight' constraint. Surface Obstruction. Use interface IAgAccessConstraint 
% % eCstrCrdnCondition 104 Coordinate condition constraint. Use interface IAgAccessCnstrCrdnCn 
% % eCstrSarCNRJamming 105 SAR CNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarJOverS 106 SAR J/S constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolCNR 107 SAR Orthogonal Polar CNR constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolCNRJamming 108 SAR Orthogonal Polar CNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolJOverS 109 SAR Orthogonal Polar J/S constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolPTCR 110 SAR Orthogonal Polar PTCR constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolSCR 111 SAR Orthogonal Polar SCR constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolSCRJamming 112 SAR Orthogonal Polar SCR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolSNR 113 SAR Orthogonal Polar SNR constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarOrthoPolSNRJamming 114 SAR Orthogonal Polar SNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarSCRJamming 115 SAR SCR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSarSNRJamming 116 SAR SNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkDwellTimeJamming 117 Search-Track Dwell Time Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegratedJOverS 118 Search-Track Integrated J/S constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegratedPDetJamming 119 Search-Track Integrated PDet Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegratedPulsesJamming 120 Search-Track Integrated Pulses Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegratedSNRJamming 121 Search-Track Integrated SNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkIntegrationTimeJamming 122 Search-Track Integration Time Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolDwellTime 123 Search-Track Orthogonal Polar Dwell Time constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolDwellTimeJamming 124 Search-Track Orthogonal Polar Dwell Time Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedJOverS 125 Search-Track Orthogonal Polar Integrated J/S constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedPDet 126 Search-Track Orthogonal Polar Integrated PDet constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedPDetJamming 127 Search-Track Orthogonal Polar Integrated PDet Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedPulses 128 Search-Track Orthogonal Polar Integrated Pulses constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedPulsesJamming 129 Search-Track Orthogonal Polar Integrated Pulses Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedSNR 130 Search-Track Orthogonal Polar Integrated SNR constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegratedSNRJamming 131 Search-Track Orthogonal Polar Integrated SNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegrationTime 132 Search-Track Orthogonal Polar Integration Time constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolIntegrationTimeJamming 133 Search-Track Orthogonal Polar Integration Time Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolSinglePulseJOverS 134 Search-Track Orthogonal Polar Single Pulse J/S constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolSinglePulsePDet 135 Search-Track Orthogonal Polar Single Pulse PDet constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolSinglePulsePDetJamming 136 Search-Track Orthogonal Polar Single Pulse PDet Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolSinglePulseSNR 137 Search-Track Orthogonal Polar Single Pulse SNR constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkOrthoPolSinglePulseSNRJamming 138 Search-Track Orthogonal Polar Integrated SNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkSinglePulseJOverS 139 Search-Track Single Pulse J/S constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkSinglePulsePDetJamming 140 Search-Track Single Pulse PDet Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrSrchTrkSinglePulseSNRJamming 141 Search-Track Single Pulse SNR Jamming constraint. Use IAgAccessCnstrMinMax 
% % eCstrEOIRSNR 142 EOIR SNR constraint. Use IAgAccessCnstrMinMax 
% % eCstrFOVCbCenter 143 Field Of View Central Body Center constraint.  
% % eCstrFOVCbHorizonRefine 144 Field Of View Central Body Horizon Refine constraint.  
% % eCstrFOVCbObstructionCrossIn 145 Field Of View Central Body Obstruction Cross In constraint.  
% % eCstrFOVCbObstructionCrossOut 146 Field Of View Central Body Obstruction Cross Out constraint.  
% % eCstrSensorRangeMask 147 Sensor Range Mask constraint.  
% % eCstrAtmosLoss 148 Atmosphere Absorption Loss constraint.  
% % eCstrBERPlusI 149 BER+I constraint.  
% % eCstrBitErrorRate 150 Bit Error Rate constraint.  
% % eCstrCOverI 151 C/I constraint.  
% % eCstrCOverN 152 C/N constraint.  
% % eCstrCOverNPlusI 153 C/N+I constraint.  
% % eCstrCOverNo 154 C/No constraint.  
% % eCstrCOverNoPlusIo 155 C/No+Io constraint.  
% % eCstrCloudsFogLoss 156 Clouds And Fog Loss constraint.  
% % eCstrCommPlugin 157 Comm Plugin constraint.  
% % eCstrDeltaTOverT 158 Delta T/T constraint.  
% % eCstrDopplerShift 159 Doppler Shift constraint.  
% % eCstrEbOverNo 160 Energy per bit to noise ratio (Eb/No) constraint.  
% % eCstrEbOverNoPlusIo 161 Eb/No+Io constraint.  
% % eCstrFluxDensity 162 Flux Density constraint.  
% % eCstrFrequency 163 Frequence constraint.  
% % eCstrGOverT 164 G/T constraint.  
% % eCstrJOverS 165 J/S constraint.  
% % eCstrLinkEIRP 166 Link EIRP constraint.  
% % eCstrLinkMargin 167 Link Margin constraint.  
% % eCstrNoiseTemperature 168 Noise Temperature constraint.  
% % eCstrPolRelAngle 169 Polar Relative Angle constraint.  
% % eCstrPowerAtReceiverInput 170 Power at Receiver Input constraint.  
% % eCstrPowerFluxDensity 171 Power Flux Density constraint.  
% % eCstrRainLoss 172 Rain Loss constraint.  
% % eCstrRcvdIsotropicPower 173 Received Isotropic Power constraint.  
% % eCstrUserCustomALoss 174 User Custom A Loss constraint.  
% % eCstrUserCustomBLoss 175 User Custom B Loss constraint.  
% % eCstrUserCustomCLoss 176 User Custom C Loss constraint.  
% % eCstrFreeSpaceLoss 177 Free Space Loss constraint.  
% % eCstrPropLoss 178 Propagation Loss constraint.  
% % eCstrTotalPwrAtRcvrInput 179 Total Power At Receiver Input constraint.  
% % eCstrTotalRcvdRfPower 180 Total Received Rf Power constraint.  
% % eCstrTropoScintillLoss 181 Troposphere Scintillation Loss constraint.  
% % eCstrUrbanTerresLoss 182 Urban Terrestrial Loss constraint.  
% % eCstrTimeSlipSurfaceRange 183 Time Slip Surface Range constraint.  
% % eCstrCableTransDelay 184 Cable Transmission Delay constraint.  
% % eCstrProcessDelay 185 Process Delay constraint.  
% % eCstrRdrXmtTgtAccess 186 RdrXmtTgtAccess constraint.  
% % eCstrSunIlluminationAngle 187 Sun Illumination angle. Use interface IAgAccessCnstrMinMax 


