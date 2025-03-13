% generate perpendicular plates (nonsharing)

clear all
close all
clc

addpath("submodules/distmesh-utilities/")

output_folder = "perpendicular-plates/";

scale_factors = [2, 5, 10, 20, 50, 80];
shared_dimension = 1;
offset = 0.1;
x = [0.1, 0.5, 1.0, 2.0, 4.0, 10.0];
z = [0.1, 1.0, 1.0, 2.0, 4.0, 10.0];

for i = 1 : length(scale_factors)
  folder_name = output_folder + "L" + num2str(i) + "/";

  for j = 1 : length(x)
    x_dim = x(j);
    z_dim = z(j);

    hP = [ offset, 0, 0; offset+x_dim, 0, 0; offset+x_dim, shared_dimension, 0; offset, shared_dimension, 0 ];
    vP = [ 0, 0, offset; 0, shared_dimension, offset; 0, shared_dimension, offset + z_dim; 0, 0, offset + z_dim ];
    
    hM = generateRectangle( hP, scale_factors(i) );
    vM = generateRectangle( vP, scale_factors(i) );

    horizontal_name = "horizontal-horzDim=" + num2str(x_dim) + "-shrdDim=" + num2str(shared_dimension) + "-axisOffset=" + num2str(offset) + ".stl";
    vertical_name = "vertical-vertDim=" + num2str(z_dim) + "-shrdDim=" + num2str(shared_dimension) + "-axisOffset=" + num2str(offset) + ".stl";
  
    stlwrite(hM, folder_name + horizontal_name, "binary")
    stlwrite(vM, folder_name + vertical_name, "binary")
  end

end