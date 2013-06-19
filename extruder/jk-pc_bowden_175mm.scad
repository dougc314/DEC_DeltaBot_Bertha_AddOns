
30model ();



module 30model () {
	import ("jk-pc-bowden_3mm.stl");
	translate ([11,37.5,20]) rotate ([0,0,30])  #dec_hob(fil30=true);
}

module 175model () {
	import ("jk-pc-bowden_3mm.stl");
	translate ([11,37.5,20]) rotate ([0,0,30])  #dec_hob(fil30=false);
}




module dec_hob(fil30=true) {
	difference () {
		cylinder (r=7.8/2,h=50,center=true,$fn=32);
		
		if (fil30==true) {
			translate ([0,0,-6]) rotate_extrude(convexity = 20)
			translate([(7.8+3.5)/2-2, 0,0])
			circle(r = 3.5/2, $fn = 100);
		}
		else {
			translate ([0,0,-6]) rotate_extrude(convexity = 20)
			translate([(7.8+4)/2-1, 0,0])
			circle(r = 4/2, $fn = 100);	
		}
	}
}