include <Chamfers-for-OpenSCAD/Chamfer.scad>;

main(
    board_size = [124, 89, 1.7],
    thickness  = 2.5,
    grip       = 2,
    base_space = 3,
    chamfer    = 1.5
);

module main() {
    difference() {
        box(
            length  = board_size[0] + thickness * 2,
            width   = board_size[1] + thickness * 2,
            height  = thickness + base_space + grip + board_size[2] + grip,
            chamfer = chamfer
        );

        translate([-1, thickness + grip, thickness])
        cutout(
            length = board_size[0] - grip + thickness + 1,
            width  = board_size[1] - grip * 2,
            height = base_space + grip + board_size[2] + grip + 1
        );

        translate([- 1, thickness, thickness + base_space - grip ])
        holder(
            length = board_size[0] + thickness + 1,
            width  = board_size[1],
            height = board_size[2],
            grip   = grip
        );
    }
}

module box() {
    chamferCube(length, width, height, chamfer, [1, 1, 1, 1], [1, 1, 1, 1], [0, 0, 0, 0]);
}

module cutout() {
    cube([length, width, height]);
}

module holder() {
    chamferCube(length, width, height + grip * 2, grip, [1, 1, 1, 1], [0, 0, 1, 1], [0, 0, 0, 0]);
}
