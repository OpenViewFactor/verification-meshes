% GENERATE SPHERE MESHES FOR VERIFICATION

clear all

addpath('submodules\\distmesh-utilities\\')
addpath('submodules\\distmesh-utilities\\generateSphere\\')

inner_r = [1, 1.5, 2];
outer_r = [1.5, 2, 3];


output_user_response = input("Output Files? ", "s");
if (output_user_response == "y")
  do_output = true;
else
  do_output = false;
end


num_refinements = 5;

output_folder = 'concentric-spheres\\';

for r = inner_r
  inner_mesh = generateSphere(r, num_refinements);
  if do_output
    stlwrite(inner_mesh, output_folder + "inner_sphere_r=" + num2str(r) + ".stl", "binary");
  end
end

for r = outer_r
  outer_mesh = generateSphere(r, num_refinements);
  outer_mesh = flipNormals(outer_mesh);
  if do_output
    stlwrite(outer_mesh, output_folder + "outer_sphere_r=" + num2str(r) + ".stl", "binary");
  end
end