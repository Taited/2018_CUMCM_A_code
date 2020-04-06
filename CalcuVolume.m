function v = CalcuVolume(l1,l2,l3,l4,core)
h = 1.9;
radius_d = l1+l2+l3+l4+core;
radius_s = core + l4;

v_d = pi * radius_d.^2 * h;
v_s = pi * radius_s.^2 * h;
v = v_d - v_s;
end