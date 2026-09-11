---
title: "John Ragland Portfolio"
description: "A simple, clean portfolio website"
root: ""
---

<section>

<img src="media/profile_picture.jpeg" alt="John Ragland profile photo" style="max-width: 200px; border-radius: 8px;">

<p>
<b>John Ragland</b><br>
Postdoctoral Fellow<br>
Woods Hole Oceanographic Institution<br>
210A Bigelow Laboratory<br>
MS #11<br>
<a href="mailto:john.ragland@whoi.edu">john.ragland@whoi.edu</a>
</p>

Hi! I'm a postdoctoral fellow at Woods Hole Oceanographic Institution.
I'm working to develop tools to observe the ocean with sound.

</section>

<section id="research">

## Research

Sound contains an *incredible* amount of information about the ocean!
From listening to things that make sound --- like whales or waves --- to using the way that sound moves in the ocean to measure ocean temperature,
I am working to make robust acoustic methods that will help us better understand, and thrive on, our ocean planet.

I've listed a few projects that I've had the opportunity to work in the section below. For a comprehensive list, checkout my [CV](cv.html).

The common thread that connects all of my oceanographic research is the goal of developing acoustic remote sensing methods as a fundamental pillar of the Global Ocean Observing System. Acoustic methods are particularly powerful since underwater acoustics is such an information dense medium. You can listen to the ambient sound of the ocean, which is itself and [Essential Ocean Variable](https://goosocean.org/what-we-do/framework/essential-ocean-variables/) (EOV). Additionally, the ambient sound contains information about surface wave spectra [@ragland2025b] (also an EOV), temperature[@ragland2024], whale migrations, weather patterns, and seismic activity [@ragland2022]. Going one step further, if you put an active source in the ocean, it is possible to make robust measurements of spatially integrated, sub-surface temperature and salinity. This is currently one of the most under-sampled aspects of the ocean.

There has been significant work in the field of acoustic remote sensing for many decades, but it has not yet become one of the primary tools that we used to understand the ocean. I think that some of the roadblocks to this are technical in nature --- using modern techniques of advanced statistical inference using Bayesian methods and machine learning, I am working to overcome these problems.

</section>
<section id="projects">

## Project Highlights

### Simultaneous localization and environment inversion using relative arrival-time differences
In the classical formulation of ocean acoustic tomography [@munk1995], acoustic arrival times are measured between a source and receiver. This arrival time is the integrated sound speed slowness along the path that the ray takes through the ocean. In order to be able to isolate the part fluctuations in an arrival time due to temperature or salinity fluctuations, the exact motion of the mooring needs to be removed. This has previously been done with advances systems that can localize individual elements of an acoustic array in 3D down to the accuracy of 1 meter.

Unfortunately, this high level of location accuracy eliminates the possibility of using either sources of opportunity or AUVs, where the location of the receiver or source is not fully known.
We have developed a method that extracts information about the source /receiver geometry and the environment between them from the arrival time differences between multiple different arrivals.
This removes the constraint of needing to know the exact 3D location of a source and receiver, and since the observable that is tracked is just arrival times, this method could potentially be used on autonomous platforms, giving position information for the AUV while simultaneously providing information about the spatial structure of the temperature and salinity fields.

We successfully use our method to localize a source, and invert for the environment information for acoustic transmissions that transect the Gulf Stream.
These are preliminary results and a paper reporting these findings is currently in preparation. Check back soon to see if there's a pre-print available!

### Acoustic Fluctuations due to stochastic, small-scale oceanographic structure
I am working to understand how sound propagates through stochastic, small-scale ocean structure --- like internal waves, or spice. In a recent pre-print that is under review, we quantify the acoustic fluctuations of intensity, phase, and the vertical coherence of acoustic propagation directly across the Gulf Stream. This is the first time that wave propagation through random media theories have been applied to the case of large range dependence (such as the Gulf Stream front) [@ragland2026a]

### Ocean basin acoustic propagation for measuring ocean temperature
The Kauai Beacon is an active source that began transmitting in March of 2023. We study receptions at single hydrophones that are part of the OOI network, making first steps necesary to leverage existing passive acoustic monitoring infrastructure to measure ocean basin heat content. This figure shows the arrivals over the first year of regular transmissions at one of the OOI hydrophones [@ragland2025a].

[![Kauai_Beacon](media/paper_figures/AXCC1_KB_receptions.png){style="width: 100%; border-radius: 8px;"}](https://doi.org/10.1121/10.0038971)

### OOIPY

<a href="https://github.com/Ocean-Data-Lab/ooipy"><img src="media/ooipy/OOIPY_Logo.png" alt="OOIPY logo" class="project-logo"></a>

To accomplish the work that I've done with OOI hydrophones, you need to be able to pull years of broadband hydrophone data off of the [Ocean Observatories Initiative](https://oceanobservatories.org/) raw data server - which isn't something that is possible with the standard OOI API. [OOIPY](https://github.com/Ocean-Data-Lab/ooipy) is an open source (MIT licensed) Python package that I helped write and maintain that handles this: it takes care of locating and downloading the raw hydrophone records, stitching them into contiguous time series, and provides tools for the analysis that usually comes next, like spectrograms and power spectral density estimates. The package is on PyPI and documented at [ooipy.readthedocs.io](https://ooipy.readthedocs.io/en/latest/). I have several other open source projects that I have built and maintain as well, like [pygenray](https://pygenray.readthedocs.io/en/latest/) (a purely python, jit compiled acoustic ray tracer), and [xrsignal](https://xrsignal.readthedocs.io/en/latest/?badge=latest) (a mirror of the scipy signal module for use with xarray data objects). To learn more, you should check out my [GitHub](https://github.com/John-Ragland).


### Using ambient sound to measure ocean temperature
You can use coherence ambient sound to passively illuminate acoustic propagation between two hydrophones. From measured arrival times, which from a ray perspective represent the integrated sound speed slowness along the ray path, you can get integrated perturbations of ocean temperature. We demonstrate this capability with open access hydrophones that are part of the [Ocean Observatories Initiative](https://oceanobservatories.org/), comparing to estimated temperature with HYCOM ocean model outputs and sparse ARGO profiles. Check out the paper for more details [@ragland2024]

[![Ambient_NI_Temperature](media/paper_figures/inversion_601.png){style="width: 100%; border-radius: 8px;"}](https://doi.org/10.1029/2024GL108943)


### Real-time Vacuum Tube Modelling in a guitar effects pedal
This one isn't related to my current research efforts, but for my Master's thesis I designed and built a guitar effects pedal that was able to implement a real-time spice simulation of a vacuum tube pre-amp and tone stack circuits and was able to accurately emulate the sounds of vacuum tube distortion. This project was super fun and was what originally inspired me to continue on to get a PhD and start a career in research. I designed the algorithm and implemented the algorithm, but I also designed and built the circuit board itself, which was a CD audio (44.1 kHz, 16-bit) ADC > DSP > DAC system. I go into a lot more detail in my [master's thesis](https://etd.auburn.edu//handle/10415/7112) [@ragland2020].

<div class="media-row">
<img src="media/tube_amp/digital_tube_amp.jpeg" alt="Digital tube amp pedal">
<video controls preload="metadata" playsinline width="540" height="960" poster="media/tube_amp/digital_tube_demo_poster.jpg" src="media/tube_amp/digital_tube_demo.mp4">Your browser does not support embedded video. <a href="media/tube_amp/digital_tube_demo.mp4">Download the demo video</a>.</video>
</div>
</section>
