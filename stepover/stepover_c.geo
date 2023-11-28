/**
 * @file
 * This file is part of SeisSol.
 *
 * @author Thomas Ulrich, Zihua Niu
 *
 * @section LICENSE
 * Copyright (c) 2014-2022, SeisSol Group
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
*/


lc = 5e3;
lc_fault = 800;

Fault1_length = 70e3;
Fault1_width = 15e3;
Fault1_dip = 90*Pi/180.;

Fault2_length = 58e3;
Fault2_width = Fault1_width;
Fault2_dip = Fault1_dip;

H_dist = 2e3;
D_overlap = 28e3;

// Nucleation in X,Z local coordinates
X_nucl = -40e3;
Start_nucl = 1e3;
Width_nucl = Fault1_width - 2e3;
R_nucl = 20e3;
lc_nucl = 400;

Xmax = 80e3;
Xmin = -Xmax;

Ymax =  60e3 + 0.5 * Fault1_width  *Cos(Fault1_dip);
Ymin = -60e3 +  0.5 * Fault1_width  *Cos(Fault1_dip);

Zmin = -Ymax;

// Create the Volume
Point(1) = {Xmin, Ymin, 0, lc};
Point(2) = {Xmin, Ymax, 0, lc};
Point(3) = {Xmax, Ymax, 0, lc};
Point(4) = {Xmax, Ymin, 0, lc};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
Curve Loop(5) = {1,2,3,4};
Plane Surface(1) = {5};
Extrude {0,0, Zmin} { Surface{1}; }

// Create the fault 1
Point(100) = {-50e3, Fault1_width  *Cos(Fault1_dip), -Fault1_width  *Sin(Fault1_dip), lc};
Point(101) = {-50e3, 0, 0e3, lc};
Point(102) = {-50e3+Fault1_length, 0,  0e3, lc};
Point(103) = {-50e3+Fault1_length, Fault1_width  *Cos(Fault1_dip), -Fault1_width  *Sin(Fault1_dip), lc};
Line(100) = {100, 101};
Line(101) = {101, 102};
Line{101} In Surface{1};
Line(102) = {102, 103};
Line(103) = {103, 100};

// Create the fault 2
Point(300) = {20e3-D_overlap, H_dist+Fault2_width  *Cos(Fault2_dip), -Fault2_width  *Sin(Fault2_dip), lc};
Point(301) = {20e3-D_overlap, H_dist+0, 0e3, lc};
Point(302) = {20e3-D_overlap+Fault2_length, H_dist+0,  0e3, lc};
Point(303) = {20e3-D_overlap+Fault2_length, H_dist+Fault2_width  *Cos(Fault2_dip), -Fault2_width  *Sin(Fault2_dip), lc};
Line(300) = {300, 301};
Line(301) = {301, 302};
Line{301} In Surface{1};
Line(302) = {302, 303};
Line(303) = {303, 300};

// Create nucleation patch
/*
Point(200) = {X_nucl, Width_nucl*Cos(Fault_dip), -Width_nucl  *Sin(Fault_dip), lc_nucl};
Point(201) = {X_nucl, (Width_nucl + R_nucl) * Cos(Fault_dip), -(Width_nucl+R_nucl)  *Sin(Fault_dip), lc_nucl};
Point(202) = {X_nucl + R_nucl, Width_nucl*Cos(Fault_dip), -Width_nucl  *Sin(Fault_dip), lc_nucl};
Point(203) = {X_nucl, (Width_nucl - R_nucl) * Cos(Fault_dip), -(Width_nucl-R_nucl)  *Sin(Fault_dip), lc_nucl};
Point(204) = {X_nucl - R_nucl, Width_nucl*Cos(Fault_dip), -Width_nucl  *Sin(Fault_dip), lc_nucl};
Circle(200) = {201,200,202};
Circle(201) = {202,200,203};
Circle(202) = {203,200,204};
Circle(203) = {204,200,201};
Curve Loop(204) = {200,201,202,203};
Plane Surface(200) = {204};
*/

Point(201) = {X_nucl + R_nucl , (Start_nucl + Width_nucl) * Cos(Fault1_dip), -(Start_nucl + Width_nucl)  *Sin(Fault1_dip), lc_nucl};
Point(202) = {X_nucl + R_nucl , (Start_nucl) * Cos(Fault1_dip)             , -(Start_nucl)  *Sin(Fault1_dip), lc_nucl};
Point(203) = {X_nucl          , (Start_nucl) * Cos(Fault1_dip)             , -(Start_nucl)  *Sin(Fault1_dip), lc_nucl};
Point(204) = {X_nucl          , (Start_nucl + Width_nucl) * Cos(Fault1_dip), -(Start_nucl + Width_nucl)  *Sin(Fault1_dip), lc_nucl};
Line(200) = {201, 202};
Line(201) = {202, 203};
Line(202) = {203, 204};
Line(203) = {204, 201};
Curve Loop(204) = {200,201,202,203};
Plane Surface(200) = {204};

Curve Loop(105) = {100,101,102,103};
Plane Surface(100) = {105, 204};

Curve Loop(305) = {300,301,302,303};
Plane Surface(300) = {305};

// There is a bug in "Attractor", we need to define a Ruled surface in FaceList
Line Loop(106) = {100,101,102,103};
Ruled Surface(101) = {106};
Ruled Surface(201) = {204};
Ruled Surface(301) = {305};

Surface{100,200,300} In Volume{1};

// Managing coarsening away from the fault
// Attractor field returns the distance to the curve (actually, the
// distance to 100 equidistant points on the curve)
Field[1] = Distance;
Field[1].FacesList = {101,301};

// Matheval field returns "distance squared + lc/20"
Field[2] = MathEval;
//Field[2].F = Sprintf("0.02*F1 + 0.00001*F1^2 + %g", lc_fault);
//Field[2].F = Sprintf("0.02*F1 +(F1/2e3)^2 + %g", lc_fault);
Field[2].F = Sprintf("0.05*F1 +(F1/2.5e3)^2 + %g", lc_fault);

// Managing coarsening around the nucleation Patch
Field[3] = Distance;
Field[3].FacesList = {201};

Field[4] = Threshold;
Field[4].IField = 3;
Field[4].LcMin = lc_nucl;
Field[4].LcMax = lc_fault;
Field[4].DistMin = 0.4*R_nucl;
Field[4].DistMax = 2*0.4*R_nucl;

Field[5] = Restrict;
Field[5].IField = 4;
Field[5].FacesList = {100,200};

// Equivalent of propagation size on element
Field[6] = Threshold;
Field[6].IField = 1;
Field[6].LcMin = lc_fault;
Field[6].LcMax = lc;
Field[6].DistMin = 2*lc_fault;
Field[6].DistMax = 2*lc_fault+0.001;


Field[7] = Min;
Field[7].FieldsList = {2,5,6};

Background Field = 7;

Physical Surface(101) = {1};
Physical Surface(103) = {100,200,300};
// This ones are read from the gui
Physical Surface(105) = {14,18,22,26,27};

Physical Volume(1) = {1};
Mesh.MshFileVersion = 2.2;
