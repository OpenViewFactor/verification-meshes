clear all
clc

addpath("submodules/distmesh-utilities/")

output_path = "coaxial-cylinders/";


scale_factors = [7, 13, 20, 30, 50, 70];

inner_radii = [0.125, 0.25, 0.5, 0.75, 1.0, 2.0, 10];
outer_radii = [0.25, 0.5, 0.75, 1.0, 2.0, 3.0, 32.0];
height = 1;


arc_length = @(r,h,s) h/sqrt(r) / s;
num_divisions = @(al) floor(2*pi / al);


for j = 1 : length(scale_factors)
  scale = scale_factors(j);
  folder_name = output_path + "L" + num2str(j) + "/";
  
  for i = 1 : length(inner_radii)
    ir = inner_radii(i);
    or = outer_radii(i);
    inner_N = num_divisions(arc_length(ir,height,scale));
    if (mod(inner_N,2) == 1)
      inner_N = inner_N + 1;
    end
    inner_m = generateCylinder2(ir,height,inner_N);
    inner_filename = folder_name + "inner-r=" + num2str(ir) + "-h=" + num2str(height) + ".stl";
    stlwrite(inner_m, inner_filename, "binary")
  
    outer_N = num_divisions(arc_length(or,height,scale));
    if (mod(outer_N,2) == 1)
      outer_N = outer_N + 1;
    end
    outer_m = generateCylinder2(or,height,outer_N);
    outer_m = flipNormals(outer_m);
    outer_filename = folder_name + "outer-r=" + num2str(or) + "-h=" + num2str(height) + ".stl";
    stlwrite(outer_m, outer_filename, "binary")
  end
 
end