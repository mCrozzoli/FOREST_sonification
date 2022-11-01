s.meter;

//play them!
(
Pdef(\cTime).play;
Pdef(\sdrops).play;
Pdef(\sBugs).play;
)

(
~length = 8; //amount of seconds between each row.
~synthenvsustain = 180;//length of sonification = total number of rows
~rep = 1; //inf

(
Pdef(\cTime, Pmono(
	\closingTime, \dur, ~length,

	\freq1, m.initCoverFreq,
	\freq2, Pseq(m.coverFreq, ~rep), //Penv(m.coverFreq, 30, 'exp'),

	\atk, 3, \sus, ~synthenvsustain, \rel, 3,

	\gate, 1,
	\amp, Pseq(m.coverFreq.linlin(m.coverFreq.minItem,m.biomassFreq.maxItem, 0.01,0.009), ~rep).trace, //0.05,
));
);

(
Pdef(\sdrops, Pbind(
	\instrument, \singingDrops, \dur, ~length,
	\freq, (Pseq(m.biomassFreq, ~rep) * [1, 1.55, 1.75]),
	\atk, Pseq(m.biomassFreq.linexp(m.biomassFreq.minItem,m.biomassFreq.maxItem, 1,5), ~rep),
	\rel, Pseq(m.biomassFreq.linexp(m.biomassFreq.minItem,m.biomassFreq.maxItem, 4,7), ~rep),
	\amp, Pseq(m.biomassFreq.linlin(m.biomassFreq.minItem,m.biomassFreq.maxItem, 0.003, 0.5), ~rep).trace, //0.2,
	\strum, Pseq(m.biomassFreq.linexp(m.biomassFreq.minItem,m.biomassFreq.maxItem, 1,0.08)*3, ~rep),
)));

/*
(m.biomassFreq.clump(2).do {
	arg freqs, n;
	Pdef("sdrops%".format(n).asSymbol,
		Pdef(\sdrops) <> Pbind(\baseFreq, Pseq(freqs))
	)
});*/


(
Pdef(\sBugs, Pbind(
	\instrument, \strangeBugs, \dur, ~length,
	\freq, (Pseq(m.co2Freq, ~rep) * [1, 1.3]), //(Pkey(\baseFreq) * [1, 1.3]).trace,
	\sus, Pseq(m.co2Freq.linlin(m.co2Freq.minItem,m.biomassFreq.maxItem, 7,15), ~rep),//Prand([rrand(7,15),rrand(7,15)],1),
	\amp, Pseq(m.co2Freq.linlin(m.co2Freq.minItem,m.biomassFreq.maxItem, 0.9,0.1), ~rep).trace,//Prand([rrand(0.007,0.009),rrand(0.007,0.009)],1),
	\strum, Pseq(m.biomassFreq.linexp(m.biomassFreq.minItem,m.biomassFreq.maxItem, 1,0.1)*2, ~rep),
));
);


/*
(m.co2Freq.clump(2).do {
	arg freqs, n;
	Pdef("sBugs%".format(n).asSymbol,
		Pdef(\sBugs) <> Pbind(\baseFreq, Pseq(freqs))
	)
});*/
);


//(
//~hunter = Pbind(
//	\instrument, \hunter,
//	\dur, Pseq([2, Rest(5), 1, Rest(7), 3], 1),
//	\modHz, Pexprand(2, 9, inf),
//	\carHz, Penv(m.coverFreqHunter, 3, 'exp'),//Pexprand(80, 95, inf),
//	\modAmp, Pwhite(140, 150),
//	\pan, Pwhite(-1.0, 1.0),
//	\atk, Pexprand(1, 5, 1),
//	\rel, Pexprand(0.5, 2, 1),
//	\amp, Pexprand(0.002, 0.01, 1),
//	\out, 0,
//));

//(m.coverFreqHunter.clump(4).do {
	//arg freqs, n;
	//Pdef("hunter%".format(n).asSymbol,
		//Pdef(\hunter) <> Pbind(\baseFreq, Pseq(freqs))
	//)
//});
