USE INFO_430_Proj_04;
GO

------------ populate look up tables (Cynthia 05/16) ------------

INSERT INTO tblPLANE_TYPE
VALUES('Intercontinental', 'a form of commercial flight within civil aviation where the departure and the arrival take place in different countries'),
      ('Domestic', 'a form of commercial flight within civil aviation where the departure and the arrival take place in the same country')

INSERT INTO tblMAINTENANCE_TYPE
VALUES('Line Maintenance', 'Investigate wheels, brakes and fluid levels (oil, hydraulics) are done during transit checks. Any running repairs that the aircraft 
        tells us it needs through thousands of on-board sensors. Most aircraft would receive about 12 hours of line maintenance per week. 
        Happen around the world and around the clock.'),
        ('A Check', 'Every eight to 10 weeks, filters will be changed, key systems (like hydraulics in the ‘control surfaces’ that steer the aircraft) will be lubricated
         and a detailed inspection of all the emergency equipment (like inflatable slides) is completed. A typical A Check on B737 takes between six and 24 hours.'),
        ('C Check', 'Happens every 18 months to two years (depending on type of aircraft) and takes three weeks. Can include things like cabin updates/remodeling'),
        ('D Check', 'This is also known as a C4 or C8 check depending on the aircraft type. This check is performed every six years and the entire aircraft is basically 
         dismantled and put back together. Everything in the cabin is taken out (seats, toilets, galleys, overhead bins) so engineers can inspect the metal skin of the aircraft, 
         inside out. The engines are taken off.'),
        ('Heavy Maintenance', 'Heavy maintenance happens every 18 months to six years depending on the aircraft type and age.')

INSERT INTO tblCLASS
VALUES('First', 'Generally the most expensive and most comfortable accommodations available.'),
      ('Business', 'High quality, traditionally purchased by business travelers (sometimes called executive class)'),
      ('Premium Economy', 'slightly better Economy Class seating (greater distance between rows of seats; the seats themselves may or may not be wider than regular economy class)'),
      ('Economy', 'Basic accommodation, commonly purchased by leisure travelers'),
      ('Basic Economy', 'Bare bones fare; typically does no include seat selection or baggage allowance 9which must be purchased separately)')



------------ populate look up tables (Cynthia 05/16) ------------



---- idk whats going on-----
INSERT INTO tblMAINTENANCE (MaintenanceName, MaintenanceTypeID)
VALUES('Lubrication', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'A Check')),
      ('EmergencyEquipmentCheck', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'A Check')), 
      -- ('CabinUpdate', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'B Check')), 
      ('EngineRemoval', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'D Check')),
      ('WheelInvestigation', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'Line Maintenance')),
      ('BrakeInvestigation', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'Line Maintenance')),
      ('FluidLevelInvestigation', (SELECT MaintenanceTypeID FROM tblMAINTENANCE_TYPE WHERE MaintenanceTypeName = 'Line Maintenance'))
GO

SELECT *
FROM tblMAINTENANCE_TYPE

SELECT *
FROM tblMAINTENANCE

--Vishank--

INSERT INTO tblPASSENGER_TYPE(PassengerTypeName, PassengerTypeDescr)
VALUES ('Normal', ''),
      ('VIP', ''),
      ('Unaccompanied Children', ''),
      ('Pregnant Woman', ''),
      ('Infant', ''),
      ('Sight Impaired', ''),
      ('Hearing Impaired', ''),
      ('Criminal/Suspect', ''),
      ('Diplomatic couriers', ''),
      ('Disabled', '')
GO

INSERT INTO tblLUGGAGE_TYPE(LuggageTypeName, LuggageTypeDescription)
VALUES ('Normal', ''),
      ('Animal', ''),
      ('Overweight', ''),
      ('Fragile', ''),
      ('Medical', ''),
      ('Musical Instruments', ''),
      ('Sporting Equipment', '')
GO
--------------- Brian -----------------------

INSERT INTO tblFLIGHT_TYPE (FlightTypeName, FlightTypeDescr)
VALUES ('Private', ''),
		('Public', ''),
		('Passenger', ''),
		('Cargo', ''),
		('Military', ''),
		('Reccreational', '')

GO


INSERT INTO tblAIRPORT_TYPE (AirportTypeName, AirportTypeDescr)
VALUES ('International', ''),
		('Domestic', ''),
		('International', ''),
		('International', '')

INSERT INTO tblEMPLOYEE_TYPE (EmployeeTypeName, EmployeeTypeDescr)
VALUES('')


-- populate tblROLE -- 
INSERT INTO tblROLE(RoleName, RoleDescription)
VALUES('Captain', ' responsible for conducting a final examination of the aircraft and guiding the pilots toward the runway. 
        Plane captains possess extensive knowledge of their designated aircraft and can determine if there are any last minute discrepancies that should ground the aircraft'),
        ('Co-Captain', 'acts as the second-in-command under the captain. This means that a co-pilot can often have lower-level responsibilities and can take instructions 
        immediately from the captain during a fligh'),
        ('Stewardess', 'responsible for ensuring passengers safety and comfort at all times'),
        ('Purser', 'oversees the flight attendants by making sure airline passengers are safe and comfortable. A flight purser completes detailed reports and verifies all safety 
        procedures are followed'),
        ('Load Master', 'supervising the loading and unloading of cargo, vehicles and people on a variety of aircraft.'),
        ('Flight Medic', 'transports and transfers patients by aircraft and assesses the extent of an illness or injury to establish and prioritize medical procedures to follow'),
        ('First Officer', 'works in conjunction with the Captain and ensures safety and efficient operation and management of the aircraft'),
        ('Second Officers', 'responsible for monitoring and controlling various aircraft systems including fixed-wing and rotary wing. They work in close coordination with the two 
        pilots during all phases of flight.'),
        ('Navigator', 'responsible for planning the course that will take an aircraft to a location in the least amount of time without compromising its safety and that of its passengers'),
        ('Flight Engineer', 'check systems before flight, help develop flight plans, and continue to perform checks while the aircraft is in flight. Their focus is to ensure that there are 
        no mechanical concerns, and they monitor the engines, mechanical systems and fuel levels during the flight.')

-- populate tblEmployeeType -- 
INSERT INTO tblEMPLOYEE_TYPE(EmployeeTypeName, EmployeeTypeDescr)
VALUES('Full Time', 'Employee works for a minimum of 40 hours a week'),
      ('Part Time', 'Employee works under 40 hours a week')


