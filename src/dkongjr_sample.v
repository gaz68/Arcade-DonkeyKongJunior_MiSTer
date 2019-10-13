

module dkongjr_sample(

O_ROM_AB,
I_ROM_DB,
I_SAM_ADDR, // New e.g. Jump_cnt  = 15'h2000
I_SAM_LEN, // New e.g. Jump_cnt  = 15'h2000

I_CLK,
I_RSTn,
I_SW
//O_DEBUG
);

output [18:0]O_ROM_AB; 
input  [7:0]I_ROM_DB;
input  [15:0]I_SAM_ADDR;
input  [14:0]I_SAM_LEN;

input  I_CLK,I_RSTn;
input  [4:0]I_SW; 
//output [2:0]O_DEBUG; 

parameter Sample_div = 2228;

//parameter Walk_cnt  = 15'h0708; // 10000 - 107FF
//parameter Climb_cnt = 15'h0800; // 10000 - 107FF 
//parameter Jump_cnt  = 15'h2000; // 14000 - 15FFF
//parameter Land_cnt  = 15'h2000; // 16000 - 17FFF
//parameter Fall_cnt  = 15'h4E50; // 18000 - 1CFFF

reg   [11:0]sample;
reg   sample_pls;

always@(posedge I_CLK or negedge I_RSTn)
begin
  if(! I_RSTn)begin
    sample <= 0;
    sample_pls <= 0;
  end else begin
    sample <= (sample == Sample_div-1) ? 0 : sample+1;
    sample_pls <= (sample == Sample_div-1)? 1 : 0 ;
  end
end

//-----------  WALK SOUND ------------------------------------------
//reg    [1:0]sw0,sw1,sw2,sw3,sw4;
reg    [1:0]sw;
reg    status;
reg    status1;
reg    [2:0]status2;
reg    [14:0]ad_cnt;
reg    [14:0]end_cnt;
reg	[15:0] wav_addr;

always@(posedge I_CLK or negedge I_RSTn)
begin
  if(! I_RSTn)begin
    sw <= 0;
    status0 <= 0;
    status1 <= 0;
    status2 <= 1;
    end_cnt <= Land_cnt;
    ad_cnt  <= 0;
  end else begin
  	 
    sw[0] <= ~I_SW[2]; // Land
    sw[1] <= sw[0];
    status <= ~sw[1] & sw[0];

    sw4[0] <= ~I_SW[4]; // Climb

    if((status2==3'b100) & ~I_SW[3]) begin
		ad_cnt <= end_cnt; 
	 end

	 if(status)begin
      ad_cnt <= 0;
		status1 <= 1;
		addr <= I_SAM_ADDR;
      end_cnt <= I_SAM_LEN;
    end 
	 else begin
      if(sample_pls)begin
        if(ad_cnt >= I_SAM_LEN) begin
          status1 <= 0;
          ad_cnt <= ad_cnt; 
        end else begin
          wav_addr <= wav_addr+1;
          ad_cnt <= ad_cnt+1 ;
        end
      end
    end
  end
end

assign O_ROM_AB  = wav_addr;

endmodule
