# Focal Getis-Ord
Robust Getis-Ord G and G* statistic devised by Julian Bruns (2018)<sup>1</sup><sup>2</sup>. The modified function reduces spatial scale effects by replacing the global parameter with a focal (regional) parameter. The method is implemented to extend the _spdep_-package by Roger Bivand</br>

:round_pushpin: disy Informationssysteme GmbH. https://www.disy.net/de/ <br/>

## Dependencies:<br/>
:wrench: __spdep__-package, for neighborhood definition and weighting schemes<br/>

## Parameters:<br/>
As for spdep::localG(), additionally:
- Input: _weighted neighborhood list_ ("listw" "nb"), defining the _focal_<sup>3</sup> parameter __listw_f__<br/>

The function is written in the same manner as __spdep::localG__, implementing the original Getis-Ord G* and can be applied in thevery same way. Additionally, the parameter __listw_f__ has to be defined (spdep::poly2nb and spdep::nb2listw).<br/>
The area defined by the focal parameter should be smaller then the analysed area of study (global). For focal areas that include the analysed area of study as a whole, the obtained results become equal to the original Getis-Ord G*.<br/><br/>

<img src="https://github.com/OliverHennhoefer/r-focal-getis-ord/blob/master/img/focal.png" width="600">

<sup>1</sup> https://publikationen.bibliothek.kit.edu/1000083353<br/>
<sup>2</sup> https://publikationen.bibliothek.kit.edu/1000071483<br/>
<sup>3</sup> Focal Getis-Ord G* replaces the _global mean_ of the original Getis-Ord G* with a _focal mean_ that changes for every iteration, representing the _focal_ neighborhood to that the current spatial analysis unit is compared to (in order to obtain statistical z-scores).


