function Tune = lnls1_freq2tune(Freqs, RFreq)
%LNLS1_FREQ2TUNE - Converts measured betatron freqs to tunes.
%
%Hist�ria
%
%2010-09-13: c�digo fonte com coment�rios iniciais.

harmonic_number = getharmonicnumber;

AD = getad;
rev_freq_harm = AD.LNLS1Params.rev_freq_harm;
reference_rfreq = AD.LNLS1Params.reference_rfreq;

reference_revolution_freq = reference_rfreq / harmonic_number;
reference_harmonic_rfreq  = rev_freq_harm * reference_revolution_freq;

revolution_freq = RFreq / harmonic_number;
harmonic_rfreq  = rev_freq_harm * revolution_freq;

beta_freqs = (Freqs + reference_harmonic_rfreq - harmonic_rfreq);
Tune = beta_freqs / revolution_freq; 