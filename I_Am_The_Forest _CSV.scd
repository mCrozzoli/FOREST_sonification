//open data
(
(
~columns;
~dataset = CSVFileReader.readInterpret("C:/Users/migue/Documents/RMC achives/Soloist archive 2020/0. Sonifications/I Am The Forest/forestData/lithuania_treecover_loss__ha.csv", true); //tree cover loss
~dataset.removeAt(0);
~columns = ~dataset.flop.asFloat;

d = (
	year: ~columns[1],
	//biomass: ~columns[2],
	coverLoss: ~columns[2],
	co2: ~columns[3],
);

~dataset2 = CSVFileReader.readInterpret("C:/Users/migue/Documents/RMC achives/Soloist archive 2020/0. Sonifications/I Am The Forest/forestData/lithuania_treecover_extent_2000__ha.csv", true); //tree cover extent
~initCover = ~dataset2[1][1].asFloat;
~area = ~dataset2[1][2].asFloat;
~totalLossByYear = d.coverLoss.integrate;
d.initCover = ~initCover;
d.cover = ~initCover - ~totalLossByYear;

d.year.asInt;
);

(
m = ();
m.initCoverFreq = (~area - ~initCover)*0.0005; //1900; //find a relation!!! //wind
m.coverFreq =  d.cover*0.001; //.linexp(d.cover.minItem,d.cover.maxItem,1875,1700); //wind
m.co2Freq = (d.co2/d.coverLoss)**1.5; //bugs
m.biomassFreq = d.co2*0.00005; //drops > check the freq range.
//m.coverFreqHunter = d.cover.linexp(d.cover.minItem,d.cover.maxItem,75,120);
);
)

//m.biomassFreq
//m.co2Freq
//wind ... is the relation between initCover and the loss of forest
//bugs... is the relation between (co2/loss)**2
//drops... C02/2000