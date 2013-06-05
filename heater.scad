


archemedes_sprial(1,1,2,7);


module archemedes_sprial (N,ri,gap,seg) {
	b=gap/2/pi;
	ang = 360/seg;
	pl = [0,0];
	for (i=[1:N*seg-1]){
		//p = [(ri+ang/180*pi*b)*cos(ang),(ri+ang/180*pi*b)*sin(ang)];
		//p= ([i*3,i*5]);
		 rotate ([0,0,ang*i+90]) translate ([5,0,0]) polygon ([0,0],[1,0]);
		//pl=p;
		echo (ang*i);
	}
}
		
			
			
			
		