%% Data taken from:
% 
% R. S. O'Shaughnessy and J. A. Gilmore,
% Solar Absorptance and Thermal Emittance of Some Common Spacecraft Thermal-Control Coatings,
% NASA Reference Publication 1121, 1984.*

%% Black Coatings

%   Variables
alpha = [88 96 96 96 96 97 97 96 96 96 95 94 91 97 95 98 93 92 94 96]'/100;
emm = [  88 88 88 91 87 73 75 89 86 86 84 94 94 91 75 91 92 72 90 85]'/100;
coating_names = [
    "anodized black";
    "carbon black paint NS-7";
    "catalac black paint";
    "chemglaze black paint z306";
    "derlin black plastic";
    "ebanol c black";
    "ebanol c black-384 Equivalent Sun Hours UV";
    "GSFC Black silicate ms-94";
    "gsfc black paint 313-1";
    "hughson black paint h322";
    "hughson black paint L-300";
    "martin black paint N-150-1";
    "Martin black velvet paint";
    "3M Black Velvet Paint";
    "Paladin Black Lacquer";
    "Parsons Black Paint";
    "Polyethylene Black Paint";
    "Pyramil Black on Beryllium Copper";
    "Tedlar Black Plastic";
    "Velestat Black Plastic"
];

%   Table
coating.b=table(alpha, emm, coating_names);
%% White Coatings.

%   Variables
alpha = [6 23 24 35 19 20 34 17 36 26 44 26 25 40 25 30 25 9 9 28 27 23 15 28 39 36 34 39 20 17 20 17 13 15 23]'/100;
emm =   [88 86 90 90 88 92 91 92 91 88 88 89 87 87 89 90 91 90 92 87 83 92 88 87 82 87 85 87 90 92 90 92 92 92 88]'/100;

coating_names = [
    "Barium Sulphate with polyvinyl Alcohol";
    "Biphenyl - White Solid";
    "Catalac White Paint";
    "Dupont Lucite Acrylic Lacquer";
    "Dow Corning White Paint DC-007";
    "GSFC White Paint NS43-CC";
    "GSFC White Paint NS44-B";
    "GSFC White Paint MS-74";
    "GSFC White Paint NS-37";
    "Hughson White Paint A-276";
    "Hughson White Paint A-276 + 1036 ESH UV";
    "Hughson White Paint V-200";
    "Hughson White Paint Z-202";
    "Hughson White Paint Z-202 + 1000 ESH UV";
    "Hughson White Paint Z-255";
    "Mautz White House Paint";
    "M-401 White Paint";
    "Magnesium Oxide White Paint";
    "Magnesium Oxide Aluminium Oxide Paint";
    "Opal Glass";
    "OSO-H White Paint 63W";
    "P764-1A White Paint";
    "Potassium Fluorotitanate White Paint";
    "Sherwin Williams White Paint(A8w11)";
    "Sherwin Williams White Paint (F8W2030)";
    "Sherwin Williams F8W2030 WITH pOLASOL v6v241";
    "sPEREX White Paint";
    "Tedflar White Plastic";
    "Titanium Oxide White Paint with methyl Silicone";
    "Titanium Oxide White Paint with Potassium Silicate";
    "Zerlauts S-13G White Paint";
    "Zerlauts Z-93 White Paint";
    "Zinc Orthotitanate with Potassium Silicate";
    "Zinc Oxide with Sodium Silicate";
    "Zirconium Oxide with 650 Glass Resin"
];
%   Table
coating.w=table(alpha, emm, coating_names);
%% Conductive Paints

%   Variables
alpha = [0.30 0.77 0.22 0.37 0.29 0.24 0.28 0.29 0.43 0.30 0.38 0.52 0.57 0.20 0.57 0.57]';
emm = [  0.31 0.81 0.23 0.36 0.32 0.24 0.29 0.30 0.49 0.30 0.90 0.87 0.89 0.92 0.91 0.91]';

coating_names = [
    "Brilliant Aluminium Paint";
    "Expoy Aluminium Paint";
    "Finch aluminium Paint 643-1-1";
    "Leafing Aluminium in Epon 828";
    "Leafing Aluminium (80-U)";
    "NRL Learfing Almunium Paint 1";
    "NRL Learfing Almunium Paint 2";
    "Sillicone ALuminium Paint";
    "Dupont Silver Paint 4817";
    "Chromeric Silver Paint 586";
    "GSFC Yellow NS-43-G";
    "GSFC Green NS-53-B";
    "GSFC Green NS-43-E";
    "GSFC white NS-43-C";
    "GSFC Green NS-55-F";
    "GSFC Green NS-79"
];
%   Table
coating.p=table(alpha, emm, coating_names);
%% Anodized Aluminium Samples*
%   * coating thickness is critical

%   Variables
alpha = [ 65 86 67 53 73 44 27 35 66 48 26 57 42 47 70]'/100;
emm = [   82 86 87 82 86 56 76 84 88 82 4  88 87 87 13]'/100;

coating_names = [
    "Black";
    "Black";
    "Blue";
    "Blue";
    "Brown";
    "Chromic";
    "Clear";
    "Clear";
    "Green";
    "Gold";
    "Plain";
    "Red";
    "Sulphuric";
    "Yellow";
    "Blue Anodized Titanium Foil"
];

%   Table
coating.al=table(alpha, emm, coating_names);
%% Metals and Conversion* Coatings
%   *thickness of coating can change values significantly

alpha = [16 18 96 98 62 91 16 30 37 32 26 55 NaN nan nan 62 97 23 39 nan 52 45 31 33 42 47 58 39 44 40 40 44]'/100;
emm =   [73 nan 62 63 17 66 3 3 9 2 4 4 49 65 87 67 77 3 7 11 10 8 3 4 11 14 38 11 10 5 5 3]'/100;
coating_names = [
    "Alzac A-2";
    "Alzac A-5";
    "Black Chrome";
    "Black Copper";
    "Black Irridite";
    "Black Nickel";
    "Buffed Aluminium";
    "Buffed Copper";
    "Constantan - Metal Strip";
    "Copper Foil Tape Plain";
    "Copper Foil Tape Sanded";
    "Copper Foil Tape Tarnished";
    "Dow 7 on Polished Magnesium";
    "Dow 7 on Sanded Magnesium";
    "Dow 9 on Magnesium";
    "Dow 23 on Magnesium";
    "Ebanol C Black";
    "Electroplated Gold";
    "eletroless Nickel";
    "Irridite Aluminium";
    "Iconel X Foil (1 mil)";
    "Kannigen - Nickel Alloy";
    "Plain Berrylium Copper";
    "Platinum Foil";
    "Stainless Steel Polished";
    "Stainless Steel Machined";
    "Stainless Steel Sand Blasted";
    "Stainless Steel Machine Rolled";
    "Stainless Steel Boom-Polished";
    "Stainless Steel 1-mil 304 Foil";
    "Tantalum Foil";
    "Tungsten Polished"
];
%   Table for Metals and Conversion Coatings
coating.m = table(alpha, emm, coating_names);
%% Vapor-deposited Coatings* 
%   *On glass substrates except as noted

alpha = [8 15 8 56 57 52 19 85 56 38 18 4 52 60]'/100;
emm =   [2 7 2 17 24 9 2 56 21 4 3 2 12 27]'/100;
coating_names = [
    "Aluminium";
    "Aluminium on Fiberglass";
    "Aluminium on Stainless Steel";
    "Chromium";
    "Chromium on 5-mil Kapton";
    "Germanium";
    "Gold";
    "Iron Oxide";
    "Molybdenum";
    "Nickel";
    "Rhodium";
    "Silver";
    "Titanium";
    "Tungsten"
];

coating.v = table(alpha, emm, coating_names);
%% Solar Cells

alpha = [78 82 77 86 85 82 77 82 91 81 80 75 78 78 91 86 85 77 81 86 79]'/100;
emm = [  82 85 80 85 85 85 81 80 81 80 82 79 82 81 79 84 81 81 80 86 82]'/100;

coating_names = [
    "AE";
    "AMSAT";
    "ATN Black";
    "ATN Blue";
    "ATS-F";
    "COMSAT";
    "DE";
    "ETS/GOES";
    "GOES";
    "GPS - Conductive Coating";
    "HELIOS";
    "IME - Conductive Coating";
    "IMP-H";
    "IMP-I";
    "ISEE - Conductive Coating";
    "IUE";
    "OAO";
    "PAC";
    "SMS-B";
    "Spanish INTASAT";
    "SSS"
];

coating.sol = table(alpha, emm, coating_names);
%% Composite Coatings

alpha = [13 12 19 31 22 12 86 7 7 7 8 55 89]'/100;
emm = [  23 24 3 57 34 38 4 68 79 80 79 46 90]'/100;
coating_names = [
    "Aluminium Oxide on Buffed Aluminium";
    "Aluminium Oxide on Fused Silica";
    "Silver Beryllium Copper";
    "Silver Beryllium Copper Kapton Overcoating";
    "Silver Beryllium Copper Parylene C Overcoating";
    "Silver Beryllium Copper Teflon Overcoating";
    "GSFC Dark Mirror Coating";
    "GSFC Composite";
    "Helios Second Surface Mirror/Silver Backing Initial";
    "Helios Second Surface Mirror/Silver Backing 24 Hours at 5 Suns";
    "Helios Second Surface Mirror/Silver Backing 48 Hours at 11 Suns + P+";
    "Inconel with Teflon Overcoating - 1 mil";
    "Vespel Polyimide SPI"
];

coating.com = table(alpha, emm, coating_names);

%% Films and Tapes
alpha = [12 11 11 23 25 31 34 38 40 41 45 46 79 12 12 11 22 8 8 12 28 19 20 17]'/100;
emm = [  45 62 73 24 34 45 55 67 71 75 82 86 78 20 20 33 33 19 21 18 24 23 30 28]'/100;

coating_names = [
    "Aclar Film (Aluminium Backing) 1 mil";
    "Aclar Film (Aluminium Backing) 2 mil";
    "Aclar Film (Aluminium Backing) 5 mil";
    "Kapton Film (Aluminium Backing) 0.08 mil";
    "Kapton Film (Aluminium Backing) 0.15 mil";
    "Kapton Film (Aluminium Backing) 0.25 mil";
    "Kapton Film (Aluminium Backing) 0.5 mil";
    "Kapton Film (Aluminium Backing) 1 mil";
    "Kapton Film (Aluminium Backing) 1.5 mil";
    "Kapton Film (Aluminium Backing) 2.0 mil";
    "Kapton Film (Aluminium Backing) 3.0 mil";
    "Kapton Film (Aluminium Backing) 5.0 mil";
    "Kapton Film (Chromium-Silicon Oxide-Aluminium Backing (Green)) 1 mil";
    "Kapton Film (Al-Al Oxide Overcoating) 1 mil Initial";
    "Kapton Film (Al-Al Oxide Overcoating) 1 mil 1800 ESH UV";
    "Kapton Film (Al-Silicon Oxide Overcoating) 1 mil Initial";
    "Kapton Film (Al-Silicon Oxide Overcoating) 1 mil 2400 ESH UV";
    "Kapton Film (Silver-Al Oxide Overcoating) 1 mil Initial";
    "Kapton Film (Silver-Al Oxide Overcoating) 1 mil 2400 ESH UV";
    "Kapton Film (Al-Silicon Oxide Overcoating) 0.5 mil Initial";
    "Kapton Film (Al-Silicon Oxide Overcoating) 0.5 mil 4000 ESH UV";
    "Kimfoil-Polycarbonate Film (Aluminium Backing) 0.08 mil";
    "Kimfoil-Polycarbonate Film (Aluminium Backing) 0.20 mil";
    "Kimfoil-Polycarbonate Film (Aluminium Backing) 0.24 mil"
];

coating.flm = table(alpha, emm, coating_names);

save('Solar_Absorptance_and_Thermal_Emittance.mat',"coating")