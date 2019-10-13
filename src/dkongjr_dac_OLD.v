
// Signal decay circuit input to DAC-08 pin 14 (R20, C32, Q4).

module dkongjr_dac
(
	input		I_CLK,
	input		I_DECAY_EN,
	input  	I_RESET_n,
	input		[7:0]I_SND_DAT,
	output	[7:0]O_SND_DAT
);

//parameter Sample_cnt = 2228;
parameter Sample_cnt = 1114;
reg   [11:0]sample;
reg   sample_pls;

always@(posedge I_CLK or negedge I_RESET_n)
begin
  if(! I_RESET_n)begin
    sample <= 0;
    sample_pls <= 0;
  end else begin
    sample <= (sample == Sample_cnt-1) ? 0 : sample+1;
    sample_pls <= (sample == Sample_cnt-1)? 1 : 0 ;
  end
end

//parameter sam_cnt_end = 16'h3FFF;
parameter sam_cnt_end = 16'h7FFF;

reg   [15:0]sam_cnt;

//wire [7:0] W_SND_TC = {~I_SND_DAT[7],I_SND_DAT[6:0]};

//wire 	[7:0]W_SND_DAT50 = {1'b0,I_SND_DAT[7:1]} - 64;
//wire 	[7:0]W_SND_DAT25 = {2'b00,I_SND_DAT[7:2]} - 32;
//wire 	[7:0]W_SND_DAT12 = {3'b000,I_SND_DAT[7:3]} - 16;
//wire 	[7:0]W_SND_DAT6  = {4'b0000,I_SND_DAT[7:4]} - 8;

//wire 	[7:0]W_SND_DAT50 = {W_SND_TC[7],W_SND_TC[7:1]};
wire 	[7:0]W_SND_DAT50 = {~I_SND_DAT[7],~I_SND_DAT[7],I_SND_DAT[6:1]}; // 2's comp.
wire 	[7:0]W_SND_DAT25 = {W_SND_DAT50[7],W_SND_DAT50[7:1]};
wire 	[7:0]W_SND_DAT12 = {W_SND_DAT25[7],W_SND_DAT25[7:1]};
wire 	[7:0]W_SND_DAT6  = {W_SND_DAT12[7],W_SND_DAT12[7:1]};

reg	[7:0]snd;

always@(posedge I_CLK or negedge I_RESET_n)
begin
  if(! I_RESET_n) begin
    sam_cnt <= 0;
  end
  else begin
		
		if (sample_pls) begin
			sam_cnt <= (I_DECAY_EN) ? ((sam_cnt == sam_cnt_end-1) ? sam_cnt : sam_cnt+1) : 0;
		end
		
		//if(sam_cnt < 71) begin
		if(sam_cnt < 142) begin
			snd <= {~I_SND_DAT[7],I_SND_DAT[6:0]};
	   end
		//else if(sam_cnt < 147) begin
		else if(sam_cnt < 294) begin
			snd <= W_SND_DAT50 + W_SND_DAT25 + W_SND_DAT12 + W_SND_DAT6; // 93.75 
		end
		//else if(sam_cnt < 229) begin
		else if(sam_cnt < 458) begin
			snd <= W_SND_DAT50 + W_SND_DAT25 + W_SND_DAT12; // 87.5
		end
		//else if(sam_cnt < 317) begin
		else if(sam_cnt < 634) begin
			snd <= W_SND_DAT50 + W_SND_DAT25 + W_SND_DAT6; //81.25
		end
		//else if(sam_cnt < 413) begin
		else if(sam_cnt < 826) begin
			snd <= W_SND_DAT50 + W_SND_DAT25; //75
		end
		//else if(sam_cnt < 518) begin
		else if(sam_cnt < 1036) begin
			snd <= W_SND_DAT50 + W_SND_DAT12 + W_SND_DAT6; // 68.75
		end
		//else if(sam_cnt < 674) begin
		else if(sam_cnt < 1348) begin
			snd <= W_SND_DAT50 + W_SND_DAT12; //62.5
		end
		//else if(sam_cnt < 764) begin
		else if(sam_cnt < 1528) begin
			snd <= W_SND_DAT50 + W_SND_DAT6; //56.25
		end
		//else if(sam_cnt < 911) begin
		else if(sam_cnt < 1822) begin
			snd <= W_SND_DAT50; // 50
		end
		//else if(sam_cnt < 1081) begin
		else if(sam_cnt < 2162) begin
			snd <= W_SND_DAT25 + W_SND_DAT12 + W_SND_DAT6; // 43.75
		end
		//else if(sam_cnt < 1282) begin
		else if(sam_cnt < 2564) begin
			snd <= W_SND_DAT25 + W_SND_DAT12; // 37.5
		end
		//else if(sam_cnt < 1528) begin
		else if(sam_cnt < 3056) begin
			snd <= W_SND_DAT25 + W_SND_DAT6; // 31.25
		end
		//else if(sam_cnt < 1845) begin
		else if(sam_cnt < 3690) begin
			snd <= W_SND_DAT25; // 25
		end
		//else if(sam_cnt < 2292) begin
		else if(sam_cnt < 4584) begin
			snd <= W_SND_DAT12 + W_SND_DAT6; // 18.75
		end
		//else if(sam_cnt < 3056) begin
		else if(sam_cnt < 6112) begin
			snd <= W_SND_DAT12; // 12.5
		end
		else begin
			snd <= W_SND_DAT6; //6.25
		end
  end
end

assign O_SND_DAT	= {~snd[7],snd[6:0]};

endmodule
