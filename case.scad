$fn=100;

include <Chamfers-for-OpenSCAD/Chamfer.scad>;

main(
    board_size   = [125, 88.7, 1.7],
    thickness    = 1.5,
    grip         = 2.5,
    bevel        = 0.5,
    bottom_gap   = 2.3,
    corner_r     = 2,
    wire_r       = 1,
    wire_gap     = 7.5,
    wire_stand_r = 9,
    stand_length = 35,
    stand_width  = 8,
    stand_offset = 24
);

module main() {
    box_length = board_size[0] + thickness * 2;
    box_width = board_size[1] + thickness * 2;
    box_height = thickness + bottom_gap + board_size[2] + bevel;

    difference() {
        union() {
            difference() {
                translate([corner_r, corner_r, 0])
                    minkowski() {
                        cube([box_length - corner_r * 2, box_width - corner_r * 2, box_height - 1]);
                        cylinder(h=1, r=corner_r);
                    }

                translate([thickness + grip, thickness + grip, thickness])
                    cube(size=[board_size[0] - grip * 2, board_size[1] - grip * 2, 20]);

                translate([thickness, thickness, thickness + bottom_gap])
                    cube(size=[board_size[0], board_size[1], 20]);
            }

            stand_x = box_length / 2;
            stand_y = [thickness + stand_offset, thickness + board_size[1] - stand_offset];

            for(y = stand_y) {
                translate([stand_width / 2 - stand_length / 2 + stand_x, y, 0])
                    hull() {
                        cylinder(h=thickness + bottom_gap, r=stand_width / 2);
                        translate([stand_length - stand_width, 0, 0])
                            cylinder(h=thickness + bottom_gap, r=stand_width / 2);
                    }
            }

            translate([thickness + grip, box_width / 2, 0])
                difference() {
                    cylinder(h=thickness + bottom_gap, r=wire_stand_r);
                    translate([-wire_stand_r, 0, 0])
                        cube(size=[wire_stand_r * 2, wire_stand_r * 2, 20], center=true);
                }
        }

        wire_pos = [box_width / 2 - wire_gap / 2, box_width / 2 + wire_gap / 2];

        for (x = wire_pos) {
            translate([thickness + grip + wire_stand_r + 1, x, wire_r + thickness + bottom_gap - wire_r * 2])
            rotate([0, -90, 0])
                hull() {
                    cylinder(h=thickness + grip + wire_stand_r + 2, r=wire_r);
                    translate([20, 0, 0])
                        cylinder(h=thickness + grip + wire_stand_r + 2, r=wire_r);
                }
        }
    }
}
