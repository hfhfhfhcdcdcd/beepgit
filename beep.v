module beep (
    input   rst     ,
    input   clk     ,
    output reg beep
);
/*----cnt_500ms-------------------------------*/
 reg [24:0] cnt_500ms;
 parameter time_500ms = 25_000_000;
 always @(posedge clk or negedge rst) begin
   if (!rst) begin
      cnt_500ms <= 25'd0;
   end
   else if (cnt_500ms == time_500ms - 1) begin
      cnt_500ms <= 25'd0;
   end
   else 
      cnt_500ms <= cnt_500ms + 25'd1;
 end
/*----freq_cnt-----------------------*/
 reg    [16:0]     freq_cnt     ;
 reg    [2:0]      cur_state    ;
 reg    [2:0]      next_state   ;
 parameter IDLE = 3'd0;
 parameter Do   = 3'd1;
 parameter Ri   = 3'd2;
 parameter Mi   = 3'd3;
 parameter Fa   = 3'd4;
 parameter So   = 3'd5;
 parameter La   = 3'd6;
 parameter Xi   = 3'd7; 
 parameter Do_freq = 2*95419 - 1 ; 
 parameter Ri_freq = 2*85034 - 1 ; 
 parameter Mi_freq = 2*75757 - 1 ; 
 parameter Fa_freq = 2*71633 - 1 ; 
 parameter So_freq = 2*63775 - 1 ; 
 parameter La_freq = 2*56818 - 1 ; 
 parameter Xi_freq = 2*50607 - 1 ;
 always @(posedge clk or negedge rst) begin
   if (!rst) begin
      freq_cnt <= 17'd0;
   end
   else case (cur_state)
      Do:begin
         if (freq_cnt == Do_freq) begin
            freq_cnt <= 17'd0;         
         end
         else
            freq_cnt <= freq_cnt + 17'd1;
      end 
      Ri:begin
         if (freq_cnt == Ri_freq) begin
               freq_cnt <= 17'd0;         
            end
            else
               freq_cnt <= freq_cnt + 17'd1;
      end
      Mi:begin
         if (freq_cnt == Mi_freq) begin
            freq_cnt <= 17'd0;         
         end
         else
            freq_cnt <= freq_cnt + 17'd1;
      end 
      Fa:begin
         if (freq_cnt == Fa_freq) begin
            freq_cnt <= 17'd0;         
         end
         else
            freq_cnt <= freq_cnt + 17'd1;
      end 
      So:begin
         if (freq_cnt == So_freq) begin
            freq_cnt <= 17'd0;         
         end
         else
            freq_cnt <= freq_cnt + 17'd1;
      end 
      La:begin
         if (freq_cnt == La_freq) begin
            freq_cnt <= 17'd0;         
         end  
         else
            freq_cnt <= freq_cnt + 17'd1;
      end
      Xi:begin
         if (freq_cnt == Xi_freq) begin
            freq_cnt <= 17'd0;         
         end   
         else
            freq_cnt <= freq_cnt + 17'd1;
      end 
      default:; 
    endcase
 end
/*----exec------IDLE到state_Do的触发信号--------*/
 reg exec;
 always @(posedge clk or negedge rst) begin
   if (!rst) begin
      exec <= 1'd0;
   end
   else if (cnt_500ms == time_500ms - 1) begin
      exec <= 1'd1;
   end
   else
      exec <= exec;
 end
/*----状态机1-----------------------*/
 always @(posedge clk or negedge rst) begin
   if (!rst) begin
      cur_state <= IDLE;
   end
   else
      cur_state <= next_state;
 end
/*----状态机2-----------------------*/
 always @(*) begin
   if (!rst) begin
      cur_state <= IDLE;
   end
   else case (cur_state)
      IDLE:begin
         if (exec) begin
            next_state = Do;
            cnt_500ms = 25'd0;

         end
         else begin
            next_state = IDLE;
            cnt_500ms = 25'd0;
         end            
      end
      Do  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = Ri;
         end
         else begin
            next_state = Do;
            cnt_500ms = 25'd0;
         end
      end
      Ri  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = Mi;
         end
         else begin
            next_state = Ri;
            cnt_500ms = 25'd0;
         end
      end
      Mi  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = Fa;
         end
         else begin
            next_state = Mi;
            cnt_500ms = 25'd0;
         end           
      end
      Fa  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = So;
         end
         else begin
            next_state = Fa;
            cnt_500ms = 25'd0;
         end            
      end
      So  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = La;
         end
         else begin
            next_state = So;
            cnt_500ms = 25'd0;
         end            
      end
      La  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = Xi;
         end
         else begin
            next_state = La;
            cnt_500ms = 25'd0;
         end            
      end
      Xi  :begin
         if (cnt_500ms == time_500ms - 1) begin
            next_state = IDLE;
         end
         else begin
            next_state = Xi;
            cnt_500ms = 25'd0;
         end            
      end
      default: ;
      endcase
 end
/*----状态机3-----------------------*/
 always @(*) begin
    if (!rst) begin
       beep = 1'b0;
    end
    else case (cur_state)
       IDLE :begin
             beep = 1'b0;
       end
       Do  :begin
             beep = 1'b1;
             if(freq_cnt == Do_freq/2-1)begin
                beep = 1'b0;
             end
       end
       Ri  :begin
             if(freq_cnt <= Ri_freq/2-1)begin
                beep = 1'b1;
             end
             else if (freq_cnt > Ri_freq/2-1) begin
                beep = 1'b0;
             end
       end
       Mi  :begin
             if (freq_cnt <= Mi_freq/2-1) begin
                beep = 1'b1;
             end
             else if (freq_cnt > Mi_freq/2-1) begin
                beep = 1'b0;
             end
       end
       Fa  :begin
             if (freq_cnt <= Fa_freq/2-1) begin
                beep = 1'b1;
             end
             else if (freq_cnt > Fa_freq/2-1) begin
                beep = 1'b0;
             end
       end
       So  :begin
             if (freq_cnt <= So_freq/2-1) begin
                beep = 1'b1;
             end
             else if (freq_cnt > So_freq/2-1) begin
                beep = 1'b0;
             end
       end
       La  :begin
             if (freq_cnt <= La_freq/2-1) begin
                beep = 1'b1;
             end
             else if (freq_cnt > La_freq/2-1) begin
                beep = 1'b0;
             end
       end
       Xi  :begin
             if (freq_cnt <= Xi_freq/2-1) begin
                beep = 1'b1;
             end
             else if (freq_cnt > Xi_freq/2-1) begin
                beep = 1'b0;
             end
       end
       default:;
    endcase
 end
endmodule