//POVRay-Datei erstellt mit 3d41.ulp v20110101
//C:/Users/c5125630/Dropbox/GitHub/Xpark/xpark.brd
//17.05.2013 11:19:01

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 45;
#local cam_y = 163;
#local cam_z = -87;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 13;
#local lgt1_pos_y = 21;
#local lgt1_pos_z = 20;
#local lgt1_intense = 0.719861;
#local lgt2_pos_x = -13;
#local lgt2_pos_y = 21;
#local lgt2_pos_z = 20;
#local lgt2_intense = 0.719861;
#local lgt3_pos_x = 13;
#local lgt3_pos_y = 21;
#local lgt3_pos_z = -13;
#local lgt3_intense = 0.719861;
#local lgt4_pos_x = -13;
#local lgt4_pos_y = 21;
#local lgt4_pos_z = -13;
#local lgt4_intense = 0.719861;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 36.500000;
#declare pcb_y_size = 38.090000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(530);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animationsdaten
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "Keine/zu wenig Animationsdaten vorhanden (mind. 3 Punkte) (Flugpfad)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "Keine/zu wenig Animationsdaten vorhanden (mind. 3 Punkte) (Blickpunktpfad)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//versetzt die Kamera, sodass <0,0,0> über dem Eagle-Nullpunkt ist
	//translate<-18.250000,0,-19.045000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro XPARK(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Platine
prism{-1.500000,0.000000,8
<0.000000,0.000000><36.500000,0.000000>
<36.500000,0.000000><36.500000,38.090000>
<36.500000,38.090000><0.000000,38.090000>
<0.000000,38.090000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Bohrungen(real)/Bauteile
//Bohrungen(real)/Platine
//Bohrungen(real)/Durchkontaktierungen
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Bauteile
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_ELKO_2MM5_5MM("4.7µF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<10.160000,0.000000,31.750000>}#end		//Elko 2,5mm Pitch, 5mm Durchmesser, 11,2mm Hoehe C1 4.7µF E2,5-5
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_ELKO_2MM5_5MM("4.7µF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<22.860000,0.000000,34.290000>}#end		//Elko 2,5mm Pitch, 5mm Durchmesser, 11,2mm Hoehe C2 4.7µF E2,5-5
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<13.652500,0.000000,35.242500>}#end		//Diode DO35 10mm hor. D1 1N4004 DO41-10
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<29.527500,0.000000,30.162500>}#end		//Diode DO35 10mm hor. D2 1N4004 DO41-10
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP14("TINY24/44/84-PU","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<22.860000,0.000000,17.780000>translate<0,3.000000,0> }#end		//DIP14 IC1 TINY24/44/84-PU DIL14
#ifndef(pack_IC1) object{SOCKET_DIP14()rotate<0,-90.000000,0> rotate<0,0,0> translate<22.860000,0.000000,17.780000>}#end					//IC-Sockel 14Pin IC1 TINY24/44/84-PU
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {TR_TO92_G("LP2950Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<16.510000,0.000000,31.750000>}#end		//TO92 gewinckelt stehend IC2 LP2950Z TO92
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<3.810000,0.000000,3.810000>}#end		//Stiftleiste 2,54mm Raster 2Pin 1Reihe (pinhead.lib) JP1 StatusLED 1X02
#ifndef(pack_JP2) #declare global_pack_JP2=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<3.810000,0.000000,10.160000>}#end		//Stiftleiste 2,54mm Raster 2Pin 1Reihe (pinhead.lib) JP2 Photoresistor 1X02
#ifndef(pack_JP3) #declare global_pack_JP3=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<3.810000,0.000000,15.875000>}#end		//Stiftleiste 2,54mm Raster 2Pin 1Reihe (pinhead.lib) JP3 Red 1X02
#ifndef(pack_JP4) #declare global_pack_JP4=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<3.810000,0.000000,19.685000>}#end		//Stiftleiste 2,54mm Raster 2Pin 1Reihe (pinhead.lib) JP4 Yellow 1X02
#ifndef(pack_JP5) #declare global_pack_JP5=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<3.810000,0.000000,23.495000>}#end		//Stiftleiste 2,54mm Raster 2Pin 1Reihe (pinhead.lib) JP5 Green 1X02
#ifndef(pack_JP6) #declare global_pack_JP6=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<33.020000,0.000000,8.572500>}#end		//Stiftleiste 2,54mm Raster 4Pin 1Reihe (pinhead.lib) JP6 Ultrasonic 1X04
#ifndef(pack_JP7) #declare global_pack_JP7=yes; object {CON_PH_1X6()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<18.732500,0.000000,5.080000>}#end		//Stiftleiste 2,54mm Raster 6Pin 1Reihe (pinhead.lib) JP7 TTL 1X06
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0204_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<21.907500,0.000000,27.940000>}#end		//Diskreter Widerstand 0,15W 7,5MM Raster R1 10k 0204/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0204_075MM(texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<7.620000,0.000000,6.667500>}#end		//Diskreter Widerstand 0,15W 7,5MM Raster R2 330 0204/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0204_075MM(texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Black}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Yellow}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<12.700000,0.000000,13.970000>}#end		//Diskreter Widerstand 0,15W 7,5MM Raster R3 100k 0204/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0204_075MM(texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<12.700000,0.000000,17.780000>}#end		//Diskreter Widerstand 0,15W 7,5MM Raster R4 330 0204/7
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0204_075MM(texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<12.700000,0.000000,22.225000>}#end		//Diskreter Widerstand 0,15W 7,5MM Raster R5 330 0204/7
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0204_075MM(texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{Orange}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{DarkBrown}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<12.700000,0.000000,26.035000>}#end		//Diskreter Widerstand 0,15W 7,5MM Raster R6 330 0204/7
}//End union
#end
#if(pcb_pads_smds=on)
//Lötaugen&SMD/Bauteile
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<10.160000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<10.160000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<22.860000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<22.860000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<8.572500,0,35.242500> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<18.732500,0,35.242500> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<29.527500,0,25.082500> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<29.527500,0,35.242500> texture{col_thl}}
#ifndef(global_pack_G1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(3.149600,1.117600,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<3.810000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_G1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(3.149600,1.117600,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<3.810000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<26.670000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<16.510000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<14.605000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<16.510000,0,33.020000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<5.080000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<2.540000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<2.540000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<5.080000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<5.080000,0,15.875000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<2.540000,0,15.875000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<5.080000,0,19.685000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<2.540000,0,19.685000> texture{col_thl}}
#ifndef(global_pack_JP5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<5.080000,0,23.495000> texture{col_thl}}
#ifndef(global_pack_JP5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<2.540000,0,23.495000> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.020000,0,4.762500> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.020000,0,7.302500> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.020000,0,9.842500> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<33.020000,0,12.382500> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.382500,0,5.080000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<14.922500,0,5.080000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.462500,0,5.080000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.002500,0,5.080000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.542500,0,5.080000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.082500,0,5.080000> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<33.655000,0,33.972500> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<33.655000,0,28.892500> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<33.655000,0,23.812500> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<33.655000,0,18.732500> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.717500,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<18.097500,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<7.620000,0,2.857500> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<7.620000,0,10.477500> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<16.510000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<8.890000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.890000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<16.510000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.890000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<16.510000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<8.890000,0,26.035000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<16.510000,0,26.035000> texture{col_thl}}
//Lötaugen/Durchkontaktierungen
#end
#if(pcb_wires=on)
union{
//Signale
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.540000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.540000,-1.535000,8.890000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.540000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.540000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.540000,-1.535000,11.430000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,90.000000,0> translate<2.540000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.540000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,7.620000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<2.540000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.540000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<2.540000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,7.620000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<3.810000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<3.810000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,15.875000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,-90.000000,0> translate<5.080000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,19.685000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,-90.000000,0> translate<5.080000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,23.495000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,-90.000000,0> translate<5.080000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.350000,-1.535000,3.810000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.985000,-1.535000,12.382500>}
box{<0,0,-0.203200><2.927205,0.035000,0.203200> rotate<0,-49.395445,0> translate<5.080000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.350000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,2.540000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<6.350000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,2.857500>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,90.000000,0> translate<7.620000,-1.535000,2.857500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,10.477500>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,90.000000,0> translate<7.620000,-1.535000,10.477500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,16.510000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,20.320000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,24.130000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<5.080000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.572500,-1.535000,35.242500>}
box{<0,0,-0.203200><4.856816,0.035000,0.203200> rotate<0,-11.309186,0> translate<3.810000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,15.557500>}
box{<0,0,-0.203200><4.762500,0.035000,0.203200> rotate<0,-36.867464,0> translate<5.080000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,17.780000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.620000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.620000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,22.225000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,90.000000,0> translate<8.890000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,25.400000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.620000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,26.035000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,90.000000,0> translate<8.890000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.080000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.477500,-1.535000,2.222500>}
box{<0,0,-0.203200><7.633218,0.035000,0.203200> rotate<0,44.997030,0> translate<5.080000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890000,-1.535000,15.557500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.382500,-1.535000,15.557500>}
box{<0,0,-0.203200><3.492500,0.035000,0.203200> rotate<0,0.000000,0> translate<8.890000,-1.535000,15.557500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.382500,-1.535000,15.557500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.382500,-1.535000,24.130000>}
box{<0,0,-0.203200><8.572500,0.035000,0.203200> rotate<0,90.000000,0> translate<12.382500,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.985000,-1.535000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.922500,-1.535000,12.382500>}
box{<0,0,-0.203200><7.937500,0.035000,0.203200> rotate<0,0.000000,0> translate<6.985000,-1.535000,12.382500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.240000,-1.535000,10.160000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<7.620000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.922500,-1.535000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,13.970000>}
box{<0,0,-0.203200><2.245064,0.035000,0.203200> rotate<0,-44.997030,0> translate<14.922500,-1.535000,12.382500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,22.225000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.510000,-1.535000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,26.035000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,90.000000,0> translate<16.510000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.382500,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,30.480000>}
box{<0,0,-0.203200><7.573556,0.035000,0.203200> rotate<0,-56.972372,0> translate<12.382500,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,30.480000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,90.000000,0> translate<16.510000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,33.020000>}
box{<0,0,-0.203200><6.350000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.160000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.827500,-1.535000,15.557500>}
box{<0,0,-0.203200><1.618939,0.035000,0.203200> rotate<0,-78.684874,0> translate<16.510000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.240000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.780000,-1.535000,11.430000>}
box{<0,0,-0.203200><2.839806,0.035000,0.203200> rotate<0,-26.563298,0> translate<15.240000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.780000,-1.535000,27.940000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<16.510000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.780000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.097500,-1.535000,27.940000>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,0.000000,0> translate<17.780000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,35.242500>}
box{<0,0,-0.203200><3.143090,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.510000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.780000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050000,-1.535000,12.700000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.780000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.827500,-1.535000,15.557500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050000,-1.535000,17.780000>}
box{<0,0,-0.203200><3.143090,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.827500,-1.535000,15.557500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050000,-1.535000,20.320000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.510000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050000,-1.535000,22.860000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<16.510000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.510000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050000,-1.535000,25.400000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<16.510000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,35.242500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050000,-1.535000,35.560000>}
box{<0,0,-0.203200><0.449013,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.732500,-1.535000,35.242500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.002500,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.320000,-1.535000,5.080000>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,0.000000,0> translate<20.002500,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.320000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.225000,-1.535000,12.065000>}
box{<0,0,-0.203200><7.240114,0.035000,0.203200> rotate<0,-74.739948,0> translate<20.320000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.542500,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,5.080000>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,0.000000,0> translate<22.542500,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.780000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,33.020000>}
box{<0,0,-0.203200><7.184205,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.780000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,11.430000>}
box{<0,0,-0.203200><6.475755,0.035000,0.203200> rotate<0,-78.684874,0> translate<22.860000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,20.320000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.130000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.717500,-1.535000,27.940000>}
box{<0,0,-0.203200><1.587500,0.035000,0.203200> rotate<0,0.000000,0> translate<24.130000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.477500,-1.535000,2.222500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,2.222500>}
box{<0,0,-0.203200><16.192500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.477500,-1.535000,2.222500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,2.222500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,10.160000>}
box{<0,0,-0.203200><7.937500,0.035000,0.203200> rotate<0,90.000000,0> translate<26.670000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,12.700000>}
box{<0,0,-0.203200><2.839806,0.035000,0.203200> rotate<0,-26.563298,0> translate<24.130000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.225000,-1.535000,12.065000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,15.240000>}
box{<0,0,-0.203200><5.462477,0.035000,0.203200> rotate<0,-35.535332,0> translate<22.225000,-1.535000,12.065000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.130000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,17.780000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<24.130000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.940000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.670000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,17.780000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<26.670000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,17.780000>}
box{<0,0,-0.203200><10.160000,0.035000,0.203200> rotate<0,90.000000,0> translate<29.210000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.940000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.940000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.527500,-1.535000,25.082500>}
box{<0,0,-0.203200><1.618939,0.035000,0.203200> rotate<0,78.684874,0> translate<29.210000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.670000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,19.050000>}
box{<0,0,-0.203200><5.388154,0.035000,0.203200> rotate<0,44.997030,0> translate<26.670000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,19.050000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,90.000000,0> translate<30.480000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,26.670000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<29.210000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.750000,-1.535000,33.020000>}
box{<0,0,-0.203200><8.890000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.860000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,7.302500>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.020000,-1.535000,7.302500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.210000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,7.620000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,0.000000,0> translate<29.210000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,9.842500>}
box{<0,0,-0.203200><0.317500,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.020000,-1.535000,9.842500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,10.160000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.480000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.020000,-1.535000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655000,-1.535000,18.732500>}
box{<0,0,-0.203200><6.381671,0.035000,0.203200> rotate<0,-84.283844,0> translate<33.020000,-1.535000,12.382500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.480000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655000,-1.535000,23.812500>}
box{<0,0,-0.203200><4.271526,0.035000,0.203200> rotate<0,41.984442,0> translate<30.480000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.750000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655000,-1.535000,33.972500>}
box{<0,0,-0.203200><2.129855,0.035000,0.203200> rotate<0,-26.563298,0> translate<31.750000,-1.535000,33.020000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygone
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,1.219197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,36.870800>}
box{<0,0,-0.203200><35.651603,0.035000,0.203200> rotate<0,90.000000,0> translate<1.219197,-1.535000,36.870800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,1.219197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,1.219197>}
box{<0,0,-0.203200><34.061603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,1.219197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,1.219200>}
box{<0,0,-0.203200><34.061603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.068609,-1.535000,1.625600>}
box{<0,0,-0.203200><8.849413,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.864175,-1.535000,2.032000>}
box{<0,0,-0.203200><0.644978,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.482266,-1.535000,2.438400>}
box{<0,0,-0.203200><0.263069,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.337784,-1.535000,2.844800>}
box{<0,0,-0.203200><0.118588,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,3.251200>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,3.657600>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,4.064000>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,4.470400>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.357094,-1.535000,4.876800>}
box{<0,0,-0.203200><0.137897,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.549706,-1.535000,5.283200>}
box{<0,0,-0.203200><0.330509,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.047900,-1.535000,5.689600>}
box{<0,0,-0.203200><0.828703,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.598209,-1.535000,6.096000>}
box{<0,0,-0.203200><4.379013,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.191809,-1.535000,6.502400>}
box{<0,0,-0.203200><3.972613,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.668531,-1.535000,6.908800>}
box{<0,0,-0.203200><2.449334,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.109009,-1.535000,7.315200>}
box{<0,0,-0.203200><1.889813,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.702609,-1.535000,7.721600>}
box{<0,0,-0.203200><1.483413,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.287378,-1.535000,8.128000>}
box{<0,0,-0.203200><1.068181,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.607547,-1.535000,8.534400>}
box{<0,0,-0.203200><0.388350,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.354738,-1.535000,8.940800>}
box{<0,0,-0.203200><0.135541,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,9.347200>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,9.753600>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,10.160000>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,10.566400>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,10.972800>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.354744,-1.535000,11.379200>}
box{<0,0,-0.203200><0.135547,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.607550,-1.535000,11.785600>}
box{<0,0,-0.203200><0.388353,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.296213,-1.535000,12.192000>}
box{<0,0,-0.203200><1.077016,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.702613,-1.535000,12.598400>}
box{<0,0,-0.203200><1.483416,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.109012,-1.535000,13.004800>}
box{<0,0,-0.203200><1.889816,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.842938,-1.535000,13.411200>}
box{<0,0,-0.203200><3.623741,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.384806,-1.535000,13.817600>}
box{<0,0,-0.203200><4.165609,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.704791,-1.535000,14.224000>}
box{<0,0,-0.203200><0.485594,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.417553,-1.535000,14.630400>}
box{<0,0,-0.203200><0.198356,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,15.036800>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,15.443200>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,15.849600>}
box{<0,0,-0.203200><1.269981,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,16.256000>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,16.662400>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.398359,-1.535000,17.068800>}
box{<0,0,-0.203200><0.179163,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.653994,-1.535000,17.475200>}
box{<0,0,-0.203200><0.434797,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.899138,-1.535000,17.881600>}
box{<0,0,-0.203200><0.679941,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.495206,-1.535000,18.288000>}
box{<0,0,-0.203200><0.276009,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.341809,-1.535000,18.694400>}
box{<0,0,-0.203200><0.122613,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,19.100800>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,19.507200>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,19.913600>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,20.320000>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.349856,-1.535000,20.726400>}
box{<0,0,-0.203200><0.130659,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.531253,-1.535000,21.132800>}
box{<0,0,-0.203200><0.312056,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.998050,-1.535000,21.539200>}
box{<0,0,-0.203200><0.778853,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.605063,-1.535000,21.945600>}
box{<0,0,-0.203200><0.385866,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.381850,-1.535000,22.352000>}
box{<0,0,-0.203200><0.162653,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,22.758400>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,23.164800>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,23.571200>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,23.977600>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.325719,-1.535000,24.384000>}
box{<0,0,-0.203200><0.106522,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.443444,-1.535000,24.790400>}
box{<0,0,-0.203200><0.224247,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.759303,-1.535000,25.196800>}
box{<0,0,-0.203200><0.540106,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,25.603200>}
box{<0,0,-0.203200><6.502403,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,26.009600>}
box{<0,0,-0.203200><6.502403,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,26.416000>}
box{<0,0,-0.203200><6.502403,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.025034,-1.535000,26.822400>}
box{<0,0,-0.203200><6.805838,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.917519,-1.535000,27.228800>}
box{<0,0,-0.203200><1.698322,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.511119,-1.535000,27.635200>}
box{<0,0,-0.203200><1.291922,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.104719,-1.535000,28.041600>}
box{<0,0,-0.203200><0.885522,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,28.448000>}
box{<0,0,-0.203200><0.558803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,28.854400>}
box{<0,0,-0.203200><0.558803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733778,-1.535000,29.260800>}
box{<0,0,-0.203200><2.514581,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,29.667200>}
box{<0,0,-0.203200><0.558803,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.799922,-1.535000,30.073600>}
box{<0,0,-0.203200><0.580725,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.206322,-1.535000,30.480000>}
box{<0,0,-0.203200><0.987125,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.612722,-1.535000,30.886400>}
box{<0,0,-0.203200><1.393525,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.194712,-1.535000,31.292800>}
box{<0,0,-0.203200><7.975516,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.601113,-1.535000,31.699200>}
box{<0,0,-0.203200><8.381916,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.224466,-1.535000,32.105600>}
box{<0,0,-0.203200><8.005269,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.642475,-1.535000,32.512000>}
box{<0,0,-0.203200><1.423278,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.236075,-1.535000,32.918400>}
box{<0,0,-0.203200><1.016878,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.829675,-1.535000,33.324800>}
box{<0,0,-0.203200><0.610478,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,33.731200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,33.731200>}
box{<0,0,-0.203200><0.508003,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,33.731200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,34.137600>}
box{<0,0,-0.203200><0.508003,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,34.544000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,34.544000>}
box{<0,0,-0.203200><0.508003,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,34.950400>}
box{<0,0,-0.203200><0.508003,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.931278,-1.535000,35.356800>}
box{<0,0,-0.203200><0.712081,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.337678,-1.535000,35.763200>}
box{<0,0,-0.203200><1.118481,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.744078,-1.535000,36.169600>}
box{<0,0,-0.203200><1.524881,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.274072,-1.535000,36.576000>}
box{<0,0,-0.203200><7.054875,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.219197,-1.535000,36.870800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,36.870800>}
box{<0,0,-0.203200><34.061603,0.035000,0.203200> rotate<0,0.000000,0> translate<1.219197,-1.535000,36.870800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,9.145378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.463347,-1.535000,8.678600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<1.270000,-1.535000,9.145378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,11.174619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,9.145378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.270000,-1.535000,9.145378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.270000,-1.535000,11.174619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.463347,-1.535000,11.641397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<1.270000,-1.535000,11.174619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,3.860800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,4.667953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,-89.993839,0> translate<1.320797,-1.535000,3.860800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,3.860800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,3.860800>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320797,-1.535000,3.860800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,15.925800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,16.732953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,-89.993839,0> translate<1.320797,-1.535000,15.925800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,15.925800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,15.925800>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320797,-1.535000,15.925800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,19.735800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,20.542953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,-89.993839,0> translate<1.320797,-1.535000,19.735800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,19.735800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,19.735800>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320797,-1.535000,19.735800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,23.545800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,24.352953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,-89.993839,0> translate<1.320797,-1.535000,23.545800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320797,-1.535000,23.545800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,23.545800>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320797,-1.535000,23.545800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,2.952044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,2.762500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<1.320800,-1.535000,2.952044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,3.759194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,2.952044>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.320800,-1.535000,2.952044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,3.759194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,3.759194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320800,-1.535000,3.759194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,4.667953>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,4.857497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<1.320800,-1.535000,4.667953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,15.017044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,14.827500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<1.320800,-1.535000,15.017044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,15.824194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,15.017044>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.320800,-1.535000,15.017044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,15.824194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,15.824194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320800,-1.535000,15.824194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,16.732953>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,16.922497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<1.320800,-1.535000,16.732953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,18.827044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,18.637500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<1.320800,-1.535000,18.827044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,19.634194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,18.827044>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.320800,-1.535000,18.827044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,19.634194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,19.634194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320800,-1.535000,19.634194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,20.542953>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,20.732497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<1.320800,-1.535000,20.542953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,22.637044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,22.447500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<1.320800,-1.535000,22.637044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,23.444194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,22.637044>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.320800,-1.535000,22.637044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,23.444194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,23.444194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<1.320800,-1.535000,23.444194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.320800,-1.535000,24.352953>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,24.542497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<1.320800,-1.535000,24.352953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,2.762500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,2.579988>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<1.350822,-1.535000,2.762500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,4.857497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,5.040009>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<1.350822,-1.535000,4.857497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,14.827500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,14.644988>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<1.350822,-1.535000,14.827500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,16.922497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,17.105009>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<1.350822,-1.535000,16.922497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,18.637500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,18.454988>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<1.350822,-1.535000,18.637500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,20.732497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,20.915009>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<1.350822,-1.535000,20.732497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,22.447500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,22.264988>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<1.350822,-1.535000,22.447500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.350822,-1.535000,24.542497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,24.725009>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<1.350822,-1.535000,24.542497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,2.579988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,2.409000>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<1.410122,-1.535000,2.579988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,5.040009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,5.210997>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<1.410122,-1.535000,5.040009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,14.644988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,14.474000>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<1.410122,-1.535000,14.644988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,17.105009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,17.275997>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<1.410122,-1.535000,17.105009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,18.454988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,18.284000>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<1.410122,-1.535000,18.454988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,20.915009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,21.085997>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<1.410122,-1.535000,20.915009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,22.264988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,22.094000>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<1.410122,-1.535000,22.264988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.410122,-1.535000,24.725009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,24.895997>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<1.410122,-1.535000,24.725009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.463347,-1.535000,8.678600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.820600,-1.535000,8.321347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<1.463347,-1.535000,8.678600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.463347,-1.535000,11.641397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.820600,-1.535000,11.998650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.463347,-1.535000,11.641397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,2.409000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,2.253744>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<1.497247,-1.535000,2.409000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,5.210997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,5.366253>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<1.497247,-1.535000,5.210997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,14.474000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,14.318744>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<1.497247,-1.535000,14.474000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,17.275997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,17.431253>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<1.497247,-1.535000,17.275997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,18.284000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,18.128744>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<1.497247,-1.535000,18.284000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,21.085997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,21.241253>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<1.497247,-1.535000,21.085997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,22.094000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,21.938744>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<1.497247,-1.535000,22.094000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.497247,-1.535000,24.895997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,25.051253>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<1.497247,-1.535000,24.895997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,2.253744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,2.118047>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<1.610047,-1.535000,2.253744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,5.366253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,5.501950>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.610047,-1.535000,5.366253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,14.318744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,14.183047>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<1.610047,-1.535000,14.318744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,17.431253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,17.566950>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.610047,-1.535000,17.431253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,18.128744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,17.993047>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<1.610047,-1.535000,18.128744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,21.241253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,21.376950>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.610047,-1.535000,21.241253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,21.938744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,21.803047>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<1.610047,-1.535000,21.938744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.610047,-1.535000,25.051253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,25.186950>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.610047,-1.535000,25.051253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,33.427275>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.947275,-1.535000,32.207200>}
box{<0,0,-0.203200><1.725447,0.035000,0.203200> rotate<0,44.997030,0> translate<1.727200,-1.535000,33.427275> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,35.152722>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,33.427275>}
box{<0,0,-0.203200><1.725447,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.727200,-1.535000,33.427275> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.727200,-1.535000,35.152722>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.947275,-1.535000,36.372797>}
box{<0,0,-0.203200><1.725447,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.727200,-1.535000,35.152722> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,2.118047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,2.005247>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<1.745744,-1.535000,2.118047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,5.501950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,5.614750>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<1.745744,-1.535000,5.501950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,14.183047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,14.070247>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<1.745744,-1.535000,14.183047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,17.566950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,17.679750>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<1.745744,-1.535000,17.566950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,17.993047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,17.880247>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<1.745744,-1.535000,17.993047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,21.376950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,21.489750>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<1.745744,-1.535000,21.376950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,21.803047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,21.690247>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<1.745744,-1.535000,21.803047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.745744,-1.535000,25.186950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,25.299750>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<1.745744,-1.535000,25.186950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.777997,-1.535000,29.286200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,30.051678>}
box{<0,0,-0.203200><0.765478,0.035000,0.203200> rotate<0,-89.993826,0> translate<1.777997,-1.535000,29.286200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.777997,-1.535000,29.286200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733778,-1.535000,29.286200>}
box{<0,0,-0.203200><1.955781,0.035000,0.203200> rotate<0,0.000000,0> translate<1.777997,-1.535000,29.286200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,28.368319>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.968319,-1.535000,27.178000>}
box{<0,0,-0.203200><1.683365,0.035000,0.203200> rotate<0,44.997030,0> translate<1.778000,-1.535000,28.368319> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,29.133794>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,28.368319>}
box{<0,0,-0.203200><0.765475,0.035000,0.203200> rotate<0,-90.000000,0> translate<1.778000,-1.535000,28.368319> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,29.133794>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733778,-1.535000,29.133794>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,0.000000,0> translate<1.778000,-1.535000,29.133794> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.778000,-1.535000,30.051678>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.968319,-1.535000,31.241997>}
box{<0,0,-0.203200><1.683365,0.035000,0.203200> rotate<0,-44.997030,0> translate<1.778000,-1.535000,30.051678> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.820600,-1.535000,8.321347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.287378,-1.535000,8.128000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<1.820600,-1.535000,8.321347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.820600,-1.535000,11.998650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.287378,-1.535000,12.191997>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<1.820600,-1.535000,11.998650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,2.005247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,1.918122>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<1.901000,-1.535000,2.005247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,5.614750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,5.701875>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<1.901000,-1.535000,5.614750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,14.070247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,13.983122>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<1.901000,-1.535000,14.070247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,17.679750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,17.766875>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<1.901000,-1.535000,17.679750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,17.880247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,17.793122>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<1.901000,-1.535000,17.880247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,21.489750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,21.576875>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<1.901000,-1.535000,21.489750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,21.690247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,21.603122>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<1.901000,-1.535000,21.690247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<1.901000,-1.535000,25.299750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,25.386875>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<1.901000,-1.535000,25.299750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,1.918122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,1.858822>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<2.071988,-1.535000,1.918122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,5.701875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,5.761175>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<2.071988,-1.535000,5.701875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,13.983122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,13.923822>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<2.071988,-1.535000,13.983122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,17.766875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.112381,-1.535000,17.780000>}
box{<0,0,-0.203200><0.042473,0.035000,0.203200> rotate<0,-17.999165,0> translate<2.071988,-1.535000,17.766875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,17.793122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.112381,-1.535000,17.780000>}
box{<0,0,-0.203200><0.042472,0.035000,0.203200> rotate<0,17.995156,0> translate<2.071988,-1.535000,17.793122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,21.576875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.112384,-1.535000,21.589997>}
box{<0,0,-0.203200><0.042475,0.035000,0.203200> rotate<0,-17.993853,0> translate<2.071988,-1.535000,21.576875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,21.603122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.112384,-1.535000,21.589997>}
box{<0,0,-0.203200><0.042476,0.035000,0.203200> rotate<0,17.997862,0> translate<2.071988,-1.535000,21.603122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.071988,-1.535000,25.386875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,25.446175>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<2.071988,-1.535000,25.386875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,1.858822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,1.828800>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<2.254500,-1.535000,1.858822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,5.761175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,5.791197>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<2.254500,-1.535000,5.761175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,13.923822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,13.893800>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<2.254500,-1.535000,13.923822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.254500,-1.535000,25.446175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,25.476197>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<2.254500,-1.535000,25.446175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.287378,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.296209,-1.535000,8.128000>}
box{<0,0,-0.203200><0.008831,0.035000,0.203200> rotate<0,0.000000,0> translate<2.287378,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.287378,-1.535000,12.191997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.296209,-1.535000,12.191997>}
box{<0,0,-0.203200><0.008831,0.035000,0.203200> rotate<0,0.000000,0> translate<2.287378,-1.535000,12.191997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.296209,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.407138,-1.535000,7.017072>}
box{<0,0,-0.203200><1.571090,0.035000,0.203200> rotate<0,44.997030,0> translate<2.296209,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.296209,-1.535000,12.191997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.407138,-1.535000,13.302925>}
box{<0,0,-0.203200><1.571090,0.035000,0.203200> rotate<0,-44.997030,0> translate<2.296209,-1.535000,12.191997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,1.828800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,1.828797>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.003965,0> translate<2.444044,-1.535000,1.828800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,5.791197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,5.791197>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.000000,0> translate<2.444044,-1.535000,5.791197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,13.893800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,13.893797>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.003965,0> translate<2.444044,-1.535000,13.893800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.444044,-1.535000,25.476197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,25.476197>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.000000,0> translate<2.444044,-1.535000,25.476197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,3.860800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,3.759194>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.489178,-1.535000,3.759194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,15.925800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,15.824194>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.489178,-1.535000,15.824194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,19.735800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,19.634194>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.489178,-1.535000,19.634194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,23.545800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489178,-1.535000,23.444194>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.489178,-1.535000,23.444194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,1.828797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,3.759178>}
box{<0,0,-0.203200><1.930381,0.035000,0.203200> rotate<0,90.000000,0> translate<2.489194,-1.535000,3.759178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,2.032000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,2.438400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,2.844800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,3.251200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,3.657600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,3.759178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,3.759178>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,3.759178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,3.860819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,5.791197>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,90.000000,0> translate<2.489194,-1.535000,5.791197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,3.860819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,3.860819>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,3.860819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,4.064000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,4.470400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,4.876800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,5.283200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,5.689600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,13.893797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,15.824178>}
box{<0,0,-0.203200><1.930381,0.035000,0.203200> rotate<0,90.000000,0> translate<2.489194,-1.535000,15.824178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,14.224000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,14.630400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,15.036800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,15.443200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,15.824178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,15.824178>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,15.824178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,15.925819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.634178>}
box{<0,0,-0.203200><3.708359,0.035000,0.203200> rotate<0,90.000000,0> translate<2.489194,-1.535000,19.634178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,15.925819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,15.925819>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,15.925819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,16.256000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,16.662400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,17.068800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,17.475200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,17.881600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,18.288000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,18.694400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.100800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.507200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.634178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.634178>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,19.634178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.735819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.444178>}
box{<0,0,-0.203200><3.708359,0.035000,0.203200> rotate<0,90.000000,0> translate<2.489194,-1.535000,23.444178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.735819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.735819>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,19.735819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.913600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,20.320000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,20.726400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,21.132800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,21.539200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,21.945600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,22.352000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,22.758400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.164800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.444178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.444178>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,23.444178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.545819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,25.476197>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,90.000000,0> translate<2.489194,-1.535000,25.476197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.545819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.545819>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,23.545819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.571200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.977600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,24.384000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,24.790400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.489194,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,25.196800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<2.489194,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,1.828800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,1.828800>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590800,-1.535000,1.828800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,3.759178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,1.828800>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,1.828800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,5.791197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,3.860819>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,3.860819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,5.791197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,5.791197>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590800,-1.535000,5.791197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,13.893800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,13.893800>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590800,-1.535000,13.893800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,15.824178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,13.893800>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,13.893800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,17.856197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,15.925819>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,15.925819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.634178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,17.856197>}
box{<0,0,-0.203200><1.777981,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,17.856197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,21.513800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,19.735819>}
box{<0,0,-0.203200><1.777981,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,19.735819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.444178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,21.513800>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,21.513800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,25.476197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,23.545819>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<2.590800,-1.535000,23.545819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590800,-1.535000,25.476197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,25.476197>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590800,-1.535000,25.476197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,3.759194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,3.860800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<2.590819,-1.535000,3.860800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,3.759194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,3.759194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,3.759194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,3.860800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,3.860800>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,3.860800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,15.824194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,15.925800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<2.590819,-1.535000,15.925800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,15.824194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.824194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,15.824194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,15.849600>}
box{<0,0,-0.203200><1.219181,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,15.925800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.925800>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,15.925800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,19.634194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,19.735800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<2.590819,-1.535000,19.735800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,19.634194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.634194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,19.634194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,19.735800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.735800>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,19.735800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,23.444194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,23.545800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<2.590819,-1.535000,23.545800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,23.444194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.444194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,23.444194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.590819,-1.535000,23.545800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.545800>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<2.590819,-1.535000,23.545800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,1.828800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,1.858822>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<2.635953,-1.535000,1.828800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,5.791197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,5.761175>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<2.635953,-1.535000,5.791197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,13.893800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,13.923822>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<2.635953,-1.535000,13.893800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.635953,-1.535000,25.476197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,25.446175>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<2.635953,-1.535000,25.476197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,1.858822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,1.918122>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<2.825497,-1.535000,1.858822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,5.761175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,5.701875>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<2.825497,-1.535000,5.761175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,13.923822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,13.983122>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<2.825497,-1.535000,13.923822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.825497,-1.535000,25.446175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,25.386875>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<2.825497,-1.535000,25.446175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.947275,-1.535000,32.207200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.672722,-1.535000,32.207200>}
box{<0,0,-0.203200><1.725447,0.035000,0.203200> rotate<0,0.000000,0> translate<2.947275,-1.535000,32.207200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.947275,-1.535000,36.372797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.672722,-1.535000,36.372797>}
box{<0,0,-0.203200><1.725447,0.035000,0.203200> rotate<0,0.000000,0> translate<2.947275,-1.535000,36.372797> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.967612,-1.535000,21.589997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,21.576875>}
box{<0,0,-0.203200><0.042475,0.035000,0.203200> rotate<0,17.993853,0> translate<2.967612,-1.535000,21.589997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.967612,-1.535000,21.589997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,21.603122>}
box{<0,0,-0.203200><0.042476,0.035000,0.203200> rotate<0,-17.997862,0> translate<2.967612,-1.535000,21.589997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.967616,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,17.766875>}
box{<0,0,-0.203200><0.042473,0.035000,0.203200> rotate<0,17.999165,0> translate<2.967616,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.967616,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,17.793122>}
box{<0,0,-0.203200><0.042472,0.035000,0.203200> rotate<0,-17.995156,0> translate<2.967616,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.968319,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,27.178000>}
box{<0,0,-0.203200><0.765475,0.035000,0.203200> rotate<0,0.000000,0> translate<2.968319,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.968319,-1.535000,31.241997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,31.241997>}
box{<0,0,-0.203200><0.765475,0.035000,0.203200> rotate<0,0.000000,0> translate<2.968319,-1.535000,31.241997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,1.918122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,2.005247>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<3.008009,-1.535000,1.918122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,5.701875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,5.614750>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<3.008009,-1.535000,5.701875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,13.983122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,14.070247>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<3.008009,-1.535000,13.983122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,17.766875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,17.679750>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<3.008009,-1.535000,17.766875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,17.793122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,17.880247>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<3.008009,-1.535000,17.793122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,21.576875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,21.489750>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<3.008009,-1.535000,21.576875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,21.603122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,21.690247>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<3.008009,-1.535000,21.603122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.008009,-1.535000,25.386875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,25.299750>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<3.008009,-1.535000,25.386875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.032100,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.459462,-1.535000,5.689600>}
box{<0,0,-0.203200><1.427362,0.035000,0.203200> rotate<0,0.000000,0> translate<3.032100,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.081950,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.398144,-1.535000,21.539200>}
box{<0,0,-0.203200><1.316194,0.035000,0.203200> rotate<0,0.000000,0> translate<3.081950,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,2.005247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,2.118047>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<3.178997,-1.535000,2.005247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,5.614750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,5.501950>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<3.178997,-1.535000,5.614750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,14.070247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,14.183047>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<3.178997,-1.535000,14.070247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,17.679750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,17.566950>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<3.178997,-1.535000,17.679750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,17.880247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,17.993047>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<3.178997,-1.535000,17.880247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,21.489750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,21.376950>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<3.178997,-1.535000,21.489750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,21.690247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,21.803047>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<3.178997,-1.535000,21.690247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.178997,-1.535000,25.299750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,25.186950>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<3.178997,-1.535000,25.299750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.180856,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.325347,-1.535000,17.881600>}
box{<0,0,-0.203200><1.144491,0.035000,0.203200> rotate<0,0.000000,0> translate<3.180856,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.215819,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.299947,-1.535000,2.032000>}
box{<0,0,-0.203200><1.084128,0.035000,0.203200> rotate<0,0.000000,0> translate<3.215819,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.320697,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.223750,-1.535000,25.196800>}
box{<0,0,-0.203200><0.903053,0.035000,0.203200> rotate<0,0.000000,0> translate<3.320697,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,2.118047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,2.253744>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<3.334253,-1.535000,2.118047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,5.501950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,5.366253>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<3.334253,-1.535000,5.501950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,14.183047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,14.318744>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<3.334253,-1.535000,14.183047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,17.566950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,17.431253>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<3.334253,-1.535000,17.566950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,17.993047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,18.128744>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<3.334253,-1.535000,17.993047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,21.376950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,21.241253>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<3.334253,-1.535000,21.376950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,21.803047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,21.938744>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<3.334253,-1.535000,21.803047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.334253,-1.535000,25.186950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,25.051253>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<3.334253,-1.535000,25.186950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.375206,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.172947,-1.535000,14.224000>}
box{<0,0,-0.203200><0.797741,0.035000,0.203200> rotate<0,0.000000,0> translate<3.375206,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.407138,-1.535000,7.017072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.668531,-1.535000,6.908800>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<3.407138,-1.535000,7.017072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.407138,-1.535000,13.302925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.668531,-1.535000,13.411197>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<3.407138,-1.535000,13.302925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.426003,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.122150,-1.535000,17.475200>}
box{<0,0,-0.203200><0.696147,0.035000,0.203200> rotate<0,0.000000,0> translate<3.426003,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,2.253744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,2.409000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<3.469950,-1.535000,2.253744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,5.366253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,5.210997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<3.469950,-1.535000,5.366253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,14.318744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,14.474000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<3.469950,-1.535000,14.318744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,17.431253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,17.275997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<3.469950,-1.535000,17.431253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,18.128744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,18.284000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<3.469950,-1.535000,18.128744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,21.241253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,21.085997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<3.469950,-1.535000,21.241253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,21.938744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,22.094000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<3.469950,-1.535000,21.938744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.469950,-1.535000,25.051253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,24.895997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<3.469950,-1.535000,25.051253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.474931,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.071347,-1.535000,21.945600>}
box{<0,0,-0.203200><0.596416,0.035000,0.203200> rotate<0,0.000000,0> translate<3.474931,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.530294,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.999953,-1.535000,5.283200>}
box{<0,0,-0.203200><0.469659,0.035000,0.203200> rotate<0,0.000000,0> translate<3.530294,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.548747,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.989431,-1.535000,21.132800>}
box{<0,0,-0.203200><0.440684,0.035000,0.203200> rotate<0,0.000000,0> translate<3.548747,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,2.409000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,2.579988>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<3.582750,-1.535000,2.409000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,5.210997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,5.040009>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<3.582750,-1.535000,5.210997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,14.474000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,14.644988>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<3.582750,-1.535000,14.474000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,17.275997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,17.105009>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<3.582750,-1.535000,17.275997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,18.284000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,18.454988>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<3.582750,-1.535000,18.284000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,21.085997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,20.915009>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<3.582750,-1.535000,21.085997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,22.094000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,22.264988>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<3.582750,-1.535000,22.094000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.582750,-1.535000,24.895997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,24.725009>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<3.582750,-1.535000,24.895997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.584788,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.968384,-1.535000,18.288000>}
box{<0,0,-0.203200><0.383597,0.035000,0.203200> rotate<0,0.000000,0> translate<3.584788,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.597728,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.957866,-1.535000,2.438400>}
box{<0,0,-0.203200><0.360137,0.035000,0.203200> rotate<0,0.000000,0> translate<3.597728,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.636556,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.926306,-1.535000,24.790400>}
box{<0,0,-0.203200><0.289750,0.035000,0.203200> rotate<0,0.000000,0> translate<3.636556,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.662441,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.905259,-1.535000,14.630400>}
box{<0,0,-0.203200><0.242819,0.035000,0.203200> rotate<0,0.000000,0> translate<3.662441,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.668531,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.785409,-1.535000,6.908800>}
box{<0,0,-0.203200><1.116878,0.035000,0.203200> rotate<0,0.000000,0> translate<3.668531,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.668531,-1.535000,13.411197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.842931,-1.535000,13.411197>}
box{<0,0,-0.203200><1.174400,0.035000,0.203200> rotate<0,0.000000,0> translate<3.668531,-1.535000,13.411197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,2.579988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,2.762500>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<3.669875,-1.535000,2.579988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,5.040009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,4.857497>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<3.669875,-1.535000,5.040009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,14.644988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,14.827500>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<3.669875,-1.535000,14.644988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,17.105009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,16.922497>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<3.669875,-1.535000,17.105009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,18.454988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,18.637500>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<3.669875,-1.535000,18.454988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,20.915009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,20.732497>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<3.669875,-1.535000,20.915009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,22.264988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,22.447500>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<3.669875,-1.535000,22.264988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.669875,-1.535000,24.725009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,24.542497>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<3.669875,-1.535000,24.725009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.681641,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.884222,-1.535000,17.068800>}
box{<0,0,-0.203200><0.202581,0.035000,0.203200> rotate<0,0.000000,0> translate<3.681641,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.698144,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.863175,-1.535000,22.352000>}
box{<0,0,-0.203200><0.165031,0.035000,0.203200> rotate<0,0.000000,0> translate<3.698144,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.722906,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.831616,-1.535000,4.876800>}
box{<0,0,-0.203200><0.108709,0.035000,0.203200> rotate<0,0.000000,0> translate<3.722906,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,2.762500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,2.952044>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<3.729175,-1.535000,2.762500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,4.857497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,4.667953>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<3.729175,-1.535000,4.857497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,14.827500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.017044>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<3.729175,-1.535000,14.827500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,16.922497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,16.732953>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<3.729175,-1.535000,16.922497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,18.637500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,18.827044>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<3.729175,-1.535000,18.637500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,20.732497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,20.542953>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<3.729175,-1.535000,20.732497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,22.447500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,22.637044>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<3.729175,-1.535000,22.447500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.729175,-1.535000,24.542497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,24.352953>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<3.729175,-1.535000,24.542497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.730144,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.821094,-1.535000,20.726400>}
box{<0,0,-0.203200><0.090950,0.035000,0.203200> rotate<0,0.000000,0> translate<3.730144,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733778,-1.535000,29.286200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733778,-1.535000,29.133794>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.733778,-1.535000,29.133794> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,29.133778>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,90.000000,0> translate<3.733794,-1.535000,29.133778> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,27.228800>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,27.635200>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,28.041600>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,28.448000>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,28.854400>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,29.133778>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,29.133778>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,29.133778> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,29.286219>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,31.241997>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,90.000000,0> translate<3.733794,-1.535000,31.241997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,29.286219>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,29.286219>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,29.286219> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,29.667200>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,30.073600>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,30.480000>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.733794,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,30.886400>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<3.733794,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.738184,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,18.694400>}
box{<0,0,-0.203200><0.071816,0.035000,0.203200> rotate<0,0.000000,0> translate<3.738184,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.742209,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,2.844800>}
box{<0,0,-0.203200><0.067791,0.035000,0.203200> rotate<0,0.000000,0> translate<3.742209,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.754281,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,24.384000>}
box{<0,0,-0.203200><0.055719,0.035000,0.203200> rotate<0,0.000000,0> translate<3.754281,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,2.952044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,3.759194>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,3.759194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,3.251200>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,3.657600>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,3.860800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,4.667953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,4.667953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,4.064000>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,4.470400>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.017044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.824194>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,15.824194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,15.036800>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,15.443200>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,15.925800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,16.732953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,16.732953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,16.256000>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,16.662400>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,18.827044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.634194>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,19.634194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,19.100800>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,19.507200>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.735800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,20.542953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,20.542953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,19.913600>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,20.320000>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,22.637044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.444194>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,23.444194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,22.758400>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,23.164800>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.545800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,24.352953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,90.000000,0> translate<3.759197,-1.535000,24.352953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,23.571200>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.759197,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,23.977600>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<3.759197,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,2.795378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,2.328600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<3.810000,-1.535000,2.795378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,4.824619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,2.795378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.810000,-1.535000,2.795378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,4.824619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,5.291397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<3.810000,-1.535000,4.824619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,14.860378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,14.393600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<3.810000,-1.535000,14.860378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,16.889619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,14.860378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.810000,-1.535000,14.860378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,16.889619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,17.356397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<3.810000,-1.535000,16.889619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,18.670378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,18.203600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<3.810000,-1.535000,18.670378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,20.699619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,18.670378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.810000,-1.535000,18.670378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,20.699619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,21.166397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<3.810000,-1.535000,20.699619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,22.480378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,22.013600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<3.810000,-1.535000,22.480378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,24.509619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,22.480378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.810000,-1.535000,22.480378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.810000,-1.535000,24.509619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,24.976397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<3.810000,-1.535000,24.509619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.651678,-1.535000,27.178000>}
box{<0,0,-0.203200><0.765478,0.035000,0.203200> rotate<0,0.000000,0> translate<3.886200,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,29.133778>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,27.178000>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.886200,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,31.241997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,29.286219>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.886200,-1.535000,29.286219> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886200,-1.535000,31.241997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.651678,-1.535000,31.241997>}
box{<0,0,-0.203200><0.765478,0.035000,0.203200> rotate<0,0.000000,0> translate<3.886200,-1.535000,31.241997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886219,-1.535000,29.133794>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886219,-1.535000,29.286200>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,90.000000,0> translate<3.886219,-1.535000,29.286200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886219,-1.535000,29.133794>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,29.133794>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,0.000000,0> translate<3.886219,-1.535000,29.133794> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886219,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.601109,-1.535000,29.260800>}
box{<0,0,-0.203200><5.714891,0.035000,0.203200> rotate<0,0.000000,0> translate<3.886219,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.886219,-1.535000,29.286200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,29.286200>}
box{<0,0,-0.203200><1.955778,0.035000,0.203200> rotate<0,0.000000,0> translate<3.886219,-1.535000,29.286200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,2.328600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,1.971347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<4.003347,-1.535000,2.328600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,5.291397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,5.648650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.003347,-1.535000,5.291397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,14.393600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,14.036347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<4.003347,-1.535000,14.393600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,17.356397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,17.713650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.003347,-1.535000,17.356397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,18.203600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,17.846347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<4.003347,-1.535000,18.203600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,21.166397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,21.523650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.003347,-1.535000,21.166397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,22.013600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,21.656347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<4.003347,-1.535000,22.013600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.003347,-1.535000,24.976397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,25.333650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.003347,-1.535000,24.976397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,1.971347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,1.778000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<4.360600,-1.535000,1.971347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,5.648650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,5.841997>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<4.360600,-1.535000,5.648650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,14.036347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,13.843000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<4.360600,-1.535000,14.036347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,17.713650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.520781,-1.535000,17.780000>}
box{<0,0,-0.203200><0.173379,0.035000,0.203200> rotate<0,-22.498745,0> translate<4.360600,-1.535000,17.713650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,17.846347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.520781,-1.535000,17.780000>}
box{<0,0,-0.203200><0.173378,0.035000,0.203200> rotate<0,22.497791,0> translate<4.360600,-1.535000,17.846347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,21.523650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.520784,-1.535000,21.589997>}
box{<0,0,-0.203200><0.173381,0.035000,0.203200> rotate<0,-22.497396,0> translate<4.360600,-1.535000,21.523650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,21.656347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.520784,-1.535000,21.589997>}
box{<0,0,-0.203200><0.173382,0.035000,0.203200> rotate<0,22.498350,0> translate<4.360600,-1.535000,21.656347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.360600,-1.535000,25.333650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,25.526997>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<4.360600,-1.535000,25.333650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.651678,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,28.368319>}
box{<0,0,-0.203200><1.683365,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.651678,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.651678,-1.535000,31.241997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,30.051678>}
box{<0,0,-0.203200><1.683365,0.035000,0.203200> rotate<0,44.997030,0> translate<4.651678,-1.535000,31.241997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.672722,-1.535000,32.207200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.892797,-1.535000,33.427275>}
box{<0,0,-0.203200><1.725447,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.672722,-1.535000,32.207200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.672722,-1.535000,36.372797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.660197,-1.535000,35.385319>}
box{<0,0,-0.203200><1.396503,0.035000,0.203200> rotate<0,44.997121,0> translate<4.672722,-1.535000,36.372797> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.702478,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.548484,-1.535000,27.228800>}
box{<0,0,-0.203200><8.846006,0.035000,0.203200> rotate<0,0.000000,0> translate<4.702478,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.785409,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.668316,-1.535000,4.025897>}
box{<0,0,-0.203200><4.077043,0.035000,0.203200> rotate<0,44.996999,0> translate<4.785409,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,1.778000>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<4.827378,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,5.841997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,5.841997>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<4.827378,-1.535000,5.841997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,13.843000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,13.843000>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<4.827378,-1.535000,13.843000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.827378,-1.535000,25.526997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,25.526997>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<4.827378,-1.535000,25.526997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.842931,-1.535000,13.411197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.524825,-1.535000,13.922616>}
box{<0,0,-0.203200><0.852366,0.035000,0.203200> rotate<0,-36.867380,0> translate<4.842931,-1.535000,13.411197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.875919,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.595788,-1.535000,36.169600>}
box{<0,0,-0.203200><2.719869,0.035000,0.203200> rotate<0,0.000000,0> translate<4.875919,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.977522,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.954541,-1.535000,32.512000>}
box{<0,0,-0.203200><3.977019,0.035000,0.203200> rotate<0,0.000000,0> translate<4.977522,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.007275,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,30.886400>}
box{<0,0,-0.203200><3.895425,0.035000,0.203200> rotate<0,0.000000,0> translate<5.007275,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.108878,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.812644,-1.535000,27.635200>}
box{<0,0,-0.203200><8.703766,0.035000,0.203200> rotate<0,0.000000,0> translate<5.108878,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.282319,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.331069,-1.535000,35.763200>}
box{<0,0,-0.203200><2.048750,0.035000,0.203200> rotate<0,0.000000,0> translate<5.282319,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,1.971347>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<5.332619,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,5.841997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,5.648650>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<5.332619,-1.535000,5.841997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,13.843000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.524825,-1.535000,13.922616>}
box{<0,0,-0.203200><0.208043,0.035000,0.203200> rotate<0,-22.498818,0> translate<5.332619,-1.535000,13.843000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.332619,-1.535000,25.526997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,25.333650>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<5.332619,-1.535000,25.526997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.383922,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.851900,-1.535000,32.918400>}
box{<0,0,-0.203200><3.467978,0.035000,0.203200> rotate<0,0.000000,0> translate<5.383922,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.413675,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159966,-1.535000,30.480000>}
box{<0,0,-0.203200><4.746291,0.035000,0.203200> rotate<0,0.000000,0> translate<5.413675,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.505975,-1.535000,8.199809>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.682925,-1.535000,8.022859>}
box{<0,0,-0.203200><0.250245,0.035000,0.203200> rotate<0,44.997030,0> translate<5.505975,-1.535000,8.199809> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.505975,-1.535000,8.199809>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,8.321347>}
box{<0,0,-0.203200><0.317597,0.035000,0.203200> rotate<0,-22.498212,0> translate<5.505975,-1.535000,8.199809> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.515278,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.076806,-1.535000,28.041600>}
box{<0,0,-0.203200><8.561528,0.035000,0.203200> rotate<0,0.000000,0> translate<5.515278,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.577784,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.414100,-1.535000,8.128000>}
box{<0,0,-0.203200><14.836316,0.035000,0.203200> rotate<0,0.000000,0> translate<5.577784,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.639213,-1.535000,21.589997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,21.523650>}
box{<0,0,-0.203200><0.173381,0.035000,0.203200> rotate<0,22.497396,0> translate<5.639213,-1.535000,21.589997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.639213,-1.535000,21.589997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,21.656347>}
box{<0,0,-0.203200><0.173382,0.035000,0.203200> rotate<0,-22.498350,0> translate<5.639213,-1.535000,21.589997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.639216,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,17.713650>}
box{<0,0,-0.203200><0.173379,0.035000,0.203200> rotate<0,22.498745,0> translate<5.639216,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.639216,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,17.846347>}
box{<0,0,-0.203200><0.173378,0.035000,0.203200> rotate<0,-22.497791,0> translate<5.639216,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.660197,-1.535000,35.385319>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.311328,-1.535000,35.715544>}
box{<0,0,-0.203200><1.683830,0.035000,0.203200> rotate<0,-11.309144,0> translate<5.660197,-1.535000,35.385319> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.682925,-1.535000,8.022859>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.772088,-1.535000,2.933697>}
box{<0,0,-0.203200><7.197163,0.035000,0.203200> rotate<0,44.997030,0> translate<5.682925,-1.535000,8.022859> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.700538,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.004609,-1.535000,5.689600>}
box{<0,0,-0.203200><0.304072,0.035000,0.203200> rotate<0,0.000000,0> translate<5.700538,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.761856,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.833416,-1.535000,21.539200>}
box{<0,0,-0.203200><2.071559,0.035000,0.203200> rotate<0,0.000000,0> translate<5.761856,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.790322,-1.535000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.870378,-1.535000,33.324800>}
box{<0,0,-0.203200><3.080056,0.035000,0.203200> rotate<0,0.000000,0> translate<5.790322,-1.535000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,1.971347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,2.328600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<5.799397,-1.535000,1.971347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,5.648650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,5.291397>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<5.799397,-1.535000,5.648650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,8.321347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,8.678600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<5.799397,-1.535000,8.321347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,17.713650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,17.356397>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<5.799397,-1.535000,17.713650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,17.846347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,18.203600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<5.799397,-1.535000,17.846347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,21.523650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,21.166397>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<5.799397,-1.535000,21.523650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,21.656347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,22.013600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<5.799397,-1.535000,21.656347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.799397,-1.535000,25.333650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,24.976397>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<5.799397,-1.535000,25.333650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.820075,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,30.073600>}
box{<0,0,-0.203200><3.082625,0.035000,0.203200> rotate<0,0.000000,0> translate<5.820075,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.834650,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,17.881600>}
box{<0,0,-0.203200><1.886950,0.035000,0.203200> rotate<0,0.000000,0> translate<5.834650,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,28.368319>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,29.133794>}
box{<0,0,-0.203200><0.765475,0.035000,0.203200> rotate<0,90.000000,0> translate<5.841997,-1.535000,29.133794> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.340966,-1.535000,28.448000>}
box{<0,0,-0.203200><8.498969,0.035000,0.203200> rotate<0,0.000000,0> translate<5.841997,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605125,-1.535000,28.854400>}
box{<0,0,-0.203200><8.763128,0.035000,0.203200> rotate<0,0.000000,0> translate<5.841997,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,29.286200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,30.051678>}
box{<0,0,-0.203200><0.765478,0.035000,0.203200> rotate<0,90.000000,0> translate<5.841997,-1.535000,30.051678> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.841997,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.194709,-1.535000,29.667200>}
box{<0,0,-0.203200><3.352712,0.035000,0.203200> rotate<0,0.000000,0> translate<5.841997,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.860050,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.793131,-1.535000,2.032000>}
box{<0,0,-0.203200><0.933081,0.035000,0.203200> rotate<0,0.000000,0> translate<5.860050,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.892797,-1.535000,33.427275>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.892797,-1.535000,33.981278>}
box{<0,0,-0.203200><0.554003,0.035000,0.203200> rotate<0,90.000000,0> translate<5.892797,-1.535000,33.981278> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.892797,-1.535000,33.731200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.038713,-1.535000,33.731200>}
box{<0,0,-0.203200><3.145916,0.035000,0.203200> rotate<0,0.000000,0> translate<5.892797,-1.535000,33.731200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.892797,-1.535000,33.981278>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.590391,-1.535000,34.320797>}
box{<0,0,-0.203200><1.731213,0.035000,0.203200> rotate<0,-11.309186,0> translate<5.892797,-1.535000,33.981278> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.936247,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.681016,-1.535000,25.196800>}
box{<0,0,-0.203200><1.744769,0.035000,0.203200> rotate<0,0.000000,0> translate<5.936247,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.984184,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.303263,-1.535000,7.721600>}
box{<0,0,-0.203200><14.319078,0.035000,0.203200> rotate<0,0.000000,0> translate<5.984184,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.012450,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.524934,-1.535000,8.534400>}
box{<0,0,-0.203200><14.512484,0.035000,0.203200> rotate<0,0.000000,0> translate<6.012450,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.037847,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.579416,-1.535000,17.475200>}
box{<0,0,-0.203200><1.541569,0.035000,0.203200> rotate<0,0.000000,0> translate<6.037847,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.088650,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,21.945600>}
box{<0,0,-0.203200><1.632950,0.035000,0.203200> rotate<0,0.000000,0> translate<6.088650,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,2.328600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,2.795378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<6.156650,-1.535000,2.328600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,5.291397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,4.824619>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<6.156650,-1.535000,5.291397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,8.678600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,9.145378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<6.156650,-1.535000,8.678600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,17.356397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.212650,-1.535000,17.221197>}
box{<0,0,-0.203200><0.146339,0.035000,0.203200> rotate<0,67.496151,0> translate<6.156650,-1.535000,17.356397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,18.203600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,18.670378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<6.156650,-1.535000,18.203600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,21.166397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.212650,-1.535000,21.031197>}
box{<0,0,-0.203200><0.146339,0.035000,0.203200> rotate<0,67.496151,0> translate<6.156650,-1.535000,21.166397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,22.013600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,22.480378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<6.156650,-1.535000,22.013600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.156650,-1.535000,24.976397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.212650,-1.535000,24.841197>}
box{<0,0,-0.203200><0.146339,0.035000,0.203200> rotate<0,67.496151,0> translate<6.156650,-1.535000,24.976397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.158381,-1.535000,14.397784>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,14.860378>}
box{<0,0,-0.203200><0.500709,0.035000,0.203200> rotate<0,-67.495226,0> translate<6.158381,-1.535000,14.397784> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.158381,-1.535000,14.397784>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.422850,-1.535000,16.096138>}
box{<0,0,-0.203200><2.830587,0.035000,0.203200> rotate<0,-36.867490,0> translate<6.158381,-1.535000,14.397784> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.160047,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.411009,-1.535000,5.283200>}
box{<0,0,-0.203200><0.250962,0.035000,0.203200> rotate<0,0.000000,0> translate<6.160047,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.170569,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.427016,-1.535000,21.132800>}
box{<0,0,-0.203200><1.256447,0.035000,0.203200> rotate<0,0.000000,0> translate<6.170569,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.191609,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.745634,-1.535000,18.288000>}
box{<0,0,-0.203200><1.554025,0.035000,0.203200> rotate<0,0.000000,0> translate<6.191609,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.202128,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,2.438400>}
box{<0,0,-0.203200><0.249472,0.035000,0.203200> rotate<0,0.000000,0> translate<6.202128,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.212650,-1.535000,17.221197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.325409,-1.535000,17.221197>}
box{<0,0,-0.203200><1.112759,0.035000,0.203200> rotate<0,0.000000,0> translate<6.212650,-1.535000,17.221197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.212650,-1.535000,21.031197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.325409,-1.535000,21.031197>}
box{<0,0,-0.203200><1.112759,0.035000,0.203200> rotate<0,0.000000,0> translate<6.212650,-1.535000,21.031197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.212650,-1.535000,24.841197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.325409,-1.535000,24.841197>}
box{<0,0,-0.203200><1.112759,0.035000,0.203200> rotate<0,0.000000,0> translate<6.212650,-1.535000,24.841197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.254734,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.468538,-1.535000,14.630400>}
box{<0,0,-0.203200><0.213803,0.035000,0.203200> rotate<0,0.000000,0> translate<6.254734,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.265256,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.635772,-1.535000,8.940800>}
box{<0,0,-0.203200><14.370516,0.035000,0.203200> rotate<0,0.000000,0> translate<6.265256,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.296819,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,22.352000>}
box{<0,0,-0.203200><1.424781,0.035000,0.203200> rotate<0,0.000000,0> translate<6.296819,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.328384,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.817409,-1.535000,4.876800>}
box{<0,0,-0.203200><0.489025,0.035000,0.203200> rotate<0,0.000000,0> translate<6.328384,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,2.795378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,2.804216>}
box{<0,0,-0.203200><0.008838,0.035000,0.203200> rotate<0,90.000000,0> translate<6.349997,-1.535000,2.804216> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,2.804216>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,2.702613>}
box{<0,0,-0.203200><0.143689,0.035000,0.203200> rotate<0,44.997030,0> translate<6.349997,-1.535000,2.804216> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,4.521197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,4.824619>}
box{<0,0,-0.203200><0.303422,0.035000,0.203200> rotate<0,90.000000,0> translate<6.349997,-1.535000,4.824619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,4.521197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.491466,-1.535000,4.521197>}
box{<0,0,-0.203200><0.141469,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,4.521197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,9.145378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,10.548844>}
box{<0,0,-0.203200><1.403466,0.035000,0.203200> rotate<0,90.000000,0> translate<6.349997,-1.535000,10.548844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.097931,-1.535000,9.347200>}
box{<0,0,-0.203200><0.747934,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.691531,-1.535000,9.753600>}
box{<0,0,-0.203200><0.341534,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,10.160000>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,10.548844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,10.667381>}
box{<0,0,-0.203200><0.156123,0.035000,0.203200> rotate<0,-49.395570,0> translate<6.349997,-1.535000,10.548844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,14.860378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,15.798800>}
box{<0,0,-0.203200><0.938422,0.035000,0.203200> rotate<0,90.000000,0> translate<6.349997,-1.535000,15.798800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.010403,-1.535000,15.036800>}
box{<0,0,-0.203200><0.660406,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.552269,-1.535000,15.443200>}
box{<0,0,-0.203200><1.202272,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,15.798800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.761466,-1.535000,15.798800>}
box{<0,0,-0.203200><1.411469,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,15.798800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,18.670378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,19.608800>}
box{<0,0,-0.203200><0.938422,0.035000,0.203200> rotate<0,90.000000,0> translate<6.349997,-1.535000,19.608800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.152034,-1.535000,18.694400>}
box{<0,0,-0.203200><1.802038,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,19.100800>}
box{<0,0,-0.203200><5.321303,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,19.507200>}
box{<0,0,-0.203200><5.321303,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,19.608800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.761466,-1.535000,19.608800>}
box{<0,0,-0.203200><1.411469,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,19.608800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,22.480378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,23.418800>}
box{<0,0,-0.203200><0.938422,0.035000,0.203200> rotate<0,90.000000,0> translate<6.349997,-1.535000,23.418800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.771034,-1.535000,22.758400>}
box{<0,0,-0.203200><1.421037,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.177434,-1.535000,23.164800>}
box{<0,0,-0.203200><1.827438,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.349997,-1.535000,23.418800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.761466,-1.535000,23.418800>}
box{<0,0,-0.203200><1.411469,0.035000,0.203200> rotate<0,0.000000,0> translate<6.349997,-1.535000,23.418800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.365044,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,10.566400>}
box{<0,0,-0.203200><0.086556,0.035000,0.203200> rotate<0,0.000000,0> translate<6.365044,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.390584,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.192428,-1.535000,7.315200>}
box{<0,0,-0.203200><13.801844,0.035000,0.203200> rotate<0,0.000000,0> translate<6.390584,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,2.373531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.136031,-1.535000,1.689100>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<6.451600,-1.535000,2.373531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,2.702613>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,2.373531>}
box{<0,0,-0.203200><0.329081,0.035000,0.203200> rotate<0,-90.000000,0> translate<6.451600,-1.535000,2.373531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,9.993531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.136031,-1.535000,9.309100>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<6.451600,-1.535000,9.993531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,10.667381>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.451600,-1.535000,9.993531>}
box{<0,0,-0.203200><0.673850,0.035000,0.203200> rotate<0,-90.000000,0> translate<6.451600,-1.535000,9.993531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.491466,-1.535000,4.521197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.752859,-1.535000,4.412925>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<6.491466,-1.535000,4.521197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.614103,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.223809,-1.535000,4.470400>}
box{<0,0,-0.203200><0.609706,0.035000,0.203200> rotate<0,0.000000,0> translate<6.614103,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.674406,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.773584,-1.535000,34.137600>}
box{<0,0,-0.203200><1.099178,0.035000,0.203200> rotate<0,0.000000,0> translate<6.674406,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.752859,-1.535000,4.412925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.952925,-1.535000,4.212859>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,44.997030,0> translate<6.752859,-1.535000,4.412925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.796984,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.790700,-1.535000,6.908800>}
box{<0,0,-0.203200><4.993716,0.035000,0.203200> rotate<0,0.000000,0> translate<6.796984,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.952925,-1.535000,4.212859>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.139884,-1.535000,4.025897>}
box{<0,0,-0.203200><0.264403,0.035000,0.203200> rotate<0,44.997509,0> translate<6.952925,-1.535000,4.212859> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.101784,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.630209,-1.535000,4.064000>}
box{<0,0,-0.203200><0.528425,0.035000,0.203200> rotate<0,0.000000,0> translate<7.101784,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.136031,-1.535000,1.689100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.103966,-1.535000,1.689100>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<7.136031,-1.535000,1.689100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.136031,-1.535000,9.309100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.103966,-1.535000,9.309100>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<7.136031,-1.535000,9.309100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.139884,-1.535000,4.025897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.668316,-1.535000,4.025897>}
box{<0,0,-0.203200><0.528431,0.035000,0.203200> rotate<0,0.000000,0> translate<7.139884,-1.535000,4.025897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.203384,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.355300,-1.535000,6.502400>}
box{<0,0,-0.203200><4.151916,0.035000,0.203200> rotate<0,0.000000,0> translate<7.203384,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.311328,-1.535000,35.715544>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.431247,-1.535000,36.005059>}
box{<0,0,-0.203200><0.313368,0.035000,0.203200> rotate<0,-67.495976,0> translate<7.311328,-1.535000,35.715544> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.325409,-1.535000,17.221197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,17.617384>}
box{<0,0,-0.203200><0.560296,0.035000,0.203200> rotate<0,-44.996804,0> translate<7.325409,-1.535000,17.221197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.325409,-1.535000,21.031197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.878425,-1.535000,21.584209>}
box{<0,0,-0.203200><0.782080,0.035000,0.203200> rotate<0,-44.996868,0> translate<7.325409,-1.535000,21.031197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.325409,-1.535000,24.841197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.878425,-1.535000,25.394209>}
box{<0,0,-0.203200><0.782080,0.035000,0.203200> rotate<0,-44.996868,0> translate<7.325409,-1.535000,24.841197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.431247,-1.535000,36.005059>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.809938,-1.535000,36.383750>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.431247,-1.535000,36.005059> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.590391,-1.535000,34.320797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.809938,-1.535000,34.101247>}
box{<0,0,-0.203200><0.310488,0.035000,0.203200> rotate<0,44.997438,0> translate<7.590391,-1.535000,34.320797> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.609784,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.188334,-1.535000,6.096000>}
box{<0,0,-0.203200><3.578550,0.035000,0.203200> rotate<0,0.000000,0> translate<7.609784,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,18.263966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,17.617384>}
box{<0,0,-0.203200><0.646581,0.035000,0.203200> rotate<0,-90.000000,0> translate<7.721600,-1.535000,17.617384> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,18.263966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.406031,-1.535000,18.948397>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.721600,-1.535000,18.263966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,21.741031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.878425,-1.535000,21.584209>}
box{<0,0,-0.203200><0.221782,0.035000,0.203200> rotate<0,44.996459,0> translate<7.721600,-1.535000,21.741031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,22.708966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,21.741031>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,-90.000000,0> translate<7.721600,-1.535000,21.741031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,22.708966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.406031,-1.535000,23.393397>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.721600,-1.535000,22.708966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,25.551031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.878425,-1.535000,25.394209>}
box{<0,0,-0.203200><0.221782,0.035000,0.203200> rotate<0,44.996459,0> translate<7.721600,-1.535000,25.551031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,26.518966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,25.551031>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,-90.000000,0> translate<7.721600,-1.535000,25.551031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.721600,-1.535000,26.518966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.406031,-1.535000,27.203397>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.721600,-1.535000,26.518966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.761466,-1.535000,15.798800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.022859,-1.535000,15.907072>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<7.761466,-1.535000,15.798800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.761466,-1.535000,19.608800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.022859,-1.535000,19.717072>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<7.761466,-1.535000,19.608800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.761466,-1.535000,23.418800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.022859,-1.535000,23.527072>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<7.761466,-1.535000,23.418800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.809938,-1.535000,34.101247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.304722,-1.535000,33.896300>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,22.498562,0> translate<7.809938,-1.535000,34.101247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.809938,-1.535000,36.383750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.304722,-1.535000,36.588697>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-22.498562,0> translate<7.809938,-1.535000,36.383750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.884106,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.094134,-1.535000,15.849600>}
box{<0,0,-0.203200><0.210028,0.035000,0.203200> rotate<0,0.000000,0> translate<7.884106,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.016184,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,5.689600>}
box{<0,0,-0.203200><3.147116,0.035000,0.203200> rotate<0,0.000000,0> translate<8.016184,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.022859,-1.535000,15.907072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.222925,-1.535000,16.107138>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.022859,-1.535000,15.907072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.022859,-1.535000,19.717072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.222925,-1.535000,19.917138>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.022859,-1.535000,19.717072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.022859,-1.535000,23.527072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.222925,-1.535000,23.727138>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.022859,-1.535000,23.527072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.066987,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,23.571200>}
box{<0,0,-0.203200><3.604313,0.035000,0.203200> rotate<0,0.000000,0> translate<8.066987,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.103966,-1.535000,1.689100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788397,-1.535000,2.373531>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.103966,-1.535000,1.689100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.103966,-1.535000,9.309100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.243666,-1.535000,9.448800>}
box{<0,0,-0.203200><0.197566,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.103966,-1.535000,9.309100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.142066,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.621872,-1.535000,9.347200>}
box{<0,0,-0.203200><9.479806,0.035000,0.203200> rotate<0,0.000000,0> translate<8.142066,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.219387,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,19.913600>}
box{<0,0,-0.203200><3.451913,0.035000,0.203200> rotate<0,0.000000,0> translate<8.219387,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.222925,-1.535000,16.107138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.727384,-1.535000,16.611600>}
box{<0,0,-0.203200><0.713415,0.035000,0.203200> rotate<0,-44.997208,0> translate<8.222925,-1.535000,16.107138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.222925,-1.535000,19.917138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.292859,-1.535000,20.987072>}
box{<0,0,-0.203200><1.513116,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.222925,-1.535000,19.917138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.222925,-1.535000,23.727138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.292859,-1.535000,24.797072>}
box{<0,0,-0.203200><1.513116,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.222925,-1.535000,23.727138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.243666,-1.535000,9.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.124584,-1.535000,9.448800>}
box{<0,0,-0.203200><6.880919,0.035000,0.203200> rotate<0,0.000000,0> translate<8.243666,-1.535000,9.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.304722,-1.535000,33.896300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.840275,-1.535000,33.896300>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,0.000000,0> translate<8.304722,-1.535000,33.896300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.304722,-1.535000,36.588697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.840275,-1.535000,36.588697>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,0.000000,0> translate<8.304722,-1.535000,36.588697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.371784,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.717881,-1.535000,16.256000>}
box{<0,0,-0.203200><0.346097,0.035000,0.203200> rotate<0,0.000000,0> translate<8.371784,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.406031,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,18.948397>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<8.406031,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.406031,-1.535000,23.393397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,23.393397>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<8.406031,-1.535000,23.393397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.406031,-1.535000,27.203397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,27.203397>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<8.406031,-1.535000,27.203397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.422584,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,5.283200>}
box{<0,0,-0.203200><2.740716,0.035000,0.203200> rotate<0,0.000000,0> translate<8.422584,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.422850,-1.535000,16.096138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.487138,-1.535000,16.160425>}
box{<0,0,-0.203200><0.090916,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.422850,-1.535000,16.096138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.446866,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.662209,-1.535000,2.032000>}
box{<0,0,-0.203200><1.215344,0.035000,0.203200> rotate<0,0.000000,0> translate<8.446866,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.473388,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,23.977600>}
box{<0,0,-0.203200><3.197912,0.035000,0.203200> rotate<0,0.000000,0> translate<8.473388,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.487138,-1.535000,16.160425>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.535000,-1.535000,16.180250>}
box{<0,0,-0.203200><0.051806,0.035000,0.203200> rotate<0,-22.498212,0> translate<8.487138,-1.535000,16.160425> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.535000,-1.535000,16.180250>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.576450,-1.535000,16.211337>}
box{<0,0,-0.203200><0.051812,0.035000,0.203200> rotate<0,-36.867464,0> translate<8.535000,-1.535000,16.180250> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.576450,-1.535000,16.211337>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.664534,-1.535000,16.233903>}
box{<0,0,-0.203200><0.090929,0.035000,0.203200> rotate<0,-14.368170,0> translate<8.576450,-1.535000,16.211337> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.625788,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,20.320000>}
box{<0,0,-0.203200><3.045512,0.035000,0.203200> rotate<0,0.000000,0> translate<8.625788,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.664534,-1.535000,16.233903>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.748531,-1.535000,16.268697>}
box{<0,0,-0.203200><0.090918,0.035000,0.203200> rotate<0,-22.499159,0> translate<8.664534,-1.535000,16.233903> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.727384,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,16.611600>}
box{<0,0,-0.203200><0.646581,0.035000,0.203200> rotate<0,0.000000,0> translate<8.727384,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.748531,-1.535000,16.268697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.800341,-1.535000,16.268697>}
box{<0,0,-0.203200><0.051809,0.035000,0.203200> rotate<0,0.000000,0> translate<8.748531,-1.535000,16.268697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788397,-1.535000,2.373531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788397,-1.535000,2.905816>}
box{<0,0,-0.203200><0.532284,0.035000,0.203200> rotate<0,90.000000,0> translate<8.788397,-1.535000,2.905816> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788397,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.255809,-1.535000,2.438400>}
box{<0,0,-0.203200><0.467413,0.035000,0.203200> rotate<0,0.000000,0> translate<8.788397,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788397,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.849409,-1.535000,2.844800>}
box{<0,0,-0.203200><0.061013,0.035000,0.203200> rotate<0,0.000000,0> translate<8.788397,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788397,-1.535000,2.905816>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.074637,-1.535000,1.619572>}
box{<0,0,-0.203200><1.819021,0.035000,0.203200> rotate<0,44.997100,0> translate<8.788397,-1.535000,2.905816> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.800341,-1.535000,16.268697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.850531,-1.535000,16.281556>}
box{<0,0,-0.203200><0.051812,0.035000,0.203200> rotate<0,-14.369717,0> translate<8.800341,-1.535000,16.268697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.828984,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,4.876800>}
box{<0,0,-0.203200><2.334316,0.035000,0.203200> rotate<0,0.000000,0> translate<8.828984,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.840275,-1.535000,33.896300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.335059,-1.535000,34.101247>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-22.498562,0> translate<8.840275,-1.535000,33.896300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.840275,-1.535000,36.588697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.335059,-1.535000,36.383750>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,22.498562,0> translate<8.840275,-1.535000,36.588697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.850531,-1.535000,16.281556>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.940550,-1.535000,16.268697>}
box{<0,0,-0.203200><0.090933,0.035000,0.203200> rotate<0,8.129287,0> translate<8.850531,-1.535000,16.281556> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.851900,-1.535000,32.759800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.051047,-1.535000,32.279019>}
box{<0,0,-0.203200><0.520394,0.035000,0.203200> rotate<0,67.495468,0> translate<8.851900,-1.535000,32.759800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.851900,-1.535000,33.280197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.851900,-1.535000,32.759800>}
box{<0,0,-0.203200><0.520397,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.851900,-1.535000,32.759800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.851900,-1.535000,33.280197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.051047,-1.535000,33.760978>}
box{<0,0,-0.203200><0.520394,0.035000,0.203200> rotate<0,-67.495468,0> translate<8.851900,-1.535000,33.280197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.870928,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.434072,-1.535000,36.576000>}
box{<0,0,-0.203200><9.563144,0.035000,0.203200> rotate<0,0.000000,0> translate<8.870928,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.879788,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.706319,-1.535000,24.384000>}
box{<0,0,-0.203200><2.826531,0.035000,0.203200> rotate<0,0.000000,0> translate<8.879788,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890031,-1.535000,13.969981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890031,-1.535000,13.970013>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,90.000000,0> translate<8.890031,-1.535000,13.970013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890031,-1.535000,13.969981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.969981>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,0.000000,0> translate<8.890031,-1.535000,13.969981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.890031,-1.535000,13.970013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.970013>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,0.000000,0> translate<8.890031,-1.535000,13.970013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,29.959209>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.639209,-1.535000,29.222700>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,44.997030,0> translate<8.902700,-1.535000,29.959209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,30.479981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,29.959209>}
box{<0,0,-0.203200><0.520772,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.902700,-1.535000,29.959209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,30.479981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159966,-1.535000,30.479981>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,0.000000,0> translate<8.902700,-1.535000,30.479981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,30.480013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159966,-1.535000,30.480013>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,0.000000,0> translate<8.902700,-1.535000,30.480013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,31.000788>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,30.480013>}
box{<0,0,-0.203200><0.520775,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.902700,-1.535000,30.480013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.902700,-1.535000,31.000788>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.639209,-1.535000,31.737297>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.902700,-1.535000,31.000788> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.940550,-1.535000,16.268697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,16.268697>}
box{<0,0,-0.203200><2.730750,0.035000,0.203200> rotate<0,0.000000,0> translate<8.940550,-1.535000,16.268697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.032188,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,20.726400>}
box{<0,0,-0.203200><2.639112,0.035000,0.203200> rotate<0,0.000000,0> translate<9.032188,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.051047,-1.535000,32.279019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.419019,-1.535000,31.911047>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,44.997030,0> translate<9.051047,-1.535000,32.279019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.051047,-1.535000,33.760978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.419019,-1.535000,34.128950>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.051047,-1.535000,33.760978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.235384,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,4.470400>}
box{<0,0,-0.203200><1.927916,0.035000,0.203200> rotate<0,0.000000,0> translate<9.235384,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.286188,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.963525,-1.535000,24.790400>}
box{<0,0,-0.203200><2.677338,0.035000,0.203200> rotate<0,0.000000,0> translate<9.286188,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.292859,-1.535000,20.987072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.362388,-1.535000,21.056600>}
box{<0,0,-0.203200><0.098328,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.292859,-1.535000,20.987072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.292859,-1.535000,24.797072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.362388,-1.535000,24.866600>}
box{<0,0,-0.203200><0.098328,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.292859,-1.535000,24.797072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.335059,-1.535000,34.101247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.713750,-1.535000,34.479937>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.335059,-1.535000,34.101247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.335059,-1.535000,36.383750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.713750,-1.535000,36.005059>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,44.997030,0> translate<9.335059,-1.535000,36.383750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.362388,-1.535000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,21.056600>}
box{<0,0,-0.203200><0.011578,0.035000,0.203200> rotate<0,0.000000,0> translate<9.362388,-1.535000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.362388,-1.535000,24.866600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,24.866600>}
box{<0,0,-0.203200><0.011578,0.035000,0.203200> rotate<0,0.000000,0> translate<9.362388,-1.535000,24.866600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.371412,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.439903,-1.535000,34.137600>}
box{<0,0,-0.203200><0.068491,0.035000,0.203200> rotate<0,0.000000,0> translate<9.371412,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,17.296031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.373966,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,18.263966>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<9.373966,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,21.741031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.373966,-1.535000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,23.393397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,22.708966>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<9.373966,-1.535000,23.393397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,24.866600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,25.551031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<9.373966,-1.535000,24.866600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.373966,-1.535000,27.203397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,26.518966>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<9.373966,-1.535000,27.203397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.419019,-1.535000,31.911047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.838491,-1.535000,31.737297>}
box{<0,0,-0.203200><0.454033,0.035000,0.203200> rotate<0,22.498406,0> translate<9.419019,-1.535000,31.911047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.419019,-1.535000,34.128950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.899800,-1.535000,34.328097>}
box{<0,0,-0.203200><0.520394,0.035000,0.203200> rotate<0,-22.498592,0> translate<9.419019,-1.535000,34.128950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.424766,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,16.662400>}
box{<0,0,-0.203200><2.246534,0.035000,0.203200> rotate<0,0.000000,0> translate<9.424766,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.450166,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,21.132800>}
box{<0,0,-0.203200><2.221134,0.035000,0.203200> rotate<0,0.000000,0> translate<9.450166,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.549209,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.755788,-1.535000,36.169600>}
box{<0,0,-0.203200><8.206578,0.035000,0.203200> rotate<0,0.000000,0> translate<9.549209,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.594216,-1.535000,13.093697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.507075>}
box{<0,0,-0.203200><0.584607,0.035000,0.203200> rotate<0,-44.996814,0> translate<9.594216,-1.535000,13.093697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.594216,-1.535000,13.093697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.627909,-1.535000,13.093697>}
box{<0,0,-0.203200><5.033694,0.035000,0.203200> rotate<0,0.000000,0> translate<9.594216,-1.535000,13.093697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.594216,-1.535000,14.846300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,14.432922>}
box{<0,0,-0.203200><0.584607,0.035000,0.203200> rotate<0,44.996814,0> translate<9.594216,-1.535000,14.846300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.594216,-1.535000,14.846300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.523966,-1.535000,14.846300>}
box{<0,0,-0.203200><2.929750,0.035000,0.203200> rotate<0,0.000000,0> translate<9.594216,-1.535000,14.846300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.602563,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,23.164800>}
box{<0,0,-0.203200><2.068737,0.035000,0.203200> rotate<0,0.000000,0> translate<9.602563,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.627963,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,18.694400>}
box{<0,0,-0.203200><2.043337,0.035000,0.203200> rotate<0,0.000000,0> translate<9.627963,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.639209,-1.535000,29.222700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,29.222700>}
box{<0,0,-0.203200><0.520772,0.035000,0.203200> rotate<0,0.000000,0> translate<9.639209,-1.535000,29.222700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.639209,-1.535000,31.737297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.838491,-1.535000,31.737297>}
box{<0,0,-0.203200><0.199281,0.035000,0.203200> rotate<0,0.000000,0> translate<9.639209,-1.535000,31.737297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.641784,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.188331,-1.535000,4.064000>}
box{<0,0,-0.203200><1.546547,0.035000,0.203200> rotate<0,0.000000,0> translate<9.641784,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.704166,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.227684,-1.535000,25.196800>}
box{<0,0,-0.203200><2.523519,0.035000,0.203200> rotate<0,0.000000,0> translate<9.704166,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.713750,-1.535000,34.479937>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.918697,-1.535000,34.974722>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-67.495498,0> translate<9.713750,-1.535000,34.479937> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.713750,-1.535000,36.005059>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.918697,-1.535000,35.510275>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,67.495498,0> translate<9.713750,-1.535000,36.005059> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.740284,-1.535000,34.544000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.028216,-1.535000,34.544000>}
box{<0,0,-0.203200><7.287931,0.035000,0.203200> rotate<0,0.000000,0> translate<9.740284,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.754963,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.284325,-1.535000,26.822400>}
box{<0,0,-0.203200><3.529362,0.035000,0.203200> rotate<0,0.000000,0> translate<9.754963,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.810119,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.518034,-1.535000,14.630400>}
box{<0,0,-0.203200><5.707916,0.035000,0.203200> rotate<0,0.000000,0> translate<9.810119,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.813934,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.491066,-1.535000,35.763200>}
box{<0,0,-0.203200><7.677131,0.035000,0.203200> rotate<0,0.000000,0> translate<9.813934,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.831166,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,17.068800>}
box{<0,0,-0.203200><1.840134,0.035000,0.203200> rotate<0,0.000000,0> translate<9.831166,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.856566,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,21.539200>}
box{<0,0,-0.203200><1.814734,0.035000,0.203200> rotate<0,0.000000,0> translate<9.856566,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.899800,-1.535000,34.328097>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.420197,-1.535000,34.328097>}
box{<0,0,-0.203200><0.520397,0.035000,0.203200> rotate<0,0.000000,0> translate<9.899800,-1.535000,34.328097> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.908622,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.396375,-1.535000,34.950400>}
box{<0,0,-0.203200><7.487753,0.035000,0.203200> rotate<0,0.000000,0> translate<9.908622,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.911719,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.945413,-1.535000,13.411200>}
box{<0,0,-0.203200><5.033694,0.035000,0.203200> rotate<0,0.000000,0> translate<9.911719,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.918697,-1.535000,34.974722>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.918697,-1.535000,35.510275>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,90.000000,0> translate<9.918697,-1.535000,35.510275> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.918697,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.386300,-1.535000,35.356800>}
box{<0,0,-0.203200><7.467603,0.035000,0.203200> rotate<0,0.000000,0> translate<9.918697,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.507075>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.969981>}
box{<0,0,-0.203200><0.462906,0.035000,0.203200> rotate<0,90.000000,0> translate<10.007597,-1.535000,13.969981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,13.817600>}
box{<0,0,-0.203200><5.334003,0.035000,0.203200> rotate<0,0.000000,0> translate<10.007597,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,13.970013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,14.432922>}
box{<0,0,-0.203200><0.462909,0.035000,0.203200> rotate<0,90.000000,0> translate<10.007597,-1.535000,14.432922> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.007597,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,14.224000>}
box{<0,0,-0.203200><5.334003,0.035000,0.203200> rotate<0,0.000000,0> translate<10.007597,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.008963,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,22.758400>}
box{<0,0,-0.203200><1.662337,0.035000,0.203200> rotate<0,0.000000,0> translate<10.008963,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.034363,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,18.288000>}
box{<0,0,-0.203200><1.636938,0.035000,0.203200> rotate<0,0.000000,0> translate<10.034363,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.048184,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.355294,-1.535000,3.657600>}
box{<0,0,-0.203200><1.307109,0.035000,0.203200> rotate<0,0.000000,0> translate<10.048184,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,17.296031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,18.263966>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,90.000000,0> translate<10.058397,-1.535000,18.263966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,17.475200>}
box{<0,0,-0.203200><1.612903,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,17.881600>}
box{<0,0,-0.203200><1.612903,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,21.741031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,22.708966>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,90.000000,0> translate<10.058397,-1.535000,22.708966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,21.945600>}
box{<0,0,-0.203200><1.612903,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,22.352000>}
box{<0,0,-0.203200><1.612903,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,25.551031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,26.518966>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,90.000000,0> translate<10.058397,-1.535000,26.518966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.491844,-1.535000,25.603200>}
box{<0,0,-0.203200><2.433447,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.756003,-1.535000,26.009600>}
box{<0,0,-0.203200><2.697606,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.058397,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.020166,-1.535000,26.416000>}
box{<0,0,-0.203200><2.961769,0.035000,0.203200> rotate<0,0.000000,0> translate<10.058397,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.074637,-1.535000,1.619572>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.336031,-1.535000,1.511300>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<10.074637,-1.535000,1.619572> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159966,-1.535000,30.480013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159966,-1.535000,30.479981>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,-90.000000,0> translate<10.159966,-1.535000,30.479981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,29.222700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,30.479966>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,90.000000,0> translate<10.159981,-1.535000,30.479966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,29.260800>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<10.159981,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,29.667200>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<10.159981,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,30.073600>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<10.159981,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.159981,-1.535000,30.479966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,30.479966>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<10.159981,-1.535000,30.479966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,29.222700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.680788,-1.535000,29.222700>}
box{<0,0,-0.203200><0.520775,0.035000,0.203200> rotate<0,0.000000,0> translate<10.160013,-1.535000,29.222700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,30.479966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160013,-1.535000,29.222700>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,-90.000000,0> translate<10.160013,-1.535000,29.222700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160031,-1.535000,30.479981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160031,-1.535000,30.480013>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,90.000000,0> translate<10.160031,-1.535000,30.480013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160031,-1.535000,30.479981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417294,-1.535000,30.479981>}
box{<0,0,-0.203200><1.257262,0.035000,0.203200> rotate<0,0.000000,0> translate<10.160031,-1.535000,30.479981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160031,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,30.480000>}
box{<0,0,-0.203200><5.181569,0.035000,0.203200> rotate<0,0.000000,0> translate<10.160031,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.160031,-1.535000,30.480013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,30.480013>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,0.000000,0> translate<10.160031,-1.535000,30.480013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.336031,-1.535000,1.511300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.811466,-1.535000,1.511300>}
box{<0,0,-0.203200><16.475434,0.035000,0.203200> rotate<0,0.000000,0> translate<10.336031,-1.535000,1.511300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.420197,-1.535000,34.328097>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.900978,-1.535000,34.128950>}
box{<0,0,-0.203200><0.520394,0.035000,0.203200> rotate<0,22.498592,0> translate<10.420197,-1.535000,34.328097> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.454584,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.790691,-1.535000,3.251200>}
box{<0,0,-0.203200><1.336106,0.035000,0.203200> rotate<0,0.000000,0> translate<10.454584,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.481506,-1.535000,31.737297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.680788,-1.535000,31.737297>}
box{<0,0,-0.203200><0.199281,0.035000,0.203200> rotate<0,0.000000,0> translate<10.481506,-1.535000,31.737297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.481506,-1.535000,31.737297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.900978,-1.535000,31.911047>}
box{<0,0,-0.203200><0.454033,0.035000,0.203200> rotate<0,-22.498406,0> translate<10.481506,-1.535000,31.737297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.680788,-1.535000,29.222700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,29.959209>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.680788,-1.535000,29.222700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.680788,-1.535000,31.737297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,31.000788>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,44.997030,0> translate<10.680788,-1.535000,31.737297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.718884,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.699200>}
box{<0,0,-0.203200><2.768516,0.035000,0.203200> rotate<0,0.000000,0> translate<10.718884,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.718888,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.869284,-1.535000,29.260800>}
box{<0,0,-0.203200><4.150397,0.035000,0.203200> rotate<0,0.000000,0> translate<10.718888,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.772088,-1.535000,2.933697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,2.933697>}
box{<0,0,-0.203200><15.186712,0.035000,0.203200> rotate<0,0.000000,0> translate<10.772088,-1.535000,2.933697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.880097,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.975234,-1.535000,34.137600>}
box{<0,0,-0.203200><5.095137,0.035000,0.203200> rotate<0,0.000000,0> translate<10.880097,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.900978,-1.535000,31.911047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.268950,-1.535000,32.279019>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.900978,-1.535000,31.911047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.900978,-1.535000,34.128950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.268950,-1.535000,33.760978>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,44.997030,0> translate<10.900978,-1.535000,34.128950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.095531,-1.535000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,32.105600>}
box{<0,0,-0.203200><2.391869,0.035000,0.203200> rotate<0,0.000000,0> translate<11.095531,-1.535000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.125284,-1.535000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.292800>}
box{<0,0,-0.203200><2.362116,0.035000,0.203200> rotate<0,0.000000,0> translate<11.125284,-1.535000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.125288,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.133447,-1.535000,29.667200>}
box{<0,0,-0.203200><4.008159,0.035000,0.203200> rotate<0,0.000000,0> translate<11.125288,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163297,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,5.937953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,-89.993839,0> translate<11.163297,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163297,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331678,-1.535000,5.130800>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,0.000000,0> translate<11.163297,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,4.222044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.193322,-1.535000,4.032500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<11.163300,-1.535000,4.222044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,4.222044>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.163300,-1.535000,4.222044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331678,-1.535000,5.029194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<11.163300,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.163300,-1.535000,5.937953>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.193322,-1.535000,6.127497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<11.163300,-1.535000,5.937953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.193322,-1.535000,4.032500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.252622,-1.535000,3.849988>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<11.193322,-1.535000,4.032500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.193322,-1.535000,6.127497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.252622,-1.535000,6.310009>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<11.193322,-1.535000,6.127497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.252622,-1.535000,3.849988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.339747,-1.535000,3.679000>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<11.252622,-1.535000,3.849988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.252622,-1.535000,6.310009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.339747,-1.535000,6.480997>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<11.252622,-1.535000,6.310009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.268950,-1.535000,32.279019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.281284,-1.535000,32.308800>}
box{<0,0,-0.203200><0.032234,0.035000,0.203200> rotate<0,-67.497881,0> translate<11.268950,-1.535000,32.279019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.268950,-1.535000,33.760978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.281284,-1.535000,33.731197>}
box{<0,0,-0.203200><0.032234,0.035000,0.203200> rotate<0,67.497881,0> translate<11.268950,-1.535000,33.760978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.281284,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.583281,-1.535000,32.308800>}
box{<0,0,-0.203200><2.301997,0.035000,0.203200> rotate<0,0.000000,0> translate<11.281284,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.281284,-1.535000,33.731197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.568831,-1.535000,33.731197>}
box{<0,0,-0.203200><4.287547,0.035000,0.203200> rotate<0,0.000000,0> translate<11.281284,-1.535000,33.731197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.281284,-1.535000,33.731200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.568834,-1.535000,33.731200>}
box{<0,0,-0.203200><4.287550,0.035000,0.203200> rotate<0,0.000000,0> translate<11.281284,-1.535000,33.731200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.339747,-1.535000,3.679000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.452547,-1.535000,3.523744>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<11.339747,-1.535000,3.679000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.339747,-1.535000,6.480997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.452547,-1.535000,6.636253>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<11.339747,-1.535000,6.480997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417294,-1.535000,30.479981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,29.959209>}
box{<0,0,-0.203200><0.520772,0.035000,0.203200> rotate<0,89.993717,0> translate<11.417294,-1.535000,30.479981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,30.073600>}
box{<0,0,-0.203200><3.924303,0.035000,0.203200> rotate<0,0.000000,0> translate<11.417297,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,30.480013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,31.000788>}
box{<0,0,-0.203200><0.520775,0.035000,0.203200> rotate<0,90.000000,0> translate<11.417297,-1.535000,31.000788> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.417297,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.888075,-1.535000,30.886400>}
box{<0,0,-0.203200><2.470778,0.035000,0.203200> rotate<0,0.000000,0> translate<11.417297,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.452547,-1.535000,3.523744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.588244,-1.535000,3.388047>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<11.452547,-1.535000,3.523744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.452547,-1.535000,6.636253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.588244,-1.535000,6.771950>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.452547,-1.535000,6.636253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.588244,-1.535000,3.388047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.743500,-1.535000,3.275247>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<11.588244,-1.535000,3.388047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.588244,-1.535000,6.771950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.743500,-1.535000,6.884750>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<11.588244,-1.535000,6.771950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.657425,-1.535000,24.120806>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,24.055397>}
box{<0,0,-0.203200><0.066865,0.035000,0.203200> rotate<0,78.018480,0> translate<11.657425,-1.535000,24.120806> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.657425,-1.535000,24.120806>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,24.195500>}
box{<0,0,-0.203200><0.075972,0.035000,0.203200> rotate<0,-79.471521,0> translate<11.657425,-1.535000,24.120806> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,24.055397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,16.268697>}
box{<0,0,-0.203200><7.786700,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.671300,-1.535000,16.268697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,24.271466>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,24.195500>}
box{<0,0,-0.203200><0.075966,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.671300,-1.535000,24.195500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.671300,-1.535000,24.271466>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.696888,-1.535000,24.333238>}
box{<0,0,-0.203200><0.066862,0.035000,0.203200> rotate<0,-67.494950,0> translate<11.671300,-1.535000,24.271466> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.696888,-1.535000,24.333238>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.709100,-1.535000,24.398984>}
box{<0,0,-0.203200><0.066871,0.035000,0.203200> rotate<0,-79.471977,0> translate<11.696888,-1.535000,24.333238> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.709100,-1.535000,24.398984>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.750503,-1.535000,24.462681>}
box{<0,0,-0.203200><0.075970,0.035000,0.203200> rotate<0,-56.972273,0> translate<11.709100,-1.535000,24.398984> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.743500,-1.535000,3.275247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.914487,-1.535000,3.188122>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<11.743500,-1.535000,3.275247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.743500,-1.535000,6.884750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.914487,-1.535000,6.971875>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<11.743500,-1.535000,6.884750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.750503,-1.535000,24.462681>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.779572,-1.535000,24.532859>}
box{<0,0,-0.203200><0.075960,0.035000,0.203200> rotate<0,-67.495532,0> translate<11.750503,-1.535000,24.462681> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.779572,-1.535000,24.532859>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.826850,-1.535000,24.580134>}
box{<0,0,-0.203200><0.066859,0.035000,0.203200> rotate<0,-44.995137,0> translate<11.779572,-1.535000,24.532859> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.826850,-1.535000,24.580134>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.344984,-1.535000,29.992647>}
box{<0,0,-0.203200><6.455429,0.035000,0.203200> rotate<0,-56.972363,0> translate<11.826850,-1.535000,24.580134> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.914487,-1.535000,3.188122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.097000,-1.535000,3.128822>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<11.914487,-1.535000,3.188122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.914487,-1.535000,6.971875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.097000,-1.535000,7.031175>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<11.914487,-1.535000,6.971875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.097000,-1.535000,3.128822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.286544,-1.535000,3.098800>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<12.097000,-1.535000,3.128822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.097000,-1.535000,7.031175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.286544,-1.535000,7.061197>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<12.097000,-1.535000,7.031175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.286544,-1.535000,3.098800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,3.098797>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.003965,0> translate<12.286544,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.286544,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,7.061197>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.000000,0> translate<12.286544,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331678,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331678,-1.535000,5.029194>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<12.331678,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,3.098797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,5.029178>}
box{<0,0,-0.203200><1.930381,0.035000,0.203200> rotate<0,90.000000,0> translate<12.331694,-1.535000,5.029178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,3.251200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,3.657600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,4.064000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,4.470400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,4.876800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,5.029178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,5.029178>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,5.029178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,5.130819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,7.061197>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,90.000000,0> translate<12.331694,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,5.130819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,5.130819>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,5.130819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,5.283200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,5.689600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,6.096000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,6.502400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.331694,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,6.908800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<12.331694,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,3.098800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.478453,-1.535000,3.098800>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<12.433300,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,5.029178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,3.098800>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<12.433300,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,5.130819>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<12.433300,-1.535000,5.130819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433300,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.478453,-1.535000,7.061197>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<12.433300,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433319,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433319,-1.535000,5.130800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<12.433319,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433319,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.029194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<12.433319,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.433319,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.130800>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<12.433319,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.478453,-1.535000,3.098800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.667997,-1.535000,3.128822>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<12.478453,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.478453,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.667997,-1.535000,7.031175>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<12.478453,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.523966,-1.535000,14.846300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.785359,-1.535000,14.954572>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<12.523966,-1.535000,14.846300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.667997,-1.535000,3.128822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.850509,-1.535000,3.188122>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<12.667997,-1.535000,3.128822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.667997,-1.535000,7.031175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.850509,-1.535000,6.971875>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<12.667997,-1.535000,7.031175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.785359,-1.535000,14.954572>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.985425,-1.535000,15.154638>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.785359,-1.535000,14.954572> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.850509,-1.535000,3.188122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.021497,-1.535000,3.275247>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<12.850509,-1.535000,3.188122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.850509,-1.535000,6.971875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.021497,-1.535000,6.884750>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<12.850509,-1.535000,6.971875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.867588,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.924434,-1.535000,15.036800>}
box{<0,0,-0.203200><3.056847,0.035000,0.203200> rotate<0,0.000000,0> translate<12.867588,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.974300,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.330700,-1.535000,6.908800>}
box{<0,0,-0.203200><1.356400,0.035000,0.203200> rotate<0,0.000000,0> translate<12.974300,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.974303,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.330691,-1.535000,3.251200>}
box{<0,0,-0.203200><1.356388,0.035000,0.203200> rotate<0,0.000000,0> translate<12.974303,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.985425,-1.535000,15.154638>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,15.416031>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-67.495725,0> translate<12.985425,-1.535000,15.154638> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.021497,-1.535000,3.275247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.176753,-1.535000,3.388047>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<13.021497,-1.535000,3.275247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.021497,-1.535000,6.884750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.176753,-1.535000,6.771950>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<13.021497,-1.535000,6.884750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,15.416031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,23.919172>}
box{<0,0,-0.203200><8.503141,0.035000,0.203200> rotate<0,90.000000,0> translate<13.093697,-1.535000,23.919172> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.079359,-1.535000,15.443200>}
box{<0,0,-0.203200><2.985662,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.167169,-1.535000,15.849600>}
box{<0,0,-0.203200><3.073472,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.520216,-1.535000,16.256000>}
box{<0,0,-0.203200><3.426519,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.975231,-1.535000,16.662400>}
box{<0,0,-0.203200><2.881534,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.568831,-1.535000,17.068800>}
box{<0,0,-0.203200><2.475134,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,17.475200>}
box{<0,0,-0.203200><2.247903,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,17.881600>}
box{<0,0,-0.203200><2.247903,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.365634,-1.535000,18.288000>}
box{<0,0,-0.203200><2.271937,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.772034,-1.535000,18.694400>}
box{<0,0,-0.203200><2.678337,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.825012,-1.535000,19.100800>}
box{<0,0,-0.203200><3.731316,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.231413,-1.535000,19.507200>}
box{<0,0,-0.203200><4.137716,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.293269,-1.535000,19.913600>}
box{<0,0,-0.203200><4.199572,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221200,-1.535000,20.320000>}
box{<0,0,-0.203200><4.127503,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.293272,-1.535000,20.726400>}
box{<0,0,-0.203200><4.199575,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.949831,-1.535000,21.132800>}
box{<0,0,-0.203200><2.856134,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.543431,-1.535000,21.539200>}
box{<0,0,-0.203200><2.449734,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,21.945600>}
box{<0,0,-0.203200><2.247903,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,22.352000>}
box{<0,0,-0.203200><2.247903,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.391034,-1.535000,22.758400>}
box{<0,0,-0.203200><2.297337,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.797434,-1.535000,23.164800>}
box{<0,0,-0.203200><2.703737,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.448434,-1.535000,23.571200>}
box{<0,0,-0.203200><4.354738,0.035000,0.203200> rotate<0,0.000000,0> translate<13.093697,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.093697,-1.535000,23.919172>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.798800,-1.535000,28.080869>}
box{<0,0,-0.203200><4.963598,0.035000,0.203200> rotate<0,-56.972371,0> translate<13.093697,-1.535000,23.919172> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.131675,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.034556,-1.535000,23.977600>}
box{<0,0,-0.203200><4.902881,0.035000,0.203200> rotate<0,0.000000,0> translate<13.131675,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.176753,-1.535000,3.388047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.312450,-1.535000,3.523744>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<13.176753,-1.535000,3.388047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.176753,-1.535000,6.771950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.312450,-1.535000,6.636253>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<13.176753,-1.535000,6.771950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.312450,-1.535000,3.523744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.425250,-1.535000,3.679000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<13.312450,-1.535000,3.523744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.312450,-1.535000,6.636253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.425250,-1.535000,6.480997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<13.312450,-1.535000,6.636253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.395834,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.789262,-1.535000,24.384000>}
box{<0,0,-0.203200><4.393428,0.035000,0.203200> rotate<0,0.000000,0> translate<13.395834,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.409700,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.895294,-1.535000,3.657600>}
box{<0,0,-0.203200><0.485594,0.035000,0.203200> rotate<0,0.000000,0> translate<13.409700,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.409700,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.895300,-1.535000,6.502400>}
box{<0,0,-0.203200><0.485600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.409700,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.425250,-1.535000,3.679000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.512375,-1.535000,3.849988>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<13.425250,-1.535000,3.679000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.425250,-1.535000,6.480997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.512375,-1.535000,6.310009>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<13.425250,-1.535000,6.480997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.287075>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.142075,-1.535000,30.632400>}
box{<0,0,-0.203200><0.925850,0.035000,0.203200> rotate<0,44.997030,0> translate<13.487400,-1.535000,31.287075> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.749981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.287075>}
box{<0,0,-0.203200><0.462906,0.035000,0.203200> rotate<0,-90.000000,0> translate<13.487400,-1.535000,31.287075> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.749981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604966,-1.535000,31.749981>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,0.000000,0> translate<13.487400,-1.535000,31.749981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.750013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604966,-1.535000,31.750013>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,0.000000,0> translate<13.487400,-1.535000,31.750013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,32.212922>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,31.750013>}
box{<0,0,-0.203200><0.462909,0.035000,0.203200> rotate<0,-90.000000,0> translate<13.487400,-1.535000,31.750013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.487400,-1.535000,32.212922>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.583281,-1.535000,32.308800>}
box{<0,0,-0.203200><0.135594,0.035000,0.203200> rotate<0,-44.996097,0> translate<13.487400,-1.535000,32.212922> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.512375,-1.535000,3.849988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.571675,-1.535000,4.032500>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<13.512375,-1.535000,3.849988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.512375,-1.535000,6.310009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.571675,-1.535000,6.127497>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<13.512375,-1.535000,6.310009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.571675,-1.535000,4.032500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,4.222044>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<13.571675,-1.535000,4.032500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.571675,-1.535000,6.127497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.937953>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<13.571675,-1.535000,6.127497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.576663,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.728331,-1.535000,4.064000>}
box{<0,0,-0.203200><0.151669,0.035000,0.203200> rotate<0,0.000000,0> translate<13.576663,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.576666,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.728334,-1.535000,6.096000>}
box{<0,0,-0.203200><0.151669,0.035000,0.203200> rotate<0,0.000000,0> translate<13.576666,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,4.222044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.029194>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,90.000000,0> translate<13.601697,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,4.470400>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<13.601697,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,4.876800>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<13.601697,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.937953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,90.000000,0> translate<13.601697,-1.535000,5.937953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,5.283200>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<13.601697,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.601697,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,5.689600>}
box{<0,0,-0.203200><0.101603,0.035000,0.203200> rotate<0,0.000000,0> translate<13.601697,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.659994,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.123244,-1.535000,24.790400>}
box{<0,0,-0.203200><2.463250,0.035000,0.203200> rotate<0,0.000000,0> translate<13.659994,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703297,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,5.937953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,-89.993839,0> translate<13.703297,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703297,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871678,-1.535000,5.130800>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,0.000000,0> translate<13.703297,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,4.222044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.733322,-1.535000,4.032500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<13.703300,-1.535000,4.222044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,4.222044>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,-90.000000,0> translate<13.703300,-1.535000,4.222044> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871678,-1.535000,5.029194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<13.703300,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.703300,-1.535000,5.937953>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.733322,-1.535000,6.127497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<13.703300,-1.535000,5.937953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.733322,-1.535000,4.032500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.792622,-1.535000,3.849988>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<13.733322,-1.535000,4.032500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.733322,-1.535000,6.127497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.792622,-1.535000,6.310009>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<13.733322,-1.535000,6.127497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.792622,-1.535000,3.849988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.879747,-1.535000,3.679000>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<13.792622,-1.535000,3.849988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.792622,-1.535000,6.310009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.879747,-1.535000,6.480997>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<13.792622,-1.535000,6.310009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.879747,-1.535000,3.679000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.992547,-1.535000,3.523744>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<13.879747,-1.535000,3.679000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.879747,-1.535000,6.480997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.992547,-1.535000,6.636253>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<13.879747,-1.535000,6.480997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.924153,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.695831,-1.535000,25.196800>}
box{<0,0,-0.203200><1.771678,0.035000,0.203200> rotate<0,0.000000,0> translate<13.924153,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.992547,-1.535000,3.523744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.128244,-1.535000,3.388047>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<13.992547,-1.535000,3.523744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.992547,-1.535000,6.636253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.128244,-1.535000,6.771950>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<13.992547,-1.535000,6.636253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.128244,-1.535000,3.388047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.283500,-1.535000,3.275247>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<14.128244,-1.535000,3.388047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.128244,-1.535000,6.771950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.283500,-1.535000,6.884750>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<14.128244,-1.535000,6.771950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.142075,-1.535000,30.632400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,30.632397>}
box{<0,0,-0.203200><0.462906,0.035000,0.203200> rotate<0,0.000387,0> translate<14.142075,-1.535000,30.632400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.188313,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,25.603200>}
box{<0,0,-0.203200><1.153288,0.035000,0.203200> rotate<0,0.000000,0> translate<14.188313,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.283500,-1.535000,3.275247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.454488,-1.535000,3.188122>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<14.283500,-1.535000,3.275247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.283500,-1.535000,6.884750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.454488,-1.535000,6.971875>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<14.283500,-1.535000,6.884750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.452475,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,26.009600>}
box{<0,0,-0.203200><0.889125,0.035000,0.203200> rotate<0,0.000000,0> translate<14.452475,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.454488,-1.535000,3.188122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.637000,-1.535000,3.128822>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<14.454488,-1.535000,3.188122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.454488,-1.535000,6.971875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.637000,-1.535000,7.031175>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<14.454488,-1.535000,6.971875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604966,-1.535000,31.750013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604966,-1.535000,31.749981>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,-90.000000,0> translate<14.604966,-1.535000,31.749981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,30.632397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,31.749966>}
box{<0,0,-0.203200><1.117569,0.035000,0.203200> rotate<0,90.000000,0> translate<14.604981,-1.535000,31.749966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,30.886400>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<14.604981,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,31.292800>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<14.604981,-1.535000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,31.699200>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<14.604981,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.604981,-1.535000,31.749966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,31.749966>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<14.604981,-1.535000,31.749966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,30.632400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.067922,-1.535000,30.632400>}
box{<0,0,-0.203200><0.462909,0.035000,0.203200> rotate<0,0.000000,0> translate<14.605013,-1.535000,30.632400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,31.749966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605013,-1.535000,30.632400>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,-90.000000,0> translate<14.605013,-1.535000,30.632400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605031,-1.535000,31.749981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605031,-1.535000,31.750013>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,90.000000,0> translate<14.605031,-1.535000,31.750013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605031,-1.535000,31.749981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.749981>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,0.000000,0> translate<14.605031,-1.535000,31.749981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.605031,-1.535000,31.750013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.750013>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,0.000000,0> translate<14.605031,-1.535000,31.750013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.627909,-1.535000,13.093697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,13.807388>}
box{<0,0,-0.203200><1.009311,0.035000,0.203200> rotate<0,-44.997030,0> translate<14.627909,-1.535000,13.093697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.637000,-1.535000,3.128822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.826544,-1.535000,3.098800>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<14.637000,-1.535000,3.128822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.637000,-1.535000,7.031175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.826544,-1.535000,7.061197>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<14.637000,-1.535000,7.031175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.716634,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,26.416000>}
box{<0,0,-0.203200><0.624966,0.035000,0.203200> rotate<0,0.000000,0> translate<14.716634,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.826544,-1.535000,3.098800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,3.098797>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.003965,0> translate<14.826544,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.826544,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,7.061197>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,0.000000,0> translate<14.826544,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871678,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871678,-1.535000,5.029194>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<14.871678,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,3.098797>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,5.029178>}
box{<0,0,-0.203200><1.930381,0.035000,0.203200> rotate<0,90.000000,0> translate<14.871694,-1.535000,5.029178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,3.251200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,3.657600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,4.064000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,4.470400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,4.876800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,5.029178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,5.029178>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,5.029178> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,5.130819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,7.061197>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,90.000000,0> translate<14.871694,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,5.130819>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,5.130819>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,5.130819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,5.283200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,5.689600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,6.096000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,6.502400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.871694,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,6.908800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<14.871694,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,3.098800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.018453,-1.535000,3.098800>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<14.973300,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,5.029178>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,3.098800>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<14.973300,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,5.130819>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,-90.000000,0> translate<14.973300,-1.535000,5.130819> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973300,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.018453,-1.535000,7.061197>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,0.000000,0> translate<14.973300,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973319,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973319,-1.535000,5.130800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<14.973319,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973319,-1.535000,5.029194>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.029194>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<14.973319,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.973319,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.130800>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,0.000000,0> translate<14.973319,-1.535000,5.130800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.980794,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.645034,-1.535000,26.822400>}
box{<0,0,-0.203200><0.664241,0.035000,0.203200> rotate<0,0.000000,0> translate<14.980794,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.018453,-1.535000,3.098800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.207997,-1.535000,3.128822>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<15.018453,-1.535000,3.098800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.018453,-1.535000,7.061197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.207997,-1.535000,7.031175>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<15.018453,-1.535000,7.061197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.067922,-1.535000,30.632400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,30.906081>}
box{<0,0,-0.203200><0.387042,0.035000,0.203200> rotate<0,-44.997357,0> translate<15.067922,-1.535000,30.632400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.124584,-1.535000,9.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.149303,-1.535000,9.440559>}
box{<0,0,-0.203200><0.026056,0.035000,0.203200> rotate<0,18.435905,0> translate<15.124584,-1.535000,9.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.149303,-1.535000,9.440559>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.265244,-1.535000,9.448800>}
box{<0,0,-0.203200><0.116233,0.035000,0.203200> rotate<0,-4.065264,0> translate<15.149303,-1.535000,9.440559> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.207997,-1.535000,3.128822>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.390509,-1.535000,3.188122>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<15.207997,-1.535000,3.128822> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.207997,-1.535000,7.031175>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.390509,-1.535000,6.971875>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<15.207997,-1.535000,7.031175> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.244953,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,27.228800>}
box{<0,0,-0.203200><1.123578,0.035000,0.203200> rotate<0,0.000000,0> translate<15.244953,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.265244,-1.535000,9.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.381466,-1.535000,9.448800>}
box{<0,0,-0.203200><0.116222,0.035000,0.203200> rotate<0,0.000000,0> translate<15.265244,-1.535000,9.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.321919,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,30.886400>}
box{<0,0,-0.203200><0.019681,0.035000,0.203200> rotate<0,0.000000,0> translate<15.321919,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,14.453966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,13.807388>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-90.000000,0> translate<15.341600,-1.535000,13.807388> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,14.453966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.016488,-1.535000,15.128853>}
box{<0,0,-0.203200><0.954435,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.341600,-1.535000,14.453966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,17.296031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,16.611600>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<15.341600,-1.535000,17.296031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,18.263966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,17.296031>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,-90.000000,0> translate<15.341600,-1.535000,17.296031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,18.263966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,18.948397>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.341600,-1.535000,18.263966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,21.741031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,21.056600>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<15.341600,-1.535000,21.741031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,22.708966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,21.741031>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,-90.000000,0> translate<15.341600,-1.535000,21.741031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,22.708966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,23.393397>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.341600,-1.535000,22.708966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,25.551031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,24.866600>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<15.341600,-1.535000,25.551031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,26.518966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,25.551031>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,-90.000000,0> translate<15.341600,-1.535000,25.551031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,26.518966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,27.203397>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.341600,-1.535000,26.518966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,29.996031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.344984,-1.535000,29.992647>}
box{<0,0,-0.203200><0.004786,0.035000,0.203200> rotate<0,44.997030,0> translate<15.341600,-1.535000,29.996031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,30.906081>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.341600,-1.535000,29.996031>}
box{<0,0,-0.203200><0.910050,0.035000,0.203200> rotate<0,-90.000000,0> translate<15.341600,-1.535000,29.996031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.381466,-1.535000,9.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.405538,-1.535000,9.458772>}
box{<0,0,-0.203200><0.026056,0.035000,0.203200> rotate<0,-22.500502,0> translate<15.381466,-1.535000,9.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.390509,-1.535000,3.188122>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.561497,-1.535000,3.275247>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<15.390509,-1.535000,3.188122> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.390509,-1.535000,6.971875>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.561497,-1.535000,6.884750>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<15.390509,-1.535000,6.971875> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.405538,-1.535000,9.458772>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.431525,-1.535000,9.460619>}
box{<0,0,-0.203200><0.026053,0.035000,0.203200> rotate<0,-4.064783,0> translate<15.405538,-1.535000,9.458772> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.431525,-1.535000,9.460619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.535456,-1.535000,9.512588>}
box{<0,0,-0.203200><0.116200,0.035000,0.203200> rotate<0,-26.564676,0> translate<15.431525,-1.535000,9.460619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.509113,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.866453,-1.535000,27.635200>}
box{<0,0,-0.203200><0.357341,0.035000,0.203200> rotate<0,0.000000,0> translate<15.509113,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.514300,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.733250,-1.535000,6.908800>}
box{<0,0,-0.203200><1.218950,0.035000,0.203200> rotate<0,0.000000,0> translate<15.514300,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.514303,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.733247,-1.535000,3.251200>}
box{<0,0,-0.203200><1.218944,0.035000,0.203200> rotate<0,0.000000,0> translate<15.514303,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.535456,-1.535000,9.512588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.642859,-1.535000,9.557072>}
box{<0,0,-0.203200><0.116251,0.035000,0.203200> rotate<0,-22.496942,0> translate<15.535456,-1.535000,9.512588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.561497,-1.535000,3.275247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.716753,-1.535000,3.388047>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<15.561497,-1.535000,3.275247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.561497,-1.535000,6.884750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.716753,-1.535000,6.771950>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<15.561497,-1.535000,6.884750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.568831,-1.535000,33.731197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,34.188397>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.568831,-1.535000,33.731197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.642859,-1.535000,9.557072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.661288,-1.535000,9.575500>}
box{<0,0,-0.203200><0.026061,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.642859,-1.535000,9.557072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.661288,-1.535000,9.575500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.294863,-1.535000,10.392288>}
box{<0,0,-0.203200><1.826392,0.035000,0.203200> rotate<0,-26.563298,0> translate<15.661288,-1.535000,9.575500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.716753,-1.535000,3.388047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.852450,-1.535000,3.523744>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.716753,-1.535000,3.388047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.716753,-1.535000,6.771950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.852450,-1.535000,6.636253>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<15.716753,-1.535000,6.771950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.344959>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.749981>}
box{<0,0,-0.203200><0.405022,0.035000,0.203200> rotate<0,90.000000,0> translate<15.722597,-1.535000,31.749981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.344959>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,31.648397>}
box{<0,0,-0.203200><0.429123,0.035000,0.203200> rotate<0,-44.997325,0> translate<15.722597,-1.535000,31.344959> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.533416,-1.535000,31.699200>}
box{<0,0,-0.203200><4.810819,0.035000,0.203200> rotate<0,0.000000,0> translate<15.722597,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,31.750013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,32.155037>}
box{<0,0,-0.203200><0.405025,0.035000,0.203200> rotate<0,90.000000,0> translate<15.722597,-1.535000,32.155037> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.772031,-1.535000,32.105600>}
box{<0,0,-0.203200><0.049434,0.035000,0.203200> rotate<0,0.000000,0> translate<15.722597,-1.535000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.722597,-1.535000,32.155037>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,31.851600>}
box{<0,0,-0.203200><0.429123,0.035000,0.203200> rotate<0,44.997325,0> translate<15.722597,-1.535000,32.155037> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.773275,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.798800,-1.535000,28.041600>}
box{<0,0,-0.203200><0.025525,0.035000,0.203200> rotate<0,0.000000,0> translate<15.773275,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.798800,-1.535000,27.798531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.907072,-1.535000,27.537138>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,67.495725,0> translate<15.798800,-1.535000,27.798531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.798800,-1.535000,28.080869>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.798800,-1.535000,27.798531>}
box{<0,0,-0.203200><0.282338,0.035000,0.203200> rotate<0,-90.000000,0> translate<15.798800,-1.535000,27.798531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.852450,-1.535000,3.523744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.965250,-1.535000,3.679000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<15.852450,-1.535000,3.523744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.852450,-1.535000,6.636253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.965250,-1.535000,6.480997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<15.852450,-1.535000,6.636253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.907072,-1.535000,27.537138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.107138,-1.535000,27.337072>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,44.997030,0> translate<15.907072,-1.535000,27.537138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.949700,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.361406,-1.535000,3.657600>}
box{<0,0,-0.203200><0.411706,0.035000,0.203200> rotate<0,0.000000,0> translate<15.949700,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.949700,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.361413,-1.535000,6.502400>}
box{<0,0,-0.203200><0.411713,0.035000,0.203200> rotate<0,0.000000,0> translate<15.949700,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.965250,-1.535000,3.679000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.052375,-1.535000,3.849988>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<15.965250,-1.535000,3.679000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.965250,-1.535000,6.480997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.052375,-1.535000,6.310009>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<15.965250,-1.535000,6.480997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.016488,-1.535000,15.128853>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.116300,-1.535000,15.627913>}
box{<0,0,-0.203200><0.508943,0.035000,0.203200> rotate<0,-78.684805,0> translate<16.016488,-1.535000,15.128853> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.017488,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.346528,-1.535000,9.753600>}
box{<0,0,-0.203200><1.329041,0.035000,0.203200> rotate<0,0.000000,0> translate<16.017488,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.875816,-1.535000,16.611600>}
box{<0,0,-0.203200><0.849784,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.672609,-1.535000,18.948397>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,21.056600>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,23.393397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.037609,-1.535000,23.393397>}
box{<0,0,-0.203200><0.011578,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,23.393397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,24.866600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.037613,-1.535000,24.866600>}
box{<0,0,-0.203200><0.011581,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,24.866600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,27.203397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,27.203397>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,27.203397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,31.648397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,31.648397>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,31.648397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,31.851600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,31.851600>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,31.851600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.026031,-1.535000,34.188397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.672612,-1.535000,34.188397>}
box{<0,0,-0.203200><0.646581,0.035000,0.203200> rotate<0,0.000000,0> translate<16.026031,-1.535000,34.188397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.037609,-1.535000,23.393397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.107138,-1.535000,23.462925>}
box{<0,0,-0.203200><0.098328,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.037609,-1.535000,23.393397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.037613,-1.535000,24.866600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.107138,-1.535000,24.797072>}
box{<0,0,-0.203200><0.098325,0.035000,0.203200> rotate<0,44.998318,0> translate<16.037613,-1.535000,24.866600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.052375,-1.535000,3.849988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.111675,-1.535000,4.032500>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<16.052375,-1.535000,3.849988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.052375,-1.535000,6.310009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.111675,-1.535000,6.127497>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<16.052375,-1.535000,6.310009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.107138,-1.535000,23.462925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,23.571197>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<16.107138,-1.535000,23.462925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.107138,-1.535000,24.797072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,24.688800>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<16.107138,-1.535000,24.797072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.107138,-1.535000,27.337072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,27.228800>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<16.107138,-1.535000,27.337072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.111675,-1.535000,4.032500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,4.222044>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<16.111675,-1.535000,4.032500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.111675,-1.535000,6.127497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.937953>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<16.111675,-1.535000,6.127497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.116300,-1.535000,15.698966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.116300,-1.535000,15.627913>}
box{<0,0,-0.203200><0.071053,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.116300,-1.535000,15.627913> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.116300,-1.535000,15.698966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.143778,-1.535000,15.765300>}
box{<0,0,-0.203200><0.071800,0.035000,0.203200> rotate<0,-67.494419,0> translate<16.116300,-1.535000,15.698966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.116663,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.193069,-1.535000,4.064000>}
box{<0,0,-0.203200><0.076406,0.035000,0.203200> rotate<0,0.000000,0> translate<16.116663,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.116666,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.193075,-1.535000,6.096000>}
box{<0,0,-0.203200><0.076409,0.035000,0.203200> rotate<0,0.000000,0> translate<16.116666,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,4.222044>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.029194>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,90.000000,0> translate<16.141697,-1.535000,5.029194> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,4.470400>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<16.141697,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,4.876800>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<16.141697,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.130800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.937953>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,90.000000,0> translate<16.141697,-1.535000,5.937953> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,5.283200>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<16.141697,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.141697,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,5.689600>}
box{<0,0,-0.203200><0.050803,0.035000,0.203200> rotate<0,0.000000,0> translate<16.141697,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.143778,-1.535000,15.765300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.157856,-1.535000,15.835697>}
box{<0,0,-0.203200><0.071791,0.035000,0.203200> rotate<0,-78.685852,0> translate<16.143778,-1.535000,15.765300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.157856,-1.535000,15.835697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.197384,-1.535000,15.894719>}
box{<0,0,-0.203200><0.071036,0.035000,0.203200> rotate<0,-56.185284,0> translate<16.157856,-1.535000,15.835697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.385847,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<16.192500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,6.094619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,4.065378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.192500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.192500,-1.535000,6.094619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.385847,-1.535000,6.561397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<16.192500,-1.535000,6.094619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.197384,-1.535000,15.894719>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.224572,-1.535000,15.960359>}
box{<0,0,-0.203200><0.071048,0.035000,0.203200> rotate<0,-67.496839,0> translate<16.197384,-1.535000,15.894719> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.224572,-1.535000,15.960359>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.275344,-1.535000,16.011128>}
box{<0,0,-0.203200><0.071800,0.035000,0.203200> rotate<0,-44.995267,0> translate<16.224572,-1.535000,15.960359> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.275344,-1.535000,16.011128>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.315291,-1.535000,16.070781>}
box{<0,0,-0.203200><0.071793,0.035000,0.203200> rotate<0,-56.187943,0> translate<16.275344,-1.535000,16.011128> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.315291,-1.535000,16.070781>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.374400,-1.535000,16.110184>}
box{<0,0,-0.203200><0.071039,0.035000,0.203200> rotate<0,-33.685747,0> translate<16.315291,-1.535000,16.070781> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,23.571197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.448431,-1.535000,23.571197>}
box{<0,0,-0.203200><1.079900,0.035000,0.203200> rotate<0,0.000000,0> translate<16.368531,-1.535000,23.571197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,24.688800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.448431,-1.535000,24.688800>}
box{<0,0,-0.203200><1.079900,0.035000,0.203200> rotate<0,0.000000,0> translate<16.368531,-1.535000,24.688800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.368531,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.156334,-1.535000,27.228800>}
box{<0,0,-0.203200><0.787803,0.035000,0.203200> rotate<0,0.000000,0> translate<16.368531,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.374400,-1.535000,16.110184>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.875816,-1.535000,16.611600>}
box{<0,0,-0.203200><0.709109,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.374400,-1.535000,16.110184> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.385847,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.743100,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<16.385847,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.385847,-1.535000,6.561397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.743100,-1.535000,6.918650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.385847,-1.535000,6.561397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.672609,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.394184,-1.535000,19.669972>}
box{<0,0,-0.203200><1.020461,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.672609,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.672612,-1.535000,34.188397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.407575,-1.535000,34.923363>}
box{<0,0,-0.203200><1.039396,0.035000,0.203200> rotate<0,-44.997152,0> translate<16.672612,-1.535000,34.188397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.743100,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.209878,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<16.743100,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.743100,-1.535000,6.918650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.209878,-1.535000,7.111997>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<16.743100,-1.535000,6.918650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830288,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049966,-1.535000,10.160000>}
box{<0,0,-0.203200><2.219678,0.035000,0.203200> rotate<0,0.000000,0> translate<16.830288,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,21.741031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.993966,-1.535000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,27.203397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,26.518966>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<16.993966,-1.535000,27.203397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,31.648397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,30.963966>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<16.993966,-1.535000,31.648397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.993966,-1.535000,31.851600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,32.536031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.993966,-1.535000,31.851600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.070166,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.550034,-1.535000,21.132800>}
box{<0,0,-0.203200><0.479869,0.035000,0.203200> rotate<0,0.000000,0> translate<17.070166,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.156334,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.613531,-1.535000,26.771600>}
box{<0,0,-0.203200><0.646576,0.035000,0.203200> rotate<0,44.997226,0> translate<17.156334,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.209878,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.715119,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<17.209878,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.209878,-1.535000,7.111997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.715119,-1.535000,7.111997>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<17.209878,-1.535000,7.111997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221197,-1.535000,28.716059>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221197,-1.535000,29.538831>}
box{<0,0,-0.203200><0.822772,0.035000,0.203200> rotate<0,90.000000,0> translate<17.221197,-1.535000,29.538831> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221197,-1.535000,28.716059>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.613531,-1.535000,29.108397>}
box{<0,0,-0.203200><0.554847,0.035000,0.203200> rotate<0,-44.997258,0> translate<17.221197,-1.535000,28.716059> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221197,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.359538,-1.535000,28.854400>}
box{<0,0,-0.203200><0.138341,0.035000,0.203200> rotate<0,0.000000,0> translate<17.221197,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221197,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.095016,-1.535000,29.260800>}
box{<0,0,-0.203200><0.873819,0.035000,0.203200> rotate<0,0.000000,0> translate<17.221197,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221197,-1.535000,29.538831>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,29.996031>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.221197,-1.535000,29.538831> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221200,-1.535000,20.087588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.394184,-1.535000,19.669972>}
box{<0,0,-0.203200><0.452025,0.035000,0.203200> rotate<0,67.495274,0> translate<17.221200,-1.535000,20.087588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221200,-1.535000,20.552409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221200,-1.535000,20.087588>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<17.221200,-1.535000,20.087588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.221200,-1.535000,20.552409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.399078,-1.535000,20.981844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<17.221200,-1.535000,20.552409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.247966,-1.535000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.939816,-1.535000,32.105600>}
box{<0,0,-0.203200><3.691850,0.035000,0.203200> rotate<0,0.000000,0> translate<17.247966,-1.535000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.072041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.299519,-1.535000,9.898294>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,80.994671,0> translate<17.272000,-1.535000,10.072041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.159981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.072041>}
box{<0,0,-0.203200><0.087941,0.035000,0.203200> rotate<0,-90.000000,0> translate<17.272000,-1.535000,10.072041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.159981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049966,-1.535000,10.159981>}
box{<0,0,-0.203200><1.777966,0.035000,0.203200> rotate<0,0.000000,0> translate<17.272000,-1.535000,10.159981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.160013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049966,-1.535000,10.160013>}
box{<0,0,-0.203200><1.777966,0.035000,0.203200> rotate<0,0.000000,0> translate<17.272000,-1.535000,10.160013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.247956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.160013>}
box{<0,0,-0.203200><0.087944,0.035000,0.203200> rotate<0,-90.000000,0> translate<17.272000,-1.535000,10.160013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.272000,-1.535000,10.247956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.294863,-1.535000,10.392288>}
box{<0,0,-0.203200><0.146131,0.035000,0.203200> rotate<0,-80.993618,0> translate<17.272000,-1.535000,10.247956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.299519,-1.535000,9.898294>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.353878,-1.535000,9.730988>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,71.995781,0> translate<17.299519,-1.535000,9.898294> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.349563,-1.535000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.127016,-1.535000,31.292800>}
box{<0,0,-0.203200><2.777453,0.035000,0.203200> rotate<0,0.000000,0> translate<17.349563,-1.535000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.349566,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.501416,-1.535000,29.667200>}
box{<0,0,-0.203200><1.151850,0.035000,0.203200> rotate<0,0.000000,0> translate<17.349566,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.353878,-1.535000,9.730988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.433744,-1.535000,9.574250>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,62.994716,0> translate<17.353878,-1.535000,9.730988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.374963,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.562731,-1.535000,26.822400>}
box{<0,0,-0.203200><0.187769,0.035000,0.203200> rotate<0,0.000000,0> translate<17.374963,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.386300,-1.535000,34.974722>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.407575,-1.535000,34.923363>}
box{<0,0,-0.203200><0.055591,0.035000,0.203200> rotate<0,67.494355,0> translate<17.386300,-1.535000,34.974722> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.386300,-1.535000,35.510275>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.386300,-1.535000,34.974722>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,-90.000000,0> translate<17.386300,-1.535000,34.974722> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.386300,-1.535000,35.510275>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.591247,-1.535000,36.005059>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-67.495498,0> translate<17.386300,-1.535000,35.510275> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.399078,-1.535000,20.981844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,21.310519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.399078,-1.535000,20.981844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.433744,-1.535000,9.574250>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.537141,-1.535000,9.431931>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,53.997424,0> translate<17.433744,-1.535000,9.574250> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.448431,-1.535000,23.571197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,23.850519>}
box{<0,0,-0.203200><0.395021,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.448431,-1.535000,23.571197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.448431,-1.535000,24.688800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,24.409478>}
box{<0,0,-0.203200><0.395021,0.035000,0.203200> rotate<0,44.997030,0> translate<17.448431,-1.535000,24.688800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476566,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,21.539200>}
box{<0,0,-0.203200><5.942234,0.035000,0.203200> rotate<0,0.000000,0> translate<17.476566,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.537141,-1.535000,9.431931>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.661531,-1.535000,9.307541>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,44.997030,0> translate<17.537141,-1.535000,9.431931> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.591247,-1.535000,36.005059>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.969938,-1.535000,36.383750>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.591247,-1.535000,36.005059> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.613531,-1.535000,26.771600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.581466,-1.535000,26.771600>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<17.613531,-1.535000,26.771600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.613531,-1.535000,29.108397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.942609,-1.535000,29.108397>}
box{<0,0,-0.203200><0.329078,0.035000,0.203200> rotate<0,0.000000,0> translate<17.613531,-1.535000,29.108397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.654366,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.346216,-1.535000,32.512000>}
box{<0,0,-0.203200><3.691850,0.035000,0.203200> rotate<0,0.000000,0> translate<17.654366,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.661531,-1.535000,9.307541>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.803850,-1.535000,9.204144>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,35.996636,0> translate<17.661531,-1.535000,9.307541> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,13.641159>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,14.298838>}
box{<0,0,-0.203200><0.657678,0.035000,0.203200> rotate<0,90.000000,0> translate<17.678397,-1.535000,14.298838> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,13.641159>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,13.690519>}
box{<0,0,-0.203200><0.069802,0.035000,0.203200> rotate<0,-44.998844,0> translate<17.678397,-1.535000,13.641159> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.034556,-1.535000,13.817600>}
box{<0,0,-0.203200><0.356159,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.789262,-1.535000,14.224000>}
box{<0,0,-0.203200><0.110866,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,14.298838>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,14.249478>}
box{<0,0,-0.203200><0.069802,0.035000,0.203200> rotate<0,44.998844,0> translate<17.678397,-1.535000,14.298838> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,21.741031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,21.918838>}
box{<0,0,-0.203200><0.177806,0.035000,0.203200> rotate<0,90.000000,0> translate<17.678397,-1.535000,21.918838> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,21.918838>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,21.869478>}
box{<0,0,-0.203200><0.069802,0.035000,0.203200> rotate<0,44.998844,0> translate<17.678397,-1.535000,21.918838> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,26.341159>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,26.518966>}
box{<0,0,-0.203200><0.177806,0.035000,0.203200> rotate<0,90.000000,0> translate<17.678397,-1.535000,26.518966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,26.341159>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,26.390519>}
box{<0,0,-0.203200><0.069802,0.035000,0.203200> rotate<0,-44.998844,0> translate<17.678397,-1.535000,26.341159> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.789272,-1.535000,26.416000>}
box{<0,0,-0.203200><0.110875,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,29.996031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,30.963966>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,90.000000,0> translate<17.678397,-1.535000,30.963966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.907816,-1.535000,30.073600>}
box{<0,0,-0.203200><1.229419,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.314216,-1.535000,30.480000>}
box{<0,0,-0.203200><1.635819,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.720616,-1.535000,30.886400>}
box{<0,0,-0.203200><2.042219,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,32.536031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,33.182613>}
box{<0,0,-0.203200><0.646581,0.035000,0.203200> rotate<0,90.000000,0> translate<17.678397,-1.535000,33.182613> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.551900,-1.535000,32.918400>}
box{<0,0,-0.203200><3.873503,0.035000,0.203200> rotate<0,0.000000,0> translate<17.678397,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.678397,-1.535000,33.182613>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.413363,-1.535000,33.917575>}
box{<0,0,-0.203200><1.039396,0.035000,0.203200> rotate<0,-44.996908,0> translate<17.678397,-1.535000,33.182613> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.715119,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.181897,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<17.715119,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.715119,-1.535000,7.111997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.181897,-1.535000,6.918650>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<17.715119,-1.535000,7.111997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,13.690519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,13.868397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<17.727753,-1.535000,13.690519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,14.249478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,14.071600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<17.727753,-1.535000,14.249478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,21.310519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,21.488397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<17.727753,-1.535000,21.310519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,21.869478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,21.691600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<17.727753,-1.535000,21.869478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,23.850519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,24.028397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<17.727753,-1.535000,23.850519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,24.409478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,24.231600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<17.727753,-1.535000,24.409478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.727753,-1.535000,26.390519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,26.568397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<17.727753,-1.535000,26.390519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.803850,-1.535000,9.204144>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.960588,-1.535000,9.124278>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,26.999344,0> translate<17.803850,-1.535000,9.204144> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.820584,-1.535000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.570378,-1.535000,33.324800>}
box{<0,0,-0.203200><3.749794,0.035000,0.203200> rotate<0,0.000000,0> translate<17.820584,-1.535000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.942609,-1.535000,29.108397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.564238,-1.535000,32.730022>}
box{<0,0,-0.203200><5.121753,0.035000,0.203200> rotate<0,-44.997005,0> translate<17.942609,-1.535000,29.108397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.960588,-1.535000,9.124278>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.127894,-1.535000,9.069919>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,17.998279,0> translate<17.960588,-1.535000,9.124278> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.969938,-1.535000,36.383750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.464722,-1.535000,36.588697>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-22.498562,0> translate<17.969938,-1.535000,36.383750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.127894,-1.535000,9.069919>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.301641,-1.535000,9.042400>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,8.999389,0> translate<18.127894,-1.535000,9.069919> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,13.868397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,13.868397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,13.868397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,14.071600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,14.071600>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,14.071600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,21.488397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,21.488397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,21.488397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,21.691600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,21.691600>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,21.691600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,24.028397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,24.028397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,24.028397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,24.231600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,24.231600>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,24.231600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.157187,-1.535000,26.568397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,26.568397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<18.157187,-1.535000,26.568397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.181897,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.539150,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.181897,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.181897,-1.535000,6.918650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.539150,-1.535000,6.561397>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<18.181897,-1.535000,6.918650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.191747,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.273250,-1.535000,6.908800>}
box{<0,0,-0.203200><1.081503,0.035000,0.203200> rotate<0,0.000000,0> translate<18.191747,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.191750,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.273247,-1.535000,3.251200>}
box{<0,0,-0.203200><1.081497,0.035000,0.203200> rotate<0,0.000000,0> translate<18.191750,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.226984,-1.535000,33.731200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.738713,-1.535000,33.731200>}
box{<0,0,-0.203200><3.511728,0.035000,0.203200> rotate<0,0.000000,0> translate<18.226984,-1.535000,33.731200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.301641,-1.535000,9.042400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,9.042400>}
box{<0,0,-0.203200><0.748341,0.035000,0.203200> rotate<0,0.000000,0> translate<18.301641,-1.535000,9.042400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.413363,-1.535000,33.917575>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.464722,-1.535000,33.896300>}
box{<0,0,-0.203200><0.055591,0.035000,0.203200> rotate<0,22.499706,0> translate<18.413363,-1.535000,33.917575> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.464722,-1.535000,33.896300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.000275,-1.535000,33.896300>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,0.000000,0> translate<18.464722,-1.535000,33.896300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.464722,-1.535000,36.588697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.000275,-1.535000,36.588697>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,0.000000,0> translate<18.464722,-1.535000,36.588697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.539150,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,4.065378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<18.539150,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.539150,-1.535000,6.561397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,6.094619>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<18.539150,-1.535000,6.561397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.563588,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.901406,-1.535000,3.657600>}
box{<0,0,-0.203200><0.337819,0.035000,0.203200> rotate<0,0.000000,0> translate<18.563588,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.563588,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.901412,-1.535000,6.502400>}
box{<0,0,-0.203200><0.337825,0.035000,0.203200> rotate<0,0.000000,0> translate<18.563588,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.581466,-1.535000,26.771600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.265897,-1.535000,27.456031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.581466,-1.535000,26.771600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.632266,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,26.822400>}
box{<0,0,-0.203200><4.786534,0.035000,0.203200> rotate<0,0.000000,0> translate<18.632266,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.633381,-1.535000,11.277597>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.887384,-1.535000,11.531600>}
box{<0,0,-0.203200><0.359215,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.633381,-1.535000,11.277597> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.633381,-1.535000,11.277597>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,11.277597>}
box{<0,0,-0.203200><0.416600,0.035000,0.203200> rotate<0,0.000000,0> translate<18.633381,-1.535000,11.277597> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.684181,-1.535000,16.408397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.887388,-1.535000,16.611600>}
box{<0,0,-0.203200><0.287375,0.035000,0.203200> rotate<0,-44.996590,0> translate<18.684181,-1.535000,16.408397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.684181,-1.535000,16.408397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,16.408397>}
box{<0,0,-0.203200><1.258628,0.035000,0.203200> rotate<0,0.000000,0> translate<18.684181,-1.535000,16.408397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.684181,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.887388,-1.535000,19.151600>}
box{<0,0,-0.203200><0.287375,0.035000,0.203200> rotate<0,-44.996590,0> translate<18.684181,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.684181,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,18.948397>}
box{<0,0,-0.203200><1.258628,0.035000,0.203200> rotate<0,0.000000,0> translate<18.684181,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.731925,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.733069,-1.535000,4.064000>}
box{<0,0,-0.203200><0.001144,0.035000,0.203200> rotate<0,0.000000,0> translate<18.731925,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.731925,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.733075,-1.535000,6.096000>}
box{<0,0,-0.203200><0.001150,0.035000,0.203200> rotate<0,0.000000,0> translate<18.731925,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,6.094619>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,90.000000,0> translate<18.732497,-1.535000,6.094619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,4.470400>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<18.732497,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,4.876800>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<18.732497,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,5.283200>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<18.732497,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732497,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,5.689600>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<18.732497,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.925847,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<18.732500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,6.094619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,4.065378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<18.732500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.732500,-1.535000,6.094619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.925847,-1.535000,6.561397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<18.732500,-1.535000,6.094619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.734984,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.300791,-1.535000,11.379200>}
box{<0,0,-0.203200><2.565806,0.035000,0.203200> rotate<0,0.000000,0> translate<18.734984,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.836584,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.343412,-1.535000,19.100800>}
box{<0,0,-0.203200><5.506828,0.035000,0.203200> rotate<0,0.000000,0> translate<18.836584,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.887384,-1.535000,11.531600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,11.531600>}
box{<0,0,-0.203200><1.055425,0.035000,0.203200> rotate<0,0.000000,0> translate<18.887384,-1.535000,11.531600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.887388,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,16.611600>}
box{<0,0,-0.203200><1.055422,0.035000,0.203200> rotate<0,0.000000,0> translate<18.887388,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.887388,-1.535000,19.151600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,19.151600>}
box{<0,0,-0.203200><1.055422,0.035000,0.203200> rotate<0,0.000000,0> translate<18.887388,-1.535000,19.151600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.925847,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.283100,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<18.925847,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.925847,-1.535000,6.561397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.283100,-1.535000,6.918650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.925847,-1.535000,6.561397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.000275,-1.535000,33.896300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.495059,-1.535000,34.101247>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-22.498562,0> translate<19.000275,-1.535000,33.896300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.000275,-1.535000,36.588697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.495059,-1.535000,36.383750>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,22.498562,0> translate<19.000275,-1.535000,36.588697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.030928,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.097912,-1.535000,36.576000>}
box{<0,0,-0.203200><3.066984,0.035000,0.203200> rotate<0,0.000000,0> translate<19.030928,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.038666,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,27.228800>}
box{<0,0,-0.203200><4.380134,0.035000,0.203200> rotate<0,0.000000,0> translate<19.038666,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049966,-1.535000,10.160013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049966,-1.535000,10.159981>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.049966,-1.535000,10.159981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,9.042400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,10.159966>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,90.000000,0> translate<19.049981,-1.535000,10.159966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,9.347200>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<19.049981,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,9.753600>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<19.049981,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,10.159966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,10.159966>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<19.049981,-1.535000,10.159966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,10.160031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,11.277597>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,90.000000,0> translate<19.049981,-1.535000,11.277597> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,10.160031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,10.160031>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<19.049981,-1.535000,10.160031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,10.566400>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<19.049981,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.049981,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,10.972800>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<19.049981,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,9.042400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.798356,-1.535000,9.042400>}
box{<0,0,-0.203200><0.748344,0.035000,0.203200> rotate<0,0.000000,0> translate<19.050013,-1.535000,9.042400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,10.159966>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,9.042400>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.050013,-1.535000,9.042400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,11.277597>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,10.160031>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.050013,-1.535000,10.160031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050013,-1.535000,11.277597>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.798356,-1.535000,11.277597>}
box{<0,0,-0.203200><0.748344,0.035000,0.203200> rotate<0,0.000000,0> translate<19.050013,-1.535000,11.277597> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050031,-1.535000,10.159981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050031,-1.535000,10.160013>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,90.000000,0> translate<19.050031,-1.535000,10.160013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050031,-1.535000,10.159981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.159981>}
box{<0,0,-0.203200><1.777966,0.035000,0.203200> rotate<0,0.000000,0> translate<19.050031,-1.535000,10.159981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050031,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.968281,-1.535000,10.160000>}
box{<0,0,-0.203200><1.918250,0.035000,0.203200> rotate<0,0.000000,0> translate<19.050031,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.050031,-1.535000,10.160013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.160013>}
box{<0,0,-0.203200><1.777966,0.035000,0.203200> rotate<0,0.000000,0> translate<19.050031,-1.535000,10.160013> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.265897,-1.535000,27.456031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.265897,-1.535000,28.420109>}
box{<0,0,-0.203200><0.964078,0.035000,0.203200> rotate<0,90.000000,0> translate<19.265897,-1.535000,28.420109> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.265897,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,27.635200>}
box{<0,0,-0.203200><4.152903,0.035000,0.203200> rotate<0,0.000000,0> translate<19.265897,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.265897,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,28.041600>}
box{<0,0,-0.203200><4.152903,0.035000,0.203200> rotate<0,0.000000,0> translate<19.265897,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.265897,-1.535000,28.420109>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.570022,-1.535000,31.724238>}
box{<0,0,-0.203200><4.672741,0.035000,0.203200> rotate<0,-44.997057,0> translate<19.265897,-1.535000,28.420109> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.283100,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.749878,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<19.283100,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.283100,-1.535000,6.918650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.749878,-1.535000,7.111997>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<19.283100,-1.535000,6.918650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.293784,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.632213,-1.535000,28.448000>}
box{<0,0,-0.203200><4.338428,0.035000,0.203200> rotate<0,0.000000,0> translate<19.293784,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.495059,-1.535000,34.101247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.873750,-1.535000,34.479937>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,-44.997030,0> translate<19.495059,-1.535000,34.101247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.495059,-1.535000,36.383750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.873750,-1.535000,36.005059>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,44.997030,0> translate<19.495059,-1.535000,36.383750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.531413,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.139903,-1.535000,34.137600>}
box{<0,0,-0.203200><2.608491,0.035000,0.203200> rotate<0,0.000000,0> translate<19.531413,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.700184,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.979534,-1.535000,28.854400>}
box{<0,0,-0.203200><5.279350,0.035000,0.203200> rotate<0,0.000000,0> translate<19.700184,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.709209,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.691513,-1.535000,36.169600>}
box{<0,0,-0.203200><1.982303,0.035000,0.203200> rotate<0,0.000000,0> translate<19.709209,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.749878,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.255119,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<19.749878,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.749878,-1.535000,7.111997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.137006,-1.535000,7.111997>}
box{<0,0,-0.203200><0.387128,0.035000,0.203200> rotate<0,0.000000,0> translate<19.749878,-1.535000,7.111997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.798356,-1.535000,9.042400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.972103,-1.535000,9.069919>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-8.999389,0> translate<19.798356,-1.535000,9.042400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.798356,-1.535000,11.277597>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.972103,-1.535000,11.250078>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,8.999389,0> translate<19.798356,-1.535000,11.277597> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.873750,-1.535000,34.479937>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.078697,-1.535000,34.974722>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-67.495498,0> translate<19.873750,-1.535000,34.479937> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.873750,-1.535000,36.005059>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.078697,-1.535000,35.510275>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,67.495498,0> translate<19.873750,-1.535000,36.005059> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.900284,-1.535000,34.544000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.097909,-1.535000,34.544000>}
box{<0,0,-0.203200><2.197625,0.035000,0.203200> rotate<0,0.000000,0> translate<19.900284,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,11.531600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,11.709478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<19.942809,-1.535000,11.531600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,13.868397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,13.690519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<19.942809,-1.535000,13.868397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,14.071600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,14.249478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<19.942809,-1.535000,14.071600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,16.408397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,16.230519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<19.942809,-1.535000,16.408397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,16.789478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<19.942809,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,18.948397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,18.770519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<19.942809,-1.535000,18.948397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,19.151600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,19.329478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<19.942809,-1.535000,19.151600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,21.488397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,21.310519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<19.942809,-1.535000,21.488397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,21.691600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,21.869478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<19.942809,-1.535000,21.691600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,24.028397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,23.850519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<19.942809,-1.535000,24.028397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,24.231600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,24.409478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<19.942809,-1.535000,24.231600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.942809,-1.535000,26.568397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,26.390519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<19.942809,-1.535000,26.568397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.972103,-1.535000,9.069919>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.139409,-1.535000,9.124278>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,-17.998279,0> translate<19.972103,-1.535000,9.069919> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.972103,-1.535000,11.250078>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.139409,-1.535000,11.195719>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,17.998279,0> translate<19.972103,-1.535000,11.250078> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.973934,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.763200>}
box{<0,0,-0.203200><1.628766,0.035000,0.203200> rotate<0,0.000000,0> translate<19.973934,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.065444,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.455050,-1.535000,13.817600>}
box{<0,0,-0.203200><3.389606,0.035000,0.203200> rotate<0,0.000000,0> translate<20.065444,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.065444,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,23.977600>}
box{<0,0,-0.203200><3.353356,0.035000,0.203200> rotate<0,0.000000,0> translate<20.065444,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.065450,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654544,-1.535000,16.662400>}
box{<0,0,-0.203200><5.589094,0.035000,0.203200> rotate<0,0.000000,0> translate<20.065450,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.068622,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.691509,-1.535000,34.950400>}
box{<0,0,-0.203200><1.622888,0.035000,0.203200> rotate<0,0.000000,0> translate<20.068622,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.078697,-1.535000,34.974722>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.078697,-1.535000,35.510275>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,90.000000,0> translate<20.078697,-1.535000,35.510275> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.078697,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.356800>}
box{<0,0,-0.203200><1.524003,0.035000,0.203200> rotate<0,0.000000,0> translate<20.078697,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.106584,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.939153,-1.535000,29.260800>}
box{<0,0,-0.203200><11.832569,0.035000,0.203200> rotate<0,0.000000,0> translate<20.106584,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.137006,-1.535000,7.111997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.529394,-1.535000,12.217419>}
box{<0,0,-0.203200><5.291888,0.035000,0.203200> rotate<0,-74.739951,0> translate<20.137006,-1.535000,7.111997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.139409,-1.535000,9.124278>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.296147,-1.535000,9.204144>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,-26.999344,0> translate<20.139409,-1.535000,9.124278> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.139409,-1.535000,11.195719>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.296147,-1.535000,11.115853>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,26.999344,0> translate<20.139409,-1.535000,11.195719> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.255119,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.721897,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<20.255119,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.296147,-1.535000,9.204144>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.438466,-1.535000,9.307541>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-35.996636,0> translate<20.296147,-1.535000,9.204144> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.296147,-1.535000,11.115853>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.438466,-1.535000,11.012456>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,35.996636,0> translate<20.296147,-1.535000,11.115853> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.310728,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.409272,-1.535000,16.256000>}
box{<0,0,-0.203200><5.098544,0.035000,0.203200> rotate<0,0.000000,0> translate<20.310728,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.310728,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,26.416000>}
box{<0,0,-0.203200><3.108072,0.035000,0.203200> rotate<0,0.000000,0> translate<20.310728,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.310731,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.024009,-1.535000,14.224000>}
box{<0,0,-0.203200><3.713278,0.035000,0.203200> rotate<0,0.000000,0> translate<20.310731,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.310731,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,24.384000>}
box{<0,0,-0.203200><3.108069,0.035000,0.203200> rotate<0,0.000000,0> translate<20.310731,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,11.709478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,12.038153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.372244,-1.535000,11.709478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,13.690519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,13.361844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<20.372244,-1.535000,13.690519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,14.249478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,14.578153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.372244,-1.535000,14.249478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,16.230519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,15.901844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<20.372244,-1.535000,16.230519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,16.789478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,17.118153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.372244,-1.535000,16.789478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,18.770519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,18.441844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<20.372244,-1.535000,18.770519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,19.329478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,19.658153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.372244,-1.535000,19.329478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,21.310519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,20.981844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<20.372244,-1.535000,21.310519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,21.869478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,22.198153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.372244,-1.535000,21.869478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,23.850519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,23.521844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<20.372244,-1.535000,23.850519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,24.409478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,24.738153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.372244,-1.535000,24.409478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.372244,-1.535000,26.390519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,26.061844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<20.372244,-1.535000,26.390519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.438466,-1.535000,9.307541>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.562856,-1.535000,9.431931>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.438466,-1.535000,9.307541> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.438466,-1.535000,11.012456>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.562856,-1.535000,10.888066>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,44.997030,0> translate<20.438466,-1.535000,11.012456> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.448363,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.749813,-1.535000,18.694400>}
box{<0,0,-0.203200><4.301450,0.035000,0.203200> rotate<0,0.000000,0> translate<20.448363,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.448366,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.411628,-1.535000,11.785600>}
box{<0,0,-0.203200><0.963262,0.035000,0.203200> rotate<0,0.000000,0> translate<20.448366,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.448366,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,21.945600>}
box{<0,0,-0.203200><2.970434,0.035000,0.203200> rotate<0,0.000000,0> translate<20.448366,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.478122,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.189953,-1.535000,10.972800>}
box{<0,0,-0.203200><0.711831,0.035000,0.203200> rotate<0,0.000000,0> translate<20.478122,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.478125,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.746609,-1.535000,9.347200>}
box{<0,0,-0.203200><0.268484,0.035000,0.203200> rotate<0,0.000000,0> translate<20.478125,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.512984,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.188775,-1.535000,29.667200>}
box{<0,0,-0.203200><11.675791,0.035000,0.203200> rotate<0,0.000000,0> translate<20.512984,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.549962,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,21.132800>}
box{<0,0,-0.203200><2.868838,0.035000,0.203200> rotate<0,0.000000,0> translate<20.549962,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.549966,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.937013,-1.535000,19.507200>}
box{<0,0,-0.203200><3.387047,0.035000,0.203200> rotate<0,0.000000,0> translate<20.549966,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.562856,-1.535000,9.431931>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.666253,-1.535000,9.574250>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-53.997424,0> translate<20.562856,-1.535000,9.431931> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.562856,-1.535000,10.888066>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.666253,-1.535000,10.745747>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,53.997424,0> translate<20.562856,-1.535000,10.888066> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.651563,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.886091,-1.535000,13.411200>}
box{<0,0,-0.203200><2.234528,0.035000,0.203200> rotate<0,0.000000,0> translate<20.651563,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.651563,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,23.571200>}
box{<0,0,-0.203200><2.767238,0.035000,0.203200> rotate<0,0.000000,0> translate<20.651563,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.651566,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.068431,-1.535000,17.068800>}
box{<0,0,-0.203200><4.416866,0.035000,0.203200> rotate<0,0.000000,0> translate<20.651566,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.666253,-1.535000,9.574250>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.746119,-1.535000,9.730988>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,-62.994716,0> translate<20.666253,-1.535000,9.574250> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.666253,-1.535000,10.745747>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.746119,-1.535000,10.589009>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,62.994716,0> translate<20.666253,-1.535000,10.745747> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,12.038153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,12.467588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<20.700919,-1.535000,12.038153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,13.361844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,12.932409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<20.700919,-1.535000,13.361844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,14.578153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,15.007588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<20.700919,-1.535000,14.578153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,15.901844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,15.472409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<20.700919,-1.535000,15.901844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,17.118153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,17.547588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<20.700919,-1.535000,17.118153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,18.441844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,18.012409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<20.700919,-1.535000,18.441844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,19.658153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,20.087588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<20.700919,-1.535000,19.658153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,20.981844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,20.552409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<20.700919,-1.535000,20.981844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,22.198153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,22.627588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<20.700919,-1.535000,22.198153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,23.521844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,23.092409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<20.700919,-1.535000,23.521844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,24.738153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,25.167587>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<20.700919,-1.535000,24.738153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.700919,-1.535000,26.061844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,25.632409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<20.700919,-1.535000,26.061844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.721897,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.079150,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.721897,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.722559,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.592972,-1.535000,14.630400>}
box{<0,0,-0.203200><3.870413,0.035000,0.203200> rotate<0,0.000000,0> translate<20.722559,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.722559,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.997441,-1.535000,15.849600>}
box{<0,0,-0.203200><4.274881,0.035000,0.203200> rotate<0,0.000000,0> translate<20.722559,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.722559,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,24.790400>}
box{<0,0,-0.203200><2.696241,0.035000,0.203200> rotate<0,0.000000,0> translate<20.722559,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.722559,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,26.009600>}
box{<0,0,-0.203200><2.696241,0.035000,0.203200> rotate<0,0.000000,0> translate<20.722559,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.731750,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.813247,-1.535000,3.251200>}
box{<0,0,-0.203200><1.081497,0.035000,0.203200> rotate<0,0.000000,0> translate<20.731750,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.746119,-1.535000,9.730988>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.800478,-1.535000,9.898294>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,-71.995781,0> translate<20.746119,-1.535000,9.730988> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.746119,-1.535000,10.589009>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.800478,-1.535000,10.421703>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,71.995781,0> translate<20.746119,-1.535000,10.589009> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.753466,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.857444,-1.535000,9.753600>}
box{<0,0,-0.203200><0.103978,0.035000,0.203200> rotate<0,0.000000,0> translate<20.753466,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.753466,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.079119,-1.535000,10.566400>}
box{<0,0,-0.203200><0.325653,0.035000,0.203200> rotate<0,0.000000,0> translate<20.753466,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.764644,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.522462,-1.535000,12.192000>}
box{<0,0,-0.203200><0.757819,0.035000,0.203200> rotate<0,0.000000,0> translate<20.764644,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.764644,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.955356,-1.535000,18.288000>}
box{<0,0,-0.203200><4.190713,0.035000,0.203200> rotate<0,0.000000,0> translate<20.764644,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.764644,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,22.352000>}
box{<0,0,-0.203200><2.654156,0.035000,0.203200> rotate<0,0.000000,0> translate<20.764644,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.800478,-1.535000,9.898294>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.072041>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-80.994671,0> translate<20.800478,-1.535000,9.898294> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.800478,-1.535000,10.421703>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.247956>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,80.994671,0> translate<20.800478,-1.535000,10.421703> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.806728,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.530609,-1.535000,19.913600>}
box{<0,0,-0.203200><2.723881,0.035000,0.203200> rotate<0,0.000000,0> translate<20.806728,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.806728,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,20.726400>}
box{<0,0,-0.203200><2.612072,0.035000,0.203200> rotate<0,0.000000,0> translate<20.806728,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.072041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.159981>}
box{<0,0,-0.203200><0.087941,0.035000,0.203200> rotate<0,90.000000,0> translate<20.827997,-1.535000,10.159981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.160013>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.827997,-1.535000,10.247956>}
box{<0,0,-0.203200><0.087944,0.035000,0.203200> rotate<0,90.000000,0> translate<20.827997,-1.535000,10.247956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.848813,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.317131,-1.535000,13.004800>}
box{<0,0,-0.203200><1.468319,0.035000,0.203200> rotate<0,0.000000,0> translate<20.848813,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.848813,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.871181,-1.535000,17.475200>}
box{<0,0,-0.203200><4.022369,0.035000,0.203200> rotate<0,0.000000,0> translate<20.848813,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.848813,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,23.164800>}
box{<0,0,-0.203200><2.569987,0.035000,0.203200> rotate<0,0.000000,0> translate<20.848813,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,12.467588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,12.932409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<20.878797,-1.535000,12.932409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.738550,-1.535000,12.598400>}
box{<0,0,-0.203200><0.859753,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,15.007588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,15.472409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<20.878797,-1.535000,15.472409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,15.036800>}
box{<0,0,-0.203200><3.962403,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,15.443200>}
box{<0,0,-0.203200><3.962403,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,17.547588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,18.012409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<20.878797,-1.535000,18.012409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,17.881600>}
box{<0,0,-0.203200><3.962403,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,20.087588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,20.552409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<20.878797,-1.535000,20.552409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,20.320000>}
box{<0,0,-0.203200><2.540003,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,22.627588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,23.092409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<20.878797,-1.535000,23.092409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,22.758400>}
box{<0,0,-0.203200><2.540003,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,25.167587>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,25.632409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<20.878797,-1.535000,25.632409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,25.196800>}
box{<0,0,-0.203200><2.540003,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.878797,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,25.603200>}
box{<0,0,-0.203200><2.540003,0.035000,0.203200> rotate<0,0.000000,0> translate<20.878797,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.919384,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,30.073600>}
box{<0,0,-0.203200><14.361416,0.035000,0.203200> rotate<0,0.000000,0> translate<20.919384,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.079150,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,4.065378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<21.079150,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.103587,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.441406,-1.535000,3.657600>}
box{<0,0,-0.203200><0.337819,0.035000,0.203200> rotate<0,0.000000,0> translate<21.103587,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.271925,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.273069,-1.535000,4.064000>}
box{<0,0,-0.203200><0.001144,0.035000,0.203200> rotate<0,0.000000,0> translate<21.271925,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,5.869519>}
box{<0,0,-0.203200><1.804141,0.035000,0.203200> rotate<0,90.000000,0> translate<21.272497,-1.535000,5.869519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,4.470400>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<21.272497,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,4.876800>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<21.272497,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,5.283200>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<21.272497,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,5.689600>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<21.272497,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272497,-1.535000,5.869519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,5.869541>}
box{<0,0,-0.203200><0.000022,0.035000,0.203200> rotate<0,-81.864495,0> translate<21.272497,-1.535000,5.869519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.465847,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<21.272500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,5.869541>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.272500,-1.535000,4.065378>}
box{<0,0,-0.203200><1.804162,0.035000,0.203200> rotate<0,-90.000000,0> translate<21.272500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.325784,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,30.480000>}
box{<0,0,-0.203200><13.955016,0.035000,0.203200> rotate<0,0.000000,0> translate<21.325784,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.465847,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.823100,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<21.465847,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.529394,-1.535000,12.217419>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.546734,-1.535000,12.321463>}
box{<0,0,-0.203200><0.105479,0.035000,0.203200> rotate<0,-80.532363,0> translate<21.529394,-1.535000,12.217419> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.546734,-1.535000,12.321463>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.566337,-1.535000,12.352878>}
box{<0,0,-0.203200><0.037030,0.035000,0.203200> rotate<0,-58.032302,0> translate<21.546734,-1.535000,12.321463> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.551900,-1.535000,32.759800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.564238,-1.535000,32.730022>}
box{<0,0,-0.203200><0.032233,0.035000,0.203200> rotate<0,67.490624,0> translate<21.551900,-1.535000,32.759800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.551900,-1.535000,33.280197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.551900,-1.535000,32.759800>}
box{<0,0,-0.203200><0.520397,0.035000,0.203200> rotate<0,-90.000000,0> translate<21.551900,-1.535000,32.759800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.551900,-1.535000,33.280197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.751047,-1.535000,33.760978>}
box{<0,0,-0.203200><0.520394,0.035000,0.203200> rotate<0,-67.495468,0> translate<21.551900,-1.535000,33.280197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.566337,-1.535000,12.352878>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.576081,-1.535000,12.388609>}
box{<0,0,-0.203200><0.037036,0.035000,0.203200> rotate<0,-74.741644,0> translate<21.566337,-1.535000,12.352878> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.576081,-1.535000,12.388609>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.640669,-1.535000,12.472006>}
box{<0,0,-0.203200><0.105483,0.035000,0.203200> rotate<0,-52.240221,0> translate<21.576081,-1.535000,12.388609> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.039209>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.339209,-1.535000,34.302700>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,44.997030,0> translate<21.602700,-1.535000,35.039209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.559981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.039209>}
box{<0,0,-0.203200><0.520772,0.035000,0.203200> rotate<0,-90.000000,0> translate<21.602700,-1.535000,35.039209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.559981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859966,-1.535000,35.559981>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,0.000000,0> translate<21.602700,-1.535000,35.559981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.560012>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859966,-1.535000,35.560012>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,0.000000,0> translate<21.602700,-1.535000,35.560012> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,36.080787>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,35.560012>}
box{<0,0,-0.203200><0.520775,0.035000,0.203200> rotate<0,-90.000000,0> translate<21.602700,-1.535000,35.560012> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.602700,-1.535000,36.080787>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.339209,-1.535000,36.817297>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,-44.997030,0> translate<21.602700,-1.535000,36.080787> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.640669,-1.535000,12.472006>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.696506,-1.535000,12.561500>}
box{<0,0,-0.203200><0.105484,0.035000,0.203200> rotate<0,-58.035048,0> translate<21.640669,-1.535000,12.472006> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.696506,-1.535000,12.561500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.726644,-1.535000,12.583025>}
box{<0,0,-0.203200><0.037035,0.035000,0.203200> rotate<0,-35.533085,0> translate<21.696506,-1.535000,12.561500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.726644,-1.535000,12.583025>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.749319,-1.535000,12.612306>}
box{<0,0,-0.203200><0.037034,0.035000,0.203200> rotate<0,-52.242841,0> translate<21.726644,-1.535000,12.583025> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.732184,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,30.886400>}
box{<0,0,-0.203200><13.548616,0.035000,0.203200> rotate<0,0.000000,0> translate<21.732184,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.749319,-1.535000,12.612306>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.840897,-1.535000,12.664634>}
box{<0,0,-0.203200><0.105474,0.035000,0.203200> rotate<0,-29.741866,0> translate<21.749319,-1.535000,12.612306> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.751047,-1.535000,33.760978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.119019,-1.535000,34.128950>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,-44.997030,0> translate<21.751047,-1.535000,33.760978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.823100,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.289878,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<21.823100,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.840897,-1.535000,12.664634>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.905091,-1.535000,14.853344>}
box{<0,0,-0.203200><3.765599,0.035000,0.203200> rotate<0,-35.535327,0> translate<21.840897,-1.535000,12.664634> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.119019,-1.535000,34.128950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.538494,-1.535000,34.302700>}
box{<0,0,-0.203200><0.454036,0.035000,0.203200> rotate<0,-22.498255,0> translate<22.119019,-1.535000,34.128950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.138584,-1.535000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,31.292800>}
box{<0,0,-0.203200><13.142216,0.035000,0.203200> rotate<0,0.000000,0> translate<22.138584,-1.535000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.289878,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.795119,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<22.289878,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.339209,-1.535000,34.302700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.538494,-1.535000,34.302700>}
box{<0,0,-0.203200><0.199284,0.035000,0.203200> rotate<0,0.000000,0> translate<22.339209,-1.535000,34.302700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.339209,-1.535000,36.817297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,36.817297>}
box{<0,0,-0.203200><0.520772,0.035000,0.203200> rotate<0,0.000000,0> translate<22.339209,-1.535000,36.817297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.544984,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,31.699200>}
box{<0,0,-0.203200><12.735816,0.035000,0.203200> rotate<0,0.000000,0> translate<22.544984,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.570022,-1.535000,31.724238>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.599800,-1.535000,31.711900>}
box{<0,0,-0.203200><0.032233,0.035000,0.203200> rotate<0,22.503436,0> translate<22.570022,-1.535000,31.724238> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.599800,-1.535000,31.711900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.120197,-1.535000,31.711900>}
box{<0,0,-0.203200><0.520397,0.035000,0.203200> rotate<0,0.000000,0> translate<22.599800,-1.535000,31.711900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.795119,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.261897,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<22.795119,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859966,-1.535000,35.560012>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859966,-1.535000,35.559981>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,-90.000000,0> translate<22.859966,-1.535000,35.559981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,35.560031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,36.817297>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,90.000000,0> translate<22.859981,-1.535000,36.817297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,35.560031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,35.560031>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<22.859981,-1.535000,35.560031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,35.763200>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<22.859981,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,36.169600>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<22.859981,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.859981,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,36.576000>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<22.859981,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,36.817297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,35.560031>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,-90.000000,0> translate<22.860012,-1.535000,35.560031> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860012,-1.535000,36.817297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.380788,-1.535000,36.817297>}
box{<0,0,-0.203200><0.520775,0.035000,0.203200> rotate<0,0.000000,0> translate<22.860012,-1.535000,36.817297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860031,-1.535000,35.559981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860031,-1.535000,35.560012>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,90.000000,0> translate<22.860031,-1.535000,35.560012> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860031,-1.535000,35.559981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117294,-1.535000,35.559981>}
box{<0,0,-0.203200><1.257262,0.035000,0.203200> rotate<0,0.000000,0> translate<22.860031,-1.535000,35.559981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.860031,-1.535000,35.560012>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,35.560012>}
box{<0,0,-0.203200><1.257266,0.035000,0.203200> rotate<0,0.000000,0> translate<22.860031,-1.535000,35.560012> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.120197,-1.535000,31.711900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.600978,-1.535000,31.911047>}
box{<0,0,-0.203200><0.520394,0.035000,0.203200> rotate<0,-22.498592,0> translate<23.120197,-1.535000,31.711900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.181503,-1.535000,34.302700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.380788,-1.535000,34.302700>}
box{<0,0,-0.203200><0.199284,0.035000,0.203200> rotate<0,0.000000,0> translate<23.181503,-1.535000,34.302700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.181503,-1.535000,34.302700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.600978,-1.535000,34.128950>}
box{<0,0,-0.203200><0.454036,0.035000,0.203200> rotate<0,22.498255,0> translate<23.181503,-1.535000,34.302700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.261897,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.619150,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.261897,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.271750,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.353247,-1.535000,3.251200>}
box{<0,0,-0.203200><1.081497,0.035000,0.203200> rotate<0,0.000000,0> translate<23.271750,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.380788,-1.535000,34.302700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,35.039209>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.380788,-1.535000,34.302700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.380788,-1.535000,36.817297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,36.080787>}
box{<0,0,-0.203200><1.041582,0.035000,0.203200> rotate<0,44.997030,0> translate<23.380788,-1.535000,36.817297> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,20.178531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.527072,-1.535000,19.917138>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,67.495725,0> translate<23.418800,-1.535000,20.178531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,28.081466>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,20.178531>}
box{<0,0,-0.203200><7.902934,0.035000,0.203200> rotate<0,-90.000000,0> translate<23.418800,-1.535000,20.178531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.418800,-1.535000,28.081466>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.527072,-1.535000,28.342859>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-67.495725,0> translate<23.418800,-1.535000,28.081466> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.527072,-1.535000,19.917138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.727138,-1.535000,19.717072>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,44.997030,0> translate<23.527072,-1.535000,19.917138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.527072,-1.535000,28.342859>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.727138,-1.535000,28.542925>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.527072,-1.535000,28.342859> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.580097,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.844394,-1.535000,34.137600>}
box{<0,0,-0.203200><5.264297,0.035000,0.203200> rotate<0,0.000000,0> translate<23.580097,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.600978,-1.535000,31.911047>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.968950,-1.535000,32.279019>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.600978,-1.535000,31.911047> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.600978,-1.535000,34.128950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.968950,-1.535000,33.760978>}
box{<0,0,-0.203200><0.520391,0.035000,0.203200> rotate<0,44.997030,0> translate<23.600978,-1.535000,34.128950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.619150,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,4.065378>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<23.619150,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.622084,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,36.576000>}
box{<0,0,-0.203200><11.658716,0.035000,0.203200> rotate<0,0.000000,0> translate<23.622084,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.622088,-1.535000,34.544000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.433784,-1.535000,34.544000>}
box{<0,0,-0.203200><4.811697,0.035000,0.203200> rotate<0,0.000000,0> translate<23.622088,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.643588,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981406,-1.535000,3.657600>}
box{<0,0,-0.203200><0.337819,0.035000,0.203200> rotate<0,0.000000,0> translate<23.643588,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.727138,-1.535000,19.717072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.727141,-1.535000,19.717072>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<23.727138,-1.535000,19.717072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.727138,-1.535000,28.542925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.988531,-1.535000,28.651197>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<23.727138,-1.535000,28.542925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.727141,-1.535000,19.717072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.014184,-1.535000,18.430028>}
box{<0,0,-0.203200><1.820155,0.035000,0.203200> rotate<0,44.997030,0> translate<23.727141,-1.535000,19.717072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.795531,-1.535000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,32.105600>}
box{<0,0,-0.203200><11.485269,0.035000,0.203200> rotate<0,0.000000,0> translate<23.795531,-1.535000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.796112,-1.535000,6.134169>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,6.094619>}
box{<0,0,-0.203200><0.042809,0.035000,0.203200> rotate<0,67.492790,0> translate<23.796112,-1.535000,6.134169> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.796112,-1.535000,6.134169>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.759169,-1.535000,10.949441>}
box{<0,0,-0.203200><4.910633,0.035000,0.203200> rotate<0,-78.684853,0> translate<23.796112,-1.535000,6.134169> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.811925,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.813069,-1.535000,4.064000>}
box{<0,0,-0.203200><0.001144,0.035000,0.203200> rotate<0,0.000000,0> translate<23.811925,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.811925,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.813075,-1.535000,6.096000>}
box{<0,0,-0.203200><0.001150,0.035000,0.203200> rotate<0,0.000000,0> translate<23.811925,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,6.094619>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,90.000000,0> translate<23.812497,-1.535000,6.094619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,4.470400>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<23.812497,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,4.876800>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<23.812497,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,5.283200>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<23.812497,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812497,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,5.689600>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<23.812497,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,4.065378>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.005847,-1.535000,3.598600>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<23.812500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,6.094619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,4.065378>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,-90.000000,0> translate<23.812500,-1.535000,4.065378> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.812500,-1.535000,6.094619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.005847,-1.535000,6.561397>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<23.812500,-1.535000,6.094619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.869756,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981413,-1.535000,6.502400>}
box{<0,0,-0.203200><0.111656,0.035000,0.203200> rotate<0,0.000000,0> translate<23.869756,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.951038,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.353250,-1.535000,6.908800>}
box{<0,0,-0.203200><0.402213,0.035000,0.203200> rotate<0,0.000000,0> translate<23.951038,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.968950,-1.535000,32.279019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981284,-1.535000,32.308800>}
box{<0,0,-0.203200><0.032234,0.035000,0.203200> rotate<0,-67.497881,0> translate<23.968950,-1.535000,32.279019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.968950,-1.535000,33.760978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981284,-1.535000,33.731197>}
box{<0,0,-0.203200><0.032234,0.035000,0.203200> rotate<0,67.497881,0> translate<23.968950,-1.535000,33.760978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981284,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.634584,-1.535000,32.308800>}
box{<0,0,-0.203200><7.653300,0.035000,0.203200> rotate<0,0.000000,0> translate<23.981284,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981284,-1.535000,33.731197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.582109,-1.535000,33.731197>}
box{<0,0,-0.203200><7.600825,0.035000,0.203200> rotate<0,0.000000,0> translate<23.981284,-1.535000,33.731197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.981284,-1.535000,33.731200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.582119,-1.535000,33.731200>}
box{<0,0,-0.203200><7.600834,0.035000,0.203200> rotate<0,0.000000,0> translate<23.981284,-1.535000,33.731200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.988531,-1.535000,28.651197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.776331,-1.535000,28.651197>}
box{<0,0,-0.203200><0.787800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.988531,-1.535000,28.651197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.005847,-1.535000,3.598600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.363100,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<24.005847,-1.535000,3.598600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.005847,-1.535000,6.561397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.363100,-1.535000,6.918650>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<24.005847,-1.535000,6.561397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.028484,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.622631,-1.535000,36.169600>}
box{<0,0,-0.203200><4.594147,0.035000,0.203200> rotate<0,0.000000,0> translate<24.028484,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.028488,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.262216,-1.535000,34.950400>}
box{<0,0,-0.203200><4.233728,0.035000,0.203200> rotate<0,0.000000,0> translate<24.028488,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.032319,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,7.315200>}
box{<0,0,-0.203200><1.926481,0.035000,0.203200> rotate<0,0.000000,0> translate<24.032319,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.113597,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,7.721600>}
box{<0,0,-0.203200><1.845203,0.035000,0.203200> rotate<0,0.000000,0> translate<24.113597,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117294,-1.535000,35.559981>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,35.039209>}
box{<0,0,-0.203200><0.520772,0.035000,0.203200> rotate<0,89.993717,0> translate<24.117294,-1.535000,35.559981> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.234056,-1.535000,35.356800>}
box{<0,0,-0.203200><4.116759,0.035000,0.203200> rotate<0,0.000000,0> translate<24.117297,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,35.560012>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,36.080787>}
box{<0,0,-0.203200><0.520775,0.035000,0.203200> rotate<0,90.000000,0> translate<24.117297,-1.535000,36.080787> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.117297,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.338950,-1.535000,35.763200>}
box{<0,0,-0.203200><4.221653,0.035000,0.203200> rotate<0,0.000000,0> translate<24.117297,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.194878,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,8.128000>}
box{<0,0,-0.203200><1.763922,0.035000,0.203200> rotate<0,0.000000,0> translate<24.194878,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.276159,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,8.534400>}
box{<0,0,-0.203200><1.682641,0.035000,0.203200> rotate<0,0.000000,0> translate<24.276159,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.357437,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,8.940800>}
box{<0,0,-0.203200><1.601363,0.035000,0.203200> rotate<0,0.000000,0> translate<24.357437,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.363100,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.829878,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<24.363100,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.363100,-1.535000,6.918650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.829878,-1.535000,7.111997>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<24.363100,-1.535000,6.918650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.438719,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.170031,-1.535000,9.347200>}
box{<0,0,-0.203200><0.731313,0.035000,0.203200> rotate<0,0.000000,0> translate<24.438719,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.520000,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.913266,-1.535000,9.753600>}
box{<0,0,-0.203200><0.393266,0.035000,0.203200> rotate<0,0.000000,0> translate<24.520000,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.601278,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,10.160000>}
box{<0,0,-0.203200><0.239922,0.035000,0.203200> rotate<0,0.000000,0> translate<24.601278,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.682559,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.913272,-1.535000,10.566400>}
box{<0,0,-0.203200><0.230712,0.035000,0.203200> rotate<0,0.000000,0> translate<24.682559,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.759169,-1.535000,10.949441>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.923488,-1.535000,11.531600>}
box{<0,0,-0.203200><1.301748,0.035000,0.203200> rotate<0,-26.563298,0> translate<24.759169,-1.535000,10.949441> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.776331,-1.535000,28.651197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.233531,-1.535000,29.108397>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-44.997030,0> translate<24.776331,-1.535000,28.651197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.805888,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.170034,-1.535000,10.972800>}
box{<0,0,-0.203200><0.364147,0.035000,0.203200> rotate<0,0.000000,0> translate<24.805888,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.829878,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.335119,-1.535000,3.048000>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<24.829878,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.829878,-1.535000,7.111997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.335119,-1.535000,7.111997>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,0.000000,0> translate<24.829878,-1.535000,7.111997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,20.614584>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,27.163938>}
box{<0,0,-0.203200><6.549353,0.035000,0.203200> rotate<0,90.000000,0> translate<24.841197,-1.535000,27.163938> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,20.614584>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.859413,-1.535000,20.596372>}
box{<0,0,-0.203200><0.025759,0.035000,0.203200> rotate<0,44.992115,0> translate<24.841197,-1.535000,20.614584> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.913272,-1.535000,20.726400>}
box{<0,0,-0.203200><0.072075,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.170034,-1.535000,21.132800>}
box{<0,0,-0.203200><0.328837,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.985012,-1.535000,21.539200>}
box{<0,0,-0.203200><2.143816,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.271631,-1.535000,21.945600>}
box{<0,0,-0.203200><0.430434,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.955350,-1.535000,22.352000>}
box{<0,0,-0.203200><0.114153,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,22.758400>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.871188,-1.535000,23.164800>}
box{<0,0,-0.203200><0.029991,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.068434,-1.535000,23.571200>}
box{<0,0,-0.203200><0.227238,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654556,-1.535000,23.977600>}
box{<0,0,-0.203200><0.813359,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.409263,-1.535000,24.384000>}
box{<0,0,-0.203200><0.568066,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.997434,-1.535000,24.790400>}
box{<0,0,-0.203200><0.156237,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,25.196800>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,25.603200>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.997441,-1.535000,26.009600>}
box{<0,0,-0.203200><0.156244,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.409272,-1.535000,26.416000>}
box{<0,0,-0.203200><0.568075,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.182731,-1.535000,26.822400>}
box{<0,0,-0.203200><0.341534,0.035000,0.203200> rotate<0,0.000000,0> translate<24.841197,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841197,-1.535000,27.163938>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.233531,-1.535000,26.771600>}
box{<0,0,-0.203200><0.554847,0.035000,0.203200> rotate<0,44.997258,0> translate<24.841197,-1.535000,27.163938> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,9.927588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,9.498153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<24.841200,-1.535000,9.927588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,10.392409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,9.927588>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.841200,-1.535000,9.927588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,10.392409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,10.821844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<24.841200,-1.535000,10.392409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,15.007588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.905091,-1.535000,14.853344>}
box{<0,0,-0.203200><0.166953,0.035000,0.203200> rotate<0,67.495301,0> translate<24.841200,-1.535000,15.007588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,15.472409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,15.007588>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.841200,-1.535000,15.007588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,15.472409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,15.901844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<24.841200,-1.535000,15.472409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,17.547588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,17.118153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<24.841200,-1.535000,17.547588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,18.012409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,17.547588>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.841200,-1.535000,17.547588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,18.012409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.014184,-1.535000,18.430028>}
box{<0,0,-0.203200><0.452028,0.035000,0.203200> rotate<0,-67.495425,0> translate<24.841200,-1.535000,18.012409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,22.627588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,22.198153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<24.841200,-1.535000,22.627588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,23.092409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,22.627588>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.841200,-1.535000,22.627588> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,23.092409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,23.521844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<24.841200,-1.535000,23.092409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,25.167587>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,24.738153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<24.841200,-1.535000,25.167587> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,25.632409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,25.167587>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.841200,-1.535000,25.167587> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.841200,-1.535000,25.632409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,26.061844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<24.841200,-1.535000,25.632409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.859413,-1.535000,20.596372>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,20.981844>}
box{<0,0,-0.203200><0.417231,0.035000,0.203200> rotate<0,-67.495806,0> translate<24.859413,-1.535000,20.596372> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,9.498153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,9.169478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<25.019078,-1.535000,9.498153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,10.821844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,11.150519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.019078,-1.535000,10.821844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,15.901844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,16.230519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.019078,-1.535000,15.901844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,17.118153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,16.789478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<25.019078,-1.535000,17.118153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,20.981844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,21.310519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.019078,-1.535000,20.981844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,22.198153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,21.869478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<25.019078,-1.535000,22.198153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,23.521844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,23.850519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.019078,-1.535000,23.521844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,24.738153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,24.409478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<25.019078,-1.535000,24.738153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.019078,-1.535000,26.061844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,26.390519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.019078,-1.535000,26.061844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.233531,-1.535000,26.771600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.201466,-1.535000,26.771600>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<25.233531,-1.535000,26.771600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.233531,-1.535000,29.108397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.201466,-1.535000,29.108397>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,0.000000,0> translate<25.233531,-1.535000,29.108397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.335119,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.801897,-1.535000,3.241347>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<25.335119,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.335119,-1.535000,7.111997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.801897,-1.535000,6.918650>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<25.335119,-1.535000,7.111997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,9.169478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,8.991600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<25.347753,-1.535000,9.169478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,11.150519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,11.328397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<25.347753,-1.535000,11.150519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,16.230519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,16.408397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<25.347753,-1.535000,16.230519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,16.789478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,16.611600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<25.347753,-1.535000,16.789478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,21.310519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,21.488397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<25.347753,-1.535000,21.310519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,21.869478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,21.691600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<25.347753,-1.535000,21.869478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,23.850519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,24.028397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<25.347753,-1.535000,23.850519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,24.409478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,24.231600>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<25.347753,-1.535000,24.409478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.347753,-1.535000,26.390519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,26.568397>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<25.347753,-1.535000,26.390519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.618688,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,11.379200>}
box{<0,0,-0.203200><2.880113,0.035000,0.203200> rotate<0,0.000000,0> translate<25.618688,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,8.991600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,8.991600>}
box{<0,0,-0.203200><0.181612,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,8.991600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,11.328397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,11.328397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,11.328397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,16.408397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,16.408397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,16.408397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,16.611600>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,21.488397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.035816,-1.535000,21.488397>}
box{<0,0,-0.203200><1.258628,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,21.488397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,21.691600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.832612,-1.535000,21.691600>}
box{<0,0,-0.203200><1.055425,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,21.691600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,24.028397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,24.028397>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,24.028397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,24.231600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,24.231600>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,24.231600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.777188,-1.535000,26.568397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.832609,-1.535000,26.568397>}
box{<0,0,-0.203200><1.055422,0.035000,0.203200> rotate<0,0.000000,0> translate<25.777188,-1.535000,26.568397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.801897,-1.535000,3.241347>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,3.398253>}
box{<0,0,-0.203200><0.221897,0.035000,0.203200> rotate<0,-44.997601,0> translate<25.801897,-1.535000,3.241347> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.801897,-1.535000,6.918650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,6.761744>}
box{<0,0,-0.203200><0.221897,0.035000,0.203200> rotate<0,44.997601,0> translate<25.801897,-1.535000,6.918650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.811747,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,3.251200>}
box{<0,0,-0.203200><0.147053,0.035000,0.203200> rotate<0,0.000000,0> translate<25.811747,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.811747,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,6.908800>}
box{<0,0,-0.203200><0.147053,0.035000,0.203200> rotate<0,0.000000,0> translate<25.811747,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.923488,-1.535000,11.531600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,11.531600>}
box{<0,0,-0.203200><1.639322,0.035000,0.203200> rotate<0,0.000000,0> translate<25.923488,-1.535000,11.531600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,3.398253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,2.933697>}
box{<0,0,-0.203200><0.464556,0.035000,0.203200> rotate<0,-90.000000,0> translate<25.958800,-1.535000,2.933697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,8.991600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.958800,-1.535000,6.761744>}
box{<0,0,-0.203200><2.229856,0.035000,0.203200> rotate<0,-90.000000,0> translate<25.958800,-1.535000,6.761744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.973347,-1.535000,13.868397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.257834,-1.535000,14.071600>}
box{<0,0,-0.203200><0.349606,0.035000,0.203200> rotate<0,-35.535035,0> translate<25.973347,-1.535000,13.868397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.973347,-1.535000,13.868397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,13.868397>}
box{<0,0,-0.203200><1.589462,0.035000,0.203200> rotate<0,0.000000,0> translate<25.973347,-1.535000,13.868397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.201466,-1.535000,26.771600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.885897,-1.535000,27.456031>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.201466,-1.535000,26.771600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.201466,-1.535000,29.108397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.885897,-1.535000,28.423966>}
box{<0,0,-0.203200><0.967932,0.035000,0.203200> rotate<0,44.997030,0> translate<26.201466,-1.535000,29.108397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.252266,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.086613,-1.535000,26.822400>}
box{<0,0,-0.203200><0.834347,0.035000,0.203200> rotate<0,0.000000,0> translate<26.252266,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.257834,-1.535000,14.071600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,14.071600>}
box{<0,0,-0.203200><1.304975,0.035000,0.203200> rotate<0,0.000000,0> translate<26.257834,-1.535000,14.071600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.455463,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.854400>}
box{<0,0,-0.203200><5.421537,0.035000,0.203200> rotate<0,0.000000,0> translate<26.455463,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.658666,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.493013,-1.535000,27.228800>}
box{<0,0,-0.203200><0.834347,0.035000,0.203200> rotate<0,0.000000,0> translate<26.658666,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.811466,-1.535000,1.511300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.072859,-1.535000,1.619572>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<26.811466,-1.535000,1.511300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.832609,-1.535000,26.568397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.337072,-1.535000,27.072859>}
box{<0,0,-0.203200><0.713418,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.832609,-1.535000,26.568397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.832612,-1.535000,21.691600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.035816,-1.535000,21.488397>}
box{<0,0,-0.203200><0.287373,0.035000,0.203200> rotate<0,44.997030,0> translate<26.832612,-1.535000,21.691600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.861863,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.966769,-1.535000,28.448000>}
box{<0,0,-0.203200><5.104906,0.035000,0.203200> rotate<0,0.000000,0> translate<26.861863,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.885897,-1.535000,27.456031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.885897,-1.535000,28.423966>}
box{<0,0,-0.203200><0.967934,0.035000,0.203200> rotate<0,90.000000,0> translate<26.885897,-1.535000,28.423966> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.885897,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,27.635200>}
box{<0,0,-0.203200><8.394903,0.035000,0.203200> rotate<0,0.000000,0> translate<26.885897,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.885897,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.264972,-1.535000,28.041600>}
box{<0,0,-0.203200><5.379075,0.035000,0.203200> rotate<0,0.000000,0> translate<26.885897,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.072859,-1.535000,1.619572>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.272925,-1.535000,1.819638>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.072859,-1.535000,1.619572> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.078888,-1.535000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,1.625600>}
box{<0,0,-0.203200><8.201912,0.035000,0.203200> rotate<0,0.000000,0> translate<27.078888,-1.535000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.272925,-1.535000,1.819638>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,2.081031>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-67.495725,0> translate<27.272925,-1.535000,1.819638> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.337072,-1.535000,27.072859>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.537138,-1.535000,27.272925>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.337072,-1.535000,27.072859> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.360888,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,2.032000>}
box{<0,0,-0.203200><7.919912,0.035000,0.203200> rotate<0,0.000000,0> translate<27.360888,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,2.081031>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,8.991600>}
box{<0,0,-0.203200><6.910569,0.035000,0.203200> rotate<0,90.000000,0> translate<27.381197,-1.535000,8.991600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,2.438400>}
box{<0,0,-0.203200><7.899603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,2.844800>}
box{<0,0,-0.203200><7.899603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,3.251200>}
box{<0,0,-0.203200><7.899603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.740966,-1.535000,3.657600>}
box{<0,0,-0.203200><4.359769,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.258475,-1.535000,4.064000>}
box{<0,0,-0.203200><3.877278,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.070966,-1.535000,4.470400>}
box{<0,0,-0.203200><3.689769,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.041706,-1.535000,4.876800>}
box{<0,0,-0.203200><3.660509,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.154972,-1.535000,5.283200>}
box{<0,0,-0.203200><3.773775,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.460894,-1.535000,5.689600>}
box{<0,0,-0.203200><4.079697,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.852075,-1.535000,6.096000>}
box{<0,0,-0.203200><4.470878,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.262047,-1.535000,6.502400>}
box{<0,0,-0.203200><3.880850,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.068531,-1.535000,6.908800>}
box{<0,0,-0.203200><1.687334,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.566453,-1.535000,7.315200>}
box{<0,0,-0.203200><1.185256,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,7.721600>}
box{<0,0,-0.203200><1.117603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,8.128000>}
box{<0,0,-0.203200><1.117603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,8.534400>}
box{<0,0,-0.203200><1.117603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,8.940800>}
box{<0,0,-0.203200><1.117603,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.381197,-1.535000,8.991600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,8.991600>}
box{<0,0,-0.203200><0.181612,0.035000,0.203200> rotate<0,0.000000,0> translate<27.381197,-1.535000,8.991600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.537138,-1.535000,27.272925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.798531,-1.535000,27.381197>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,-22.498335,0> translate<27.537138,-1.535000,27.272925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,8.991600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,9.169478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<27.562809,-1.535000,8.991600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,11.328397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,11.150519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<27.562809,-1.535000,11.328397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,11.531600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,11.709478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<27.562809,-1.535000,11.531600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,13.868397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,13.690519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<27.562809,-1.535000,13.868397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,14.071600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,14.249478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<27.562809,-1.535000,14.071600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,16.408397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,16.230519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<27.562809,-1.535000,16.408397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,16.611600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,16.789478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<27.562809,-1.535000,16.611600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,24.028397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,23.850519>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<27.562809,-1.535000,24.028397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.562809,-1.535000,24.231600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,24.409478>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<27.562809,-1.535000,24.231600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.685444,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,13.817600>}
box{<0,0,-0.203200><0.813356,0.035000,0.203200> rotate<0,0.000000,0> translate<27.685444,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.685444,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.728584,-1.535000,23.977600>}
box{<0,0,-0.203200><1.043141,0.035000,0.203200> rotate<0,0.000000,0> translate<27.685444,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.685450,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,16.662400>}
box{<0,0,-0.203200><0.813350,0.035000,0.203200> rotate<0,0.000000,0> translate<27.685450,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.798531,-1.535000,27.381197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.139581,-1.535000,27.381197>}
box{<0,0,-0.203200><1.341050,0.035000,0.203200> rotate<0,0.000000,0> translate<27.798531,-1.535000,27.381197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.930728,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,16.256000>}
box{<0,0,-0.203200><0.568072,0.035000,0.203200> rotate<0,0.000000,0> translate<27.930728,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.930731,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,14.224000>}
box{<0,0,-0.203200><0.568069,0.035000,0.203200> rotate<0,0.000000,0> translate<27.930731,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.930731,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.359709,-1.535000,24.384000>}
box{<0,0,-0.203200><0.428978,0.035000,0.203200> rotate<0,0.000000,0> translate<27.930731,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,9.169478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,9.498153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.992244,-1.535000,9.169478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,11.150519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,10.821844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<27.992244,-1.535000,11.150519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,11.709478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,12.038153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.992244,-1.535000,11.709478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,13.690519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,13.361844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<27.992244,-1.535000,13.690519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,14.249478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,14.578153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.992244,-1.535000,14.249478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,16.230519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,15.901844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<27.992244,-1.535000,16.230519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,16.789478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,17.118153>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.992244,-1.535000,16.789478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,23.850519>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,23.521844>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<27.992244,-1.535000,23.850519> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.992244,-1.535000,24.409478>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.244622,-1.535000,24.661856>}
box{<0,0,-0.203200><0.356917,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.992244,-1.535000,24.409478> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.068366,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,11.785600>}
box{<0,0,-0.203200><0.430434,0.035000,0.203200> rotate<0,0.000000,0> translate<28.068366,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.169963,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,10.972800>}
box{<0,0,-0.203200><0.328838,0.035000,0.203200> rotate<0,0.000000,0> translate<28.169963,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.169966,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,9.347200>}
box{<0,0,-0.203200><0.328834,0.035000,0.203200> rotate<0,0.000000,0> translate<28.169966,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.140547>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.263997,-1.535000,34.939156>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,80.994728,0> translate<28.232100,-1.535000,35.140547> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.166294>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.140547>}
box{<0,0,-0.203200><0.025747,0.035000,0.203200> rotate<0,-90.000000,0> translate<28.232100,-1.535000,35.140547> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.166294>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451278,-1.535000,35.166294>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,0.000000,0> translate<28.232100,-1.535000,35.166294> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.318700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451278,-1.535000,35.318700>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,0.000000,0> translate<28.232100,-1.535000,35.318700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.344450>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.318700>}
box{<0,0,-0.203200><0.025750,0.035000,0.203200> rotate<0,-90.000000,0> translate<28.232100,-1.535000,35.318700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.232100,-1.535000,35.344450>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.263997,-1.535000,35.545841>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,-80.994728,0> translate<28.232100,-1.535000,35.344450> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.244622,-1.535000,24.661856>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.386247,-1.535000,24.319938>}
box{<0,0,-0.203200><0.370089,0.035000,0.203200> rotate<0,67.495886,0> translate<28.244622,-1.535000,24.661856> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.263997,-1.535000,34.939156>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.327006,-1.535000,34.745238>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,71.994887,0> translate<28.263997,-1.535000,34.939156> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.263997,-1.535000,35.545841>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.327006,-1.535000,35.739759>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,-71.994887,0> translate<28.263997,-1.535000,35.545841> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.271563,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,13.411200>}
box{<0,0,-0.203200><0.227238,0.035000,0.203200> rotate<0,0.000000,0> translate<28.271563,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.271563,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.829881,-1.535000,23.571200>}
box{<0,0,-0.203200><3.558319,0.035000,0.203200> rotate<0,0.000000,0> translate<28.271563,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.271566,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,17.068800>}
box{<0,0,-0.203200><0.227234,0.035000,0.203200> rotate<0,0.000000,0> translate<28.271566,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,9.498153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,9.927588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<28.320919,-1.535000,9.498153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,10.821844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,10.392409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<28.320919,-1.535000,10.821844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,12.038153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,12.467588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<28.320919,-1.535000,12.038153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,13.361844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,12.932409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<28.320919,-1.535000,13.361844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,14.578153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,15.007588>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<28.320919,-1.535000,14.578153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,15.901844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,15.472409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<28.320919,-1.535000,15.901844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,17.118153>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.480584,-1.535000,17.503625>}
box{<0,0,-0.203200><0.417231,0.035000,0.203200> rotate<0,-67.495806,0> translate<28.320919,-1.535000,17.118153> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.320919,-1.535000,23.521844>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,23.092409>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<28.320919,-1.535000,23.521844> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.325813,-1.535000,22.209969>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,22.627588>}
box{<0,0,-0.203200><0.452028,0.035000,0.203200> rotate<0,-67.495425,0> translate<28.325813,-1.535000,22.209969> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.325813,-1.535000,22.209969>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.882856,-1.535000,19.652925>}
box{<0,0,-0.203200><3.616206,0.035000,0.203200> rotate<0,44.997030,0> translate<28.325813,-1.535000,22.209969> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.327006,-1.535000,34.745238>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.419575,-1.535000,34.563559>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,62.996062,0> translate<28.327006,-1.535000,34.745238> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.327006,-1.535000,35.739759>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.419575,-1.535000,35.921438>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,-62.996062,0> translate<28.327006,-1.535000,35.739759> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.342559,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,14.630400>}
box{<0,0,-0.203200><0.156241,0.035000,0.203200> rotate<0,0.000000,0> translate<28.342559,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.342559,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,15.849600>}
box{<0,0,-0.203200><0.156241,0.035000,0.203200> rotate<0,0.000000,0> translate<28.342559,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.384644,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,12.192000>}
box{<0,0,-0.203200><0.114156,0.035000,0.203200> rotate<0,0.000000,0> translate<28.384644,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.384644,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,22.352000>}
box{<0,0,-0.203200><6.896156,0.035000,0.203200> rotate<0,0.000000,0> translate<28.384644,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.386247,-1.535000,24.319938>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.764938,-1.535000,23.941247>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,44.997030,0> translate<28.386247,-1.535000,24.319938> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.419575,-1.535000,34.563559>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.539425,-1.535000,34.398603>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,53.995920,0> translate<28.419575,-1.535000,34.563559> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.419575,-1.535000,35.921438>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.539425,-1.535000,36.086394>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,-53.995920,0> translate<28.419575,-1.535000,35.921438> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.426728,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,9.753600>}
box{<0,0,-0.203200><0.072072,0.035000,0.203200> rotate<0,0.000000,0> translate<28.426728,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.426728,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,10.566400>}
box{<0,0,-0.203200><0.072072,0.035000,0.203200> rotate<0,0.000000,0> translate<28.426728,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.468809,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,17.475200>}
box{<0,0,-0.203200><0.029991,0.035000,0.203200> rotate<0,0.000000,0> translate<28.468809,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.468813,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,13.004800>}
box{<0,0,-0.203200><0.029988,0.035000,0.203200> rotate<0,0.000000,0> translate<28.468813,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.468813,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.998216,-1.535000,23.164800>}
box{<0,0,-0.203200><3.529403,0.035000,0.203200> rotate<0,0.000000,0> translate<28.468813,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.480584,-1.535000,17.503625>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,17.485409>}
box{<0,0,-0.203200><0.025761,0.035000,0.203200> rotate<0,44.997030,0> translate<28.480584,-1.535000,17.503625> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,9.927588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,10.392409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<28.498797,-1.535000,10.392409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,10.160000>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<28.498797,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,12.467588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,12.932409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<28.498797,-1.535000,12.932409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,12.598400>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<28.498797,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,15.007588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,15.472409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<28.498797,-1.535000,15.472409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,15.036800>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<28.498797,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,15.443200>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<28.498797,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,22.627588>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,23.092409>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,90.000000,0> translate<28.498797,-1.535000,23.092409> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498797,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.486244,-1.535000,22.758400>}
box{<0,0,-0.203200><3.987447,0.035000,0.203200> rotate<0,0.000000,0> translate<28.498797,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,7.478531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.607072,-1.535000,7.217138>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,67.495725,0> translate<28.498800,-1.535000,7.478531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,17.485409>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.498800,-1.535000,7.478531>}
box{<0,0,-0.203200><10.006878,0.035000,0.203200> rotate<0,-90.000000,0> translate<28.498800,-1.535000,7.478531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.539425,-1.535000,34.398603>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.683603,-1.535000,34.254425>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,44.997030,0> translate<28.539425,-1.535000,34.398603> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.539425,-1.535000,36.086394>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.683603,-1.535000,36.230572>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,-44.997030,0> translate<28.539425,-1.535000,36.086394> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.590181,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,21.945600>}
box{<0,0,-0.203200><6.690619,0.035000,0.203200> rotate<0,0.000000,0> translate<28.590181,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.607072,-1.535000,7.217138>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.807137,-1.535000,7.017072>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,44.997030,0> translate<28.607072,-1.535000,7.217138> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.683603,-1.535000,34.254425>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.848559,-1.535000,34.134575>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,35.998140,0> translate<28.683603,-1.535000,34.254425> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.683603,-1.535000,36.230572>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.848559,-1.535000,36.350422>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,-35.998140,0> translate<28.683603,-1.535000,36.230572> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.764938,-1.535000,23.941247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.259722,-1.535000,23.736300>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,22.498562,0> translate<28.764938,-1.535000,23.941247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.807137,-1.535000,7.017072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.068531,-1.535000,6.908800>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<28.807137,-1.535000,7.017072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.848559,-1.535000,34.134575>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.030238,-1.535000,34.042006>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,26.997998,0> translate<28.848559,-1.535000,34.134575> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.848559,-1.535000,36.350422>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.030238,-1.535000,36.442991>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,-26.997998,0> translate<28.848559,-1.535000,36.350422> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.996581,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,21.539200>}
box{<0,0,-0.203200><6.284219,0.035000,0.203200> rotate<0,0.000000,0> translate<28.996581,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.030238,-1.535000,34.042006>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.224156,-1.535000,33.978997>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,17.999174,0> translate<29.030238,-1.535000,34.042006> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.030238,-1.535000,36.442991>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.224156,-1.535000,36.506000>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,-17.999174,0> translate<29.030238,-1.535000,36.442991> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.068531,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.046438,-1.535000,6.908800>}
box{<0,0,-0.203200><1.977906,0.035000,0.203200> rotate<0,0.000000,0> translate<29.068531,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.139581,-1.535000,27.381197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.209238,-1.535000,27.395128>}
box{<0,0,-0.203200><0.071036,0.035000,0.203200> rotate<0,-11.309186,0> translate<29.139581,-1.535000,27.381197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.209238,-1.535000,27.395128>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.279663,-1.535000,27.381197>}
box{<0,0,-0.203200><0.071790,0.035000,0.203200> rotate<0,11.188868,0> translate<29.209238,-1.535000,27.395128> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.224156,-1.535000,33.978997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.425547,-1.535000,33.947100>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,8.999332,0> translate<29.224156,-1.535000,33.978997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.224156,-1.535000,36.506000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.425547,-1.535000,36.537897>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,-8.999332,0> translate<29.224156,-1.535000,36.506000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.259722,-1.535000,23.736300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.795275,-1.535000,23.736300>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,0.000000,0> translate<29.259722,-1.535000,23.736300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.279663,-1.535000,27.381197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.461291,-1.535000,27.381197>}
box{<0,0,-0.203200><1.181628,0.035000,0.203200> rotate<0,0.000000,0> translate<29.279663,-1.535000,27.381197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.402981,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,21.132800>}
box{<0,0,-0.203200><5.877819,0.035000,0.203200> rotate<0,0.000000,0> translate<29.402981,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.425547,-1.535000,33.947100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,33.947100>}
box{<0,0,-0.203200><0.025747,0.035000,0.203200> rotate<0,0.000000,0> translate<29.425547,-1.535000,33.947100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.425547,-1.535000,36.537897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,36.537897>}
box{<0,0,-0.203200><0.025747,0.035000,0.203200> rotate<0,0.000000,0> translate<29.425547,-1.535000,36.537897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451278,-1.535000,35.318700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451278,-1.535000,35.166294>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,-90.000000,0> translate<29.451278,-1.535000,35.166294> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,33.947100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,35.166278>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,90.000000,0> translate<29.451294,-1.535000,35.166278> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,34.137600>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,34.544000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,34.544000>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,34.950400>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,35.166278>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,35.166278>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,35.166278> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,35.318719>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,36.537897>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,90.000000,0> translate<29.451294,-1.535000,36.537897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,35.318719>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,35.318719>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,35.318719> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,35.356800>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,35.763200>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.451294,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,36.169600>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,0.000000,0> translate<29.451294,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,33.947100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.629450,-1.535000,33.947100>}
box{<0,0,-0.203200><0.025750,0.035000,0.203200> rotate<0,0.000000,0> translate<29.603700,-1.535000,33.947100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,35.166278>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,33.947100>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,-90.000000,0> translate<29.603700,-1.535000,33.947100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,36.537894>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,35.318719>}
box{<0,0,-0.203200><1.219175,0.035000,0.203200> rotate<0,-90.000000,0> translate<29.603700,-1.535000,35.318719> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603700,-1.535000,36.537894>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.629450,-1.535000,36.537897>}
box{<0,0,-0.203200><0.025750,0.035000,0.203200> rotate<0,-0.006953,0> translate<29.603700,-1.535000,36.537894> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603719,-1.535000,35.166294>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603719,-1.535000,35.318700>}
box{<0,0,-0.203200><0.152406,0.035000,0.203200> rotate<0,90.000000,0> translate<29.603719,-1.535000,35.318700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603719,-1.535000,35.166294>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.166294>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,0.000000,0> translate<29.603719,-1.535000,35.166294> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.603719,-1.535000,35.318700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.318700>}
box{<0,0,-0.203200><1.219178,0.035000,0.203200> rotate<0,0.000000,0> translate<29.603719,-1.535000,35.318700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.629450,-1.535000,33.947100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.830841,-1.535000,33.978997>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,-8.999332,0> translate<29.629450,-1.535000,33.947100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.629450,-1.535000,36.537897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.830841,-1.535000,36.506000>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,8.999332,0> translate<29.629450,-1.535000,36.537897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.795275,-1.535000,23.736300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.290059,-1.535000,23.941247>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-22.498562,0> translate<29.795275,-1.535000,23.736300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.809381,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,20.726400>}
box{<0,0,-0.203200><5.471419,0.035000,0.203200> rotate<0,0.000000,0> translate<29.809381,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.830841,-1.535000,33.978997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.024759,-1.535000,34.042006>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,-17.999174,0> translate<29.830841,-1.535000,33.978997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.830841,-1.535000,36.506000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.024759,-1.535000,36.442991>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,17.999174,0> translate<29.830841,-1.535000,36.506000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,8.331197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,9.713016>}
box{<0,0,-0.203200><1.381819,0.035000,0.203200> rotate<0,90.000000,0> translate<29.921197,-1.535000,9.713016> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,8.331197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.490647,-1.535000,8.331197>}
box{<0,0,-0.203200><1.569450,0.035000,0.203200> rotate<0,0.000000,0> translate<29.921197,-1.535000,8.331197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.913406,-1.535000,8.534400>}
box{<0,0,-0.203200><1.992209,0.035000,0.203200> rotate<0,0.000000,0> translate<29.921197,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.363647,-1.535000,8.940800>}
box{<0,0,-0.203200><1.442450,0.035000,0.203200> rotate<0,0.000000,0> translate<29.921197,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.088519,-1.535000,9.347200>}
box{<0,0,-0.203200><1.167322,0.035000,0.203200> rotate<0,0.000000,0> translate<29.921197,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.921197,-1.535000,9.713016>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.077138,-1.535000,9.557072>}
box{<0,0,-0.203200><0.220536,0.035000,0.203200> rotate<0,44.997604,0> translate<29.921197,-1.535000,9.713016> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.024759,-1.535000,34.042006>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.206437,-1.535000,34.134575>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,-26.997998,0> translate<30.024759,-1.535000,34.042006> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.024759,-1.535000,36.442991>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.206437,-1.535000,36.350422>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,26.997998,0> translate<30.024759,-1.535000,36.442991> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.077138,-1.535000,9.557072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.338531,-1.535000,9.448800>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,22.498335,0> translate<30.077138,-1.535000,9.557072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.206437,-1.535000,34.134575>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.371394,-1.535000,34.254425>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,-35.998140,0> translate<30.206437,-1.535000,34.134575> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.206437,-1.535000,36.350422>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.371394,-1.535000,36.230572>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,35.998140,0> translate<30.206437,-1.535000,36.350422> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.210600,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,34.137600>}
box{<0,0,-0.203200><1.615600,0.035000,0.203200> rotate<0,0.000000,0> translate<30.210600,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.215781,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,20.320000>}
box{<0,0,-0.203200><5.065019,0.035000,0.203200> rotate<0,0.000000,0> translate<30.215781,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.290059,-1.535000,23.941247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.668750,-1.535000,24.319938>}
box{<0,0,-0.203200><0.535549,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.290059,-1.535000,23.941247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.326412,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,23.977600>}
box{<0,0,-0.203200><1.499788,0.035000,0.203200> rotate<0,0.000000,0> translate<30.326412,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.338531,-1.535000,9.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.046438,-1.535000,9.448800>}
box{<0,0,-0.203200><0.707906,0.035000,0.203200> rotate<0,0.000000,0> translate<30.338531,-1.535000,9.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.371394,-1.535000,34.254425>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515572,-1.535000,34.398603>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.371394,-1.535000,34.254425> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.371394,-1.535000,36.230572>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515572,-1.535000,36.086394>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,44.997030,0> translate<30.371394,-1.535000,36.230572> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.432366,-1.535000,36.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,36.169600>}
box{<0,0,-0.203200><4.848434,0.035000,0.203200> rotate<0,0.000000,0> translate<30.432366,-1.535000,36.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.461291,-1.535000,27.381197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.583891,-1.535000,27.387650>}
box{<0,0,-0.203200><0.122770,0.035000,0.203200> rotate<0,-3.012819,0> translate<30.461291,-1.535000,27.381197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515572,-1.535000,34.398603>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.635422,-1.535000,34.563559>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,-53.995920,0> translate<30.515572,-1.535000,34.398603> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515572,-1.535000,36.086394>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.635422,-1.535000,35.921438>}
box{<0,0,-0.203200><0.203898,0.035000,0.203200> rotate<0,53.995920,0> translate<30.515572,-1.535000,36.086394> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.583891,-1.535000,27.387650>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.602125,-1.535000,27.381197>}
box{<0,0,-0.203200><0.019343,0.035000,0.203200> rotate<0,19.487528,0> translate<30.583891,-1.535000,27.387650> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.602125,-1.535000,27.381197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.621466,-1.535000,27.381197>}
box{<0,0,-0.203200><0.019341,0.035000,0.203200> rotate<0,0.000000,0> translate<30.602125,-1.535000,27.381197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.621209,-1.535000,34.544000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.966659,-1.535000,34.544000>}
box{<0,0,-0.203200><1.345450,0.035000,0.203200> rotate<0,0.000000,0> translate<30.621209,-1.535000,34.544000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.621466,-1.535000,27.381197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.734866,-1.535000,27.334225>}
box{<0,0,-0.203200><0.122743,0.035000,0.203200> rotate<0,22.498540,0> translate<30.621466,-1.535000,27.381197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.622181,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,19.913600>}
box{<0,0,-0.203200><4.658619,0.035000,0.203200> rotate<0,0.000000,0> translate<30.622181,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.635422,-1.535000,34.563559>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.727991,-1.535000,34.745238>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,-62.996062,0> translate<30.635422,-1.535000,34.563559> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.635422,-1.535000,35.921438>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.727991,-1.535000,35.739759>}
box{<0,0,-0.203200><0.203902,0.035000,0.203200> rotate<0,62.996062,0> translate<30.635422,-1.535000,35.921438> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.668750,-1.535000,24.319938>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.873697,-1.535000,24.814722>}
box{<0,0,-0.203200><0.535551,0.035000,0.203200> rotate<0,-67.495498,0> translate<30.668750,-1.535000,24.319938> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.695284,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.956859,-1.535000,24.384000>}
box{<0,0,-0.203200><1.261575,0.035000,0.203200> rotate<0,0.000000,0> translate<30.695284,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.716050,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,35.763200>}
box{<0,0,-0.203200><4.564750,0.035000,0.203200> rotate<0,0.000000,0> translate<30.716050,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.727991,-1.535000,34.745238>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.791000,-1.535000,34.939156>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,-71.994887,0> translate<30.727991,-1.535000,34.745238> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.727991,-1.535000,35.739759>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.791000,-1.535000,35.545841>}
box{<0,0,-0.203200><0.203899,0.035000,0.203200> rotate<0,71.994887,0> translate<30.727991,-1.535000,35.739759> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.734866,-1.535000,27.334225>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.850616,-1.535000,27.293266>}
box{<0,0,-0.203200><0.122783,0.035000,0.203200> rotate<0,19.485584,0> translate<30.734866,-1.535000,27.334225> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.791000,-1.535000,34.939156>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.140547>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,-80.994728,0> translate<30.791000,-1.535000,34.939156> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.791000,-1.535000,35.545841>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.344450>}
box{<0,0,-0.203200><0.203901,0.035000,0.203200> rotate<0,80.994728,0> translate<30.791000,-1.535000,35.545841> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.792778,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.320134,-1.535000,34.950400>}
box{<0,0,-0.203200><1.527356,0.035000,0.203200> rotate<0,0.000000,0> translate<30.792778,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.820944,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,35.356800>}
box{<0,0,-0.203200><4.459856,0.035000,0.203200> rotate<0,0.000000,0> translate<30.820944,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.140547>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.166294>}
box{<0,0,-0.203200><0.025747,0.035000,0.203200> rotate<0,90.000000,0> translate<30.822897,-1.535000,35.166294> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.318700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.822897,-1.535000,35.344450>}
box{<0,0,-0.203200><0.025750,0.035000,0.203200> rotate<0,90.000000,0> translate<30.822897,-1.535000,35.344450> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.850616,-1.535000,27.293266>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.864994,-1.535000,27.280325>}
box{<0,0,-0.203200><0.019344,0.035000,0.203200> rotate<0,41.985129,0> translate<30.850616,-1.535000,27.293266> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.863622,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.505306,-1.535000,24.790400>}
box{<0,0,-0.203200><0.641684,0.035000,0.203200> rotate<0,0.000000,0> translate<30.863622,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.864994,-1.535000,27.280325>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.882859,-1.535000,27.272925>}
box{<0,0,-0.203200><0.019338,0.035000,0.203200> rotate<0,22.498011,0> translate<30.864994,-1.535000,27.280325> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.868031,-1.535000,25.363950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.873697,-1.535000,25.350275>}
box{<0,0,-0.203200><0.014802,0.035000,0.203200> rotate<0,67.491059,0> translate<30.868031,-1.535000,25.363950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.868031,-1.535000,25.363950>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.963997,-1.535000,24.377578>}
box{<0,0,-0.203200><1.474473,0.035000,0.203200> rotate<0,41.984523,0> translate<30.868031,-1.535000,25.363950> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.873697,-1.535000,24.814722>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.873697,-1.535000,25.350275>}
box{<0,0,-0.203200><0.535553,0.035000,0.203200> rotate<0,90.000000,0> translate<30.873697,-1.535000,25.350275> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.873697,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.053750,-1.535000,25.196800>}
box{<0,0,-0.203200><0.180053,0.035000,0.203200> rotate<0,0.000000,0> translate<30.873697,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.882856,-1.535000,19.652925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.882859,-1.535000,19.652925>}
box{<0,0,-0.203200><0.000003,0.035000,0.203200> rotate<0,0.000000,0> translate<30.882856,-1.535000,19.652925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.882859,-1.535000,19.652925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.082925,-1.535000,19.452859>}
box{<0,0,-0.203200><0.282936,0.035000,0.203200> rotate<0,44.997030,0> translate<30.882859,-1.535000,19.652925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.882859,-1.535000,27.272925>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.969647,-1.535000,27.186134>}
box{<0,0,-0.203200><0.122738,0.035000,0.203200> rotate<0,44.998062,0> translate<30.882859,-1.535000,27.272925> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.926984,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,27.228800>}
box{<0,0,-0.203200><4.353816,0.035000,0.203200> rotate<0,0.000000,0> translate<30.926984,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.969647,-1.535000,27.186134>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.419913,-1.535000,24.980897>}
box{<0,0,-0.203200><3.296494,0.035000,0.203200> rotate<0,41.984421,0> translate<30.969647,-1.535000,27.186134> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.028584,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.116934,-1.535000,19.507200>}
box{<0,0,-0.203200><1.088350,0.035000,0.203200> rotate<0,0.000000,0> translate<31.028584,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038797,-1.535000,4.813300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038800,-1.535000,4.858453>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,-89.990095,0> translate<31.038797,-1.535000,4.813300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038797,-1.535000,4.813300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969178,-1.535000,4.813300>}
box{<0,0,-0.203200><1.930381,0.035000,0.203200> rotate<0,0.000000,0> translate<31.038797,-1.535000,4.813300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038800,-1.535000,4.666544>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.068822,-1.535000,4.477000>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<31.038800,-1.535000,4.666544> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038800,-1.535000,4.711694>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038800,-1.535000,4.666544>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.038800,-1.535000,4.666544> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038800,-1.535000,4.711694>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969178,-1.535000,4.711694>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,0.000000,0> translate<31.038800,-1.535000,4.711694> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.038800,-1.535000,4.858453>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.068822,-1.535000,5.047997>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<31.038800,-1.535000,4.858453> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.046438,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.181347,-1.535000,6.583100>}
box{<0,0,-0.203200><0.352535,0.035000,0.203200> rotate<0,67.495543,0> translate<31.046438,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.046438,-1.535000,9.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.181347,-1.535000,9.123100>}
box{<0,0,-0.203200><0.352535,0.035000,0.203200> rotate<0,67.495543,0> translate<31.046438,-1.535000,9.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.068822,-1.535000,4.477000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.128122,-1.535000,4.294487>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<31.068822,-1.535000,4.477000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.068822,-1.535000,5.047997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.128122,-1.535000,5.230509>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<31.068822,-1.535000,5.047997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.082925,-1.535000,19.452859>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,19.191466>}
box{<0,0,-0.203200><0.282930,0.035000,0.203200> rotate<0,67.495725,0> translate<31.082925,-1.535000,19.452859> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.128122,-1.535000,4.294487>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.215247,-1.535000,4.123500>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<31.128122,-1.535000,4.294487> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.128122,-1.535000,5.230509>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.215247,-1.535000,5.401497>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<31.128122,-1.535000,5.230509> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.181347,-1.535000,6.583100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,6.225847>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<31.181347,-1.535000,6.583100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.181347,-1.535000,9.123100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,8.765847>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<31.181347,-1.535000,9.123100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,10.871197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,11.653253>}
box{<0,0,-0.203200><0.782056,0.035000,0.203200> rotate<0,90.000000,0> translate<31.191197,-1.535000,11.653253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,10.871197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.490647,-1.535000,10.871197>}
box{<0,0,-0.203200><0.299450,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,10.871197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.668122,-1.535000,10.972800>}
box{<0,0,-0.203200><0.476925,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.465247,-1.535000,11.379200>}
box{<0,0,-0.203200><0.274050,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,11.653253>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,11.305847>}
box{<0,0,-0.203200><0.491304,0.035000,0.203200> rotate<0,44.997288,0> translate<31.191197,-1.535000,11.653253> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,13.111744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,19.191466>}
box{<0,0,-0.203200><6.079722,0.035000,0.203200> rotate<0,90.000000,0> translate<31.191197,-1.535000,19.191466> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,13.111744>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,13.459150>}
box{<0,0,-0.203200><0.491304,0.035000,0.203200> rotate<0,-44.997288,0> translate<31.191197,-1.535000,13.111744> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.490653,-1.535000,13.411200>}
box{<0,0,-0.203200><0.299456,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.448766,-1.535000,13.817600>}
box{<0,0,-0.203200><1.257569,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.489406,-1.535000,14.224000>}
box{<0,0,-0.203200><1.298209,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.530047,-1.535000,14.630400>}
box{<0,0,-0.203200><1.338850,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.570684,-1.535000,15.036800>}
box{<0,0,-0.203200><1.379487,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.611325,-1.535000,15.443200>}
box{<0,0,-0.203200><1.420128,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.651966,-1.535000,15.849600>}
box{<0,0,-0.203200><1.460769,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.692606,-1.535000,16.256000>}
box{<0,0,-0.203200><1.501409,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.733247,-1.535000,16.662400>}
box{<0,0,-0.203200><1.542050,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.773888,-1.535000,17.068800>}
box{<0,0,-0.203200><1.582691,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.814528,-1.535000,17.475200>}
box{<0,0,-0.203200><1.623331,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.193131,-1.535000,17.881600>}
box{<0,0,-0.203200><1.001934,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.914047,-1.535000,18.288000>}
box{<0,0,-0.203200><0.722850,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,18.694400>}
box{<0,0,-0.203200><0.635003,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.191197,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.882491,-1.535000,19.100800>}
box{<0,0,-0.203200><0.691294,0.035000,0.203200> rotate<0,0.000000,0> translate<31.191197,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.215247,-1.535000,4.123500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.328047,-1.535000,3.968244>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<31.215247,-1.535000,4.123500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.215247,-1.535000,5.401497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.328047,-1.535000,5.556753>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<31.215247,-1.535000,5.401497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.328047,-1.535000,3.968244>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.463744,-1.535000,3.832547>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<31.328047,-1.535000,3.968244> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.328047,-1.535000,5.556753>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.463744,-1.535000,5.692450>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.328047,-1.535000,5.556753> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.373797,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,26.822400>}
box{<0,0,-0.203200><3.907003,0.035000,0.203200> rotate<0,0.000000,0> translate<31.373797,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.463744,-1.535000,3.832547>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.619000,-1.535000,3.719747>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<31.463744,-1.535000,3.832547> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.463744,-1.535000,5.692450>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.619000,-1.535000,5.805250>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<31.463744,-1.535000,5.692450> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.490647,-1.535000,8.331197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,8.379150>}
box{<0,0,-0.203200><0.067816,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.490647,-1.535000,8.331197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.490647,-1.535000,10.871197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,10.919150>}
box{<0,0,-0.203200><0.067816,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.490647,-1.535000,10.871197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,6.225847>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,6.032500>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<31.538600,-1.535000,6.225847> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,8.379150>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,8.572497>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<31.538600,-1.535000,8.379150> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,8.765847>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,8.572500>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<31.538600,-1.535000,8.765847> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,10.919150>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,11.112497>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<31.538600,-1.535000,10.919150> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,11.305847>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,11.112500>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<31.538600,-1.535000,11.305847> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.538600,-1.535000,13.459150>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,13.652497>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<31.538600,-1.535000,13.459150> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.582109,-1.535000,33.731197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,33.853241>}
box{<0,0,-0.203200><0.272901,0.035000,0.203200> rotate<0,-26.563005,0> translate<31.582109,-1.535000,33.731197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.619000,-1.535000,3.719747>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.789988,-1.535000,3.632622>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<31.619000,-1.535000,3.719747> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.619000,-1.535000,5.805250>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.789988,-1.535000,5.892375>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<31.619000,-1.535000,5.805250> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.634584,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.659303,-1.535000,32.300559>}
box{<0,0,-0.203200><0.026056,0.035000,0.203200> rotate<0,18.435905,0> translate<31.634584,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.659303,-1.535000,32.300559>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.775244,-1.535000,32.308800>}
box{<0,0,-0.203200><0.116233,0.035000,0.203200> rotate<0,-4.065264,0> translate<31.659303,-1.535000,32.300559> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.775244,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.891466,-1.535000,32.308800>}
box{<0,0,-0.203200><0.116222,0.035000,0.203200> rotate<0,0.000000,0> translate<31.775244,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.789988,-1.535000,3.632622>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.972500,-1.535000,3.573322>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<31.789988,-1.535000,3.632622> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.789988,-1.535000,5.892375>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.972500,-1.535000,5.951675>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<31.789988,-1.535000,5.892375> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.825353,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,26.416000>}
box{<0,0,-0.203200><3.455447,0.035000,0.203200> rotate<0,0.000000,0> translate<31.825353,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,18.500087>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,18.070653>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<31.826200,-1.535000,18.500087> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,18.964909>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,18.500087>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.826200,-1.535000,18.500087> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,18.964909>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,19.394344>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<31.826200,-1.535000,18.964909> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,23.580088>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,23.150653>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,67.495479,0> translate<31.826200,-1.535000,23.580088> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,24.044909>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,23.580088>}
box{<0,0,-0.203200><0.464822,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.826200,-1.535000,23.580088> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,24.044909>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.963997,-1.535000,24.377578>}
box{<0,0,-0.203200><0.360078,0.035000,0.203200> rotate<0,-67.495403,0> translate<31.826200,-1.535000,24.044909> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,34.204909>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,33.853241>}
box{<0,0,-0.203200><0.351669,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.826200,-1.535000,33.853241> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.826200,-1.535000,34.204909>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,34.634344>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-67.495479,0> translate<31.826200,-1.535000,34.204909> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.804541>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.904519,-1.535000,28.630794>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,80.994671,0> translate<31.877000,-1.535000,28.804541> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.892481>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.804541>}
box{<0,0,-0.203200><0.087941,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.877000,-1.535000,28.804541> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.892481>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654966,-1.535000,28.892481>}
box{<0,0,-0.203200><1.777966,0.035000,0.203200> rotate<0,0.000000,0> translate<31.877000,-1.535000,28.892481> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.892513>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654966,-1.535000,28.892513>}
box{<0,0,-0.203200><1.777966,0.035000,0.203200> rotate<0,0.000000,0> translate<31.877000,-1.535000,28.892513> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.980456>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.892513>}
box{<0,0,-0.203200><0.087944,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.877000,-1.535000,28.892513> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.877000,-1.535000,28.980456>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.904519,-1.535000,29.154203>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-80.994671,0> translate<31.877000,-1.535000,28.980456> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.891466,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.915538,-1.535000,32.318772>}
box{<0,0,-0.203200><0.026056,0.035000,0.203200> rotate<0,-22.500502,0> translate<31.891466,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.904519,-1.535000,28.630794>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.958878,-1.535000,28.463488>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,71.995781,0> translate<31.904519,-1.535000,28.630794> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.904519,-1.535000,29.154203>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.958878,-1.535000,29.321509>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,-71.995781,0> translate<31.904519,-1.535000,29.154203> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.915538,-1.535000,32.318772>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.941525,-1.535000,32.320619>}
box{<0,0,-0.203200><0.026053,0.035000,0.203200> rotate<0,-4.064783,0> translate<31.915538,-1.535000,32.318772> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.941525,-1.535000,32.320619>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.045456,-1.535000,32.372584>}
box{<0,0,-0.203200><0.116199,0.035000,0.203200> rotate<0,-26.563298,0> translate<31.941525,-1.535000,32.320619> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.958878,-1.535000,28.463488>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.038744,-1.535000,28.306750>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,62.994716,0> translate<31.958878,-1.535000,28.463488> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.958878,-1.535000,29.321509>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.038744,-1.535000,29.478247>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,-62.994716,0> translate<31.958878,-1.535000,29.321509> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.972500,-1.535000,3.573322>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.162044,-1.535000,3.543300>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<31.972500,-1.535000,3.573322> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.972500,-1.535000,5.951675>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.162044,-1.535000,5.981697>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<31.972500,-1.535000,5.951675> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,18.070653>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,17.741978>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<32.004078,-1.535000,18.070653> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,19.394344>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,19.723019>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.004078,-1.535000,19.394344> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,23.150653>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,22.821978>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,44.997030,0> translate<32.004078,-1.535000,23.150653> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.004078,-1.535000,34.634344>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,34.963019>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.004078,-1.535000,34.634344> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,6.032500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,6.032500>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,0.000000,0> translate<32.005378,-1.535000,6.032500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,8.572497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,8.572497>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,0.000000,0> translate<32.005378,-1.535000,8.572497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,8.572500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,8.572500>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,0.000000,0> translate<32.005378,-1.535000,8.572500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,11.112497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,11.112497>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,0.000000,0> translate<32.005378,-1.535000,11.112497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,11.112500>}
box{<0,0,-0.203200><2.029241,0.035000,0.203200> rotate<0,0.000000,0> translate<32.005378,-1.535000,11.112500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.005378,-1.535000,13.652497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.432253,-1.535000,13.652497>}
box{<0,0,-0.203200><0.426875,0.035000,0.203200> rotate<0,0.000000,0> translate<32.005378,-1.535000,13.652497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.038744,-1.535000,28.306750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.142141,-1.535000,28.164431>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,53.997424,0> translate<32.038744,-1.535000,28.306750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.038744,-1.535000,29.478247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.142141,-1.535000,29.620566>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-53.997424,0> translate<32.038744,-1.535000,29.478247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.045456,-1.535000,32.372584>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.152859,-1.535000,32.417072>}
box{<0,0,-0.203200><0.116252,0.035000,0.203200> rotate<0,-22.498364,0> translate<32.045456,-1.535000,32.372584> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.142141,-1.535000,28.164431>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.266531,-1.535000,28.040041>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,44.997030,0> translate<32.142141,-1.535000,28.164431> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.142141,-1.535000,29.620566>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.266531,-1.535000,29.744956>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.142141,-1.535000,29.620566> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.152859,-1.535000,32.417072>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.171287,-1.535000,32.435500>}
box{<0,0,-0.203200><0.026061,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.152859,-1.535000,32.417072> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.162044,-1.535000,3.543300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,3.543297>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,0.000222,0> translate<32.162044,-1.535000,3.543300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.162044,-1.535000,5.981697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,5.981697>}
box{<0,0,-0.203200><0.807150,0.035000,0.203200> rotate<0,0.000000,0> translate<32.162044,-1.535000,5.981697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.171287,-1.535000,32.435500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.908487,-1.535000,32.804100>}
box{<0,0,-0.203200><0.824215,0.035000,0.203200> rotate<0,-26.563298,0> translate<32.171287,-1.535000,32.435500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.266531,-1.535000,28.040041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.408850,-1.535000,27.936644>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,35.996636,0> translate<32.266531,-1.535000,28.040041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.266531,-1.535000,29.744956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.408850,-1.535000,29.848353>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-35.996636,0> translate<32.266531,-1.535000,29.744956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.276909,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,26.009600>}
box{<0,0,-0.203200><3.003891,0.035000,0.203200> rotate<0,0.000000,0> translate<32.276909,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324288,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,32.512000>}
box{<0,0,-0.203200><2.956512,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324288,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,17.741978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,17.564100>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<32.332753,-1.535000,17.741978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,19.723019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,19.900897>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<32.332753,-1.535000,19.723019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,22.821978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,22.644100>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<32.332753,-1.535000,22.821978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.332753,-1.535000,34.963019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,35.140897>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<32.332753,-1.535000,34.963019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.408850,-1.535000,27.936644>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.565587,-1.535000,27.856778>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,26.999344,0> translate<32.408850,-1.535000,27.936644> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.408850,-1.535000,29.848353>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.565587,-1.535000,29.928219>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,-26.999344,0> translate<32.408850,-1.535000,29.848353> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.432253,-1.535000,13.652497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.823416,-1.535000,17.564100>}
box{<0,0,-0.203200><3.931113,0.035000,0.203200> rotate<0,-84.283812,0> translate<32.432253,-1.535000,13.652497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.565587,-1.535000,27.856778>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.732894,-1.535000,27.802419>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,17.998279,0> translate<32.565587,-1.535000,27.856778> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.565587,-1.535000,29.928219>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.732894,-1.535000,29.982578>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,-17.998279,0> translate<32.565587,-1.535000,29.928219> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.728466,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,25.603200>}
box{<0,0,-0.203200><2.552334,0.035000,0.203200> rotate<0,0.000000,0> translate<32.728466,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.732894,-1.535000,27.802419>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.906641,-1.535000,27.774900>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,8.999389,0> translate<32.732894,-1.535000,27.802419> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.732894,-1.535000,29.982578>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.906641,-1.535000,30.010097>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-8.999389,0> translate<32.732894,-1.535000,29.982578> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,17.564100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.823416,-1.535000,17.564100>}
box{<0,0,-0.203200><0.061228,0.035000,0.203200> rotate<0,0.000000,0> translate<32.762188,-1.535000,17.564100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,19.900897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,19.900897>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<32.762188,-1.535000,19.900897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,22.644100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,22.644100>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<32.762188,-1.535000,22.644100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.762188,-1.535000,35.140897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,35.140897>}
box{<0,0,-0.203200><1.785622,0.035000,0.203200> rotate<0,0.000000,0> translate<32.762188,-1.535000,35.140897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.906641,-1.535000,27.774900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,27.774900>}
box{<0,0,-0.203200><0.748341,0.035000,0.203200> rotate<0,0.000000,0> translate<32.906641,-1.535000,27.774900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.906641,-1.535000,30.010097>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,30.010097>}
box{<0,0,-0.203200><0.748341,0.035000,0.203200> rotate<0,0.000000,0> translate<32.906641,-1.535000,30.010097> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.908487,-1.535000,32.804100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,32.804100>}
box{<0,0,-0.203200><1.639322,0.035000,0.203200> rotate<0,0.000000,0> translate<32.908487,-1.535000,32.804100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969178,-1.535000,4.813300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969178,-1.535000,4.711694>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,-90.000000,0> translate<32.969178,-1.535000,4.711694> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,3.543297>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.711678>}
box{<0,0,-0.203200><1.168381,0.035000,0.203200> rotate<0,90.000000,0> translate<32.969194,-1.535000,4.711678> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,3.657600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.064000>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.470400>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.711678>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.711678>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,4.711678> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.813319>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,5.981697>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,90.000000,0> translate<32.969194,-1.535000,5.981697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.813319>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.813319>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,4.813319> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.876800>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,5.283200>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.969194,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,5.689600>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,0.000000,0> translate<32.969194,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,3.543300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.877953,-1.535000,3.543300>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,0.000000,0> translate<33.070800,-1.535000,3.543300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.711678>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,3.543300>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.070800,-1.535000,3.543300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,5.981697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,4.813319>}
box{<0,0,-0.203200><1.168378,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.070800,-1.535000,4.813319> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070800,-1.535000,5.981697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.877953,-1.535000,5.981697>}
box{<0,0,-0.203200><0.807153,0.035000,0.203200> rotate<0,0.000000,0> translate<33.070800,-1.535000,5.981697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070819,-1.535000,4.711694>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070819,-1.535000,4.813300>}
box{<0,0,-0.203200><0.101606,0.035000,0.203200> rotate<0,90.000000,0> translate<33.070819,-1.535000,4.813300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070819,-1.535000,4.711694>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.711694>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,0.000000,0> translate<33.070819,-1.535000,4.711694> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.070819,-1.535000,4.813300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.813300>}
box{<0,0,-0.203200><1.930378,0.035000,0.203200> rotate<0,0.000000,0> translate<33.070819,-1.535000,4.813300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.180022,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,25.196800>}
box{<0,0,-0.203200><2.100778,0.035000,0.203200> rotate<0,0.000000,0> translate<33.180022,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.419913,-1.535000,24.980897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,24.980897>}
box{<0,0,-0.203200><1.127897,0.035000,0.203200> rotate<0,0.000000,0> translate<33.419913,-1.535000,24.980897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654966,-1.535000,28.892513>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654966,-1.535000,28.892481>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.654966,-1.535000,28.892481> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,27.774900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.892466>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,90.000000,0> translate<33.654981,-1.535000,28.892466> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.041600>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.448000>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.854400>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.892466>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.892466>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,28.892466> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.892531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,30.010097>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,90.000000,0> translate<33.654981,-1.535000,30.010097> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,28.892531>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.892531>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,28.892531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,29.260800>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.654981,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,29.667200>}
box{<0,0,-0.203200><0.000031,0.035000,0.203200> rotate<0,0.000000,0> translate<33.654981,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,27.774900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.403356,-1.535000,27.774900>}
box{<0,0,-0.203200><0.748344,0.035000,0.203200> rotate<0,0.000000,0> translate<33.655013,-1.535000,27.774900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.892466>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,27.774900>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.655013,-1.535000,27.774900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,30.010097>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,28.892531>}
box{<0,0,-0.203200><1.117566,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.655013,-1.535000,28.892531> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.655013,-1.535000,30.010097>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.403356,-1.535000,30.010097>}
box{<0,0,-0.203200><0.748344,0.035000,0.203200> rotate<0,0.000000,0> translate<33.655013,-1.535000,30.010097> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.861744,-1.535000,13.652497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,13.652497>}
box{<0,0,-0.203200><0.172875,0.035000,0.203200> rotate<0,0.000000,0> translate<33.861744,-1.535000,13.652497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.861744,-1.535000,13.652497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.252903,-1.535000,17.564100>}
box{<0,0,-0.203200><3.931112,0.035000,0.203200> rotate<0,-84.283858,0> translate<33.861744,-1.535000,13.652497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.877953,-1.535000,3.543300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.067497,-1.535000,3.573322>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-8.999729,0> translate<33.877953,-1.535000,3.543300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.877953,-1.535000,5.981697>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.067497,-1.535000,5.951675>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,8.999729,0> translate<33.877953,-1.535000,5.981697> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.878253,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,13.817600>}
box{<0,0,-0.203200><1.402547,0.035000,0.203200> rotate<0,0.000000,0> translate<33.878253,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.918894,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,14.224000>}
box{<0,0,-0.203200><1.361906,0.035000,0.203200> rotate<0,0.000000,0> translate<33.918894,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.959531,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,14.630400>}
box{<0,0,-0.203200><1.321269,0.035000,0.203200> rotate<0,0.000000,0> translate<33.959531,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.000172,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,15.036800>}
box{<0,0,-0.203200><1.280628,0.035000,0.203200> rotate<0,0.000000,0> translate<34.000172,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,6.032500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,6.225847>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<34.034619,-1.535000,6.032500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,8.572497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,8.379150>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<34.034619,-1.535000,8.572497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,8.572500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,8.765847>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<34.034619,-1.535000,8.572500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,11.112497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,10.919150>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<34.034619,-1.535000,11.112497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,11.305847>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-22.498625,0> translate<34.034619,-1.535000,11.112500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.034619,-1.535000,13.652497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,13.459150>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,22.498625,0> translate<34.034619,-1.535000,13.652497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.040813,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,15.443200>}
box{<0,0,-0.203200><1.239987,0.035000,0.203200> rotate<0,0.000000,0> translate<34.040813,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.067497,-1.535000,3.573322>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.250009,-1.535000,3.632622>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-17.998271,0> translate<34.067497,-1.535000,3.573322> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.067497,-1.535000,5.951675>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.250009,-1.535000,5.892375>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,17.998271,0> translate<34.067497,-1.535000,5.951675> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.081453,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,15.849600>}
box{<0,0,-0.203200><1.199347,0.035000,0.203200> rotate<0,0.000000,0> translate<34.081453,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.122091,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,16.256000>}
box{<0,0,-0.203200><1.158709,0.035000,0.203200> rotate<0,0.000000,0> translate<34.122091,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.126594,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,8.534400>}
box{<0,0,-0.203200><1.154206,0.035000,0.203200> rotate<0,0.000000,0> translate<34.126594,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.162731,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,16.662400>}
box{<0,0,-0.203200><1.118069,0.035000,0.203200> rotate<0,0.000000,0> translate<34.162731,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.187919,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,6.096000>}
box{<0,0,-0.203200><1.092881,0.035000,0.203200> rotate<0,0.000000,0> translate<34.187919,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.203372,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,17.068800>}
box{<0,0,-0.203200><1.077428,0.035000,0.203200> rotate<0,0.000000,0> translate<34.203372,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.244013,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,17.475200>}
box{<0,0,-0.203200><1.036787,0.035000,0.203200> rotate<0,0.000000,0> translate<34.244013,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.250009,-1.535000,3.632622>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.420997,-1.535000,3.719747>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-26.998888,0> translate<34.250009,-1.535000,3.632622> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.250009,-1.535000,5.892375>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.420997,-1.535000,5.805250>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,26.998888,0> translate<34.250009,-1.535000,5.892375> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.252903,-1.535000,17.564100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,17.564100>}
box{<0,0,-0.203200><0.294906,0.035000,0.203200> rotate<0,0.000000,0> translate<34.252903,-1.535000,17.564100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.299028,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,3.657600>}
box{<0,0,-0.203200><0.981772,0.035000,0.203200> rotate<0,0.000000,0> translate<34.299028,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.371878,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,10.972800>}
box{<0,0,-0.203200><0.908922,0.035000,0.203200> rotate<0,0.000000,0> translate<34.371878,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.403356,-1.535000,27.774900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.577103,-1.535000,27.802419>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-8.999389,0> translate<34.403356,-1.535000,27.774900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.403356,-1.535000,30.010097>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.577103,-1.535000,29.982578>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,8.999389,0> translate<34.403356,-1.535000,30.010097> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.420997,-1.535000,3.719747>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.576253,-1.535000,3.832547>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-35.997559,0> translate<34.420997,-1.535000,3.719747> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.420997,-1.535000,5.805250>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.576253,-1.535000,5.692450>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,35.997559,0> translate<34.420997,-1.535000,5.805250> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,6.225847>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,6.583100>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.501397,-1.535000,6.225847> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,8.379150>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,8.021897>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<34.501397,-1.535000,8.379150> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,8.765847>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,9.123100>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.501397,-1.535000,8.765847> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,10.919150>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,10.561897>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<34.501397,-1.535000,10.919150> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,11.305847>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,11.663100>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.501397,-1.535000,11.305847> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501397,-1.535000,13.459150>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,13.101897>}
box{<0,0,-0.203200><0.505232,0.035000,0.203200> rotate<0,44.997030,0> translate<34.501397,-1.535000,13.459150> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,17.564100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,17.741978>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<34.547809,-1.535000,17.564100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,19.900897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,19.723019>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<34.547809,-1.535000,19.900897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,22.644100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,22.821978>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<34.547809,-1.535000,22.644100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,24.980897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,24.803019>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<34.547809,-1.535000,24.980897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,32.804100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,32.981978>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,-22.498581,0> translate<34.547809,-1.535000,32.804100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.547809,-1.535000,35.140897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,34.963019>}
box{<0,0,-0.203200><0.464817,0.035000,0.203200> rotate<0,22.498581,0> translate<34.547809,-1.535000,35.140897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.549347,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,13.411200>}
box{<0,0,-0.203200><0.731453,0.035000,0.203200> rotate<0,0.000000,0> translate<34.549347,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.574750,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,11.379200>}
box{<0,0,-0.203200><0.706050,0.035000,0.203200> rotate<0,0.000000,0> translate<34.574750,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.576253,-1.535000,3.832547>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.711950,-1.535000,3.968244>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.576253,-1.535000,3.832547> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.576253,-1.535000,5.692450>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.711950,-1.535000,5.556753>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,44.997030,0> translate<34.576253,-1.535000,5.692450> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.577103,-1.535000,27.802419>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.744409,-1.535000,27.856778>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,-17.998279,0> translate<34.577103,-1.535000,27.802419> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.577103,-1.535000,29.982578>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.744409,-1.535000,29.928219>}
box{<0,0,-0.203200><0.175916,0.035000,0.203200> rotate<0,17.998279,0> translate<34.577103,-1.535000,29.982578> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.579103,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,5.689600>}
box{<0,0,-0.203200><0.701697,0.035000,0.203200> rotate<0,0.000000,0> translate<34.579103,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.676350,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,8.940800>}
box{<0,0,-0.203200><0.604450,0.035000,0.203200> rotate<0,0.000000,0> translate<34.676350,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.711950,-1.535000,3.968244>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.824750,-1.535000,4.123500>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-53.996501,0> translate<34.711950,-1.535000,3.968244> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.711950,-1.535000,5.556753>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.824750,-1.535000,5.401497>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,53.996501,0> translate<34.711950,-1.535000,5.556753> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.744409,-1.535000,27.856778>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.901147,-1.535000,27.936644>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,-26.999344,0> translate<34.744409,-1.535000,27.856778> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.744409,-1.535000,29.928219>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.901147,-1.535000,29.848353>}
box{<0,0,-0.203200><0.175912,0.035000,0.203200> rotate<0,26.999344,0> translate<34.744409,-1.535000,29.928219> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.752547,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,8.128000>}
box{<0,0,-0.203200><0.528253,0.035000,0.203200> rotate<0,0.000000,0> translate<34.752547,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.777950,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,6.502400>}
box{<0,0,-0.203200><0.502850,0.035000,0.203200> rotate<0,0.000000,0> translate<34.777950,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.781519,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,4.064000>}
box{<0,0,-0.203200><0.499281,0.035000,0.203200> rotate<0,0.000000,0> translate<34.781519,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823750,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,22.758400>}
box{<0,0,-0.203200><0.457050,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823750,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823750,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,32.918400>}
box{<0,0,-0.203200><0.457050,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823750,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.824750,-1.535000,4.123500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.911875,-1.535000,4.294487>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,-62.995173,0> translate<34.824750,-1.535000,4.123500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.824750,-1.535000,5.401497>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.911875,-1.535000,5.230509>}
box{<0,0,-0.203200><0.191905,0.035000,0.203200> rotate<0,62.995173,0> translate<34.824750,-1.535000,5.401497> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.854147,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,10.566400>}
box{<0,0,-0.203200><0.426653,0.035000,0.203200> rotate<0,0.000000,0> translate<34.854147,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,6.583100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,7.049878>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<34.858650,-1.535000,6.583100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,8.021897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,7.555119>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<34.858650,-1.535000,8.021897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,9.123100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,9.589878>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<34.858650,-1.535000,9.123100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,10.561897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,10.095119>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<34.858650,-1.535000,10.561897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,11.663100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,12.129878>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,-67.495436,0> translate<34.858650,-1.535000,11.663100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.858650,-1.535000,13.101897>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,12.635119>}
box{<0,0,-0.203200><0.505237,0.035000,0.203200> rotate<0,67.495436,0> translate<34.858650,-1.535000,13.101897> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.885028,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,5.283200>}
box{<0,0,-0.203200><0.395772,0.035000,0.203200> rotate<0,0.000000,0> translate<34.885028,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.898872,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,13.004800>}
box{<0,0,-0.203200><0.381928,0.035000,0.203200> rotate<0,0.000000,0> translate<34.898872,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.901147,-1.535000,27.936644>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.043466,-1.535000,28.040041>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-35.996636,0> translate<34.901147,-1.535000,27.936644> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.901147,-1.535000,29.848353>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.043466,-1.535000,29.744956>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,35.996636,0> translate<34.901147,-1.535000,29.848353> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.909391,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,11.785600>}
box{<0,0,-0.203200><0.371409,0.035000,0.203200> rotate<0,0.000000,0> translate<34.909391,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.911875,-1.535000,4.294487>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.971175,-1.535000,4.477000>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,-71.995789,0> translate<34.911875,-1.535000,4.294487> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.911875,-1.535000,5.230509>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.971175,-1.535000,5.047997>}
box{<0,0,-0.203200><0.191904,0.035000,0.203200> rotate<0,71.995789,0> translate<34.911875,-1.535000,5.230509> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.951475,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,9.347200>}
box{<0,0,-0.203200><0.329325,0.035000,0.203200> rotate<0,0.000000,0> translate<34.951475,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.969028,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,4.470400>}
box{<0,0,-0.203200><0.311772,0.035000,0.203200> rotate<0,0.000000,0> translate<34.969028,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.971175,-1.535000,4.477000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.666544>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,-80.994332,0> translate<34.971175,-1.535000,4.477000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.971175,-1.535000,5.047997>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.858453>}
box{<0,0,-0.203200><0.191907,0.035000,0.203200> rotate<0,80.994332,0> translate<34.971175,-1.535000,5.047997> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,17.741978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,18.045538>}
box{<0,0,-0.203200><0.429296,0.035000,0.203200> rotate<0,-44.997325,0> translate<34.977244,-1.535000,17.741978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,19.723019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,19.419459>}
box{<0,0,-0.203200><0.429296,0.035000,0.203200> rotate<0,44.997325,0> translate<34.977244,-1.535000,19.723019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,22.821978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,23.125538>}
box{<0,0,-0.203200><0.429296,0.035000,0.203200> rotate<0,-44.997325,0> translate<34.977244,-1.535000,22.821978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,24.803019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,24.499459>}
box{<0,0,-0.203200><0.429296,0.035000,0.203200> rotate<0,44.997325,0> translate<34.977244,-1.535000,24.803019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,32.981978>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,33.285538>}
box{<0,0,-0.203200><0.429296,0.035000,0.203200> rotate<0,-44.997325,0> translate<34.977244,-1.535000,32.981978> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.977244,-1.535000,34.963019>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,34.659459>}
box{<0,0,-0.203200><0.429296,0.035000,0.203200> rotate<0,44.997325,0> translate<34.977244,-1.535000,34.963019> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.983041,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,7.721600>}
box{<0,0,-0.203200><0.297759,0.035000,0.203200> rotate<0,0.000000,0> translate<34.983041,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.989863,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,24.790400>}
box{<0,0,-0.203200><0.290937,0.035000,0.203200> rotate<0,0.000000,0> translate<34.989863,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.989863,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,34.950400>}
box{<0,0,-0.203200><0.290937,0.035000,0.203200> rotate<0,0.000000,0> translate<34.989863,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.993559,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,6.908800>}
box{<0,0,-0.203200><0.287241,0.035000,0.203200> rotate<0,0.000000,0> translate<34.993559,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.998294,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,4.876800>}
box{<0,0,-0.203200><0.282506,0.035000,0.203200> rotate<0,0.000000,0> translate<34.998294,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.666544>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.711694>}
box{<0,0,-0.203200><0.045150,0.035000,0.203200> rotate<0,90.000000,0> translate<35.001197,-1.535000,4.711694> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.813300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.001197,-1.535000,4.858453>}
box{<0,0,-0.203200><0.045153,0.035000,0.203200> rotate<0,90.000000,0> translate<35.001197,-1.535000,4.858453> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.025125,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,10.160000>}
box{<0,0,-0.203200><0.255675,0.035000,0.203200> rotate<0,0.000000,0> translate<35.025125,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.043466,-1.535000,28.040041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.167856,-1.535000,28.164431>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.043466,-1.535000,28.040041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.043466,-1.535000,29.744956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.167856,-1.535000,29.620566>}
box{<0,0,-0.203200><0.175915,0.035000,0.203200> rotate<0,44.997030,0> translate<35.043466,-1.535000,29.744956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.045025,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,28.041600>}
box{<0,0,-0.203200><0.235775,0.035000,0.203200> rotate<0,0.000000,0> translate<35.045025,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,7.049878>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,7.555119>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,90.000000,0> translate<35.051997,-1.535000,7.555119> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,7.315200>}
box{<0,0,-0.203200><0.228803,0.035000,0.203200> rotate<0,0.000000,0> translate<35.051997,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,9.589878>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,10.095119>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,90.000000,0> translate<35.051997,-1.535000,10.095119> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,9.753600>}
box{<0,0,-0.203200><0.228803,0.035000,0.203200> rotate<0,0.000000,0> translate<35.051997,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,12.129878>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,12.635119>}
box{<0,0,-0.203200><0.505241,0.035000,0.203200> rotate<0,90.000000,0> translate<35.051997,-1.535000,12.635119> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,12.192000>}
box{<0,0,-0.203200><0.228803,0.035000,0.203200> rotate<0,0.000000,0> translate<35.051997,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.051997,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,12.598400>}
box{<0,0,-0.203200><0.228803,0.035000,0.203200> rotate<0,0.000000,0> translate<35.051997,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.116863,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,17.881600>}
box{<0,0,-0.203200><0.163937,0.035000,0.203200> rotate<0,0.000000,0> translate<35.116863,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.121222,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,29.667200>}
box{<0,0,-0.203200><0.159578,0.035000,0.203200> rotate<0,0.000000,0> translate<35.121222,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.167856,-1.535000,28.164431>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.271253,-1.535000,28.306750>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,-53.997424,0> translate<35.167856,-1.535000,28.164431> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.167856,-1.535000,29.620566>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.271253,-1.535000,29.478247>}
box{<0,0,-0.203200><0.175913,0.035000,0.203200> rotate<0,53.997424,0> translate<35.167856,-1.535000,29.620566> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.193063,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,19.507200>}
box{<0,0,-0.203200><0.087737,0.035000,0.203200> rotate<0,0.000000,0> translate<35.193063,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.271253,-1.535000,28.306750>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,28.325494>}
box{<0,0,-0.203200><0.021035,0.035000,0.203200> rotate<0,-63.004440,0> translate<35.271253,-1.535000,28.306750> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.271253,-1.535000,29.478247>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,29.459503>}
box{<0,0,-0.203200><0.021035,0.035000,0.203200> rotate<0,63.004440,0> translate<35.271253,-1.535000,29.478247> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,18.045538>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,1.219197>}
box{<0,0,-0.203200><16.826341,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.280800,-1.535000,1.219197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,23.125538>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,19.419459>}
box{<0,0,-0.203200><3.706078,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.280800,-1.535000,19.419459> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,28.325494>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,24.499459>}
box{<0,0,-0.203200><3.826034,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.280800,-1.535000,24.499459> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,33.285538>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,29.459503>}
box{<0,0,-0.203200><3.826034,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.280800,-1.535000,29.459503> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,36.870800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.280800,-1.535000,34.659459>}
box{<0,0,-0.203200><2.211341,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.280800,-1.535000,34.659459> }
texture{col_pol}
}
#end
union{
cylinder{<10.160000,0.038000,33.020000><10.160000,-1.538000,33.020000>0.406400}
cylinder{<10.160000,0.038000,30.480000><10.160000,-1.538000,30.480000>0.406400}
cylinder{<22.860000,0.038000,33.020000><22.860000,-1.538000,33.020000>0.406400}
cylinder{<22.860000,0.038000,35.560000><22.860000,-1.538000,35.560000>0.406400}
cylinder{<8.572500,0.038000,35.242500><8.572500,-1.538000,35.242500>0.558800}
cylinder{<18.732500,0.038000,35.242500><18.732500,-1.538000,35.242500>0.558800}
cylinder{<29.527500,0.038000,25.082500><29.527500,-1.538000,25.082500>0.558800}
cylinder{<29.527500,0.038000,35.242500><29.527500,-1.538000,35.242500>0.558800}
cylinder{<3.810000,0.038000,34.290000><3.810000,-1.538000,34.290000>0.558800}
cylinder{<3.810000,0.038000,29.210000><3.810000,-1.538000,29.210000>0.558800}
cylinder{<26.670000,0.038000,10.160000><26.670000,-1.538000,10.160000>0.406400}
cylinder{<26.670000,0.038000,12.700000><26.670000,-1.538000,12.700000>0.406400}
cylinder{<26.670000,0.038000,15.240000><26.670000,-1.538000,15.240000>0.406400}
cylinder{<26.670000,0.038000,17.780000><26.670000,-1.538000,17.780000>0.406400}
cylinder{<26.670000,0.038000,20.320000><26.670000,-1.538000,20.320000>0.406400}
cylinder{<26.670000,0.038000,22.860000><26.670000,-1.538000,22.860000>0.406400}
cylinder{<26.670000,0.038000,25.400000><26.670000,-1.538000,25.400000>0.406400}
cylinder{<19.050000,0.038000,25.400000><19.050000,-1.538000,25.400000>0.406400}
cylinder{<19.050000,0.038000,22.860000><19.050000,-1.538000,22.860000>0.406400}
cylinder{<19.050000,0.038000,20.320000><19.050000,-1.538000,20.320000>0.406400}
cylinder{<19.050000,0.038000,17.780000><19.050000,-1.538000,17.780000>0.406400}
cylinder{<19.050000,0.038000,15.240000><19.050000,-1.538000,15.240000>0.406400}
cylinder{<19.050000,0.038000,12.700000><19.050000,-1.538000,12.700000>0.406400}
cylinder{<19.050000,0.038000,10.160000><19.050000,-1.538000,10.160000>0.406400}
cylinder{<16.510000,0.038000,30.480000><16.510000,-1.538000,30.480000>0.406400}
cylinder{<14.605000,0.038000,31.750000><14.605000,-1.538000,31.750000>0.406400}
cylinder{<16.510000,0.038000,33.020000><16.510000,-1.538000,33.020000>0.406400}
cylinder{<5.080000,0.038000,3.810000><5.080000,-1.538000,3.810000>0.508000}
cylinder{<2.540000,0.038000,3.810000><2.540000,-1.538000,3.810000>0.508000}
cylinder{<2.540000,0.038000,10.160000><2.540000,-1.538000,10.160000>0.508000}
cylinder{<5.080000,0.038000,10.160000><5.080000,-1.538000,10.160000>0.508000}
cylinder{<5.080000,0.038000,15.875000><5.080000,-1.538000,15.875000>0.508000}
cylinder{<2.540000,0.038000,15.875000><2.540000,-1.538000,15.875000>0.508000}
cylinder{<5.080000,0.038000,19.685000><5.080000,-1.538000,19.685000>0.508000}
cylinder{<2.540000,0.038000,19.685000><2.540000,-1.538000,19.685000>0.508000}
cylinder{<5.080000,0.038000,23.495000><5.080000,-1.538000,23.495000>0.508000}
cylinder{<2.540000,0.038000,23.495000><2.540000,-1.538000,23.495000>0.508000}
cylinder{<33.020000,0.038000,4.762500><33.020000,-1.538000,4.762500>0.508000}
cylinder{<33.020000,0.038000,7.302500><33.020000,-1.538000,7.302500>0.508000}
cylinder{<33.020000,0.038000,9.842500><33.020000,-1.538000,9.842500>0.508000}
cylinder{<33.020000,0.038000,12.382500><33.020000,-1.538000,12.382500>0.508000}
cylinder{<12.382500,0.038000,5.080000><12.382500,-1.538000,5.080000>0.508000}
cylinder{<14.922500,0.038000,5.080000><14.922500,-1.538000,5.080000>0.508000}
cylinder{<17.462500,0.038000,5.080000><17.462500,-1.538000,5.080000>0.508000}
cylinder{<20.002500,0.038000,5.080000><20.002500,-1.538000,5.080000>0.508000}
cylinder{<22.542500,0.038000,5.080000><22.542500,-1.538000,5.080000>0.508000}
cylinder{<25.082500,0.038000,5.080000><25.082500,-1.538000,5.080000>0.508000}
cylinder{<33.655000,0.038000,33.972500><33.655000,-1.538000,33.972500>0.406400}
cylinder{<33.655000,0.038000,28.892500><33.655000,-1.538000,28.892500>0.406400}
cylinder{<33.655000,0.038000,23.812500><33.655000,-1.538000,23.812500>0.406400}
cylinder{<33.655000,0.038000,18.732500><33.655000,-1.538000,18.732500>0.406400}
cylinder{<25.717500,0.038000,27.940000><25.717500,-1.538000,27.940000>0.406400}
cylinder{<18.097500,0.038000,27.940000><18.097500,-1.538000,27.940000>0.406400}
cylinder{<7.620000,0.038000,2.857500><7.620000,-1.538000,2.857500>0.406400}
cylinder{<7.620000,0.038000,10.477500><7.620000,-1.538000,10.477500>0.406400}
cylinder{<16.510000,0.038000,13.970000><16.510000,-1.538000,13.970000>0.406400}
cylinder{<8.890000,0.038000,13.970000><8.890000,-1.538000,13.970000>0.406400}
cylinder{<8.890000,0.038000,17.780000><8.890000,-1.538000,17.780000>0.406400}
cylinder{<16.510000,0.038000,17.780000><16.510000,-1.538000,17.780000>0.406400}
cylinder{<8.890000,0.038000,22.225000><8.890000,-1.538000,22.225000>0.406400}
cylinder{<16.510000,0.038000,22.225000><16.510000,-1.538000,22.225000>0.406400}
cylinder{<8.890000,0.038000,26.035000><8.890000,-1.538000,26.035000>0.406400}
cylinder{<16.510000,0.038000,26.035000><16.510000,-1.538000,26.035000>0.406400}
//Bohrungen(schnell)/Durchkontaktierungen
//Bohrungen(schnell)/Platine
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Bestückungsdruck
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,33.147000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.430000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.176000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,33.147000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.176000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,32.893000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.430000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,33.147000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.430000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,32.512000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,32.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,32.512000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,32.512000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,32.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,32.512000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,32.004000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.890000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,32.004000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,32.512000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.430000,0.000000,32.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.430000,0.000000,32.512000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,32.512000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.160000,0.000000,32.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,30.099000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,30.099000> }
difference{
cylinder{<10.160000,0,31.750000><10.160000,0.036000,31.750000>2.616200 translate<0,0.000000,0>}
cylinder{<10.160000,-0.1,31.750000><10.160000,0.135000,31.750000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<10.160000,0.000000,31.242000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,32.639000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,32.893000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,32.893000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,33.147000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<21.590000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.336000,0.000000,32.893000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.336000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,32.639000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,33.528000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.860000,0.000000,33.528000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,33.528000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,33.528000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.860000,0.000000,33.528000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,33.528000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,34.036000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.130000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,34.036000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,34.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,34.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,33.528000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.590000,0.000000,33.528000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,33.528000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,33.528000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,33.528000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,35.941000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.860000,0.000000,35.941000> }
difference{
cylinder{<22.860000,0,34.290000><22.860000,0.036000,34.290000>2.616200 translate<0,0.000000,0>}
cylinder{<22.860000,-0.1,34.290000><22.860000,0.135000,34.290000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<22.860000,0.000000,34.798000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.620500,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.684500,0.000000,36.512500>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.620500,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.620500,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.620500,0.000000,33.972500>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.620500,0.000000,33.972500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.684500,0.000000,33.972500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.620500,0.000000,33.972500>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.620500,0.000000,33.972500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.684500,0.000000,33.972500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.684500,0.000000,36.512500>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.684500,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<8.572500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<9.588500,0.000000,35.242500>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,0.000000,0> translate<8.572500,0.000000,35.242500> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<18.732500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<17.716500,0.000000,35.242500>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,0.000000,0> translate<17.716500,0.000000,35.242500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.287500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.242500>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.652500,0.000000,35.242500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.636500,0.000000,34.607500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.636500,0.000000,35.877500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.636500,0.000000,35.877500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.636500,0.000000,35.877500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.242500>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<12.636500,0.000000,35.877500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.128500,0.000000,35.242500>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<12.128500,0.000000,35.242500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.636500,0.000000,34.607500>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<12.636500,0.000000,34.607500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,34.607500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.242500>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.652500,0.000000,35.242500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,35.877500>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.652500,0.000000,35.877500> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-180.000000,0> translate<15.049500,0.000000,35.242500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-180.000000,0> translate<10.668000,0.000000,35.242500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-180.000000,0> translate<16.637000,0.000000,35.242500>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.257500,0.000000,28.130500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.257500,0.000000,32.194500>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.257500,0.000000,32.194500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.257500,0.000000,28.130500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.797500,0.000000,28.130500>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.257500,0.000000,28.130500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.797500,0.000000,32.194500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.797500,0.000000,28.130500>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.797500,0.000000,28.130500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.797500,0.000000,32.194500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.257500,0.000000,32.194500>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.257500,0.000000,32.194500> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<29.527500,0.000000,25.082500>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<29.527500,0.000000,26.098500>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,90.000000,0> translate<29.527500,0.000000,26.098500> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<29.527500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<29.527500,0.000000,34.226500>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,-90.000000,0> translate<29.527500,0.000000,34.226500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.797500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.162500>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.527500,0.000000,30.162500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.162500,0.000000,29.146500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.892500,0.000000,29.146500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.892500,0.000000,29.146500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.892500,0.000000,29.146500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.162500>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<28.892500,0.000000,29.146500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.162500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,28.638500>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.527500,0.000000,28.638500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.162500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.162500,0.000000,29.146500>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<29.527500,0.000000,30.162500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.162500,0.000000,30.162500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.162500>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.527500,0.000000,30.162500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.527500,0.000000,30.162500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.892500,0.000000,30.162500>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.892500,0.000000,30.162500> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<29.527500,0.000000,31.559500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-270.000000,0> translate<29.527500,0.000000,27.178000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-270.000000,0> translate<29.527500,0.000000,33.147000>}
//G1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<1.270000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<1.270000,0.000000,29.845000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<1.270000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<1.270000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<1.270000,0.000000,34.925000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<1.270000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<1.905000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<0.635000,0.000000,34.290000>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<0.635000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,36.830000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.270000,0.000000,36.068000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.588000,0.000000,36.830000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.032000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.588000,0.000000,36.830000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,44.997030,0> translate<5.588000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,27.432000>}
box{<0,0,-0.076200><8.636000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.588000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,27.432000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.588000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.588000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,26.670000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.032000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.032000,0.000000,26.670000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,44.997030,0> translate<1.270000,0.000000,27.432000> }
difference{
cylinder{<3.810000,0,34.290000><3.810000,0.036000,34.290000>1.346200 translate<0,0.000000,0>}
cylinder{<3.810000,-0.1,34.290000><3.810000,0.135000,34.290000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<3.810000,0,29.210000><3.810000,0.036000,29.210000>1.346200 translate<0,0.000000,0>}
cylinder{<3.810000,-0.1,29.210000><3.810000,0.135000,29.210000>1.193800 translate<0,0.000000,0>}}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.939000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.939000,0.000000,8.890000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.939000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.781000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.781000,0.000000,26.670000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.781000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.939000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.781000,0.000000,26.670000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.939000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.939000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,8.890000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.939000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.781000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.876000,0.000000,8.890000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.876000,0.000000,8.890000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<22.860000,0.000000,8.890000>}
//IC2 silk screen
object{ARC(2.666972,0.152400,197.149509,308.247193,0.036000) translate<16.509997,0.000000,31.749500>}
object{ARC(2.666972,0.152400,51.752807,162.850491,0.036000) translate<16.509997,0.000000,31.750500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.161000,0.000000,29.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.161000,0.000000,33.845000>}
box{<0,0,-0.076200><4.190000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.161000,0.000000,33.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,29.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,31.464000>}
box{<0,0,-0.076200><1.968000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,31.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,29.095000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,29.496000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,29.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,31.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,32.036000>}
box{<0,0,-0.076200><0.572000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,32.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,34.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,34.405000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,34.405000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,32.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,34.004000>}
box{<0,0,-0.076200><1.968000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,34.004000> }
object{ARC(2.666978,0.152400,162.850518,197.149482,0.036000) translate<16.510000,0.000000,31.750000>}
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,3.175000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.810000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,5.080000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.810000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,3.175000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,5.080000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,5.080000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,2.540000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.175000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,3.175000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.270000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.270000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,5.080000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.270000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,5.080000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,4.445000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.175000,0.000000,5.080000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<5.080000,0.000000,3.810000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<2.540000,0.000000,3.810000>}
//JP2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,11.430000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,10.795000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.175000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.810000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,8.890000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.175000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<1.270000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,10.795000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.270000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,8.890000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.270000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,8.890000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,11.430000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.810000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,11.430000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,10.795000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,8.890000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,8.890000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,9.525000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.810000,0.000000,9.525000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<2.540000,0.000000,10.160000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<5.080000,0.000000,10.160000>}
//JP3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.810000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.810000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.175000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.270000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.270000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.270000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.175000,0.000000,17.145000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<5.080000,0.000000,15.875000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<2.540000,0.000000,15.875000>}
//JP4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.050000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.810000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.320000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.810000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,20.320000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,19.050000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,18.415000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.175000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,19.050000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.270000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,20.320000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.270000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.270000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,20.320000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.175000,0.000000,20.955000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<5.080000,0.000000,19.685000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<2.540000,0.000000,19.685000>}
//JP5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.810000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,24.130000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.810000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,24.765000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.810000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,24.130000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.715000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,24.765000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.715000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<4.445000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,22.225000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.175000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.270000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,24.130000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.270000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,24.765000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.270000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.905000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,24.130000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<3.175000,0.000000,24.765000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<5.080000,0.000000,23.495000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<2.540000,0.000000,23.495000>}
//JP6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,8.572500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,9.207500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.750000,0.000000,9.207500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,9.207500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,10.477500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.750000,0.000000,10.477500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,10.477500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,11.112500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.750000,0.000000,10.477500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,11.112500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,11.112500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,11.112500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,11.112500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,10.477500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.655000,0.000000,11.112500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,10.477500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,9.207500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,9.207500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,9.207500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,8.572500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.655000,0.000000,8.572500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,4.127500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,5.397500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.750000,0.000000,5.397500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,5.397500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,6.032500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.750000,0.000000,5.397500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,6.032500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,6.032500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,6.032500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,6.032500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,5.397500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.655000,0.000000,6.032500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,6.032500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,6.667500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.750000,0.000000,6.667500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,6.667500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,7.937500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.750000,0.000000,7.937500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,7.937500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,8.572500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.750000,0.000000,7.937500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,8.572500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,8.572500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,8.572500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,8.572500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,7.937500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.655000,0.000000,8.572500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,7.937500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,6.667500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,6.667500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,6.667500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,6.032500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.655000,0.000000,6.032500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.492500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.492500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,3.492500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,4.127500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,3.492500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.750000,0.000000,4.127500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,3.492500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,4.127500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.655000,0.000000,3.492500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,5.397500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,4.127500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,4.127500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,11.747500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,13.017500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.750000,0.000000,13.017500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,13.017500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,13.652500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.750000,0.000000,13.017500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,13.652500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,13.652500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,13.652500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,13.652500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,13.017500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.655000,0.000000,13.652500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,11.747500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,11.112500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.750000,0.000000,11.747500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,11.112500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,11.747500>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.655000,0.000000,11.112500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,13.017500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,11.747500>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,11.747500> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<33.020000,0.000000,9.842500>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<33.020000,0.000000,7.302500>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<33.020000,0.000000,4.762500>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<33.020000,0.000000,12.382500>}
//JP7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.367500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.637500,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.367500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.637500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.272500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<20.637500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.272500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.272500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.272500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.272500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.637500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.637500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.272500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.907500,0.000000,6.350000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<21.272500,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.907500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.177500,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.907500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.177500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<23.177500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.812500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.177500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<23.177500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.177500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.907500,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.907500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.907500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.272500,0.000000,4.445000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<21.272500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.192500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.827500,0.000000,6.350000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<16.192500,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.827500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.097500,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.827500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.097500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.732500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<18.097500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.732500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.732500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.732500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.732500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.097500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<18.097500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.097500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.827500,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.827500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.827500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.192500,0.000000,4.445000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<16.192500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.367500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.732500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<18.732500,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.732500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.367500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<18.732500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.637500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.367500,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.367500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.747500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.017500,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.747500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.017500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<13.017500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.652500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.017500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<13.017500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.287500,0.000000,6.350000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<13.652500,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.287500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.557500,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.287500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.557500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.192500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<15.557500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.192500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.192500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.192500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.192500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.557500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.557500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.557500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.287500,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.287500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.287500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.652500,0.000000,4.445000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<13.652500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.112500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.112500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.112500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.747500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.112500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.112500,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.112500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.747500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<11.112500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.017500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.747500,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.747500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.447500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717500,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.447500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.352500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<25.717500,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.352500,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.352500,0.000000,4.445000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.352500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.352500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.717500,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.447500,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<23.812500,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.447500,0.000000,3.810000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<23.812500,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717500,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.447500,0.000000,3.810000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.447500,0.000000,3.810000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<22.542500,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<20.002500,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<17.462500,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<14.922500,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<12.382500,0.000000,5.080000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<25.082500,0.000000,5.080000>}
//K1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<36.195000,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<36.195000,0.000000,16.192500>}
box{<0,0,-0.127000><20.320000,0.036000,0.127000> rotate<0,-90.000000,0> translate<36.195000,0.000000,16.192500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<36.195000,0.000000,16.192500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.115000,0.000000,16.192500>}
box{<0,0,-0.127000><5.080000,0.036000,0.127000> rotate<0,0.000000,0> translate<31.115000,0.000000,16.192500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.115000,0.000000,16.192500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.115000,0.000000,36.512500>}
box{<0,0,-0.127000><20.320000,0.036000,0.127000> rotate<0,90.000000,0> translate<31.115000,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.115000,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,36.512500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<31.115000,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,36.512500>}
box{<0,0,-0.127000><2.540000,0.036000,0.127000> rotate<0,0.000000,0> translate<32.385000,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<36.195000,0.000000,36.512500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<34.925000,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,36.512500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,35.242500>}
box{<0,0,-0.127000><1.796051,0.036000,0.127000> rotate<0,-44.997030,0> translate<33.655000,0.000000,35.242500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,35.242500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,36.512500>}
box{<0,0,-0.127000><1.796051,0.036000,0.127000> rotate<0,44.997030,0> translate<32.385000,0.000000,36.512500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,25.717500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<34.925000,0.000000,25.717500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,25.717500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.290000,0.000000,25.717500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<34.290000,0.000000,25.717500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.290000,0.000000,25.717500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,25.717500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<33.655000,0.000000,25.717500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,25.717500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,25.717500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<32.385000,0.000000,25.717500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,25.717500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,26.987500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<32.385000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.385000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.020000,0.000000,26.987500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<32.385000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.020000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,26.987500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<33.020000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,26.987500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<33.655000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.020000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.290000,0.000000,25.717500>}
box{<0,0,-0.127000><1.796051,0.036000,0.127000> rotate<0,44.997030,0> translate<33.020000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,27.622500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,90.000000,0> translate<33.655000,0.000000,27.622500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,25.717500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.655000,0.000000,25.082500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,-90.000000,0> translate<33.655000,0.000000,25.082500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,33.972500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,33.972500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<34.925000,0.000000,33.972500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,33.972500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,32.702500>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,-90.000000,0> translate<35.560000,0.000000,32.702500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,30.797500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,18.732500>}
box{<0,0,-0.127000><12.065000,0.036000,0.127000> rotate<0,-90.000000,0> translate<35.560000,0.000000,18.732500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,18.732500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,18.732500>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<34.925000,0.000000,18.732500> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<35.560000,0.000000,32.702500>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.925000,0.000000,30.797500>}
box{<0,0,-0.127000><2.008046,0.036000,0.127000> rotate<0,-71.560328,0> translate<34.925000,0.000000,30.797500> }
difference{
cylinder{<32.766000,0,27.622500><32.766000,0.036000,27.622500>0.254000 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,27.622500><32.766000,0.135000,27.622500>0.000000 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<18.097500,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<18.986500,0.000000,27.940000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<18.097500,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<25.717500,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<24.828500,0.000000,27.940000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<24.828500,0.000000,27.940000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<24.193500,0.000000,27.178000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<24.193500,0.000000,28.702000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<19.621500,0.000000,28.702000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<19.621500,0.000000,27.178000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.447500,0.000000,28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.447500,0.000000,27.178000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.447500,0.000000,27.178000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.193500,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,26.924000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.812500,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.685500,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,26.924000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<23.685500,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.193500,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,28.956000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.812500,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.685500,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.812500,0.000000,28.956000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<23.685500,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.129500,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.002500,0.000000,26.924000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.002500,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.129500,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.685500,0.000000,27.051000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.129500,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.129500,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.002500,0.000000,28.956000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<20.002500,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.129500,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.685500,0.000000,28.829000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.129500,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.621500,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.002500,0.000000,26.924000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.621500,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.621500,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.002500,0.000000,28.956000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.621500,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.367500,0.000000,28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.367500,0.000000,27.178000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.367500,0.000000,27.178000> }
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-180.000000,0> translate<19.177000,0.000000,27.940000>}
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-180.000000,0> translate<24.638000,0.000000,27.940000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<7.620000,0.000000,10.477500>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<7.620000,0.000000,9.588500>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<7.620000,0.000000,9.588500> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<7.620000,0.000000,2.857500>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<7.620000,0.000000,3.746500>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<7.620000,0.000000,3.746500> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<6.858000,0.000000,4.381500>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<8.382000,0.000000,4.381500>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<8.382000,0.000000,8.953500>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<6.858000,0.000000,8.953500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.382000,0.000000,4.127500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.858000,0.000000,4.127500>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.858000,0.000000,4.127500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,4.381500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,4.762500>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.604000,0.000000,4.762500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,4.889500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,4.762500>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.604000,0.000000,4.762500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,4.381500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,4.762500>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.636000,0.000000,4.762500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,4.889500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,4.762500>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<8.509000,0.000000,4.889500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,8.445500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,8.572500>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<6.604000,0.000000,8.572500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,8.445500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.731000,0.000000,4.889500>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.731000,0.000000,4.889500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,8.445500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,8.572500>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.509000,0.000000,8.445500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,8.445500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.509000,0.000000,4.889500>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.509000,0.000000,4.889500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,8.953500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,8.572500>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.604000,0.000000,8.572500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,8.953500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,8.572500>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.636000,0.000000,8.572500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.382000,0.000000,9.207500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.858000,0.000000,9.207500>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.858000,0.000000,9.207500> }
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-90.000000,0> translate<7.620000,0.000000,9.398000>}
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-90.000000,0> translate<7.620000,0.000000,3.937000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.890000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.779000,0.000000,13.970000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.890000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<16.510000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.621000,0.000000,13.970000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<15.621000,0.000000,13.970000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<14.986000,0.000000,13.208000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<14.986000,0.000000,14.732000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<10.414000,0.000000,14.732000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<10.414000,0.000000,13.208000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,13.208000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,13.208000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,12.954000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,12.954000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<14.478000,0.000000,13.081000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,14.986000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.478000,0.000000,14.859000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,12.954000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.795000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,13.081000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,13.081000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.986000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.795000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,14.859000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,14.859000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,12.954000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,12.954000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,12.954000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,14.986000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,13.208000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,13.208000> }
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-180.000000,0> translate<9.969500,0.000000,13.970000>}
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-180.000000,0> translate<15.430500,0.000000,13.970000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<16.510000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.621000,0.000000,17.780000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<15.621000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.890000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.779000,0.000000,17.780000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.890000,0.000000,17.780000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<10.414000,0.000000,18.542000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<10.414000,0.000000,17.018000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<14.986000,0.000000,17.018000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<14.986000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,17.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,18.542000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,18.796000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,18.796000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.795000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,16.764000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.891000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,16.764000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.795000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,18.796000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.478000,0.000000,18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,18.669000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,16.891000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,16.764000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<14.478000,0.000000,16.891000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,16.891000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,16.891000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,16.891000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,18.796000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,16.764000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.018000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,18.542000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,18.542000> }
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-0.000000,0> translate<15.430500,0.000000,17.780000>}
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-0.000000,0> translate<9.969500,0.000000,17.780000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<16.510000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.621000,0.000000,22.225000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<15.621000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.890000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.779000,0.000000,22.225000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.890000,0.000000,22.225000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<10.414000,0.000000,22.987000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<10.414000,0.000000,21.463000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<14.986000,0.000000,21.463000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<14.986000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,21.463000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,22.987000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,23.241000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,23.241000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.795000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,21.209000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,21.209000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.795000,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,23.241000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.478000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,23.114000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,21.209000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<14.478000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,21.336000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,23.241000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,21.209000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,21.463000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,22.987000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,22.987000> }
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-0.000000,0> translate<15.430500,0.000000,22.225000>}
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-0.000000,0> translate<9.969500,0.000000,22.225000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<16.510000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<15.621000,0.000000,26.035000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<15.621000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<8.890000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<9.779000,0.000000,26.035000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,0.000000,0> translate<8.890000,0.000000,26.035000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<10.414000,0.000000,26.797000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<10.414000,0.000000,25.273000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<14.986000,0.000000,25.273000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<14.986000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,26.797000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,27.051000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,27.051000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<10.795000,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.414000,0.000000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,25.019000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.414000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,25.019000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.795000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,27.051000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.478000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,26.924000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,25.019000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<14.478000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.478000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.922000,0.000000,25.146000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.922000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,27.051000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.986000,0.000000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,25.019000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.605000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,26.797000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,26.797000> }
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-0.000000,0> translate<15.430500,0.000000,26.035000>}
box{<-0.190500,0,-0.254000><0.190500,0.036000,0.254000> rotate<0,-0.000000,0> translate<9.969500,0.000000,26.035000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  XPARK(-18.250000,0,-19.045000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//G1	AB9V	AB9V
//K1	35701331	REED
