IF (0 < XMA1006 <= 92) and (XMA1162 > 992) then do;
	seg = 1;
	%inc "&HARDCODE./hardcode_seg1.sas";
	oe_score=0.9279011453*SCORE 
				+ 202.9095409061;
end;
ELSE IF (0 < XMA1006 <= 92) and (0 <= XMA1162 <= 992) then do;
	seg = 2;
	 %inc "&HARDCODE./hardcode_seg2.sas";
	oe_score = 0.000000723212089870*SCORE*SCORE*SCORE
				- 0.000459313725116881*SCORE*SCORE
				+ 0.582403518112839000*SCORE
				+ 127.429741089634000000;
end; 
ELSE seg = 0;


IF oe_score^=. then do;
    FINAL_SCORE=round(oe_score,1);
    if FINAL_SCORE < 100 then FINAL_SCORE = 100;
    If FINAL_SCORE > 999 then FINAL_SCORE = 999;
	XRS3 = FINAL_SCORE;
end;

%cleanup;
