(
(
SynthDef(\singingDrops, {
	arg freq=2100, amps, phases, atk=1, rel=5, amp=0.5;
	var sig, rev, res, pan, env;
    amps = #[0.35, 0.23, 0.12, 0.05];
    phases = #[1, 1.5, 2, 2.5];
	sig = SinOsc.ar(freq);
	res = DynKlang.ar(`[sig, amps, phases], [0.3,0.3,0.3], [pi,pi,pi]);
	env = EnvGen.kr(Env.perc(atk,rel,0.3,4), doneAction: Done.freeSelf);
	sig = sig * env * res;
	rev = FreeVerb.ar(sig, 0.33, 0.5, 1);
	pan = PanB2.ar(rev, Rand(-1,1), amp);
	Out.ar(0, pan);
}).add;
);

(
SynthDef(\closingTime, {
	arg freq1, freq2, atk=2, sus=0, rel=0, gate=1, amp=1; // fadeTime=2,
	var sig, res, res2, pan, env;
	//freq1 = rrand(1700,1900);
	//freq2 = rrand(1900,2100);
	sig = PinkNoise.ar(0.25)*20;
	res = Resonz.ar(sig, freq1, XLine.kr(0.0001, 1, sus));
	res2 = Resonz.ar(sig, freq2, XLine.kr(0.0001, 1, sus));
	env = EnvGen.kr(Env.asr(atk, sus, rel), gate, doneAction: Done.freeSelf);
	res = res * env * amp;
	res2 = res2 * env * amp;
	pan = Rotate2.ar(res, res2, Rand(-1,1));
	Out.ar(0, pan);
}).add;
);

(
SynthDef(\strangeBugs, {
	arg freq, sus, amp;
	var sig, ctrl, rev, pan, env;
	//freq = rrand(700,800);
	ctrl = LFNoise2.kr(rrand(0.5,5));
	sig = SinOsc.ar(freq, 0, ctrl * rrand(0.05,0.25));
	env = EnvGen.kr(Env.sine(sus, 0.25), doneAction:2);  //diff env!!!
	sig = sig * env;
	rev = FreeVerb.ar(sig, 1, 1, 1);
	pan = Pan2.ar(rev, LFNoise2.ar(rrand(0.05,0.1)), amp);
	Out.ar(0, pan);
}).add;
);
)

//(
//SynthDef(\hunter, {|carHz=200, modHz=20, modAmp=200, pan=0, out=0, atk=0.01, rel=2, amp=0.5|
//	var car, mod, env;
//	mod = Saw.ar(modHz, mul:modAmp);
//	env = EnvGen.ar(Env.perc(atk, rel), doneAction:2);
//	car = SinOsc.ar(carHz + mod) * env * amp;
//	car = Pan2.ar(car, pan);
//	Out.ar(out, car)
//}).add;
//);