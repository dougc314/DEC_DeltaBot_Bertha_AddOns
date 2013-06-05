

//obround (20,8,5);
//radplate (50,40,2,5);
//obround_rod (20,3);	



module obround (rlen,rwid,hgt){ 
	hull(){
		translate ([(rlen-rwid)/2,0,0]) cylinder(r=rwid/2,h=hgt,$fn=16);
		translate ([(rlen-rwid)/-2,0,0]) cylinder(r=rwid/2,h=hgt,$fn=16);
	}
}

		
module radplate (xwid,ywid,rad,thk){
	hull(){
		translate ([xwid/2-rad,ywid/2-rad,0]) cylinder (r=rad,h=thk,$fn=16);
		translate ([xwid/2-rad,ywid/-2+rad,0]) cylinder (r=rad,h=thk,$fn=16);
		translate ([xwid/-2+rad,ywid/-2+rad,0]) cylinder (r=rad,h=thk,$fn=16);
		translate ([xwid/-2+rad,ywid/2-rad,0]) cylinder (r=rad,h=thk,$fn=16);
	}
}
module obround_rod (rlen,rwid){ //could be a radius/2 error
	hull(){
		translate ([(rlen-rwid)/2,0,0]) sphere(r=rwid/2,$fn=16);
		translate ([(rlen-rwid)/-2,0,0]) sphere(r=rwid/2,$fn=16);
	}
}

module tube (od,wall,hgt){
	linear_extrude (height =hgt ,center=false)
	difference () {
		circle (r=od/2);
		circle (r=od/2-wall);
	}
}