module semaforo(
	input wire clk,
	input wire btn,
	output reg green,
	output reg yellow,
	output reg red);
	
	reg [1:0] state; // registrador do estado
	reg [4:0] count; // contagem dos ciclos 
	
	parameter verde = 2'b00;
	parameter verdbtn = 2'b01; // estados da maquina
	parameter amarelo = 2'b10;
	parameter vermelho = 2'b11;
	
	initial begin // setando inicialmente
		state = 2'b00;
		green = 1'b0;
		yellow = 1'b0;
		red = 1'b0;
		count = 5'b00000;
	end
	
	always @(posedge clk) begin
		
		case (state)
			verde: begin // se o state == verde
				red = 1'b0; // se tivessemos vindo do estado vermelho precisariamos abaixar o output vermelho
				green = 1'b1; // levantar sinal de output do sinal verde
				if (btn == 1'b1) begin
					count = count/2; // cortamos metade do que precisariamos contar
					state = verdbtn; // vamos para o estado especial onde foi apertado o botão verde
				end else begin
					if (count == 5'b10011) begin // quando chegamos no limite do contador do estado verde
						state = amarelo; // vai pro proximo estado
						count = 5'b00000; // renicializa contador
					end else begin
						state = verde; // continuanos no estado verde
						count = count - 1; // no caso inicial onde o contador é 0 (0-1 = -1) -1 em 5bits fica 11111 (inicializando o maximo)
					end
				end
			end
			verdbtn: begin // estado especial onde foi levantado o botão
				red = 1'b0;
				green = 1'b1;
				if (count == 5'b10011) begin
					count = 5'b00000;
					state = amarelo; // vai pro proximo estado
				end else begin
					count = count + 1;
					state = verdbtn;
				end
			end
			amarelo: begin // estado do sinal amarelo
				yellow = 1'b1; // saida para o sinal amarelo
				green = 1'b0; // abaixa o sinal verde
				if (count == 5'b01010) begin
					count = 5'b00000;
					state = vermelho; // vai pro proximo estado
				end else begin
					count = count + 1;
					state = amarelo;
				end
			end
			vermelho: begin
				yellow = 1'b0; // abaixa o sinal amarelo
				red = 1'b1; // saida para o sinal vermelho
				if (count == 5'b11110) begin
					count = 5'b00000; 
					state = verde; // renicializa para o estado inicial
				end else begin
					count = count + 1;
					state = vermelho;
				end
			end
		endcase
	end
endmodule