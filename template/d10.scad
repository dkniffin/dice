/* [Die] */

// Distance from point to point
height = 10; // [10:100]
// Distance from one side to the other, through the middle
width = 5; // [10:100]
// Size of the gap between top and bottom
middle_height = 0.25; // [10:100]
top_bottom_offset = middle_height/2;

max_z = height/2;
max_y = width/2;

/* [Face text] */

// Font to use for the faces
text_font = "Roboto";
// Size of the text for the faces
text_size = 1.0; // [1:100]
// Depth of the text
text_depth = 0.2;

// Text to use the for "1" face
1_text = "1";
// Text to use the for "2" face
2_text = "2";
// Text to use the for "3" face
3_text = "3";
// Text to use the for "4" face
4_text = "4";
// Text to use the for "5" face
5_text = "5";
// Text to use the for "6" face
6_text = "6";
// Text to use the for "7" face
7_text = "7";
// Text to use the for "8" face
8_text = "8";
// Text to use the for "9" face
9_text = "9";
// Text to use the for "10" face
10_text = "10";

// The top and bottom are easy. The middle is a pentagon.
// http://mathworld.wolfram.com/Pentagon.html
c1 = (1/4)*(sqrt(5) - 1)*max_y;
c2 = (1/4)*(sqrt(5) + 1)*max_y;
s1 = (1/4)*(sqrt(10 + 2*sqrt(5)))*max_y;
s2 = (1/4)*(sqrt(10 - 2*sqrt(5)))*max_y;

points = [
  [0, 0, max_z+top_bottom_offset], // 0 - tip

  [0, max_y, top_bottom_offset], // 1 - pentagon 1
  [s1, c1, top_bottom_offset],   // 2 - pentagon 2
  [s2, -c2, top_bottom_offset],  // 3 - pentagon 3
  [-s2, -c2, top_bottom_offset], // 4 - pentagon 4
  [-s1, c1, top_bottom_offset],   // 5 - pentagon 5
];

faces = [
  // "Cone"
  [2, 0, 1], // 1
  [3, 0, 2], // 2
  [4, 0, 3], // 3
  [5, 0, 4], // 4
  [1, 0, 5], // 5
  // Bottom of "Cone"
  [2, 1, 3],
  [3, 1, 4],
  [4, 1, 5]
];

side_depth = c2;
side_height = max_z - top_bottom_offset;

middle_radius = side_depth * 0.9;

function towards_origin (start_point, distance) = (-start_point/norm(start_point))*distance;

module side_text (string, triangle_center, rotation) {
  translate(triangle_center)
  translate(towards_origin(triangle_center, text_depth))
  rotate(rotation)

  linear_extrude(height = text_depth*2)
  text(string, halign = "center", valign = "center", font = text_font, size = text_size);
}


difference() {
  color("DarkRed")
    union() {
      // Top
      polyhedron(points, faces);

      // Bottom
      rotate([180,0,0])
        polyhedron(points, faces);

      // Middle
      translate([0,0,-top_bottom_offset])
      cylinder(h = middle_height, r1 = middle_radius, r2 = middle_radius, $fn = 1000);
    }

  y = (2/3)*side_depth;
  z = top_bottom_offset + (1/3)*max_z;
  angle = 90 - atan(side_depth/side_height);

  fifth = 360/5;
  color("blue") {
    side_text(1_text, [0,-y,z], [angle,0,0]);
    rotate([0,0,fifth])
      side_text(2_text, [0,-y,z], [angle,0,0]);
    rotate([0,0,2*fifth])
      side_text(3_text, [0,-y,z], [angle,0,0]);
    rotate([0,0,3*fifth])
      side_text(4_text, [0,-y,z], [angle,0,0]);
    rotate([0,0,4*fifth])
      side_text(5_text, [0,-y,z], [angle,0,0]);

    rotate([180, 0, 0]) {
      side_text(10_text, [0,-y,z], [angle,0,0]);
      rotate([0,0,fifth])
        side_text(9_text, [0,-y,z], [angle,0,0]);
      rotate([0,0,2*fifth])
        side_text(8_text, [0,-y,z], [angle,0,0]);
      rotate([0,0,3*fifth])
        side_text(7_text, [0,-y,z], [angle,0,0]);
      rotate([0,0,4*fifth])
        side_text(6_text, [0,-y,z], [angle,0,0]);
    }
  }
}
