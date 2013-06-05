

// design a simple spool for winding Archemedes Spiral

pi = 3.1415;
agap=4.25;// distance between arms of the spiral
axel = 3/8*25.4; //diameter of the center dowel
string_dia = 1;

//arch_spool ();
//wire_axel();
pen_top (spool_dia=30,spool_height=30,axel_dia=axel);



module arch_spool (gap=4.25,axel=3/8*25.4,len=30){
	difference (){
		cylinder (r=(gap)/2*pi,h=len);
		cylinder (r=axel/2+0.5,h=len);
	}
	cylinder (r=gap/2*pi+3,h=0.25); //disk to help hold the print down
}


module wire_axel(axeldia=3/8*25.5,spool_dia=30,spool_height=30){
	difference(){
		cylinder (r=spool_dia/2-1,h=spool_height+2,center=true);
		cylinder (r=axeldia/2+1,h=spool_height+10,center=true);
	}
}

module pen_top(spool_dia,spool_height,axel_dia) {
pen_dia=8;
	difference (){
		union() {
			translate ([0,0,2]) hull() {
				cylinder (r=(spool_height+10)/2,h=4,center=true);
				translate ([spool_dia/2,0,0]) cylinder (r=(spool_height+10)/2,h=4,center=true);
			}
			
			cylinder (r=pen_dia/2+3,h=8);
			translate ([spool_dia/2,spool_height/2+4/2+1,spool_dia/2]) cube ([spool_height+10,4,spool_dia],center = true);
			translate ([spool_dia/2,-spool_height/2-4/2-1,spool_dia/2]) cube ([spool_height+10,4,spool_dia],center = true);	
		}
		translate ([spool_dia/2,0,0.75*spool_dia]) rotate ([90,0,0])cylinder (r=axel_dia/2+0.25,h=spool_height+15,center=true);
		cylinder (r=pen_dia/2+0.5,h=20);
	}
}
	