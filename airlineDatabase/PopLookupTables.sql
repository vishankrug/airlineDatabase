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

