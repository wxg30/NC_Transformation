array codes{*} $ code1-code29 ('A13','A15','A16','A45','A59','G91','G92','G93','G94','G95','X01','Y14','Y15','Y26','Y28','Y36','Y37','Y38','Y45','Y46','Y48','Y50','Y53','Y56','Y61','Y67','Y72','Y74','A14');
array pts_lst{29} A13 A15 A16 A45 A59 G91 G92 G93 G94 G95 X01 Y14 Y15 Y26 Y28 Y36 Y37 Y38 Y45 Y46 Y48 Y50 Y53 Y56 Y61 Y67 Y72 Y74 A14;
array RC{4} $ RC1-RC4;

*** Aggregate points lost ***;
%macro pts_lst(code, pts, max_pts);
	if &code < 0 then &code = 0;
	&code = &code + (&max_pts - &pts);
%mend;


%macro assign_rc(RC, RC_num);
	my_max = largest(&RC_num, of pts_lst[*]);
	if my_max > .Z then do;
		ind = whichn(my_max, of pts_lst[*]);
		&RC. = codes[ind];
	end;
	else &RC. = ' ';
%mend;

%macro cleanup;
	drop code1-code29 my_max ind A13 A15 A16 A45 A59 G91 G92 G93 G94 G95 X01 Y14 Y15 Y26 Y28 Y36 Y37 Y38 Y45 Y46 Y48 Y50 Y53 Y56 Y61 Y67 Y72 Y74 A14;
	drop seg XMA1186_C constant pts101 pts102 pts103 pts104 pts105 pts106 pts107 pts108 pts109 points score oe_score pts201 pts202	 	 
		pts203 pts204 pts205 pts206 pts207 pts208 pts209 pts210 pts211 pts212 pts213 pts214 FINAL_SCORE;
%mend;
