<<<<<<< HEAD
clear
#delimit;
set more off;

global root "D:\Dropbox\DropboxQFPD";

global kn "pTasks\analysis\evalImpacto\conocimiento";
local processed "$root\\$kn\processed";
local graphs "$root\\$kn\report\graphs";
local tables "$root\\$kn\report\tables";
local pContacts "$root\pProcessed\rapidpro\contacts";

stgit, git_dir("D:\Dropbox\DropboxQFPD\pTasks\analysis\evalImpacto\conocimiento\do\test-kn");
dtanotes, creator("evalKn");
cd "`processed'";

*Test git: is it working?;
use p_testKn, clear;

drop if recibio==0;

tab flow_cat, gen(fCat_);
tab flow_name, gen(fName_);

*Definición alternativa de tipo de respuesta: incorrecta si bf no respondio;
gen rc2=(respuestaCorrecta );	
replace rc2=0 if respondio==0;


foreach outcome in respondio respuestaCorrecta rc2{;								 								 
		reg `outcome' T if fName_1==1, r;
		outreg2 using "r_fName_`outcome'.xls", replace label dec(4);
		forvalues i=2(1)26{;							
			reg `outcome' T if fName_`i'==1, r;
			outreg2 using "r_fName_`outcome'.xls", append label dec(4);
		};								 						
};



table flow_name, center  contents(sum recibio sum respondio
                            mean respondio
                            mean respuestaCorrecta) by(T);


foreach outcome in respondio respuestaCorrecta rc2{;								 								 
		reg `outcome' T if fCat_1==1, r;
		outreg2 using "r_fCat_`outcome'.xls", replace label dec(4);
		forvalues i=2(1)5{;							
			reg `outcome' T if fCat_`i'==1, r;
			outreg2 using "r_fCat_`outcome'.xls", append label dec(4);
		};								 						
};	
							
foreach outcome in respuestaCorrecta rc2{;								 
table flow_cat, center  contents(sum recibio sum respondio
                            mean respondio  
							mean `outcome') by(T);

								 
};

foreach x in respuestaCorrecta respondio rc2{;							
ttest `x', by(T);
bysort flow_name: ttest  `x', by(T);
bysort flow_cat: ttest  `x', by(T);
};
	
								
/*Socio Emocional
Sólo mensajes ex post. División tratamiento SE y el resto de la población PD*/

tab rp_se_t, mi;
tab rp_se, mi;

table rp_se, center  contents(sum recibio sum respondio
                            mean respondio
                            mean respuestaCorrecta) by(T);
gen DD= rp_se_t*T if rp_se!="";
reg respuestaCorrecta rp_se_t T DD if rp_se!="";							
reg respondio rp_se_t T DD if rp_se!="";								

table flow_cat if T==1, center  contents(sum recibio sum respondio
                            mean respondio
                            mean respuestaCorrecta) by(rp_se_t);

				
		

foreach outcome in respondio respuestaCorrecta{;								 								 
		reg `outcome' rp_se_t if fCat_1==1 & T==1, r;
		outreg2 using "r_se_fCat_`outcome'.xls", replace label dec(4);
		forvalues i=2(1)5{;							
			reg `outcome' rp_se_t if fCat_`i'==1 & T==1, r;
			outreg2 using "r_se_fCat_`outcome'.xls", append label dec(4);
		};								 						
};								

foreach x in respuestaCorrecta respondio{;							
bysort flow_cat: ttest  `x' if T==1, by(rp_se_t);
ttest `x', by(rp_se_t);
};		
							
*Caracteristicas demograficas bf;
preserve;
drop fCat_*;
drop fName_*;
duplicates report phone;
tabmiss phone;
duplicates drop phone, force;
outreg2 using d_testKn_bf.doc, replace sum(log) 
         keep(i_pd_age 
		      i_pd_firstBaby 
			  i_pd_pastPregnancies  
			  i_pd_hasComp_ea 
			  i_pd_hasComp_ep 
			  rp_bf_altaRemota
			  i_receivedPhone
	          i_sameLocCl
	          cl_rural) eqkeep(mean sd);

restore;						









	
=======
﻿clear
#delimit;
set more off;

global root "D:\Dropbox\DropboxQFPD";
*global root "C:\Users\Cris Barnard\Dropbox\DropboxQFPD";
global kn "pTasks\analysis\evalImpacto\conocimiento";
local processed "$root\\$kn\processed";
local graphs "$root\\$kn\report\graphs";
local tables "$root\\$kn\report\tables";
local pContacts "$root\pProcessed\rapidpro\contacts";

/*
stgit, git_dir("D:\Dropbox\DropboxQFPD\pTasks\analysis\evalImpacto\conocimiento\do\test-kn");
dtanotes, creator("evalKn");*/
cd "`processed'";

*Test git;
use p_testKn, clear;

drop if recibio==0;

tab flow_cat, gen(fCat_);
tab flow_name, gen(fName_);

*Definición alternativa de tipo de respuesta: incorrecta si bf no respondio;
gen rc2=(respuestaCorrecta );	
replace rc2=0 if respondio==0;


foreach outcome in respondio respuestaCorrecta rc2{;								 								 
		reg `outcome' T if fName_1==1, r;
		outreg2 using "r_fName_`outcome'.xls", replace label dec(4);
		forvalues i=2(1)26{;							
			reg `outcome' T if fName_`i'==1, r;
			outreg2 using "r_fName_`outcome'.xls", append label dec(4);
		};								 						
};



table flow_name, center  contents(sum recibio sum respondio
                            mean respondio
                            mean respuestaCorrecta) by(T);


foreach outcome in respondio respuestaCorrecta rc2{;								 								 
		reg `outcome' T if fCat_1==1, r;
		outreg2 using "r_fCat_`outcome'.xls", replace label dec(4);
		forvalues i=2(1)5{;							
			reg `outcome' T if fCat_`i'==1, r;
			outreg2 using "r_fCat_`outcome'.xls", append label dec(4);
		};								 						
};	
							
foreach outcome in respuestaCorrecta rc2{;								 
table flow_cat, center  contents(sum recibio sum respondio
                            mean respondio  
							mean `outcome') by(T);

								 
};

foreach x in respuestaCorrecta respondio rc2{;							
ttest `x', by(T);
bysort flow_name: ttest  `x', by(T);
bysort flow_cat: ttest  `x', by(T);
};
	
								
/*Socio Emocional
Sólo mensajes ex post. División tratamiento SE y el resto de la población PD*/

tab rp_se_t, mi;
tab rp_se, mi;

table rp_se, center  contents(sum recibio sum respondio
                            mean respondio
                            mean respuestaCorrecta) by(T);
gen DD= rp_se_t*T if rp_se!="";
reg respuestaCorrecta rp_se_t T DD if rp_se!="";							
reg respondio rp_se_t T DD if rp_se!="";								

table flow_cat if T==1, center  contents(sum recibio sum respondio
                            mean respondio
                            mean respuestaCorrecta) by(rp_se_t);

				
		

foreach outcome in respondio respuestaCorrecta{;								 								 
		reg `outcome' rp_se_t if fCat_1==1 & T==1, r;
		outreg2 using "r_se_fCat_`outcome'.xls", replace label dec(4);
		forvalues i=2(1)5{;							
			reg `outcome' rp_se_t if fCat_`i'==1 & T==1, r;
			outreg2 using "r_se_fCat_`outcome'.xls", append label dec(4);
		};								 						
};								

foreach x in respuestaCorrecta respondio{;							
bysort flow_cat: ttest  `x' if T==1, by(rp_se_t);
ttest `x', by(rp_se_t);
};		
							
*Caracteristicas demograficas bf;
preserve;
drop fCat_*;
drop fName_*;
duplicates report phone;
tabmiss phone;
duplicates drop phone, force;
outreg2 using d_testKn_bf.doc, replace sum(log) 
         keep(i_pd_age 
		      i_pd_firstBaby 
			  i_pd_pastPregnancies  
			  i_pd_hasComp_ea 
			  i_pd_hasComp_ep 
			  rp_bf_altaRemota
			  i_receivedPhone
	          i_sameLocCl
	          cl_rural) eqkeep(mean sd);

restore;						









	
>>>>>>> bf64505f7c0f10fe9be0a092a980f67e79123494
