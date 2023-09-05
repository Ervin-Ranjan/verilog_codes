module special_fa //outputs sum, p = xor of a & b, g = a and b, no carryout
(input a,b,cin, output s,p,g);

xor g1(p,a,b),
	g2(s,p,cin);
	
and g3(g,a,b);

endmodule

module carry_gen // generates simultaneously with sum calculation process
(input p,g,cin , output carry);

wire pcin;

and g1(pcin,p,cin);

or(carry,pcin,g);

endmodule

module clad //carrylookahead adder
(input a0,a1,a2,a3,b0,b1,b2,b3,cin,output s0,s1,s2,s3,cout);

wire p0,p1,p2,p3,g0,g1,g2,g3,c0,c1,c2;

special_fa fa1(a0,b0,cin,s0,p0,g0);
carry_gen cg1(p0,g0,cin,c0);

special_fa fa2(a1,b1,c0,s1,p1,g1);
carry_gen cg2(p1,g1,c0,c1);

special_fa fa3(a2,b2,c1,s2,p2,g2);
carry_gen cg3(p2,g2,c1,c2);

special_fa fa4(a3,b3,c2,s3,p3,g3);
carry_gen cg4(p3,g3,c2,cout);

endmodule

module clad_tb;

reg a0,a1,a2,a3,b0,b1,b2,b3,cin;
wire s0,s1,s2,s3,cout;
integer fd;

clad clad1(a0,a1,a2,a3,b0,b1,b2,b3,cin,s0,s1,s2,s3,cout);
reg [4:0] cnt1,cnt2;

initial
fd = $fopen("clad_out.txt");

initial
begin
	for(cnt1 = 0; cnt1<16 ;cnt1 = cnt1 + 1)
	begin
		for(cnt2 = 0;cnt2<16;cnt2 = cnt2 + 1)
		begin
			{a3,a2,a1,a0} = cnt1;
			{b3,b2,b1,b0} = cnt2;
			cin = 0;
			#10;
		end
	end
end

initial
$fmonitor(fd,$time," a3=%b a2=%b a1=%b a0=%b b3=%b b2=%b b1=%b b0=%b s3=%b s2=%b s1=%b s0=%b cout=%b",a3,a2,a1,a0,b3,b2,b1,b0,s3,s2,s1,s0,cout);

endmodule

