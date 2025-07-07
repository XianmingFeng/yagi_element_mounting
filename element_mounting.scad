$fa = 1;
$fs = 0.4;

mounting_width = 12;
boom_width = 19;
element_dia = 8;
element_gap = 5;
mounting_screw = 3;
parking_angle = 10;

module base(mw = 12, bw = 19, ms = 3){
    difference(){
        difference(){
                cube([boom_width + 20, mounting_width, 12],center=true);
                translate([0,0,-6])
                    cube([boom_width + 0.2, mounting_width + 0.5, 10],center=true);
        }
        cylinder(h = 12, r = ms / 2, center = true);
    }
}

module chamfer(){
    p0 = [boom_width / 2 + 10.5, 2];
    p1 = [boom_width / 2 + 10.5, -6.5];
    p2 = [boom_width / 2 + 1, -6.5];
    
    translate([0, mounting_width / 2 + 0.5, 0])
        rotate([90, 0, 0])
            linear_extrude(height = mounting_width + 1)
                polygon([p0, p1, p2]);
    
}

module element(dia = 8, gap = 5){
    translate([0, 0, element_gap - 1 + element_dia / 2])
        rotate([0, 90, 0])
            cylinder(h = boom_width + 20.5, r = element_dia / 2, center = true);
}

module parking_slot(dia = 8, gap = 5, ang = 10){
    translate([0, 0, element_gap - 1 + element_dia / 2])
        rotate([0, 90, 90 + ang])
            cylinder(h = mounting_width + 20, r = dia / 2, center = true);
}


difference(){
    base(mw = mounting_width, bw = boom_width, ms = mounting_screw);
    element(dia = element_dia, gap = element_gap);
    parking_slot(dia = element_dia, gap = element_gap, ang = parking_angle);
    mirror([1, 0, 0])
        chamfer();
    chamfer();
}



