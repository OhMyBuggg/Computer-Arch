//Subject:     CO project 2 - Test Bench
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616223 0616059
//----------------------------------------------
//Date:        4/27
//----------------------------------------------
//Description: testbench
//--------------------------------------------------------------------------------

`define CYCLE_TIME 10			
`define END_COUNT 25
module TestBench;

//Internal Signals
reg         CLK;
reg         RST;
integer     count;
integer     handle;
integer     end_count;
//Greate tested modle  
Simple_Single_CPU cpu(
        .clk_i(CLK),
		.rst_i(RST)
		);
 
//Main function

always #(`CYCLE_TIME/2) CLK = ~CLK;	

initial  begin
	$dumpfile("tb_wave.vcd");
	$dumpvars(0, cpu);

    handle = $fopen("CO_P2_Result.txt");
	CLK = 0;
    RST = 0;
	count = 0;
    end_count=25;
    #(`CYCLE_TIME)      RST = 1;
    #(`CYCLE_TIME*`END_COUNT)	$fclose(handle); $finish;
end

//Print result to "CO_P2_Result.txt"
always@(posedge CLK) begin
    count = count + 1;
	if( count == `END_COUNT ) begin 
    $fdisplay(handle, "r0=%d, r1=%d, r2=%d, r3=%d, r4=%d, r5=%d, r6=%d, r7=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d",
	          cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4], 
			  cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7], cpu.RF.Reg_File[8], cpu.RF.Reg_File[9], 
			  cpu.RF.Reg_File[10],cpu.RF.Reg_File[11], cpu.RF.Reg_File[12]
			  );
	end
	else ;
end
  
endmodule
