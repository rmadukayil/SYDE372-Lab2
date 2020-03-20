global classA classB;
classA = load('lab2_3','a');
classB = load('lab2_3', 'b');
global_min_AB = floor(min(min(arr_x_AB,arr_y_AB)))-1;
global_max_AB = ceil(max(max(arr_x_AB,arr_y_AB)))+1;
x = global_min_AB:0.1:global_max_AB;
[X1, Y1] = ndgrid(x); 