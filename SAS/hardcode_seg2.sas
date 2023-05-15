constant = -0.6269071490;

if 999993 <= XMA1076 <= 999999 then do; pts201 = -0.2973987208; %pts_lst(Y50, pts201, 0); end;
else if -999992 <= XMA1076 <= 0 then do; pts201 = 0; end;
else if 0.01 <= XMA1076 <= 1421.29 then do; pts201 = -0.0103777070*sqrt(XMA1076); %pts_lst(Y36, pts201, 0); end;
else if 1421.30 <= XMA1076 <= 999992.99 then do; pts201 = -0.3912409303; %pts_lst(Y36, pts201, 0); end;

if 93 <= XMA1116 <= 99 then do; pts202 = 0; end;
else if XMA1116 = 0	then do; pts202 = 0; end;
else if XMA1116 = 1	then do; pts202 = -0.2507474180; %pts_lst(Y14, pts202, 0); end;
else if XMA1116 = 2	then do; pts202 = -0.3546103993; %pts_lst(Y14, pts202, 0); end;
else if XMA1116 = 3	then do; pts202 = -0.4343072678; %pts_lst(Y14, pts202, 0); end;
else if 4 <= XMA1116 <= 92 then do; pts202 = -0.5014948360; %pts_lst(Y14, pts202, 0); end;

if 93 <= XMA1121 <= 99 then do; pts203 = 0.2215281701; end;
else if 0 <= XMA1121 <= 92 then do; pts203 = 0; %pts_lst(Y15, pts203, 0.2215281701); end;

if 93 <= XMA1146 <= 99 then do; pts204 = -0.0282450060; end;
else if XMA1146 = 0	then do; pts204 = -0.0282450060; end;
else if XMA1146 = 1	then do; pts204 = -0.0282450060; end;
else if XMA1146 = 2	then do; pts204 = -0.1129800240; %pts_lst(A13, pts204, -0.0282450060); end;
else if XMA1146 = 3	then do; pts204 = -0.2542050540; %pts_lst(A13, pts204, -0.0282450060); end;
else if 4 <= XMA1146 <= 92 then do; pts204 = -0.4519200960; %pts_lst(A13, pts204, -0.0282450060); end;

if 993 <= XMA1166 <= 999 then do; pts205 = -0.4300641800; %pts_lst(G91, pts205, 0); end;
else if XMA1166 = 0	then do; pts205 = 0; end;
else if 1 <= XMA1166 <= 139	then do; pts205 = -0.0030718870*XMA1166; %pts_lst(A15, pts205, 0); end;
else if 140 <= XMA1166 <= 992 then do; pts205 = -0.4300641800; %pts_lst(A15, pts205, 0); end;

if 999993 <= XMA1171 <= 999999 then do; pts206 = 0; %pts_lst(Y48, pts206, 0.3624060098); end;
else if -999992 <= XMA1171 <= 45.26	then do; pts206 = 0; %pts_lst(Y38, pts206, 0.3624060098); end;
else if 45.27 <= XMA1171 <= 162.11 then do; pts206 = 0.2410390722; %pts_lst(Y38, pts206, 0.3624060098); end;
else if 162.12 <= XMA1171 <= 999992.99 then do; pts206 = 0.3624060098; end;

if 93 <= XMA1186 <= 99 then do; pts207 = 0.3473443332; %pts_lst(Y56, pts207, 1.1500826561); end;
else if XMA1186 = 0	then do; pts207 = 0; %pts_lst(A16, pts207, 1.1500826561); end;
else if 1 <= XMA1186 <= 37 then do; pts207 = 0.3161664372*log(XMA1186); %pts_lst(A16, pts207, 1.1500826561); end;
else if 38 <= XMA1186 <= 92 then do; pts207 = 1.1500826561; end;

if 993 <= XMA1341 <= 999 then do; pts208 = -0.5397796900; %pts_lst(Y56, pts208, 0); end;
else if 0 <= XMA1341 <= 992	then do; pts208 = 0; end;

if 993 <= XMA1356 <= 999 then do; pts209 = 0.2007589186; end;
else if 0 <= XMA1356 <= 992	then do; pts209 = 0; %pts_lst(Y72, pts209, 0.2007589186); end;

if XMA1376 = 999995	then do; pts210 = 0; end;
else if 999993 <= XMA1376 <= 999994 then do; pts210 = -0.2979939607; %pts_lst(G92, pts210, 0); end;
else if 999996 <= XMA1376 <= 999999	then do; pts210 = -0.2979939607; %pts_lst(G92, pts210, 0); end;
else if -999992 <= XMA1376 <= 0	then do; pts210 = 0; end;
else if 0.01 <= XMA1376 <= 2621.50 then do; pts210 = -0.0472896360*log(XMA1376 + 1); %pts_lst(Y45, pts210, 0); end;
else if 2621.51 <= XMA1376 <= 999992.99	then do; pts210 = -0.3722586781; %pts_lst(Y45, pts210, 0); end;

if 93 <= XMA1388 <= 99 then do; pts211 = 0.1629910446; end;
else if 0 <= XMA1388 <= 92	then do; pts211 = 0; %pts_lst(A45, pts211, 0.1629910446); end;

if 999993 <= XMA1395 <= 999999 then do; pts212 = 0; end;
else if -999992 <= XMA1395 <= 300.33 then do; pts212 = 0; end;
else if 300.34 <= XMA1395 <= 384.73 then do; pts212 = -0.321074474; %pts_lst(Y37 , pts212, 0); end;
else if 384.74 <= XMA1395 <= 520.61	then do; pts212 = -0.407524912; %pts_lst(Y37 , pts212, 0); end;
else if 520.62 <= XMA1395 <= 788.77	then do; pts212 = -0.524197318; %pts_lst(Y37 , pts212, 0); end;
else if 788.78 <= XMA1395 <= 999992.99 then do; pts212 = -0.648589348; %pts_lst(Y37 , pts212, 0); end;

if 993 <= XMA1412 <= 999 then do; pts213 = -0.2346033750; %pts_lst(G93, pts213, 0); end;
else if XMA1412 = 0	then do; pts213 = 0; end;
else if 1 <= XMA1412 <= 24 then do; pts213 = -0.0093841350*XMA1412; %pts_lst(A59, pts213, 0); end;
else if 25 <= XMA1412 <= 992 then do; pts213 = -0.2346033750; %pts_lst(A59, pts213, 0); end;

if 993 <= XMA1413 <= 999 then do; pts214 = 2.1674290337; end;
else if XMA1413 = 0	then do; pts214 = 0; %pts_lst(Y46, pts214, 2.1674290337); end;
else if 1 <= XMA1413 <= 225	then do; pts214 = 0.1441752347*sqrt(XMA1413); %pts_lst(Y46, pts214, 2.1674290337); end;
else if 226 <= XMA1413 <= 992 then do; pts214 = 2.1674290337; end;

points=pts201 + pts202 + pts203 + pts204 + pts205 + pts206 + pts207 + pts208 + pts209 + pts210 + pts211 + pts212 + pts213 + pts214 + constant ;
score=1000/(1+exp(-1.0*points));

RC1='A14';
%assign_rc(RC2, 1);
%assign_rc(RC3, 2);
%assign_rc(RC4, 3); 
