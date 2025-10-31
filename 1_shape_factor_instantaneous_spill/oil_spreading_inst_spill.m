function out = model
%
% oil_spreading_inst_spill.m
%
% Model exported on Oct 31 2025, 12:09 by COMSOL 6.0.0.312.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('D:\_OneDrive\Metu\OneDrive - metu.edu.tr\PETE\_Makaleler\Oil_Spreading\Makale3_spreading_profile\2_Ocean_Modelling\Repository\1_shape_factor_instantaneous_spill');

model.label('oil_spreading_inst_spill.mph');

model.param.set('t_i', '0.1[s]');
model.param.set('R_i', '10[cm]');
model.param.set('Volume', '2[l/min]*2[min]');
model.param.set('g_prime', '(density_w-density_o)/density_w*gravity');
model.param.set('density_w', '1025[kg/m^3]');
model.param.set('density_o', '894[kg/m^3]');
model.param.set('gravity', '9.81 [m/s^2]');
model.param.set('k', '1[kg/m^2/s]');
model.param.set('surface_tension', '0.0063[kg/s^2]');
model.param.set('a', '0.55');

model.component.create('comp2', true);

model.component('comp2').geom.create('geom2', 1);

model.result.table.create('tbl1', 'Table');
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').create('min1', 'MinLine');
model.result.evaluationGroup('eg1').create('min2', 'MinLine');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').create('gev2', 'EvalGlobal');

model.component('comp2').geom('geom2').axisymmetric(true);

model.component('comp2').mesh.create('mesh2');

model.component('comp2').geom('geom2').create('i1', 'Interval');
model.component('comp2').geom('geom2').feature('i1').set('coord', [0 5]);
model.component('comp2').geom('geom2').create('pt2', 'Point');
model.component('comp2').geom('geom2').feature('pt2').set('p', {'R_i'});
model.component('comp2').geom('geom2').create('pt1', 'Point');
model.component('comp2').geom('geom2').feature('pt1').active(false);
model.component('comp2').geom('geom2').feature('pt1').set('p', {'r_i'});
model.component('comp2').geom('geom2').run;
model.component('comp2').geom('geom2').run('fin');

model.frame('material1').tag('material2');
model.frame('mesh1').tag('mesh2');
model.frame('geometry1').tag('geometry2');
model.frame('spatial1').tag('spatial2');

model.component('comp2').variable.create('var2');
model.component('comp2').variable('var2').set('h_o', 'Volume*(a+1)/(pi*a*R_radius^2)');
model.component('comp2').variable('var2').set('c_coeff_1', '2*density_o*g_prime*h_o^2/(a*k*R_radius)');
model.component('comp2').variable('var2').set('c_coeff_2', '2*surface_tension/(R_radius*k)');
model.component('comp2').variable('var2').set('h_slick', 'if(r>R_radius,0,Volume*(a+1)/(pi*a*R_radius^2)*(1-(r/R_radius)^2)^(1/a))');

model.component('comp2').view('view1').tag('view2');
model.view.create('view3', 2);
model.view.create('view4', 2);
model.view.create('view5', 2);

model.component('comp2').physics.create('ge', 'GlobalEquations', 'geom2');
model.component('comp2').physics('ge').feature('ge1').set('DependentVariableQuantity', 'none');

model.component('comp2').mesh('mesh2').create('edg1', 'Edge');

model.component('comp2').probe.create('dom2', 'Domain');

model.result.table('tbl1').label('Probe Table 1');

model.component('comp2').view('view2').label('View 2');
model.component('comp2').view('view2').axis.set('xmin', -0.25);
model.component('comp2').view('view2').axis.set('xmax', 5.25);
model.view('view3').axis.set('xmin', -52.37123107910156);
model.view('view3').axis.set('xmax', 66.95172119140625);
model.view('view3').axis.set('ymin', -52.49959945678711);
model.view('view3').axis.set('ymax', 52.48355484008789);
model.view('view4').axis.set('xmin', -802.0538330078125);
model.view('view4').axis.set('xmax', 803.5119018554688);
model.view('view4').axis.set('ymin', -706.3080444335938);
model.view('view4').axis.set('ymax', 706.3067016601562);
model.view('view5').axis.set('xmin', -125.02507019042969);
model.view('view5').axis.set('xmax', 125.02507019042969);
model.view('view5').axis.set('ymin', -110);
model.view('view5').axis.set('ymax', 110);

model.component('comp2').physics('ge').feature('ge1').set('name', 'R_radius');
model.component('comp2').physics('ge').feature('ge1').set('equation', 'R_radiust-c_coeff_1+c_coeff_2');
model.component('comp2').physics('ge').feature('ge1').set('initialValueU', 'R_i');
model.component('comp2').physics('ge').feature('ge1').set('SourceTermQuantity', 'none');
model.component('comp2').physics('ge').feature('ge1').set('CustomSourceTermUnit', 'm/s');

model.component('comp2').mesh('mesh2').feature('size').set('hauto', 2);
model.component('comp2').mesh('mesh2').feature('size').set('custom', 'on');
model.component('comp2').mesh('mesh2').feature('size').set('hmax', 0.01);
model.component('comp2').mesh('mesh2').feature('size').set('hmin', 0.0263);
model.component('comp2').mesh('mesh2').run;

model.component('comp2').probe('dom2').set('type', 'maximum');
model.component('comp2').probe('dom2').set('probename', 'h_max');
model.component('comp2').probe('dom2').set('expr', 'h');
model.component('comp2').probe('dom2').set('unit', 'm');
model.component('comp2').probe('dom2').set('descr', 'Dependent variable h');
model.component('comp2').probe('dom2').set('table', 'tbl1');
model.component('comp2').probe('dom2').set('window', 'window1');

model.study.create('std5');
model.study('std5').create('time', 'Transient');

model.sol.create('sol5');
model.sol('sol5').study('std5');
model.sol('sol5').attach('std5');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').create('t1', 'Time');
model.sol('sol5').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('t1').feature.remove('fcDef');

model.result.dataset.create('dset3', 'Solution');
model.result.dataset.create('dset6', 'Solution');
model.result.dataset.create('max2', 'Maximum');
model.result.dataset.create('dset8', 'Solution');
model.result.dataset('dset3').set('probetag', 'dom2');
model.result.dataset('dset6').set('probetag', 'dom2');
model.result.dataset('max2').set('probetag', 'dom2');
model.result.dataset('max2').set('data', 'dset6');
model.result.dataset('max2').selection.geom('geom2', 1);
model.result.dataset('max2').selection.set([1 2]);
model.result.dataset.remove('dset1');
model.result.numerical.create('pev2', 'EvalPoint');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('pev2').set('probetag', 'dom2');
model.result.numerical('gev1').set('data', 'dset8');
model.result.numerical('gev1').set('probetag', 'none');
model.result.create('pg3', 'PlotGroup1D');
model.result.create('pg12', 'PlotGroup1D');
model.result.create('pg13', 'PlotGroup1D');
model.result('pg3').set('probetag', 'window1_default');
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('probetag', 'dom1,dom2');
model.result('pg12').set('data', 'dset8');
model.result('pg12').create('glob1', 'Global');
model.result('pg12').create('lngr1', 'LineGraph');
model.result('pg12').create('glob2', 'Global');
model.result('pg12').feature('lngr1').set('xdata', 'expr');
model.result('pg12').feature('lngr1').selection.set([1 2]);
model.result('pg12').feature('lngr1').set('expr', 'h_slick');
model.result('pg13').set('data', 'dset8');
model.result('pg13').create('lngr1', 'LineGraph');
model.result('pg13').feature('lngr1').set('xdata', 'expr');
model.result('pg13').feature('lngr1').selection.set([1 2]);
model.result('pg13').feature('lngr1').set('expr', 'h_slick');

model.component('comp2').probe('dom2').genResult([]);

model.study('std5').feature('time').set('tlist', 'range(t_i,0.1,400)');

model.sol('sol5').attach('std5');
model.sol('sol5').feature('st1').label('Compile Equations: Time Dependent');
model.sol('sol5').feature('v1').label('Dependent Variables 1.1');
model.sol('sol5').feature('v1').set('clist', {'range(t_i,0.1,400)' '0.0001[s]'});
model.sol('sol5').feature('t1').label('Time-Dependent Solver 1.1');
model.sol('sol5').feature('t1').set('control', 'user');
model.sol('sol5').feature('t1').set('tlist', 'range(t_i,0.1,400)');
model.sol('sol5').feature('t1').set('tout', 'tsteps');
model.sol('sol5').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol5').feature('t1').set('initialstepbdf', '0.0001');
model.sol('sol5').feature('t1').set('initialstepbdfactive', true);
model.sol('sol5').feature('t1').feature('dDef').label('Direct 1');
model.sol('sol5').feature('t1').feature('aDef').label('Advanced 1');
model.sol('sol5').feature('t1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol5').runAll;

model.result.dataset('dset3').label('Probe Solution 3');
model.result.dataset('dset6').label('Probe Solution 6');
model.result.dataset('max2').set('data', 'dset6');
model.result.numerical('pev2').set('descr', {'Dependent variable h'});
model.result.evaluationGroup('eg1').set('data', 'dset8');
model.result.evaluationGroup('eg1').set('looplevelinput', {'all'});
model.result.evaluationGroup('eg1').feature('min1').set('expr', {'d(h,r)'});
model.result.evaluationGroup('eg1').feature('min1').set('unit', {'1'});
model.result.evaluationGroup('eg1').feature('min1').set('descr', {''});
model.result.evaluationGroup('eg1').feature('min1').set('includepos', true);
model.result.evaluationGroup('eg1').feature('min1').selection.all;
model.result.evaluationGroup('eg1').feature('min2').set('expr', {'if(h<=0,r,1000)'});
model.result.evaluationGroup('eg1').feature('min2').set('unit', {'m'});
model.result.evaluationGroup('eg1').feature('min2').set('descr', {'Rmax'});
model.result.evaluationGroup('eg1').feature('min2').selection.all;
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'h_max'});
model.result.evaluationGroup('eg1').feature('gev1').set('unit', {'mm'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'h_max'});
model.result.evaluationGroup('eg1').feature('gev2').set('expr', {'R_radius'});
model.result.evaluationGroup('eg1').feature('gev2').set('unit', {'m'});
model.result.evaluationGroup('eg1').feature('gev2').set('descr', {'State variable R_radius'});
model.result.evaluationGroup('eg1').run;
model.result('pg3').label('Probe Plot Group 3');
model.result('pg3').set('xlabel', 'Time (s)');
model.result('pg3').set('ylabel', 'Dependent variable h (m), Domain Probe 2');
model.result('pg3').set('windowtitle', 'Probe Plot 1');
model.result('pg3').set('xlabelactive', false);
model.result('pg3').set('ylabelactive', false);
model.result('pg3').feature('tblp1').label('Probe Table Graph 1');
model.result('pg3').feature('tblp1').set('legend', true);
model.result('pg12').set('xlabel', 'Time (s)');
model.result('pg12').set('ylabel', 'State variable R_radius (m)');
model.result('pg12').set('legendpos', 'lowerright');
model.result('pg12').set('xlabelactive', false);
model.result('pg12').set('ylabelactive', false);
model.result('pg12').feature('lngr1').active(false);
model.result('pg12').feature('lngr1').set('xdataexpr', 'r');
model.result('pg12').feature('lngr1').set('xdataunit', 'm');
model.result('pg12').feature('lngr1').set('xdatadescr', 'r-coordinate');
model.result('pg12').feature('lngr1').set('resolution', 'normal');
model.result('pg12').feature('glob2').active(false);
model.result('pg13').set('looplevelinput', {'manual'});
model.result('pg13').set('looplevel', [2051]);
model.result('pg13').set('xlabel', 'r-coordinate (m)');
model.result('pg13').set('xlabelactive', false);
model.result('pg13').feature('lngr1').set('xdataexpr', 'r');
model.result('pg13').feature('lngr1').set('xdataunit', 'm');
model.result('pg13').feature('lngr1').set('xdatadescr', 'r-coordinate');
model.result('pg13').feature('lngr1').set('resolution', 'normal');

out = model;
