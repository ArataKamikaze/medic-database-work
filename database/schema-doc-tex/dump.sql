drop database if exists hospital;
create database hospital;
use hospital;

/* Lógico_1: */

CREATE TABLE Pessoa (
    CPF bigint unsigned PRIMARY KEY,
    nome varchar(50),
    estado_civil char(13) not null,
    sexo int not null,
    data_de_nascimento date not null,
    numero_do_telefone char(15) not null,
    cep char(9) not null,
    estado char(30) not null,
    cidade varchar(50) not null,
    bairro varchar(50) not null,
    logradouro varchar(53) not null,
    complemento int not null,
    numero int not null,
    email varchar(100)
);

CREATE TABLE Cliente (
    CPF bigint unsigned PRIMARY KEY
);

CREATE TABLE Funcionario (
    data_de_adminissao date not null,
    salario_bruto int not null,
    CPF bigint unsigned not null PRIMARY KEY,
    funcao_id int not null
);

CREATE TABLE Medico_Prestador_de_Servico (
    CRM bigint,
    CPF bigint unsigned,
    PRIMARY KEY (CRM, CPF)
);

CREATE TABLE Medico_funcionario (
    CRM bigint,
    CPF bigint unsigned,
    PRIMARY KEY (CRM, CPF)
);

CREATE TABLE Medico (
    CRM bigint PRIMARY KEY,
    escola_de_origem varchar(64) not null,
    tipo_de_residencia_medica_id int not null
);

CREATE TABLE Plano_de_saude (
    plano_de_saude_id int auto_increment PRIMARY KEY,
    nome varchar(20) not null,
    registro int not null
);

CREATE TABLE Tipo_de_tratamento (
    numero_esperados_de_atendimentos int,
    eh_cronico int not null,
    tipo_de_tratamento_id int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(30) not null
);

CREATE TABLE Tipo_de_atendimento (
    tipo_de_atendimento_id int auto_increment PRIMARY KEY,
    nome char(50) not null,
    duracao_esperada time not null,
    efeitos_colaterais varchar(1000) not null,
    preco int not null
);

CREATE TABLE especialidade (
    nome char(50) not null,
    especialidade_id int auto_increment PRIMARY KEY
);

CREATE TABLE Tratamento (
    tratamento_id int auto_increment PRIMARY KEY,
    tipo_de_tratamento_id int,
    cpf bigint
);

CREATE TABLE Atendimento (
    sala char(10) not null,
    atendimento_id int auto_increment PRIMARY KEY,
    horario_inicio_real datetime,
    horario_fim_real datetime,
    horario_agendado datetime,
    estado INT not null,
    crm bigint not null,
    plano_de_saude_id int,
    tipo_de_atendimento_id int,
    tratamento_id int,
    valor int not null,
    comissao_da_clinica int not null,
    data_de_recebimento datetime,
    valor_recebidos_por_medico int not null,
    data_do_reparsse_ao_medico datetime,
    imposto_retido int not null,
    valor_pago_pelo_plano int not null
);

CREATE TABLE Depedentes (
    CPF bigint unsigned,
    CPF_depedente bigint unsigned,
    PRIMARY KEY (CPF, CPF_depedente)
);

CREATE TABLE cliente_plano_de_saude (
    CPF bigint unsigned,
    plano_de_saude_id int,
    PRIMARY KEY (CPF, plano_de_saude_id)
);

CREATE TABLE medico_plano_de_saude (
    plano_de_saude_id int,
    CRM bigint
);

CREATE TABLE plano_de_saude_tipo_de_atendimento (
    plano_de_saude_id int,
    tipo_de_atendimento_id int,
    desconto int not null
);

CREATE TABLE atendimento_esperado (
    tipo_de_tratamento_id int,
    tipo_de_atendimento_id int,
    quantidade int not null,
    PRIMARY KEY (tipo_de_tratamento_id, tipo_de_atendimento_id)
);

CREATE TABLE medico_especialidade (
    CRM bigint,
    especialidade_id int,
    PRIMARY KEY (CRM, especialidade_id)
);

CREATE TABLE compete (
    tipo_de_atendimento_id int,
    especialidade_id int
);

CREATE TABLE doenca (
    doenca_id int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(50) not null
);

CREATE TABLE doencas_pre_existentes (
    doenca_id int,
    CPF bigint unsigned,
    PRIMARY KEY (CPF, doenca_id)
);

CREATE TABLE tipo_de_residencia_medica (
    tipo_de_residencia_medica_id int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(30) not null
);

CREATE TABLE funcao (
    nome char(30) not null,
    funcao_id int auto_increment PRIMARY KEY
);
 
ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_2
    FOREIGN KEY (CPF)
    REFERENCES Pessoa (CPF);
 
ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario_1
    FOREIGN KEY (CPF)
    REFERENCES Pessoa (CPF);
 
ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario_3
    FOREIGN KEY (funcao_id)
    REFERENCES funcao (funcao_id);
 
ALTER TABLE Medico_Prestador_de_Servico ADD CONSTRAINT FK_Medico_Prestador_de_Servico_2
    FOREIGN KEY (CRM)
    REFERENCES Medico (CRM)
    ON DELETE CASCADE;
 
ALTER TABLE Medico_Prestador_de_Servico ADD CONSTRAINT FK_Medico_Prestador_de_Servico_3
    FOREIGN KEY (CPF)
    REFERENCES Pessoa (CPF);
 
ALTER TABLE Medico_funcionario ADD CONSTRAINT FK_Medico_funcionario_2
    FOREIGN KEY (CRM)
    REFERENCES Medico (CRM)
    ON DELETE CASCADE;
 
ALTER TABLE Medico_funcionario ADD CONSTRAINT FK_Medico_funcionario_3
    FOREIGN KEY (CPF)
    REFERENCES Funcionario (CPF);
 
ALTER TABLE Medico ADD CONSTRAINT FK_Medico_2
    FOREIGN KEY (tipo_de_residencia_medica_id)
    REFERENCES tipo_de_residencia_medica (tipo_de_residencia_medica_id);
 
ALTER TABLE Tratamento ADD CONSTRAINT FK_Tratamento_2
    FOREIGN KEY (tipo_de_tratamento_id)
    REFERENCES Tipo_de_tratamento (tipo_de_tratamento_id);
 
ALTER TABLE Tratamento ADD CONSTRAINT FK_Tratamento_3
    FOREIGN KEY (cpf)
    REFERENCES Cliente (CPF);
 
ALTER TABLE Atendimento ADD CONSTRAINT FK_Atendimento_2
    FOREIGN KEY (crm)
    REFERENCES Medico (CRM);
 
ALTER TABLE Atendimento ADD CONSTRAINT FK_Atendimento_3
    FOREIGN KEY (tipo_de_atendimento_id)
    REFERENCES Tipo_de_atendimento (tipo_de_atendimento_id);
 
ALTER TABLE Atendimento ADD CONSTRAINT FK_Atendimento_4
    FOREIGN KEY (tratamento_id)
    REFERENCES Tratamento (tratamento_id);
 
ALTER TABLE Atendimento ADD CONSTRAINT FK_Atendimento_5
    FOREIGN KEY (plano_de_saude_id)
    REFERENCES Plano_de_saude (plano_de_saude_id);
 
ALTER TABLE Depedentes ADD CONSTRAINT FK_Depedentes_1
    FOREIGN KEY (CPF)
    REFERENCES Funcionario (CPF);
 
ALTER TABLE Depedentes ADD CONSTRAINT FK_Depedentes_3
    FOREIGN KEY (CPF_depedente)
    REFERENCES Pessoa (CPF);
 
ALTER TABLE cliente_plano_de_saude ADD CONSTRAINT FK_cliente_plano_de_saude_1
    FOREIGN KEY (CPF)
    REFERENCES Cliente (CPF)
    ON DELETE SET NULL;
 
ALTER TABLE cliente_plano_de_saude ADD CONSTRAINT FK_cliente_plano_de_saude_2
    FOREIGN KEY (plano_de_saude_id)
    REFERENCES Plano_de_saude (plano_de_saude_id)
    ON DELETE SET NULL;
 
ALTER TABLE medico_plano_de_saude ADD CONSTRAINT FK_medico_plano_de_saude_1
    FOREIGN KEY (plano_de_saude_id)
    REFERENCES Plano_de_saude (plano_de_saude_id)
    ON DELETE SET NULL;
 
ALTER TABLE medico_plano_de_saude ADD CONSTRAINT FK_medico_plano_de_saude_2
    FOREIGN KEY (CRM)
    REFERENCES Medico (CRM)
    ON DELETE SET NULL;
 
ALTER TABLE plano_de_saude_tipo_de_atendimento ADD CONSTRAINT FK_plano_de_saude_tipo_de_atendimento_1
    FOREIGN KEY (plano_de_saude_id)
    REFERENCES Plano_de_saude (plano_de_saude_id)
    ON DELETE RESTRICT;
 
ALTER TABLE plano_de_saude_tipo_de_atendimento ADD CONSTRAINT FK_plano_de_saude_tipo_de_atendimento_2
    FOREIGN KEY (tipo_de_atendimento_id)
    REFERENCES Tipo_de_atendimento (tipo_de_atendimento_id)
    ON DELETE RESTRICT;
 
ALTER TABLE atendimento_esperado ADD CONSTRAINT FK_atendimento_esperado_2
    FOREIGN KEY (tipo_de_tratamento_id)
    REFERENCES Tipo_de_tratamento (tipo_de_tratamento_id);
 
ALTER TABLE atendimento_esperado ADD CONSTRAINT FK_atendimento_esperado_3
    FOREIGN KEY (tipo_de_atendimento_id)
    REFERENCES Tipo_de_atendimento (tipo_de_atendimento_id);
 
ALTER TABLE medico_especialidade ADD CONSTRAINT FK_medico_especialidade_1
    FOREIGN KEY (CRM)
    REFERENCES Medico (CRM)
    ON DELETE SET NULL;
 
ALTER TABLE medico_especialidade ADD CONSTRAINT FK_medico_especialidade_2
    FOREIGN KEY (especialidade_id)
    REFERENCES especialidade (especialidade_id)
    ON DELETE SET NULL;
 
ALTER TABLE compete ADD CONSTRAINT FK_compete_1
    FOREIGN KEY (tipo_de_atendimento_id)
    REFERENCES Tipo_de_atendimento (tipo_de_atendimento_id)
    ON DELETE RESTRICT;
 
ALTER TABLE compete ADD CONSTRAINT FK_compete_2
    FOREIGN KEY (especialidade_id)
    REFERENCES especialidade (especialidade_id)
    ON DELETE SET NULL;
 
ALTER TABLE doencas_pre_existentes ADD CONSTRAINT FK_doencas_pre_existentes_1
    FOREIGN KEY (doenca_id)
    REFERENCES doenca (doenca_id);
 
ALTER TABLE doencas_pre_existentes ADD CONSTRAINT FK_doencas_pre_existentes_3
    FOREIGN KEY (CPF)
    REFERENCES Cliente (CPF);
	
delimiter $$

insert into Plano_de_saude(nome, registro) values ("nenhum", 0);$$

drop trigger if exists colocar_cliente_no_plano_nenhum;$$
create trigger colocar_cliente_no_plano_nenhum
	after insert on cliente
	for each row
	begin
		insert into cliente_plano_de_saude 
        (cpf, plano_de_saude_id) values
        (new.cpf, 1);
	end$$
    
drop trigger if exists colocar_medico_no_plano_nenhum;$$
create trigger colocar_medico_no_plano_nenhum
	after insert on medico
	for each row
	begin
		insert into medico_plano_de_saude 
        (crm, plano_de_saude_id) values
        (new.crm, 1);
	end$$
    
drop trigger if exists colocar_tipo_de_atendimento_no_plano_nenhum;$$
create trigger colocar_tipo_de_atendimento_no_plano_nenhum
	after insert on medico
	for each row
	begin
		insert into plano_de_saude_tipo_de_atendimento 
        (plano_de_saude_id, tipo_de_atendimento_id, desconto) values
        (1, new.crm, 0);
	end$$

SET GLOBAL log_bin_trust_function_creators = 1;
delimiter $$

# página 1

drop function if exists obter_n_atendimentos_proximo;$$
create function obter_n_atendimentos_proximo()
	returns int
    begin
		declare n int; 
		
		select ceil(count(*)/10) into n
		from atendimento
		join (
				select nome, numero_do_telefone, tratamento_id, cpf from pessoa join tratamento using (cpf)
			) as A using (tratamento_id)
		where DATEDIFF(horario_agendado, now()) between 0 and 14;
        
        return n;
    end $$

drop procedure if exists atendimentos_proximos;$$
create procedure atendimentos_proximos(in k int)
	begin
		set k = k * 10;
    
		select A.nome, A.numero_do_telefone,
				(
					select nome from pessoa join 
						(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
						where A.CRM = atendimento.crm
				) as nome_medico,
				(
					select nome from tipo_de_atendimento where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
				) as tipo_de_atendimento, horario_agendado,
                atendimento_id
		from atendimento
		join (
				select nome, numero_do_telefone, tratamento_id, cpf from pessoa join tratamento using (cpf)
			) as A using (tratamento_id)
		where DATEDIFF(horario_agendado, now()) between 0 and 14
		order by horario_agendado
        limit k, 10;
	end$$


drop function if exists obter_n_tratamentos_cronicos_proximos_de_estourar;$$
create function obter_n_tratamentos_cronicos_proximos_de_estourar()
	returns int
    begin
		declare result int;
        
		select ceil(count(*)/10) into result
		from tratamento
			join tipo_de_tratamento using(tipo_de_tratamento_id)
			join pessoa using(cpf)
		where tipo_de_tratamento.eh_cronico = 1
			and not exists (
				select * from atendimento where atendimento.tratamento_id = tratamento.tratamento_id and estado = 1
				)
			and 14 >= all(
				select datediff(date_add(horario_agendado, interval 6 month), now())
				from atendimento
				where atendimento.estado = 0
					and atendimento.tratamento_id = tratamento.tratamento_id);
		return result;
    end $$

drop procedure if exists tratamentos_cronicos_proximos_de_estourar;$$
create procedure tratamentos_cronicos_proximos_de_estourar(in k int)
	begin
		set k = k * 10;
    
		select pessoa.nome as nome_do_cliente,
			tipo_de_tratamento.nome as tipo_de_tratamento,
			pessoa.numero_do_telefone as numero_do_telefone,
			tratamento.tratamento_id as tratamento_id
		from tratamento
			join tipo_de_tratamento using(tipo_de_tratamento_id)
			join pessoa using(cpf)
		where tipo_de_tratamento.eh_cronico = 1
			and not exists (
				select * from atendimento where atendimento.tratamento_id = tratamento.tratamento_id and estado = 1
				)
			and 14 >= all(
				select datediff(date_add(horario_agendado, interval 6 month), now())
				from atendimento
				where atendimento.estado = 0
					and atendimento.tratamento_id = tratamento.tratamento_id)
		limit k, 10;
    end$$

# página 2

drop procedure if exists dados_clientes_estado_civil;$$
create procedure dados_clientes_estado_civil()
	begin
        select estado_civil, count(*) as quant
		from pessoa join cliente using(cpf)
		group by estado_civil;
    end$$
    
drop procedure if exists dados_clientes_idade;$$
create procedure dados_clientes_idade(out media real, out mediana real, out desvio real)
	begin
		declare quant int;
        declare amplitude int;
        declare classes int;
        
		select avg(idade) into media
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join cliente using(cpf)) as A;
            
		select std(idade) into desvio
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join cliente using(cpf)) as A;
            
        select count(cpf) into quant from pessoa join cliente using(cpf);
        
        select avg(idade) into mediana
        from (
			select @linha:=@linha+1 as pos, timestampdiff(YEAR,data_de_nascimento,now()) as idade
				from pessoa join cliente using(cpf), (select @linha := 0) as r
        ) as valores_medios
        where pos = floor(250/2) or pos = ceil(250/2);
        
        select max(idade) - min(idade) into amplitude
        from(
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join cliente using(cpf)
        ) as A;      
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(idade/classes) * classes) as  x, count(*) as y
        from (
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join cliente using(cpf)
        ) as A
        group by floor(idade/classes);
    end$$

drop function if exists obter_n_lista_de_clientes;$$
create function obter_n_lista_de_clientes(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from pessoa join cliente using (cpf)
	where nome like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_clientes;$$
create procedure lista_de_clientes(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, sexo, numero_do_telefone, cpf
	from pessoa join cliente using (cpf)
    where nome like concat("%",filtro,"%")
    limit k, 10;
end$$

#página 3

drop procedure if exists medicos_funcionarios_vs_prestadores;$$
create procedure medicos_funcionarios_vs_prestadores()
    begin
		declare total real;
        declare funcionarios real;
		
        select count(*) into total from medico;
		select count(*) into funcionarios from medico_funcionario;
		
        
        select total, funcionarios, total - funcionarios as prestadores from dual;
    end$$
    
drop procedure if exists dados_das_especialidades_quant_medicos;$$
create procedure dados_das_especialidades_quant_medicos(out media real, out desvio_padrao real, out maximo int, out minimo int)
	begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome as nome, count(crm) as valor
				from especialidade
				join medico_especialidade using (especialidade_id)
				group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end$$

drop procedure if exists dados_das_especialidades_valores_arrecadados;$$
create procedure dados_das_especialidades_valores_arrecadados(out media real, out desvio_padrao real, out maximo int, out minimo int)
	begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome, sum(atendimento.valor) as valor
				from especialidade
				join medico_especialidade using(especialidade_id)
				join atendimento using(crm)
                group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end$$
    
drop procedure if exists dados_das_especialidades_quant_atendimentos;$$
create procedure dados_das_especialidades_quant_atendimentos(out media real, out desvio_padrao real, out maximo int, out minimo int)
	begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome as nome, count(crm) as valor
				from especialidade
				join medico_especialidade using (especialidade_id)
				join atendimento using (crm)
				group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end$$

drop procedure if exists dados_medicos_vs_quant_pacientes;$$
create procedure dados_medicos_vs_quant_pacientes(out media real, out desvio_padrao real, out maximo int, out minimo int)
	begin       
        drop view if exists temp_view;
        create view temp_view
			as select (
				select nome from pessoa join 
						(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
						where A.CRM = atendimento.crm
				) as nome, count(cpf) as valor
				from atendimento
				join tratamento using(tratamento_id)
				group by(crm)
				order by valor;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
              
        select valor as x, count(*) as y
        from temp_view
        group by x;
    end$$

drop function if exists obter_n_lista_de_medicos;$$
create function obter_n_lista_de_medicos(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_medicos;$$
create procedure lista_de_medicos(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end$$

drop function if exists obter_n_lista_de_medicos_prestadores;$$
create function obter_n_lista_de_medicos_prestadores(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join medico_prestador_de_servico as r using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_medicos_prestadores;$$
create procedure lista_de_medicos_prestadores(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join medico_prestador_de_servico as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end$$

drop function if exists obter_n_lista_de_medicos_funcionarios;$$
create function obter_n_lista_de_medicos_funcionarios(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join medico_funcionario using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_medicos_funcionarios;$$
create procedure lista_de_medicos_funcionarios(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join medico_funcionario using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end$$

drop procedure if exists dados_funcionarios_estado_civil;$$
create procedure dados_funcionarios_estado_civil()
	begin
        select estado_civil, count(*)
		from pessoa join funcionario using(cpf)
		group by estado_civil;
    end$$
    
drop procedure if exists dados_funcionarios_idade;$$
create procedure dados_funcionarios_idade(out media real, out mediana real, out desvio real)
	begin
		declare quant int;
        declare amplitude int;
        declare classes int;
        
		select avg(idade) into media
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join funcionario using(cpf)) as A;
            
		select std(idade) into desvio
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join funcionario using(cpf)) as A;
            
        select count(cpf) into quant from pessoa join funcionario using(cpf);
        
        select avg(idade) into mediana
        from (
			select @linha:=@linha+1 as pos, timestampdiff(YEAR,data_de_nascimento,now()) as idade
				from pessoa join funcionario using(cpf), (select @linha := 0) as r
        ) as valores_medios
        where pos = floor(quant/2) or pos = ceil(quant/2);
        
        select max(idade) - min(idade) into amplitude
        from(
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join funcionario using(cpf)
        ) as A;      
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(idade/classes) * classes) as  x, count(*) as y
        from (
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join funcionario using(cpf)
        ) as A
        group by floor(idade/classes);
    end$$
    
drop procedure if exists dados_funcionarios_salario;$$
create procedure dados_funcionarios_salario(out media real, out desvio real)
	begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, salario_bruto
				from funcionario
				join pessoa using(cpf);
        
		select avg(salario_bruto) into media from temp_view;
            
		select std(salario_bruto) into desvio from temp_view;
        
        select max(salario_bruto) - min(salario_bruto) into amplitude from temp_view;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(salario_bruto/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(salario_bruto/classes);
    end$$
    
drop function if exists obter_n_lista_de_funcionarios;$$
create function obter_n_lista_de_funcionarios(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from pessoa join funcionario using (cpf)
	where nome like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_funcionario;$$
create procedure lista_de_funcionario(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select pessoa.nome, funcao.nome as cargo, data_de_adminissao, sexo, numero_do_telefone, pessoa.cpf
	from pessoa join funcionario using (cpf)
    join funcao using(funcao_id)
    where pessoa.nome like concat("%",filtro,"%")
    limit k, 10;
end$$

drop procedure if exists dados_plano_de_saude_quantidade_cliente;$$
create procedure dados_plano_de_saude_quantidade_cliente(out media real, out desvio real, out minimo int, out maximo int)
	begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(cpf) as valor
				from plano_de_saude
				join cliente_plano_de_saude using(plano_de_saude_id)
				group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(valor/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(valor/classes);
    end$$
    
drop procedure if exists dados_plano_de_saude_atendimentos_aceitos;$$
create procedure dados_plano_de_saude_atendimentos_aceitos(out media real, out desvio real, out minimo int, out maximo int)
	begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(tipo_de_atendimento_id) as valor
			from plano_de_saude
			join plano_de_saude_tipo_de_atendimento using (plano_de_saude_id)
			group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select valor as  x, count(*) as y
        from temp_view
        group by valor;
    end$$
    
drop procedure if exists dados_plano_de_saude_quantidade_de_medicos;$$
create procedure dados_plano_de_saude_quantidade_de_medicos(out media real, out desvio real, out minimo int, out maximo int)
	begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(crm) as valor
			from plano_de_saude
			join medico_plano_de_saude using (plano_de_saude_id)
			group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(valor/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(valor/classes);
    end$$
    
drop procedure if exists dados_plano_de_saude_vs_desconto;$$
create procedure dados_plano_de_saude_vs_desconto(out media real, out desvio real, out minimo int, out maximo int)
	begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, sum(valor_pago_pelo_plano) as valor
				from plano_de_saude
				join atendimento using(plano_de_saude_id)
				group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select * from temp_view;
    end$$
    
drop function if exists obter_n_lista_de_planos;$$
create function obter_n_lista_de_planos(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from plano_de_saude
	where nome like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_planos;$$
create procedure lista_de_planos(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, plano_de_saude_id
	from plano_de_saude
    where nome like concat("%",filtro,"%")
    limit k, 10;
end$$

drop procedure if exists obter_dados_tratamentos_cronicos;$$
create procedure obter_dados_tratamentos_cronicos()
begin
    select eh_cronico, count(*) as quant
    from tratamento join tipo_de_tratamento using(tipo_de_tratamento_id)
    group by eh_cronico;
end$$

drop procedure if exists obter_dados_tratamentos_quantidades;$$
create procedure obter_dados_tratamentos_quantidades()
begin
    select nome, count(*) as quant
    from tratamento join tipo_de_tratamento using(tipo_de_tratamento_id)
    group by tipo_de_tratamento_id;
end$$

drop function if exists obter_n_lista_de_tratamentos;;$$
create function obter_n_lista_de_tratamentos(filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from tratamento	join pessoa using (cpf)
	where pessoa.nome like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists lista_de_tratamentos;$$
create procedure lista_de_tratamentos(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select tratamento_id, pessoa.nome as cliente_nome, tipo_de_tratamento.nome as tipo_de_tratamento, count(*) as quant_de_atendimentos
	from tratamento
		join tipo_de_tratamento using (tipo_de_tratamento_id)
		join pessoa using (cpf)
		join atendimento using(tratamento_id)
	group by tratamento_id
    limit k, 10;
end$$

drop procedure if exists obter_dados_atendimentos_realizados$$
create procedure obter_dados_atendimentos_realizados(in inicio date, in fim date)
begin
	select
		avg(valor) as valor_recebido_media,
		std(valor) as valor_recebido_desvio,
		sum(valor) as valor_recebido_soma,
		avg(comissao_da_clinica) as valor_arrecadado_media,
		std(comissao_da_clinica) as valor_arrecadado_desvio,
		sum(comissao_da_clinica) as valor_arrecadado_total,
		count(*) as quantidade
	from atendimento
	where horario_inicio_real between inicio and fim
    and estado = 1;
end;$$

drop function if exists obter_n_atendimentos_realizados;$$
create function obter_n_atendimentos_realizados(horario_inicio date, horario_fim date)
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		FROM atendimento
		join tratamento using(tratamento_id)
        join pessoa using(cpf)
		where horario_inicio_real between horario_inicio and horario_fim
        and atendimento.estado = 1;
    
    return n;
end$$

drop procedure if exists lista_de_atendimentos_realizados;$$
create procedure lista_de_atendimentos_realizados(in k int, horario_inicio date, horario_fim date)
begin
	set k = k * 10;

	SELECT cliente.nome as nome_cliente,
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento,
		(
			select nome
			from pessoa
			join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
			where r.crm = atendimento.crm
		) as nome_medico, horario_inicio_real, 
		atendimento_id
	FROM atendimento
	join tratamento using(tratamento_id)
    join pessoa as cliente using(cpf)
	where horario_inicio_real between horario_inicio and horario_fim
    and atendimento.estado = 1
    limit k, 10;
end$$

drop procedure if exists obter_dados_atendimentos_agendados$$
create procedure obter_dados_atendimentos_agendados(in inicio date, in fim date)
begin
	select
		avg(valor) as valor_recebido_media,
		std(valor) as valor_recebido_desvio,
		sum(valor) as valor_recebido_soma,
		avg(comissao_da_clinica) as valor_arrecadado_media,
		std(comissao_da_clinica) as valor_arrecadado_desvio,
		sum(comissao_da_clinica) as valor_arrecadado_total,
		count(*) as quantidade
	from atendimento
	where horario_agendado between inicio and fim
    and atendimento.estado = 0;
end;$$

drop function if exists obter_n_atendimentos_agendados;$$
create function obter_n_atendimentos_agendados(horario_inicio date, horario_fim date)
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		FROM atendimento
		join tratamento using(tratamento_id)
        join pessoa using(cpf)
		where horario_agendado between horario_inicio and horario_fim
        and atendimento.estado = 0;
    
    return n;
end$$

drop procedure if exists lista_de_atendimentos_agendados;$$
create procedure lista_de_atendimentos_agendados(in k int, horario_inicio date, horario_fim date)
begin
	set k = k * 10;

	SELECT cliente.nome as nome_cliente,
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento,
		(
			select nome
			from pessoa
			join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
			where r.crm = atendimento.crm
		) as nome_medico, horario_agendado, 
		atendimento_id
	FROM atendimento
	join tratamento using(tratamento_id)
    join pessoa as cliente using(cpf)
	where horario_agendado between horario_inicio and horario_fim
    and atendimento.estado = 0
    limit k, 10;
end$$

drop procedure if exists obter_dados_pessoais;$$
create procedure obter_dados_pessoais(cpf bigint)
begin
	select cpf, nome, estado_civil, sexo, data_de_nascimento, timestampdiff(YEAR,data_de_nascimento,now()) as idade, cep, estado, cidade, bairro, logradouro, numero, complemento, email, numero_do_telefone
from pessoa
join cliente using(cpf)
where cliente.cpf = cpf;
end;$$

drop function if exists CRM_para_CPF;$$
create function CRM_para_CPF(crm bigint)
returns bigint
begin
	declare result bigint;

	select cpf into result from pessoa join 
		(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
		where A.CRM = crm;
        
	return result;
end;$$

drop procedure if exists atendimentos_realizados_por_cliente_dados;$$
create procedure atendimentos_realizados_por_cliente_dados(cpf bigint)
begin
	select count(*) as quant, max(horario_inicio_real) as data_ultima_consulta
		from atendimento join tratamento
		where atendimento.estado=1 and tratamento.cpf = cpf;
end;$$


drop function if exists obter_n_atendimentos_realizados_por_um_cliente;$$
create function obter_n_atendimentos_realizados_por_um_cliente(cpf_entrada bigint, filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_inicio_real, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists atendimentos_realizados_por_um_cliente_lista;$$
create procedure atendimentos_realizados_por_um_cliente_lista(in k int, cpf_entrada bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_inicio_real, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end;$$

drop procedure if exists atendimentos_agendados_por_cliente_dados;$$
create procedure atendimentos_agendados_por_cliente_dados(cpf bigint)
begin
	select count(*) as quant, min(horario_agendado) as data_proxima_consulta
		from atendimento join tratamento
		where estado=0 and tratamento.cpf = cpf;
end;$$


drop function if exists obter_n_atendimentos_agendados_por_um_cliente;$$
create function obter_n_atendimentos_agendados_por_um_cliente(cpf_entrada bigint, filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_agendado, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=0
	) as r
	where nome_medico like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists atendimentos_agendados_por_um_cliente_lista;$$
create procedure atendimentos_agendados_por_um_cliente_lista(in k int, cpf_entrada bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_agendado, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=0
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end;$$

drop function if exists obter_n_tratamento_por_cliente;$$
create function obter_n_tratamento_por_cliente(cpf_entrada bigint)
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
    from tratamento
    where cpf = cpf_entrada;
    
    return n;
end$$

drop procedure if exists tratamentos_por_um_cliente_lista;$$
create procedure tratamentos_por_um_cliente_lista(in k int, cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome, count(atendimento_id) as quant_consultas, tratamento_id
	from tratamento
	join tipo_de_tratamento using(tipo_de_tratamento_id)
	join atendimento using(tratamento_id)
	where cpf = cpf_entrada
	group by tratamento_id
    limit k, 10;
end;$$

drop function if exists obter_n_planos_de_saude_de_um_cliente_lista;$$
create function obter_n_planos_de_saude_de_um_cliente_lista(cpf_entrada bigint)
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
    from plano_de_saude
	join cliente_plano_de_saude using(plano_de_saude_id)
	where cpf = cpf_entrada;
    
    return n;
end$$

drop procedure if exists planos_de_saude_de_um_cliente_lista;$$
create procedure planos_de_saude_de_um_cliente_lista(in k int,in cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome,
		(
		select count(tratamento_id)
		from tratamento
		join atendimento using(tratamento_id)
		where tratamento.cpf = cliente_plano_de_saude.cpf
			and atendimento.plano_de_saude_id = plano_de_saude.plano_de_saude_id
			and atendimento.estado=1
		) as quant_realizadas, (
			select count(tratamento_id)
			from tratamento
			join atendimento using(tratamento_id)
			where tratamento.cpf = cliente_plano_de_saude.cpf
				and atendimento.plano_de_saude_id = plano_de_saude.plano_de_saude_id
				and atendimento.estado=0
	) as quant_agendados from plano_de_saude
	join cliente_plano_de_saude using(plano_de_saude_id)
	where cpf = cpf_entrada
	group by plano_de_saude.plano_de_saude_id
    limit k, 10;
end;$$

drop procedure if exists lista_de_doencas_pre_existentes;$$
create procedure lista_de_doencas_pre_existentes(in cpf bigint)
begin
	select nome
	from doenca
	join doencas_pre_existentes using(doenca_id)
	where doencas_pre_existentes.cpf = cpf;
end;$$


drop procedure if exists lista_de_medicos;$$
create procedure lista_de_medicos(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end$$


drop function if exists obter_data_de_adminissao;$$
create function obter_data_de_adminissao(cpf_entrada bigint)
returns date
begin
	declare result date;
    
	select data_de_adminissao into result
	from funcionario
	where CPF = 26115330408;
    
    return result;
end;$$

drop function if exists obter_n_depedentes_de_um_funcionario;$$
create function obter_n_depedentes_de_um_funcionario(cpf_entrada bigint)
returns int
begin
	declare result int;
    
	select ceil(count(*)/10) into result
	from depedentes
	join pessoa
	on depedentes.CPF_depedente = pessoa.CPF
	where depedentes.CPF = cpf_entrada;
    
    return result;
end;$$

drop procedure if exists depedentes_de_um_funcionario;$$
create procedure depedentes_de_um_funcionario(in k int, in cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome, pessoa.cpf
	from depedentes
	join pessoa
	on depedentes.CPF_depedente = pessoa.CPF
	where depedentes.CPF = cpf_entrada
    limit k, 10;
end;$$

drop procedure if exists informacoes_escolares_de_um_medico;$$
create procedure informacoes_escolares_de_um_medico(in crm bigint)
begin
	select escola_de_origem, nome as tipo_de_residencia_medica
	from medico
	join tipo_de_residencia_medica using(tipo_de_residencia_medica_id)
	where crm = 3;
end;$$

drop function if exists obter_n_especialidades_de_um_medico;$$
create function obter_n_especialidades_de_um_medico(crm_entrada bigint)
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		from medico_especialidade join especialidade using(especialidade_id)
		where CRM = crm_entrada;
    
    return n;
end$$

drop procedure if exists especialidades_de_um_medico;$$
create procedure especialidades_de_um_medico(in k int, crm_entrada bigint)
begin
	set k = k * 10;

	select nome
	from medico_especialidade join especialidade using(especialidade_id)
	where CRM = crm_entrada
    limit k, 10;
end$$

drop function if exists obter_n_planos_de_saude_de_um_medico;$$
create function obter_n_planos_de_saude_de_um_medico(crm_entrada bigint)
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
		from plano_de_saude	join medico_plano_de_saude using(plano_de_saude_id)
		where CRM = crm_entrada;
    
    return n;
end$$

drop procedure if exists planos_de_saude_de_um_medico;$$
create procedure planos_de_saude_de_um_medico(in k int, crm_entrada bigint)
begin
	set k = k * 10;

	select nome
	from plano_de_saude	join medico_plano_de_saude using(plano_de_saude_id)
	where CRM = crm_entrada
    limit k, 10;
end$$

drop procedure if exists atendimentos_realizados_por_medico_dados;$$
create procedure atendimentos_realizados_por_medico_dados(crm bigint)
begin
	select count(*) as quant, max(horario_inicio_real) as data_ultima_consulta
		from atendimento
		where estado=1 and atendimento.crm = crm;
end;$$

drop function if exists obter_n_atendimentos_realizados_por_um_medico;$$
create function obter_n_atendimentos_realizados_por_um_medico(crm bigint, filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_inicio_real, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_cliente like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists atendimentos_realizados_por_um_medico_lista;$$
create procedure atendimentos_realizados_por_um_medico_lista(in k int, crm bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_inicio_real, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end;$$

drop procedure if exists atendimentos_agendados_por_medico_dados;$$
create procedure atendimentos_agendados_por_medico_dados(crm bigint)
begin
	select count(*) as quant, min(horario_agendado) as data_proxima_consulta
		from atendimento
		where estado=0 and atendimento.crm = crm;
end;$$

drop function if exists obter_n_atendimentos_agendados_por_um_medico;$$
create function obter_n_atendimentos_agendados_por_um_medico(crm bigint, filtro varchar(50))
returns int
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_agendado, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_cliente like concat("%",filtro,"%");
    
    return n;
end$$

drop procedure if exists atendimentos_agendados_por_um_medico_lista;$$
create procedure atendimentos_agendados_por_um_medico_lista(in k int, crm bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_medico, sala, horario_agendado, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end;$$

drop procedure if exists dados_sobre_atendimento_realizado;$$
create procedure dados_sobre_atendimento_realizado(in atendimento_id int)
	begin
		select horario_agendado, horario_inicio_real, horario_fim_real,
		(
			select nome
			from tratamento
			join pessoa using(cpf)
			where tratamento.tratamento_id = atendimento.tratamento_id
		) as nome_cliente,
		(
			select nome
			from pessoa join
			(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
			where A.CRM = atendimento.crm
		) as nome_medico,
		valor, comissao_da_clinica, valor_recebidos_por_medico, data_de_recebimento, data_do_reparsse_ao_medico, 
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento
	from atendimento
	where atendimento.atendimento_id=8; 
end;$$

drop function if exists verificar_se_existe_pessoa;$$
create function verificar_se_existe_pessoa(cpf bigint)
	returns int
	begin
		declare n int;
    
		select exists (
			select *
            from pessoa
            where pessoa.cpf = cpf
        ) into n from dual;
        
        return n;
    end$$



drop procedure if exists cadastrar_pessoa;$$
create procedure cadastrar_pessoa(in info json)
begin
	
    insert into pessoa (
		CPF,nome,estado_civil,sexo,data_de_nascimento,numero_do_telefone,cep,estado,cidade,bairro,logradouro,complemento,numero,email
    ) select 
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.nome')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.estado_civil')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.sexo')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.data_de_nascimento')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.numero_do_telefone')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.cep')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.estado')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.cidade')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.bairro')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.logradouro')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.complemento')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.numero')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.email'))
from dual;
end$$

drop procedure if exists obter_funcoes;$$
create procedure obter_funcoes()
begin
	select funcao_id, nome
    from funcao;
end$$

drop procedure if exists cadastrar_funcionario;$$
create procedure cadastrar_funcionario(in info json)
begin
	declare dependetes_do_funcionario json;
    DECLARE i INT;
    declare atual bigint;
    declare func_cpf bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')) into func_cpf from dual; 
    
    insert funcionario(data_de_adminissao, salario_bruto, CPF, funcao_id)
	select
		now(),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.salario_bruto')),
        func_cpf,
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.funcao_id'))
	from dual;
    
   select JSON_EXTRACT(info, '$.depedentes') into dependetes_do_funcionario  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(dependetes_do_funcionario, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert depedentes(CPF, CPF_depedente)
            select func_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
end$$

drop procedure if exists obter_tipos_de_residencia_medica;$$
create procedure obter_tipos_de_residencia_medica()
begin
	select tipo_de_residencia_medica_id, nome
    from tipo_de_residencia_medica;
end$$


drop procedure if exists obter_especialidades;$$
create procedure obter_especialidades()
begin
	select especialidade_id, nome
    from especialidade;
end$$

drop procedure if exists obter_plano_de_saude;$$
create procedure obter_plano_de_saude()
begin
	select plano_de_saude_id, nome
    from plano_de_saude;
end$$

drop procedure if exists cadastrar_medico;$$
create procedure cadastrar_medico(in info json)
begin
	declare especialidades_do_medico json;
    declare plano_de_saude_do_medico json;
    DECLARE i INT;
    declare atual bigint;
    declare medic_crm bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CRM')) into medic_crm from dual; 
    
    insert medico(crm, escola_de_origem, tipo_de_residencia_medica_id)
	select
		medic_crm,
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.escola_de_origem')),
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.tipo_de_residencia_medica_id'))
	from dual;
    
   select JSON_EXTRACT(info, '$.especialidades') into especialidades_do_medico  from dual;
   select JSON_EXTRACT(info, '$.planos_de_saude') into plano_de_saude_do_medico  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(especialidades_do_medico, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert medico_especialidade(CRM, especialidade_id)
            select medic_crm, atual;
            set i = i + 1;
		end if;
	end loop;
    
    set i = 0;
	label2:loop
		select JSON_EXTRACT(plano_de_saude_do_medico, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label2;
		else
			insert medico_plano_de_saude(CRM, plano_de_saude_id)
            select medic_crm, atual;
            set i = i + 1;
		end if;
	end loop;
end$$

drop procedure if exists cadastrar_medico_funcionario;$$
create procedure cadastrar_medico_funcionario(in crm bigint, in cpf bigint)
begin
	insert into medico_funcionario (CRM, CPF)
    values (crm, cpf);
end$$

drop procedure if exists cadastrar_medico_prestador_de_servico;$$
create procedure cadastrar_medico_prestador_de_servico(in crm bigint, in cpf bigint)
begin
	insert into medico_prestador_de_servico (CRM, CPF)
    values (crm, cpf);
end$$

drop procedure if exists obter_doencas;$$
create procedure obter_doencas()
begin
	select doenca_id, nome
    from doenca;
end$$

drop procedure if exists cadastrar_cliente;$$
create procedure cadastrar_cliente(in info json)
begin
	declare doencas_do_cliente json;
    declare planos_de_saude_do_cliente json;
    DECLARE i INT;
    declare atual bigint;
    declare client_cpf bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')) into client_cpf from dual; 
    
    insert cliente(cpf) values (client_cpf);
    
   select JSON_EXTRACT(info, '$.doencas_pre_existentes') into doencas_do_cliente  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(doencas_do_cliente, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert doencas_pre_existentes(CPF, doenca_id)
            select client_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
    
    select JSON_EXTRACT(info, '$.planos_de_saude') into planos_de_saude_do_cliente  from dual;
   
   set i = 0;
	label2:loop
		select JSON_EXTRACT(planos_de_saude_do_cliente, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label2;
		else
			insert cliente_plano_de_saude(CPF, plano_de_saude_id)
            select client_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
end$$

drop function if exists verificar_se_existe_cliente;$$
create function verificar_se_existe_cliente(cpf bigint)
	returns int
	begin
		declare n int;
    
		select exists (
			select *
            from cliente
            where cliente.cpf = cpf
        ) into n from dual;
        
        return n;
    end$$
    
drop procedure if exists obter_lista_completa_tratamentos_do_cliente;$$
create procedure obter_lista_completa_tratamentos_do_cliente(in cpf bigint)
begin
	SELECT nome FROM tratamento join cliente using(cpf) join tipo_de_tratamento using(tipo_de_tratamento_id);
end$$

drop procedure if exists obter_tipos_de_atendimento;$$
create procedure obter_tipos_de_atendimento()
begin
	SELECT nome FROM tipo_de_atendimento;
end$$

drop procedure if exists obter_planos_de_saude_validos;$$
create procedure obter_planos_de_saude_validos(in cpf bigint, in tipo_de_atendimento_id int)
begin
	select nome
	from plano_de_saude
	join plano_de_saude_tipo_de_atendimento using(plano_de_saude_id)
	join cliente_plano_de_saude using(plano_de_saude_id)
	where plano_de_saude_tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id and
	cliente_plano_de_saude.cpf = cpf;
end$$

drop procedure if exists obter_medicos_validos;$$
create procedure obter_medicos_validos(in plano_de_saude_id int, in tipo_de_atendimento_id int)
begin
	drop temporary table if exists crms;
	CREATE TEMPORARY TABLE crms(crm bigint);
	
    INSERT INTO crms(crm)
		select distinct medico_plano_de_saude.crm
		from medico_plano_de_saude join medico_especialidade using(crm)
		join compete using(especialidade_id)
		where compete.tipo_de_atendimento_id = tipo_de_atendimento_id
		and medico_plano_de_saude.plano_de_saude_id = plano_de_saude_id;
	
    select nome from pessoa join 
		(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
		join crms using(crm);
	drop temporary table if exists crms;
end$$

drop procedure if exists obter_tipos_de_tratamento;$$
create procedure obter_tipos_de_tratamento()
begin
	SELECT nome FROM hospital.tipo_de_tratamento;
end;$$

drop procedure if exists criar_tratamento;$$
create procedure criar_tratamento(in tipo_de_tratamento int, in cpf bigint)
begin
	insert into tratamento(tipo_de_tratamento_id, cpf)
    values (tipo_de_tratamento, cpf);
end;$$

drop procedure if exists agendar_atendimento;$$
create procedure agendar_atendimento(in info json)
begin
	#calcular:
    #comissao_da_clinica, valor_recebidos_por_medico, importo_retido, valor_pago_pelo_plano
    
    declare valor int;
	declare imposto_retido int;
    declare comissao_da_clinica int;
    declare valor_recebidos_por_medico int;
    declare eh_funcionario bool;
    declare valor_pago_pelo_plano int;
    declare tipo_de_atendimento_id int;
    declare plano_de_saude_id int;
    declare crm int;
    
    #JSON_UNQUOTE(JSON_EXTRACT(info, '$.salario_bruto'))
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.tipo_de_atendimento_id')) into tipo_de_atendimento_id;
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.plano_de_saude_id')) into plano_de_saude_id;
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.crm')) into crm;
    
    set comissao_da_clinica = 0;
    set valor_recebidos_por_medico = 0;
    
	select preco into valor
	from tipo_de_atendimento
	where tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id;
    
    set imposto_retido = floor(valor * 0.05);
	
    select exists (
	select *
	from medico_funcionario
	where medico_funcionario.CRM = crm) into eh_funcionario;
	
    if eh_funcionario then
		set comissao_da_clinica = floor(valor * 0.3);
        set valor_recebidos_por_medico = floor(valor * 0.65);
    else
		set comissao_da_clinica = floor(valor * 0.95);
    end if;
    
    select floor(desconto * valor / 100) into valor_pago_pelo_plano
		from plano_de_saude_tipo_de_atendimento
		where plano_de_saude_tipo_de_atendimento.plano_de_saude_id = plano_de_saude_id
		and plano_de_saude_tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id;
    
    if valor_pago_pelo_plano is null then
		set valor_pago_pelo_plano = 0;
    end if;
    
    insert atendimento (sala, horario_agendado, 
    estado, crm, plano_de_saude_id,
    tipo_de_atendimento_id, tratamento_id, valor,
    comissao_da_clinica, valor_recebidos_por_medico,
    imposto_retido, valor_pago_pelo_plano)
	select JSON_UNQUOTE(JSON_EXTRACT(info, '$.sala')),
    JSON_UNQUOTE(JSON_EXTRACT(info, '$.horario_agendado')),
    0,
    crm,
    plano_de_saude_id,
    tipo_de_atendimento_id,
    JSON_UNQUOTE(JSON_EXTRACT(info, '$.tratamento_id')),
    valor,
    comissao_da_clinica,
    valor_recebidos_por_medico,
    imposto_retido,
    valor_pago_pelo_plano;
end;

-- MySQL dump 10.13  Distrib 5.7.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital
-- ------------------------------------------------------
-- Server version	5.7.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `atendimento`
--

LOCK TABLES `atendimento` WRITE;
/*!40000 ALTER TABLE `atendimento` DISABLE KEYS */;
INSERT INTO `atendimento` VALUES ('C25',1,NULL,NULL,'2020-01-04 18:30:00',0,151424,9,16,1,32600,30970,'2020-01-12 18:30:00',0,'2020-01-19 18:30:00',1630,912800),('C70',2,NULL,NULL,'2019-01-09 11:00:00',0,155533,9,26,1,326300,309985,'2019-01-14 11:00:00',0,'2019-01-21 11:00:00',16315,12725700),('E72',3,NULL,NULL,'2020-07-08 16:00:00',0,45166,9,12,1,64500,61275,'2020-07-21 16:00:00',0,'2020-07-28 16:00:00',3225,2580000),('A34',4,NULL,NULL,'2020-06-08 14:30:00',0,116991,10,10,1,98700,93765,'2020-06-16 14:30:00',0,'2020-06-23 14:30:00',4935,7402500),('D4',5,NULL,NULL,'2020-07-08 11:30:00',0,162034,10,20,1,53600,50920,'2020-07-25 11:30:00',0,'2020-08-01 11:30:00',2680,482400),('B65',6,NULL,NULL,'2019-06-17 15:00:00',0,171249,21,1,2,1000,950,'2019-06-05 15:00:00',0,'2019-06-12 15:00:00',50,68000),('E20',7,NULL,NULL,'2020-01-10 13:30:00',0,44409,21,4,2,34300,32585,'2019-12-20 13:30:00',0,'2019-12-27 13:30:00',1715,720300),('C70',8,NULL,NULL,'2020-05-03 12:00:00',0,151983,21,16,2,32600,30970,'2020-05-04 12:00:00',0,'2020-05-11 12:00:00',1630,260800),('A85',9,NULL,NULL,'2020-06-24 13:30:00',0,116991,21,1,2,1000,950,'2020-07-04 13:30:00',0,'2020-07-11 13:30:00',50,68000),('E7',10,'2021-12-18 17:00:00','2021-12-18 18:15:00','2021-12-18 17:00:00',1,70454,22,10,2,98700,93765,NULL,0,NULL,4935,5231100),('C25',11,NULL,NULL,'2020-03-21 15:30:00',0,171249,21,8,2,54200,51490,'2020-03-17 15:30:00',0,'2020-03-24 15:30:00',2710,4390200),('D57',12,'2021-11-06 14:00:00','2021-11-06 18:35:00','2021-11-06 14:00:00',1,145728,21,3,2,34400,32680,NULL,0,NULL,1720,2373600),('E72',13,NULL,NULL,'2020-01-19 13:30:00',0,151424,23,1,3,1000,950,'2020-01-21 13:30:00',0,'2020-01-28 13:30:00',50,63000),('B70',14,'2021-08-17 09:30:00','2021-08-17 11:00:00','2021-08-17 09:00:00',1,119032,23,6,3,34300,32585,NULL,0,NULL,1715,2538200),('D26',15,NULL,NULL,'2021-01-14 17:00:00',0,151424,23,1,3,1000,950,'2021-01-29 17:00:00',0,'2021-02-05 17:00:00',50,63000),('E7',16,NULL,NULL,'2019-06-22 08:30:00',0,197201,10,7,3,6500,6175,'2019-06-13 08:30:00',0,'2019-06-20 08:30:00',325,78000),('A69',17,NULL,NULL,'2020-07-11 15:00:00',0,193394,10,26,3,326300,97890,'2020-07-17 15:00:00',212095,NULL,16315,26756600),('C54',18,NULL,NULL,'2020-12-23 15:47:40',0,203912,17,15,4,23500,22325,'2020-12-25 15:47:40',0,'2021-01-01 15:47:40',1175,963500),('E12',19,NULL,NULL,'2020-12-24 15:47:40',0,151434,15,22,4,64300,19290,'2020-12-11 15:47:40',41795,NULL,3215,2764900),('C50',20,NULL,NULL,'2020-12-20 15:47:40',0,151983,17,6,4,34300,32585,'2020-12-20 15:47:40',0,'2020-12-27 15:47:40',1715,1337700),('D72',21,NULL,NULL,'2020-12-17 15:47:40',0,43074,11,23,4,64300,61085,'2020-12-22 15:47:40',0,'2020-12-29 15:47:40',3215,643000),('C25',22,NULL,NULL,'2020-12-18 15:47:40',0,48475,15,15,4,23500,22325,'2020-12-27 15:47:40',0,'2021-01-03 15:47:40',1175,1762500),('A20',23,NULL,NULL,'2020-12-24 15:47:40',0,196879,23,9,4,34334,32617,'2020-12-24 15:47:40',0,'2020-12-31 15:47:40',1717,2712386),('D47',24,NULL,NULL,'2020-12-16 15:47:40',0,151424,17,16,4,32600,30970,'2020-12-14 15:47:40',0,'2020-12-21 15:47:40',1630,1662600),('C81',25,NULL,NULL,'2020-06-16 15:30:00',0,116991,21,10,5,98700,93765,'2020-06-09 15:30:00',0,'2020-06-16 15:30:00',4935,9771300),('C25',26,NULL,NULL,'2019-08-08 10:30:00',0,162428,21,23,5,64300,61085,'2019-07-28 10:30:00',0,'2019-08-04 10:30:00',3215,5079700),('D20',27,NULL,NULL,'2019-11-01 12:30:00',0,151983,21,6,5,34300,32585,'2019-10-28 12:30:00',0,'2019-11-04 12:30:00',1715,2023700),('B77',28,'2021-08-15 17:30:00','2021-08-15 19:50:00','2021-08-15 17:30:00',1,91314,21,9,5,34334,32617,NULL,0,NULL,1717,2403380),('A39',29,'2021-12-18 12:00:00','2021-12-18 12:35:00','2021-12-18 12:00:00',1,64372,17,22,5,64300,61085,NULL,0,NULL,3215,257200),('E20',30,NULL,NULL,'2020-12-18 15:47:40',0,77742,18,23,6,64300,19290,'2020-12-15 15:47:40',41795,NULL,3215,5401200),('D33',31,NULL,NULL,'2020-12-23 15:47:40',0,162034,18,7,6,6500,6175,'2020-12-23 15:47:40',0,'2020-12-30 15:47:40',325,513500),('C81',32,NULL,NULL,'2020-12-20 15:47:40',0,62082,18,1,6,1000,300,'2020-12-30 15:47:40',650,NULL,50,6000),('A28',33,NULL,NULL,'2020-12-24 15:47:40',0,91314,2,1,7,1000,950,'2021-01-09 15:47:40',0,'2021-01-16 15:47:40',50,97000),('E49',34,NULL,NULL,'2020-12-18 15:47:40',0,122365,23,7,7,6500,6175,'2020-12-26 15:47:40',0,'2021-01-02 15:47:40',325,123500),('E9',35,NULL,NULL,'2020-12-22 15:47:40',0,10286,2,11,7,45700,43415,'2020-11-25 15:47:40',0,'2020-12-02 15:47:40',2285,2650600),('E9',36,NULL,NULL,'2020-12-22 15:47:40',0,48475,2,12,7,64500,61275,'2020-12-10 15:47:40',0,'2020-12-17 15:47:40',3225,5031000),('C27',37,NULL,NULL,'2020-12-18 15:47:40',0,113404,23,6,7,34300,32585,'2020-12-27 15:47:40',0,'2021-01-03 15:47:40',1715,2538200),('C18',38,NULL,NULL,'2020-12-20 15:47:40',0,58390,2,25,7,32400,30780,'2020-12-14 15:47:40',0,'2020-12-21 15:47:40',1620,2430000),('A33',39,NULL,NULL,'2020-12-22 15:47:40',0,144810,2,1,7,1000,950,'2020-12-22 15:47:40',0,'2020-12-29 15:47:40',50,97000),('D72',40,NULL,NULL,'2019-02-07 17:00:00',0,57203,16,15,8,23500,22325,'2019-02-20 17:00:00',0,'2019-02-27 17:00:00',1175,1809500),('D33',41,NULL,NULL,'2021-05-08 18:00:00',0,122365,15,7,8,6500,6175,'2021-05-01 18:00:00',0,'2021-05-08 18:00:00',325,351000),('E72',42,'2021-11-18 11:30:00','2021-11-18 11:55:00','2021-11-18 11:30:00',1,77742,2,15,8,23500,7050,NULL,15275,NULL,1175,1269000),('C31',43,NULL,NULL,'2019-06-15 08:30:00',0,91314,13,11,8,45700,43415,'2019-06-17 08:30:00',0,'2019-06-24 08:30:00',2285,1462400),('E57',44,NULL,NULL,'2019-10-07 08:00:00',0,36867,16,10,8,98700,93765,'2019-09-29 08:00:00',0,'2019-10-06 08:00:00',4935,6020700),('E49',45,NULL,NULL,'2020-03-18 11:30:00',0,144810,13,8,8,54200,51490,'2020-03-12 11:30:00',0,'2020-03-19 11:30:00',2710,4281800),('C70',46,NULL,NULL,'2020-08-07 09:30:00',0,171249,13,27,8,326700,310365,'2020-08-13 09:30:00',0,'2020-08-20 09:30:00',16335,16335000),('E0',47,NULL,NULL,'2020-12-24 15:47:40',0,10286,2,11,9,45700,43415,'2020-12-27 15:47:40',0,'2021-01-03 15:47:40',2285,2650600),('E72',48,NULL,NULL,'2020-12-18 15:47:40',0,79156,10,27,9,326700,310365,'2020-12-16 15:47:40',0,'2020-12-23 15:47:40',16335,23849100),('A34',49,NULL,NULL,'2020-12-20 15:47:40',0,143805,17,6,9,34300,10290,'2020-12-20 15:47:40',22295,NULL,1715,1337700),('D47',50,NULL,NULL,'2020-12-17 15:47:40',0,162034,17,7,9,6500,6175,'2020-12-22 15:47:40',0,'2020-12-29 15:47:40',325,383500),('C54',51,NULL,NULL,'2020-12-17 15:47:40',0,48475,2,20,9,53600,50920,'2020-12-26 15:47:40',0,'2021-01-02 15:47:40',2680,589600),('E77',52,NULL,NULL,'2020-12-23 15:47:40',0,89447,2,23,9,64300,61085,'2020-12-24 15:47:40',0,'2020-12-31 15:47:40',3215,4565300),('D49',53,NULL,NULL,'2020-12-21 15:47:40',0,88244,19,19,10,32600,30970,'2020-12-21 15:47:40',0,'2020-12-28 15:47:40',1630,1727800),('E7',54,NULL,NULL,'2020-12-20 15:47:40',0,196879,2,26,10,326300,309985,'2021-01-05 15:47:40',0,'2021-01-12 15:47:40',16315,14357200),('E72',55,NULL,NULL,'2020-12-20 15:47:40',0,94302,16,11,10,45700,43415,'2020-12-20 15:47:40',0,'2020-12-27 15:47:40',2285,1645200),('C27',56,NULL,NULL,'2020-12-20 15:47:40',0,122365,16,9,10,34334,32617,'2020-12-20 15:47:40',0,'2020-12-27 15:47:40',1717,2884056),('E57',57,NULL,NULL,'2020-04-27 08:30:00',0,218145,13,10,11,98700,93765,'2020-04-30 08:30:00',0,'2020-05-07 08:30:00',4935,4935000),('D72',58,NULL,NULL,'2020-07-09 15:00:00',0,36867,13,20,11,53600,50920,'2020-07-07 15:00:00',0,'2020-07-14 15:00:00',2680,375200),('B79',59,'2021-10-20 08:30:00','2021-10-20 09:05:00','2021-10-20 08:00:00',1,91314,13,1,11,1000,950,NULL,0,NULL,50,81000),('B1',60,'2021-09-18 18:00:00','2021-09-18 18:35:00','2021-09-18 18:00:00',1,171249,13,1,11,1000,950,NULL,0,NULL,50,81000),('C70',61,NULL,NULL,'2020-10-14 19:30:00',0,119032,13,17,11,64100,60895,'2020-10-25 19:30:00',0,'2020-11-01 19:30:00',3205,5897200),('D26',62,'2021-08-26 10:00:00','2021-08-26 10:45:00','2021-08-26 10:00:00',1,162428,23,10,12,98700,93765,NULL,0,NULL,4935,1381800),('D4',63,NULL,NULL,'2019-03-18 15:30:00',0,54659,15,12,12,64500,61275,'2019-04-02 15:30:00',0,'2019-04-09 15:30:00',3225,5224500),('A69',64,NULL,NULL,'2021-04-06 12:30:00',0,36867,12,15,12,23500,22325,'2021-04-10 12:30:00',0,'2021-04-17 12:30:00',1175,258500),('B42',65,NULL,NULL,'2020-11-27 12:00:00',0,171249,15,1,12,1000,950,'2020-12-03 12:00:00',0,'2020-12-10 12:00:00',50,38000),('D20',66,NULL,NULL,'2020-05-27 08:00:00',0,182403,7,28,12,343400,326230,'2020-05-24 08:00:00',0,'2020-05-31 08:00:00',17170,26098400),('D33',67,NULL,NULL,'2020-12-18 15:47:40',0,54659,17,22,14,64300,61085,'2020-12-19 15:47:40',0,'2020-12-26 15:47:40',3215,257200),('E0',68,NULL,NULL,'2020-12-17 15:47:40',0,151424,17,8,14,54200,51490,'2021-01-12 15:47:40',0,'2021-01-19 15:47:40',2710,2384800),('E20',69,NULL,NULL,'2020-12-20 15:47:40',0,144810,17,8,14,54200,51490,'2020-12-05 15:47:40',0,'2020-12-12 15:47:40',2710,2384800),('B79',70,NULL,NULL,'2020-12-23 15:47:40',0,116781,17,26,14,326300,309985,'2020-12-29 15:47:40',0,'2021-01-05 15:47:40',16315,16315000),('D37',71,NULL,NULL,'2020-12-18 15:47:40',0,145728,17,15,15,23500,22325,'2020-12-27 15:47:40',0,'2021-01-03 15:47:40',1175,963500),('D47',72,NULL,NULL,'2020-12-23 15:47:40',0,45051,2,8,15,54200,51490,'2020-12-27 15:47:40',0,'2021-01-03 15:47:40',2710,2547400),('E20',73,NULL,NULL,'2020-12-16 15:47:40',0,155533,2,7,15,6500,6175,'2020-12-11 15:47:40',0,'2020-12-18 15:47:40',325,526500),('E20',74,NULL,NULL,'2020-12-17 15:47:40',0,151983,2,16,15,32600,30970,'2020-12-14 15:47:40',0,'2020-12-21 15:47:40',1630,1956000),('E95',75,NULL,NULL,'2020-12-22 15:47:40',0,48475,7,15,16,23500,22325,'2020-12-29 15:47:40',0,'2021-01-05 15:47:40',1175,1410000),('C81',76,NULL,NULL,'2020-12-21 15:47:40',0,70454,23,10,16,98700,93765,'2020-12-29 15:47:40',0,'2021-01-05 15:47:40',4935,1381800),('B62',77,NULL,NULL,'2020-12-21 15:47:40',0,199303,16,5,16,43300,41135,'2020-12-26 15:47:40',0,'2021-01-02 15:47:40',2165,1255700),('E9',78,NULL,NULL,'2020-12-24 15:47:40',0,91314,23,29,16,64533,61306,'2020-12-24 15:47:40',0,'2020-12-31 15:47:40',3227,2000523),('A33',79,NULL,NULL,'2020-12-22 15:47:40',0,57203,23,7,16,6500,6175,'2020-12-25 15:47:40',0,'2021-01-01 15:47:40',325,123500),('B29',80,NULL,NULL,'2020-12-19 15:47:40',0,162428,18,23,17,64300,61085,'2020-12-17 15:47:40',0,'2020-12-24 15:47:40',3215,5401200),('B91',81,NULL,NULL,'2020-12-22 15:47:40',0,196879,14,29,17,64533,61306,'2020-12-24 15:47:40',0,'2020-12-31 15:47:40',3227,516264),('C22',82,NULL,NULL,'2020-12-24 15:47:40',0,101004,17,6,17,34300,32585,'2020-12-18 15:47:40',0,'2020-12-25 15:47:40',1715,1337700),('E43',83,NULL,NULL,'2020-12-16 15:47:40',0,151983,18,6,17,34300,32585,'2020-12-20 15:47:40',0,'2020-12-27 15:47:40',1715,720300),('A42',84,NULL,NULL,'2021-05-16 09:30:00',0,48475,16,20,18,53600,50920,'2021-05-14 09:30:00',0,'2021-05-21 09:30:00',2680,4395200),('B66',85,NULL,NULL,'2019-03-06 10:30:00',0,162428,4,23,18,64300,61085,'2019-03-02 10:30:00',0,'2019-03-09 10:30:00',3215,3407900),('A20',86,'2021-06-22 13:00:00','2021-06-22 13:50:00','2021-06-22 13:00:00',1,89447,17,23,18,64300,61085,NULL,0,NULL,3215,3022100),('C54',87,NULL,NULL,'2021-04-12 12:00:00',0,10286,17,8,18,54200,51490,'2021-04-14 12:00:00',0,'2021-04-21 12:00:00',2710,2384800),('D72',88,'2021-08-22 14:30:00','2021-08-22 16:50:00','2021-08-22 14:30:00',1,122365,15,9,19,34334,32617,NULL,0,NULL,1717,961352),('E78',89,NULL,NULL,'2020-02-18 13:30:00',0,70454,15,10,19,98700,93765,'2020-02-18 13:30:00',0,'2020-02-25 13:30:00',4935,9277800),('A79',90,NULL,NULL,'2020-08-01 10:30:00',0,44409,15,15,19,23500,22325,'2020-08-16 10:30:00',0,'2020-08-23 10:30:00',1175,1762500),('D83',91,NULL,NULL,'2019-01-10 12:30:00',0,56869,12,17,19,64100,60895,'2019-01-16 12:30:00',0,'2019-01-23 12:30:00',3205,641000),('D37',92,'2021-09-08 08:00:00','2021-09-08 12:45:00','2021-09-08 08:00:00',1,45166,16,17,20,64100,60895,NULL,0,NULL,3205,1089700),('B29',93,NULL,NULL,'2020-12-18 19:00:00',0,116991,16,4,20,34300,32585,'2020-12-14 19:00:00',0,'2020-12-21 19:00:00',1715,960400),('A69',94,NULL,NULL,'2021-03-05 13:00:00',0,162034,16,17,20,64100,60895,'2021-02-28 13:00:00',0,'2021-03-07 13:00:00',3205,1089700),('C31',95,NULL,NULL,'2020-07-03 08:30:00',0,145728,16,15,20,23500,22325,'2020-07-04 08:30:00',0,'2020-07-11 08:30:00',1175,1809500),('C66',96,NULL,NULL,'2019-06-08 16:00:00',0,170745,17,6,21,34300,32585,'2019-06-12 16:00:00',0,'2019-06-19 16:00:00',1715,1337700),('B1',97,NULL,NULL,'2021-03-22 16:00:00',0,162428,17,22,21,64300,61085,'2021-03-13 16:00:00',0,'2021-03-20 16:00:00',3215,257200),('C25',98,'2021-07-27 09:00:00','2021-07-27 10:30:00','2021-07-27 08:30:00',1,165294,17,6,21,34300,32585,NULL,0,NULL,1715,1337700),('E18',99,NULL,NULL,'2019-08-25 18:30:00',0,43074,3,22,21,64300,61085,'2019-08-19 18:30:00',0,'2019-08-26 18:30:00',3215,4436700),('B84',100,NULL,NULL,'2020-12-13 09:30:00',0,79156,17,27,21,326700,310365,'2020-12-22 09:30:00',0,'2020-12-29 09:30:00',16335,24502500),('A69',101,'2021-08-14 15:00:00','2021-08-14 15:35:00','2021-08-14 15:00:00',1,116781,3,22,21,64300,61085,NULL,0,NULL,3215,4436700),('B65',102,NULL,NULL,'2020-07-22 09:00:00',0,162428,12,22,22,64300,61085,'2020-07-08 09:00:00',0,'2020-07-15 09:00:00',3215,5787000),('A50',103,NULL,NULL,'2020-04-13 14:00:00',0,10286,12,1,22,1000,950,'2020-04-03 14:00:00',0,'2020-04-10 14:00:00',50,86000),('E12',104,NULL,NULL,'2020-01-15 15:00:00',0,151424,12,16,22,32600,30970,'2020-01-23 15:00:00',0,'2020-01-30 15:00:00',1630,2379800),('B42',105,NULL,NULL,'2020-09-24 09:30:00',0,116991,12,8,22,54200,51490,'2020-09-25 09:30:00',0,'2020-10-02 09:30:00',2710,4986400),('A69',106,NULL,NULL,'2020-08-19 15:30:00',0,62082,12,29,22,64533,19360,'2020-08-01 15:30:00',41946,NULL,3227,4259178),('E39',107,NULL,NULL,'2020-04-22 16:30:00',0,122365,12,29,22,64533,61306,'2020-04-17 16:30:00',0,'2020-04-24 16:30:00',3227,4259178),('C55',108,NULL,NULL,'2020-11-28 19:30:00',0,151424,23,20,23,53600,50920,'2020-11-17 19:30:00',0,'2020-11-24 19:30:00',2680,1715200),('B62',109,NULL,NULL,'2020-05-08 15:30:00',0,196879,23,2,23,23200,22040,'2020-05-16 15:30:00',0,'2020-05-23 15:30:00',1160,464000),('D83',110,'2021-09-19 14:00:00','2021-09-19 14:40:00','2021-09-19 14:00:00',1,203912,23,29,23,64533,61306,NULL,0,NULL,3227,2000523),('E0',111,NULL,NULL,'2020-04-14 08:00:00',0,36867,10,10,23,98700,93765,'2020-03-31 08:00:00',0,'2020-04-07 08:00:00',4935,7402500),('A85',112,NULL,NULL,'2020-10-03 17:30:00',0,203912,19,10,24,98700,93765,'2020-10-03 17:30:00',0,'2020-10-10 17:30:00',4935,2467500),('B65',113,NULL,NULL,'2020-07-19 18:00:00',0,151424,23,1,24,1000,950,'2020-07-23 18:00:00',0,'2020-07-30 18:00:00',50,63000),('D4',114,'2021-09-22 19:30:00','2021-09-22 20:20:00','2021-09-22 19:30:00',1,165294,19,26,24,326300,309985,NULL,0,NULL,16315,10115300),('B42',115,'2021-12-02 10:30:00','2021-12-02 15:30:00','2021-12-02 10:30:00',1,45051,12,8,24,54200,51490,NULL,0,NULL,2710,4986400),('B58',116,'2021-11-15 13:30:00','2021-11-15 13:55:00','2021-11-15 13:30:00',1,54659,19,7,25,6500,6175,NULL,0,NULL,325,617500),('D33',117,'2021-12-15 09:00:00','2021-12-15 10:15:00','2021-12-15 09:00:00',1,116991,19,10,25,98700,93765,NULL,0,NULL,4935,2467500),('C31',118,NULL,NULL,'2020-02-23 16:00:00',0,162428,9,22,25,64300,61085,'2020-02-27 16:00:00',0,'2020-03-05 16:00:00',3215,5079700),('C88',119,NULL,NULL,'2021-04-02 14:00:00',0,119032,9,15,26,23500,22325,'2021-03-20 14:00:00',0,'2021-03-27 14:00:00',1175,23500),('B66',120,NULL,NULL,'2020-08-05 14:30:00',0,43074,9,22,26,64300,61085,'2020-08-11 14:30:00',0,'2020-08-18 14:30:00',3215,5079700),('A34',121,NULL,NULL,'2020-11-11 10:30:00',0,94302,9,29,26,64533,61306,'2020-11-07 10:30:00',0,'2020-11-14 10:30:00',3227,2968518),('E69',122,NULL,NULL,'2020-07-18 18:30:00',0,151424,9,11,26,45700,43415,'2020-07-13 18:30:00',0,'2020-07-20 18:30:00',2285,4113000),('C54',123,NULL,NULL,'2019-11-13 09:30:00',0,27009,9,29,26,64533,61306,'2019-11-19 09:30:00',0,'2019-11-26 09:30:00',3227,2968518),('A39',124,NULL,NULL,'2020-07-10 08:30:00',0,91314,9,9,26,34334,32617,'2020-07-19 08:30:00',0,'2020-07-26 08:30:00',1717,2231710),('D20',125,NULL,NULL,'2020-07-26 18:00:00',0,182403,9,28,26,343400,326230,'2020-07-23 18:00:00',0,'2020-07-30 18:00:00',17170,12705800),('C34',126,NULL,NULL,'2019-02-19 12:30:00',0,45166,9,16,26,32600,30970,'2019-02-27 12:30:00',0,'2019-03-06 12:30:00',1630,912800),('E9',127,NULL,NULL,'2020-02-27 10:00:00',0,116991,21,21,27,4540,4313,'2020-02-29 10:00:00',0,'2020-03-07 10:00:00',227,40860),('B29',128,NULL,NULL,'2020-07-18 11:30:00',0,162428,21,23,27,64300,61085,'2020-07-25 11:30:00',0,'2020-08-01 11:30:00',3215,5079700),('E9',129,'2021-12-27 14:30:00','2021-12-27 15:10:00','2021-12-27 14:00:00',1,203912,23,29,27,64533,61306,NULL,0,NULL,3227,2000523),('E72',130,NULL,NULL,'2019-09-23 08:30:00',0,151983,21,15,27,23500,22325,'2019-09-22 08:30:00',0,'2019-09-29 08:30:00',1175,258500),('B43',131,NULL,NULL,'2019-02-01 13:30:00',0,136288,17,8,27,54200,51490,'2019-01-25 13:30:00',0,'2019-02-01 13:30:00',2710,2384800),('E20',132,NULL,NULL,'2020-09-21 18:00:00',0,54659,15,22,28,64300,61085,'2020-09-28 18:00:00',0,'2020-10-05 18:00:00',3215,2764900),('E18',133,NULL,NULL,'2020-03-06 18:00:00',0,94302,16,11,28,45700,43415,'2020-03-11 18:00:00',0,'2020-03-18 18:00:00',2285,1645200),('E9',134,NULL,NULL,'2021-04-08 13:30:00',0,77742,16,26,28,326300,97890,'2021-04-16 13:30:00',212095,NULL,16315,7831200),('B1',135,'2021-12-01 11:30:00','2021-12-01 13:00:00','2021-12-01 11:30:00',1,113404,4,6,28,34300,32585,NULL,0,NULL,1715,2058000),('E7',136,NULL,NULL,'2019-09-06 14:30:00',0,77742,15,23,28,64300,19290,'2019-08-30 14:30:00',41795,NULL,3215,2572000),('E20',137,'2021-09-23 12:00:00','2021-09-23 13:30:00','2021-09-23 12:00:00',1,119032,4,6,28,34300,32585,NULL,0,NULL,1715,2058000),('C14',138,'2021-07-13 11:30:00','2021-07-13 11:55:00','2021-07-13 11:30:00',1,162428,3,7,28,6500,6175,NULL,0,NULL,325,208000),('D47',139,NULL,NULL,'2020-10-07 18:30:00',0,203912,3,15,28,23500,22325,'2020-10-07 18:30:00',0,'2020-10-14 18:30:00',1175,2021000),('E0',140,NULL,NULL,'2019-08-08 14:30:00',0,151434,16,22,28,64300,19290,'2019-07-17 14:30:00',41795,NULL,3215,1350300),('D22',141,NULL,NULL,'2021-03-24 18:30:00',0,36867,19,15,30,23500,22325,'2021-03-15 18:30:00',0,'2021-03-22 18:30:00',1175,1997500),('D72',142,NULL,NULL,'2020-12-13 16:30:00',0,10286,13,13,30,2455,2332,'2020-12-15 16:30:00',0,'2020-12-22 16:30:00',123,105565),('B66',143,NULL,NULL,'2020-02-06 14:00:00',0,48475,13,17,30,64100,60895,'2020-02-01 14:00:00',0,'2020-02-08 14:00:00',3205,5897200),('D26',144,NULL,NULL,'2020-12-23 19:00:00',0,91314,13,10,30,98700,93765,'2020-12-23 19:00:00',0,'2020-12-30 19:00:00',4935,4935000),('C54',145,NULL,NULL,'2021-05-22 12:00:00',0,151983,13,8,30,54200,51490,'2021-05-16 12:00:00',0,'2021-05-23 12:00:00',2710,4281800),('C66',146,'2021-11-17 10:00:00','2021-11-17 20:15:00','2021-11-17 10:00:00',1,182403,15,28,32,343400,326230,NULL,0,NULL,17170,24381400),('B84',147,NULL,NULL,'2021-02-20 12:30:00',0,171249,12,27,32,326700,310365,'2021-02-15 12:30:00',0,'2021-02-22 12:30:00',16335,19602000),('D22',148,NULL,NULL,'2021-01-23 12:00:00',0,218145,15,10,32,98700,93765,'2021-01-28 12:00:00',0,'2021-02-04 12:00:00',4935,9277800),('E39',149,NULL,NULL,'2020-02-12 10:30:00',0,70454,12,10,32,98700,93765,'2020-02-14 10:30:00',0,'2020-02-21 10:30:00',4935,8586900),('C34',150,NULL,NULL,'2020-04-24 18:00:00',0,44409,2,4,33,34300,32585,'2020-04-29 18:00:00',0,'2020-05-06 18:00:00',1715,480200),('E0',151,NULL,NULL,'2021-01-05 13:30:00',0,36867,7,15,33,23500,22325,'2021-01-03 13:30:00',0,'2021-01-10 13:30:00',1175,1410000),('E95',152,'2021-12-12 19:30:00','2021-12-12 20:15:00','2021-12-12 19:30:00',1,218145,15,10,33,98700,93765,NULL,0,NULL,4935,9277800),('B65',153,NULL,NULL,'2019-02-02 08:30:00',0,27009,2,11,33,45700,43415,'2019-02-02 08:30:00',0,'2019-02-09 08:30:00',2285,2650600),('E20',154,NULL,NULL,'2019-11-12 08:30:00',0,88244,15,23,33,64300,61085,'2019-11-14 08:30:00',0,'2019-11-21 08:30:00',3215,2572000),('A34',155,NULL,NULL,'2021-02-04 16:00:00',0,48475,21,17,34,64100,60895,'2021-01-19 16:00:00',0,'2021-01-26 16:00:00',3205,2948600),('E20',156,NULL,NULL,'2019-01-03 13:00:00',0,155533,22,26,34,326300,309985,'2018-12-23 13:00:00',0,'2018-12-30 13:00:00',16315,12399400),('E20',157,NULL,NULL,'2019-08-03 13:30:00',0,122365,21,7,34,6500,6175,'2019-08-14 13:30:00',0,'2019-08-21 13:30:00',325,630500),('E43',158,'2021-07-28 19:00:00','2021-07-29 00:00:00','2021-07-28 19:00:00',1,151424,21,8,34,54200,51490,NULL,0,NULL,2710,4390200),('E7',159,NULL,NULL,'2020-04-25 09:00:00',0,57203,7,15,35,23500,22325,'2020-04-21 09:00:00',0,'2020-04-28 09:00:00',1175,1410000),('B65',160,NULL,NULL,'2020-11-19 12:00:00',0,151424,12,20,35,53600,50920,'2020-11-24 12:00:00',0,'2020-12-01 12:00:00',2680,2680000),('A73',161,NULL,NULL,'2019-11-27 10:30:00',0,54659,2,6,35,34300,32585,'2019-12-11 10:30:00',0,'2019-12-18 10:30:00',1715,2812600),('B1',162,NULL,NULL,'2019-04-16 19:30:00',0,54659,2,21,35,4540,4313,'2019-04-16 19:30:00',0,'2019-04-23 19:30:00',227,367740),('D26',163,NULL,NULL,'2021-01-27 08:00:00',0,79156,13,20,35,53600,50920,'2021-01-10 08:00:00',0,'2021-01-17 08:00:00',2680,375200),('D49',164,NULL,NULL,'2021-04-04 10:30:00',0,196879,12,9,35,34334,32617,'2021-03-29 10:30:00',0,'2021-04-05 10:30:00',1717,480676),('C31',165,NULL,NULL,'2019-07-28 11:30:00',0,197201,3,7,35,6500,6175,'2019-07-28 11:30:00',0,'2019-08-04 11:30:00',325,208000),('D20',166,'2021-12-23 10:00:00','2021-12-23 10:50:00','2021-12-23 10:00:00',1,79156,12,26,35,326300,309985,NULL,0,NULL,16315,17946500),('C77',167,NULL,NULL,'2020-11-01 19:30:00',0,64372,17,22,36,64300,61085,'2020-10-26 19:30:00',0,'2020-11-02 19:30:00',3215,257200),('C92',168,NULL,NULL,'2020-07-18 18:30:00',0,45051,17,8,36,54200,51490,'2020-07-24 18:30:00',0,'2020-07-31 18:30:00',2710,2384800),('E95',169,NULL,NULL,'2020-12-03 12:30:00',0,54659,19,21,36,4540,4313,'2020-12-11 12:30:00',0,'2020-12-18 12:30:00',227,140740),('B32',170,'2021-06-21 12:00:00','2021-06-21 21:15:00','2021-06-21 12:00:00',1,62082,19,20,36,53600,16080,NULL,34840,NULL,2680,1822400),('C18',171,NULL,NULL,'2020-04-03 09:30:00',0,91314,15,11,36,45700,43415,'2020-03-29 09:30:00',0,'2020-04-05 09:30:00',2285,3701700),('B62',172,NULL,NULL,'2020-01-13 11:30:00',0,162428,17,7,36,6500,6175,'2020-01-27 11:30:00',0,'2020-02-03 11:30:00',325,383500),('D26',173,NULL,NULL,'2020-12-19 09:30:00',0,196879,17,2,36,23200,22040,'2020-12-09 09:30:00',0,'2020-12-16 09:30:00',1160,1577600),('D11',174,NULL,NULL,'2020-06-01 11:00:00',0,88244,21,19,37,32600,30970,'2020-05-22 11:00:00',0,'2020-05-29 11:00:00',1630,2966600),('E9',175,NULL,NULL,'2021-05-05 11:30:00',0,54659,21,12,37,64500,61275,'2021-05-03 11:30:00',0,'2021-05-10 11:30:00',3225,6063000),('C22',176,'2021-08-07 15:00:00','2021-08-07 17:20:00','2021-08-07 15:00:00',1,196879,21,9,37,34334,32617,NULL,0,NULL,1717,2403380),('A34',177,'2021-07-23 16:30:00','2021-07-23 21:05:00','2021-07-23 16:00:00',1,43074,21,3,37,34400,32680,NULL,0,NULL,1720,2373600),('C92',178,'2021-09-21 09:00:00','2021-09-21 09:45:00','2021-09-21 09:00:00',1,70454,21,10,37,98700,93765,NULL,0,NULL,4935,9771300),('C98',179,NULL,NULL,'2019-09-19 19:30:00',0,151424,21,9,37,34334,32617,'2019-09-18 19:30:00',0,'2019-09-25 19:30:00',1717,2403380),('C18',180,NULL,NULL,'2020-07-23 13:00:00',0,116991,21,10,37,98700,93765,'2020-07-22 13:00:00',0,'2020-07-29 13:00:00',4935,9771300),('B70',181,NULL,NULL,'2021-02-03 08:30:00',0,144810,12,1,38,1000,950,'2021-02-07 08:30:00',0,'2021-02-14 08:30:00',50,86000),('C97',182,NULL,NULL,'2019-06-03 14:00:00',0,48475,23,7,38,6500,6175,'2019-05-31 14:00:00',0,'2019-06-07 14:00:00',325,123500),('E64',183,NULL,NULL,'2020-02-20 14:00:00',0,203912,12,15,38,23500,22325,'2020-02-20 14:00:00',0,'2020-02-27 14:00:00',1175,258500),('C34',184,NULL,NULL,'2021-05-11 09:30:00',0,27009,23,29,38,64533,61306,'2021-05-23 09:30:00',0,'2021-05-30 09:30:00',3227,2000523),('C25',185,NULL,NULL,'2021-06-14 09:30:00',0,43074,19,1,39,1000,950,'2021-06-14 09:30:00',0,NULL,50,62000),('E7',186,NULL,NULL,'2020-01-06 08:30:00',0,218145,19,10,39,98700,93765,'2019-12-28 08:30:00',0,'2020-01-04 08:30:00',4935,2467500),('B84',187,'2021-10-07 11:30:00','2021-10-07 15:45:00','2021-10-07 11:30:00',1,56869,16,17,39,64100,60895,NULL,0,NULL,3205,1089700),('B84',188,NULL,NULL,'2020-03-18 18:30:00',0,116991,3,4,40,34300,32585,'2020-03-19 18:30:00',0,'2020-03-26 18:30:00',1715,2778300),('B29',189,NULL,NULL,'2020-02-12 15:00:00',0,57203,22,10,40,98700,93765,'2020-02-27 15:00:00',0,'2020-03-05 15:00:00',4935,5231100),('E69',190,NULL,NULL,'2020-07-02 17:30:00',0,103854,22,26,40,326300,309985,'2020-07-20 17:30:00',0,'2020-07-27 17:30:00',16315,12399400),('B79',191,NULL,NULL,'2020-07-07 15:30:00',0,145728,22,12,40,64500,61275,'2020-07-05 15:30:00',0,'2020-07-12 15:30:00',3225,3741000),('B42',192,'2021-10-17 16:30:00','2021-10-17 17:35:00','2021-10-17 16:30:00',1,64372,3,22,40,64300,61085,NULL,0,NULL,3215,4436700),('D72',193,NULL,NULL,'2021-01-20 12:00:00',0,45051,13,1,41,1000,950,'2021-02-05 12:00:00',0,'2021-02-12 12:00:00',50,81000),('B66',194,NULL,NULL,'2019-04-03 12:00:00',0,54659,22,12,41,64500,61275,'2019-04-03 12:00:00',0,'2019-04-10 12:00:00',3225,3741000),('C55',195,NULL,NULL,'2020-06-16 13:00:00',0,48475,13,28,41,343400,326230,'2020-06-13 13:00:00',0,'2020-06-20 13:00:00',17170,10988800),('B79',196,NULL,NULL,'2019-08-26 11:00:00',0,162428,5,22,41,64300,61085,'2019-08-21 11:00:00',0,'2019-08-28 11:00:00',3215,5851300),('E57',197,'2021-11-03 17:00:00','2021-11-03 17:35:00','2021-11-03 17:00:00',1,64372,13,22,41,64300,61085,NULL,0,NULL,3215,1157400),('A3',198,NULL,NULL,'2020-09-10 13:00:00',0,91314,4,9,42,34334,32617,'2020-09-04 13:00:00',0,'2020-09-11 13:00:00',1717,2746720),('A42',199,NULL,NULL,'2020-01-25 08:00:00',0,116781,12,26,42,326300,309985,'2020-01-18 08:00:00',0,'2020-01-25 08:00:00',16315,17946500),('D47',200,NULL,NULL,'2020-10-03 19:30:00',0,151983,12,16,42,32600,30970,'2020-10-11 19:30:00',0,'2020-10-18 19:30:00',1630,2379800),('B29',201,NULL,NULL,'2021-03-10 19:30:00',0,43074,12,23,42,64300,61085,'2021-03-09 19:30:00',0,'2021-03-16 19:30:00',3215,450100),('E39',202,'2021-06-19 15:00:00','2021-06-19 17:20:00','2021-06-19 15:00:00',1,196879,12,9,42,34334,32617,'2021-06-15 15:00:00',0,NULL,1717,480676),('B62',203,NULL,NULL,'2020-04-19 18:30:00',0,113545,16,1,43,1000,950,'2020-04-16 18:30:00',0,'2020-04-23 18:30:00',50,85000),('B79',204,NULL,NULL,'2020-10-18 15:30:00',0,122365,14,11,43,45700,43415,'2020-10-21 15:30:00',0,'2020-10-28 15:30:00',2285,2102200),('A34',205,NULL,NULL,'2020-05-09 11:30:00',0,155533,16,26,43,326300,309985,'2020-05-04 11:30:00',0,'2020-05-11 11:30:00',16315,7831200),('E7',206,NULL,NULL,'2020-10-24 09:00:00',0,144810,16,6,43,34300,32585,'2020-10-31 09:00:00',0,'2020-11-07 09:00:00',1715,583100),('C25',207,'2021-09-22 14:00:00','2021-09-22 15:50:00','2021-09-22 14:00:00',1,25304,16,12,43,64500,61275,NULL,0,NULL,3225,4386000),('C25',208,NULL,NULL,'2021-02-17 19:30:00',0,113545,16,28,43,343400,326230,'2021-02-17 19:30:00',0,'2021-02-24 19:30:00',17170,33996600),('A37',209,NULL,NULL,'2021-01-09 12:30:00',0,70454,16,10,43,98700,93765,'2021-01-10 12:30:00',0,'2021-01-17 12:30:00',4935,6020700),('C22',210,'2021-09-06 12:00:00','2021-09-06 18:50:00','2021-09-06 12:00:00',1,171249,14,27,44,326700,310365,NULL,0,NULL,16335,29729700),('C31',211,'2021-08-14 09:30:00','2021-08-14 11:50:00','2021-08-14 09:30:00',1,94302,14,9,44,34334,32617,NULL,0,NULL,1717,1098688),('A98',212,NULL,NULL,'2020-04-09 14:00:00',0,197201,14,7,44,6500,6175,'2020-03-28 14:00:00',0,'2020-04-04 14:00:00',325,422500),('B65',213,NULL,NULL,'2020-11-26 10:30:00',0,122365,14,7,44,6500,6175,'2020-11-24 10:30:00',0,'2020-12-01 10:30:00',325,422500),('E7',214,NULL,NULL,'2021-04-15 09:00:00',0,162034,19,12,45,64500,61275,'2021-04-07 09:00:00',0,'2021-04-14 09:00:00',3225,1032000),('E20',215,NULL,NULL,'2021-03-28 17:00:00',0,182403,19,26,45,326300,309985,'2021-03-28 17:00:00',0,'2021-04-04 17:00:00',16315,10115300),('C77',216,'2021-07-15 10:30:00','2021-07-15 11:10:00','2021-07-15 10:30:00',1,151424,9,11,45,45700,43415,NULL,0,NULL,2285,4113000),('E95',217,NULL,NULL,'2019-01-13 19:00:00',0,62082,19,29,45,64533,19360,'2019-01-03 19:00:00',41946,NULL,3227,5678904),('E43',218,NULL,NULL,'2019-06-11 16:30:00',0,182403,13,28,46,343400,326230,'2019-06-03 16:30:00',0,'2019-06-10 16:30:00',17170,10988800),('B15',219,NULL,NULL,'2021-05-28 10:30:00',0,91314,13,1,46,1000,950,'2021-06-03 10:30:00',0,'2021-06-10 10:30:00',50,81000),('C46',220,NULL,NULL,'2021-04-21 13:30:00',0,94302,13,9,46,34334,32617,'2021-04-27 13:30:00',0,'2021-05-04 13:30:00',1717,1339026),('B23',221,'2021-11-03 17:30:00','2021-11-03 18:20:00','2021-11-03 17:30:00',1,155533,13,26,46,326300,309985,NULL,0,NULL,16315,7504900),('C50',222,NULL,NULL,'2020-10-14 17:30:00',0,116991,13,10,46,98700,93765,'2020-10-19 17:30:00',0,'2020-10-26 17:30:00',4935,4935000),('D19',223,'2021-10-06 17:00:00','2021-10-06 17:35:00','2021-10-06 17:00:00',1,43074,15,22,47,64300,61085,NULL,0,NULL,3215,2764900),('E78',224,'2021-07-07 19:00:00','2021-07-07 19:50:00','2021-07-07 17:00:00',1,151424,12,26,47,326300,309985,NULL,0,NULL,16315,17946500),('E20',225,NULL,NULL,'2021-01-01 11:00:00',0,113545,15,1,47,1000,950,'2021-01-15 11:00:00',0,'2021-01-22 11:00:00',50,38000),('E6',226,NULL,NULL,'2020-09-25 14:00:00',0,88244,12,23,47,64300,61085,'2020-09-20 14:00:00',0,'2020-09-27 14:00:00',3215,450100),('B17',227,'2021-10-18 16:30:00','2021-10-18 17:00:00','2021-10-18 16:30:00',1,10286,22,5,47,43300,41135,NULL,0,NULL,2165,1472200),('D47',228,NULL,NULL,'2020-06-03 09:00:00',0,151434,2,20,48,53600,16080,'2020-05-29 09:00:00',34840,NULL,2680,589600),('E9',229,NULL,NULL,'2019-11-02 12:00:00',0,101004,2,22,48,64300,61085,'2019-11-10 12:00:00',0,'2019-11-17 12:00:00',3215,4243800),('B32',230,'2021-08-03 10:00:00','2021-08-03 10:50:00','2021-08-03 10:00:00',1,103854,2,26,48,326300,309985,NULL,0,NULL,16315,14357200),('C46',231,NULL,NULL,'2020-04-02 16:00:00',0,25304,3,17,48,64100,60895,'2020-04-04 16:00:00',0,'2020-04-11 16:00:00',3205,4743400),('C25',232,NULL,NULL,'2019-01-06 09:00:00',0,113545,2,28,48,343400,326230,'2018-12-25 09:00:00',0,'2019-01-01 09:00:00',17170,7554800),('B42',233,NULL,NULL,'2020-09-01 16:00:00',0,44409,3,4,48,34300,32585,'2020-08-26 16:00:00',0,'2020-09-02 16:00:00',1715,2778300),('A3',234,NULL,NULL,'2020-10-18 13:30:00',0,91314,12,29,49,64533,61306,'2020-10-20 13:30:00',0,'2020-10-27 13:30:00',3227,4259178),('C50',235,NULL,NULL,'2019-10-04 19:30:00',0,57203,9,10,49,98700,93765,'2019-10-04 19:30:00',0,'2019-10-11 19:30:00',4935,7205100),('C27',236,NULL,NULL,'2019-04-12 10:30:00',0,77742,9,15,49,23500,7050,'2019-04-12 10:30:00',15275,NULL,1175,23500),('C46',237,NULL,NULL,'2020-08-28 10:00:00',0,10286,9,9,49,34334,32617,'2020-08-29 10:00:00',0,'2020-09-05 10:00:00',1717,2231710),('E78',238,NULL,NULL,'2020-01-04 09:30:00',0,151424,12,16,49,32600,30970,'2019-12-27 09:30:00',0,'2020-01-03 09:30:00',1630,2379800),('B58',239,'2021-08-14 10:00:00','2021-08-14 10:50:00','2021-08-14 10:00:00',1,116781,22,26,49,326300,309985,NULL,0,NULL,16315,12399400),('A28',240,NULL,NULL,'2021-03-25 17:30:00',0,88244,10,23,50,64300,61085,'2021-03-24 17:30:00',0,'2021-03-31 17:30:00',3215,6172800),('A39',241,NULL,NULL,'2021-03-03 19:00:00',0,116991,10,8,50,54200,51490,'2021-03-18 19:00:00',0,'2021-03-25 19:00:00',2710,5257400),('A77',242,NULL,NULL,'2020-10-04 17:00:00',0,48475,10,12,50,64500,61275,'2020-09-23 17:00:00',0,'2020-09-30 17:00:00',3225,258000),('C25',243,NULL,NULL,'2020-01-19 16:30:00',0,44409,10,15,50,23500,22325,'2020-01-18 16:30:00',0,'2020-01-25 16:30:00',1175,1974000),('E39',244,NULL,NULL,'2020-04-17 09:00:00',0,162428,10,23,51,64300,61085,'2020-04-23 09:00:00',0,'2020-04-30 09:00:00',3215,6172800),('B43',245,NULL,NULL,'2020-01-27 19:00:00',0,145728,10,22,51,64300,61085,'2020-02-02 19:00:00',0,'2020-02-09 19:00:00',3215,5144000),('D47',246,'2021-09-11 14:00:00','2021-09-11 14:55:00','2021-09-11 14:00:00',1,151983,10,15,51,23500,22325,NULL,0,NULL,1175,1974000),('E77',247,'2021-12-06 18:30:00','2021-12-06 19:05:00','2021-12-06 18:30:00',1,144810,10,1,51,1000,950,NULL,0,NULL,50,35000),('D59',248,NULL,NULL,'2020-08-24 11:30:00',0,162034,12,22,52,64300,61085,'2020-08-29 11:30:00',0,'2020-09-05 11:30:00',3215,5787000),('E39',249,'2021-09-25 12:00:00','2021-09-25 12:40:00','2021-09-25 12:00:00',1,122365,12,29,52,64533,61306,NULL,0,NULL,3227,4259178),('A3',250,NULL,NULL,'2020-09-11 16:30:00',0,113404,2,6,52,34300,32585,'2020-09-16 16:30:00',0,'2020-09-23 16:30:00',1715,2812600),('E29',251,NULL,NULL,'2020-06-12 12:30:00',0,10286,2,29,52,64533,61306,'2020-05-26 12:30:00',0,'2020-06-02 12:30:00',3227,5549838),('C66',252,NULL,NULL,'2020-09-14 11:00:00',0,48475,17,15,53,23500,22325,'2020-09-21 11:00:00',0,'2020-09-28 11:00:00',1175,963500),('E0',253,NULL,NULL,'2021-04-05 18:00:00',0,122365,15,11,53,45700,43415,'2021-04-07 18:00:00',0,'2021-04-14 18:00:00',2285,3701700),('B62',254,NULL,NULL,'2020-08-23 11:00:00',0,43074,15,22,53,64300,61085,'2020-08-27 11:00:00',0,'2020-09-03 11:00:00',3215,2764900),('C54',255,NULL,NULL,'2020-03-26 15:30:00',0,143805,15,6,53,34300,10290,'2020-03-19 15:30:00',22295,NULL,1715,2778300),('C27',256,NULL,NULL,'2020-01-17 13:30:00',0,151424,15,9,53,34334,32617,'2020-01-13 13:30:00',0,'2020-01-20 13:30:00',1717,961352),('B84',257,NULL,NULL,'2020-02-17 19:00:00',0,119032,15,17,53,64100,60895,'2020-02-26 19:00:00',0,'2020-03-04 19:00:00',3205,2179400),('D19',258,NULL,NULL,'2020-03-13 08:00:00',0,151424,17,26,54,326300,309985,'2020-03-01 08:00:00',0,'2020-03-08 08:00:00',16315,16315000),('E78',259,'2021-09-19 08:30:00','2021-09-19 10:50:00','2021-09-19 08:30:00',1,10286,14,9,54,34334,32617,NULL,0,NULL,1717,1098688),('A77',260,NULL,NULL,'2020-06-14 13:30:00',0,165294,17,26,54,326300,309985,'2020-06-10 13:30:00',0,'2020-06-17 13:30:00',16315,16315000),('D37',261,NULL,NULL,'2019-02-01 16:30:00',0,62082,18,11,54,45700,13710,'2019-01-18 16:30:00',29705,NULL,2285,2239300),('C92',262,NULL,NULL,'2021-05-15 08:00:00',0,27009,14,9,55,34334,32617,'2021-05-09 08:00:00',0,'2021-05-16 08:00:00',1717,1098688),('A98',263,NULL,NULL,'2020-04-13 12:30:00',0,88244,14,19,55,32600,30970,'2020-04-06 12:30:00',0,'2020-04-13 12:30:00',1630,652000),('E9',264,NULL,NULL,'2020-02-11 08:30:00',0,62082,14,11,55,45700,13710,'2020-01-27 08:30:00',29705,NULL,2285,2102200),('B62',265,NULL,NULL,'2019-07-22 18:00:00',0,151434,21,22,56,64300,19290,'2019-07-10 18:00:00',41795,NULL,3215,514400),('C46',266,NULL,NULL,'2020-10-22 14:30:00',0,48475,21,17,56,64100,60895,'2020-11-03 14:30:00',0,'2020-11-10 14:30:00',3205,2948600),('D47',267,NULL,NULL,'2019-02-07 15:00:00',0,25304,15,12,56,64500,61275,'2019-01-30 15:00:00',0,'2019-02-06 15:00:00',3225,5224500),('E7',268,NULL,NULL,'2021-03-14 11:00:00',0,165294,17,26,57,326300,309985,'2021-03-27 11:00:00',0,'2021-04-03 11:00:00',16315,16315000),('C31',269,NULL,NULL,'2020-03-01 09:00:00',0,116991,18,8,57,54200,51490,'2020-02-20 09:00:00',0,'2020-02-27 09:00:00',2710,4444400),('A79',270,'2021-10-12 16:30:00','2021-10-12 17:20:00','2021-10-12 16:00:00',1,57203,17,23,57,64300,61085,NULL,0,NULL,3215,3022100),('B65',271,NULL,NULL,'2020-03-05 17:30:00',0,57203,17,15,57,23500,22325,'2020-02-27 17:30:00',0,'2020-03-05 17:30:00',1175,963500),('C25',272,NULL,NULL,'2020-05-05 18:00:00',0,88244,18,19,57,32600,30970,'2020-04-22 18:00:00',0,'2020-04-29 18:00:00',1630,2119000),('E9',273,NULL,NULL,'2020-07-04 10:00:00',0,144810,18,8,57,54200,51490,'2020-06-28 10:00:00',0,'2020-07-05 10:00:00',2710,4444400),('C27',274,NULL,NULL,'2021-04-24 12:30:00',0,25304,7,1,58,1000,950,'2021-05-10 12:30:00',0,'2021-05-17 12:30:00',50,62000),('A85',275,NULL,NULL,'2021-01-15 09:30:00',0,44409,7,15,58,23500,22325,'2021-01-27 09:30:00',0,'2021-02-03 09:30:00',1175,1410000),('E20',276,NULL,NULL,'2019-05-17 14:00:00',0,122365,7,29,58,64533,61306,'2019-05-10 14:00:00',0,'2019-05-17 14:00:00',3227,5356239),('E18',277,'2021-12-01 17:00:00','2021-12-01 18:15:00','2021-12-01 17:00:00',1,196879,7,10,58,98700,93765,NULL,0,NULL,4935,3750600),('E6',278,NULL,NULL,'2020-02-19 14:30:00',0,62082,23,29,59,64533,19360,'2020-02-20 14:30:00',41946,NULL,3227,2000523),('A3',279,NULL,NULL,'2021-01-13 19:30:00',0,199303,22,5,59,43300,41135,'2021-01-09 19:30:00',0,'2021-01-16 19:30:00',2165,1472200),('C25',280,'2021-09-09 20:00:00','2021-09-09 20:50:00','2021-09-09 19:30:00',1,155533,22,26,59,326300,309985,NULL,0,NULL,16315,12399400),('B91',281,'2021-08-16 15:00:00','2021-08-16 16:15:00','2021-08-16 14:30:00',1,196879,19,10,61,98700,93765,NULL,0,NULL,4935,2467500),('C55',282,NULL,NULL,'2020-07-19 18:00:00',0,88244,12,19,61,32600,30970,'2020-08-01 18:00:00',0,'2020-08-08 18:00:00',1630,358600),('B42',283,'2021-07-23 15:00:00','2021-07-23 20:05:00','2021-07-23 15:00:00',1,43074,17,3,61,34400,32680,NULL,0,NULL,1720,1100800),('B32',284,'2021-11-08 11:30:00','2021-11-08 12:10:00','2021-11-08 11:30:00',1,196879,3,11,61,45700,43415,NULL,0,NULL,2285,1279600),('D4',285,NULL,NULL,'2020-11-05 19:30:00',0,143805,12,10,62,98700,29610,'2020-11-03 19:30:00',64155,NULL,4935,8586900),('C81',286,'2021-08-27 08:30:00','2021-08-27 08:55:00','2021-08-27 08:30:00',1,122365,24,7,62,6500,6175,NULL,0,NULL,325,240500),('E7',287,NULL,NULL,'2020-03-27 19:00:00',0,56869,24,17,62,64100,60895,'2020-03-24 19:00:00',0,'2020-03-31 19:00:00',3205,1666600),('C27',288,NULL,NULL,'2020-04-01 19:30:00',0,153362,12,3,62,34400,32680,'2020-03-22 19:30:00',0,'2020-03-29 19:30:00',1720,2820800),('B32',289,NULL,NULL,'2020-03-07 09:30:00',0,94302,24,9,62,34334,32617,'2020-03-18 09:30:00',0,'2020-03-25 09:30:00',1717,206004),('E29',290,NULL,NULL,'2020-10-24 11:30:00',0,25304,12,17,62,64100,60895,'2020-10-30 11:30:00',0,'2020-11-06 11:30:00',3205,641000),('A73',291,NULL,NULL,'2020-09-03 18:30:00',0,151434,24,22,62,64300,19290,'2020-08-22 18:30:00',41795,NULL,3215,64300),('C25',292,NULL,NULL,'2020-11-20 11:00:00',0,162428,24,7,62,6500,6175,'2020-11-22 11:00:00',0,'2020-11-29 11:00:00',325,240500),('E49',293,NULL,NULL,'2019-06-07 09:30:00',0,143805,14,19,63,32600,9780,'2019-05-26 09:30:00',21190,NULL,1630,652000),('D47',294,NULL,NULL,'2020-03-11 12:00:00',0,62082,14,20,63,53600,16080,'2020-03-20 12:00:00',34840,NULL,2680,2465600),('C27',295,NULL,NULL,'2020-04-26 13:30:00',0,203912,14,29,63,64533,61306,'2020-04-20 13:30:00',0,'2020-04-27 13:30:00',3227,516264),('C66',296,'2021-09-16 13:30:00','2021-09-16 15:50:00','2021-09-16 13:30:00',1,203912,14,9,63,34334,32617,NULL,0,NULL,1717,1098688),('B32',297,'2021-08-01 17:30:00','2021-08-01 18:10:00','2021-08-01 17:30:00',1,10286,14,29,63,64533,61306,NULL,0,NULL,3227,516264),('D83',298,NULL,NULL,'2020-08-02 12:00:00',0,113545,14,28,63,343400,326230,'2020-08-07 12:00:00',0,'2020-08-14 12:00:00',17170,33996600),('B15',299,NULL,NULL,'2020-03-13 14:00:00',0,25304,10,1,64,1000,950,'2020-03-21 14:00:00',0,'2020-03-28 14:00:00',50,35000),('D72',300,NULL,NULL,'2020-05-03 13:30:00',0,145728,22,17,64,64100,60895,'2020-04-29 13:30:00',0,'2020-05-06 13:30:00',3205,4935700),('B23',301,NULL,NULL,'2019-09-06 13:00:00',0,196879,22,10,64,98700,93765,'2019-09-01 13:00:00',0,'2019-09-08 13:00:00',4935,5231100),('C61',302,NULL,NULL,'2020-05-14 17:00:00',0,171249,10,1,64,1000,950,'2020-05-24 17:00:00',0,'2020-05-31 17:00:00',50,35000),('C34',303,NULL,NULL,'2021-03-23 19:30:00',0,151424,16,16,64,32600,30970,'2021-03-20 19:30:00',0,'2021-03-27 19:30:00',1630,1336600),('B1',304,NULL,NULL,'2020-12-11 17:00:00',0,36867,16,27,64,326700,310365,'2020-12-05 17:00:00',0,'2020-12-12 17:00:00',16335,20255400),('C25',305,NULL,NULL,'2020-08-09 19:30:00',0,44409,13,10,65,98700,93765,'2020-08-29 19:30:00',0,'2020-09-05 19:30:00',4935,4935000),('B77',306,NULL,NULL,'2021-05-05 15:30:00',0,162428,13,22,65,64300,61085,'2021-05-07 15:30:00',0,'2021-05-14 15:30:00',3215,1157400),('E57',307,NULL,NULL,'2019-03-08 16:30:00',0,48475,13,7,65,6500,6175,'2019-02-22 16:30:00',0,'2019-03-01 16:30:00',325,305500),('B29',308,NULL,NULL,'2020-12-14 17:00:00',0,94302,19,11,66,45700,43415,'2020-12-07 17:00:00',0,'2020-12-14 17:00:00',2285,639800),('B91',309,NULL,NULL,'2019-06-22 16:00:00',0,10286,19,1,66,1000,950,'2019-06-22 16:00:00',0,'2019-06-29 16:00:00',50,62000),('E72',310,NULL,NULL,'2021-05-01 16:00:00',0,193394,19,26,66,326300,97890,'2021-05-10 16:00:00',212095,NULL,16315,10115300),('A98',311,NULL,NULL,'2020-08-15 18:30:00',0,10286,19,1,66,1000,950,'2020-08-19 18:30:00',0,'2020-08-26 18:30:00',50,62000),('D20',312,NULL,NULL,'2020-06-28 09:00:00',0,89447,19,23,66,64300,61085,'2020-06-27 09:00:00',0,'2020-07-04 09:00:00',3215,6108500),('C88',313,'2021-08-09 09:00:00','2021-08-09 11:20:00','2021-08-09 09:00:00',1,122365,19,9,66,34334,32617,NULL,0,NULL,1717,824016),('B26',314,NULL,NULL,'2020-11-27 13:30:00',0,88244,7,19,67,32600,30970,'2020-11-25 13:30:00',0,'2020-12-02 13:30:00',1630,1304000),('B42',315,NULL,NULL,'2020-12-15 17:30:00',0,116991,7,1,67,1000,950,'2020-12-16 17:30:00',0,'2020-12-23 17:30:00',50,62000),('B29',316,NULL,NULL,'2021-05-06 10:30:00',0,151983,7,1,67,1000,950,'2021-05-03 10:30:00',0,'2021-05-10 10:30:00',50,62000),('E18',317,NULL,NULL,'2020-05-25 16:30:00',0,151424,7,29,67,64533,61306,'2020-06-02 16:30:00',0,'2020-06-09 16:30:00',3227,5356239),('D83',318,'2021-06-22 16:30:00','2021-06-22 17:10:00','2021-06-22 16:30:00',1,62082,7,29,67,64533,19360,'2021-06-12 16:30:00',41946,NULL,3227,5356239),('A85',319,'2021-08-04 17:30:00','2021-08-04 18:15:00','2021-08-04 17:30:00',1,218145,7,10,67,98700,93765,NULL,0,NULL,4935,3750600),('C14',320,NULL,NULL,'2019-04-13 13:00:00',0,48475,7,28,67,343400,326230,'2019-04-27 13:00:00',0,'2019-05-04 13:00:00',17170,26098400),('B62',321,NULL,NULL,'2020-01-13 15:30:00',0,203912,3,11,68,45700,43415,'2020-01-18 15:30:00',0,'2020-01-25 15:30:00',2285,1279600),('A28',322,NULL,NULL,'2020-05-13 13:30:00',0,151434,3,22,68,64300,19290,'2020-05-09 13:30:00',41795,NULL,3215,4436700),('B65',323,NULL,NULL,'2020-08-04 11:00:00',0,116991,16,1,68,1000,950,'2020-08-06 11:00:00',0,'2020-08-13 11:00:00',50,85000),('C25',324,NULL,NULL,'2020-10-05 11:30:00',0,25304,16,1,68,1000,950,'2020-10-15 11:30:00',0,'2020-10-22 11:30:00',50,85000),('E0',325,'2021-09-13 09:00:00','2021-09-13 17:20:00','2021-09-13 09:00:00',1,44409,3,4,68,34300,32585,NULL,0,NULL,1715,2778300),('A3',326,NULL,NULL,'2020-06-27 14:00:00',0,45166,12,16,69,32600,30970,'2020-07-03 14:00:00',0,'2020-07-10 14:00:00',1630,2379800),('D49',327,NULL,NULL,'2020-04-17 19:00:00',0,151983,12,6,69,34300,32585,'2020-04-12 19:00:00',0,'2020-04-19 19:00:00',1715,1543500),('D4',328,NULL,NULL,'2021-06-10 15:00:00',0,145728,12,17,69,64100,60895,NULL,0,NULL,3205,641000),('A3',329,NULL,NULL,'2020-04-08 09:30:00',0,77742,12,23,69,64300,19290,'2020-04-03 09:30:00',41795,NULL,3215,450100),('D57',330,NULL,NULL,'2021-06-05 18:00:00',0,143805,12,10,69,98700,29610,'2021-05-29 18:00:00',64155,NULL,4935,8586900),('E49',331,NULL,NULL,'2020-05-07 17:00:00',0,36867,12,12,69,64500,61275,'2020-05-17 17:00:00',0,'2020-05-24 17:00:00',3225,2902500),('E43',332,NULL,NULL,'2019-04-14 14:00:00',0,162034,12,12,69,64500,61275,'2019-04-14 14:00:00',0,'2019-04-21 14:00:00',3225,2902500),('E0',333,NULL,NULL,'2020-02-15 19:30:00',0,45051,7,1,70,1000,950,'2020-02-20 19:30:00',0,'2020-02-27 19:30:00',50,62000),('B15',334,NULL,NULL,'2020-04-19 18:00:00',0,143805,10,19,70,32600,9780,'2020-04-11 18:00:00',21190,NULL,1630,1043200),('E64',335,NULL,NULL,'2020-07-01 16:00:00',0,203912,23,10,70,98700,93765,'2020-06-29 16:00:00',0,'2020-07-06 16:00:00',4935,1381800),('B66',336,NULL,NULL,'2020-01-19 18:30:00',0,10286,10,15,70,23500,22325,'2020-01-18 18:30:00',0,'2020-01-25 18:30:00',1175,1974000),('D72',337,NULL,NULL,'2020-03-24 12:30:00',0,54659,10,22,70,64300,61085,'2020-03-31 12:30:00',0,'2020-04-07 12:30:00',3215,5144000),('C50',338,'2021-08-23 18:30:00','2021-08-24 02:45:00','2021-08-23 18:30:00',1,10286,10,13,70,2455,2332,NULL,0,NULL,123,225860),('C88',339,NULL,NULL,'2021-04-11 18:30:00',0,158200,10,15,70,23500,22325,'2021-04-06 18:30:00',0,'2021-04-13 18:30:00',1175,1974000),('C25',340,NULL,NULL,'2019-01-27 19:30:00',0,54659,16,21,71,4540,4313,'2019-02-09 19:30:00',0,'2019-02-16 19:30:00',227,149820),('B70',341,NULL,NULL,'2020-06-10 16:30:00',0,151434,13,20,71,53600,16080,'2020-05-31 16:30:00',34840,NULL,2680,375200),('C14',342,NULL,NULL,'2019-11-02 17:00:00',0,165294,19,26,72,326300,309985,'2019-10-19 17:00:00',0,'2019-10-26 17:00:00',16315,10115300),('C98',343,NULL,NULL,'2020-11-09 13:30:00',0,25304,19,8,72,54200,51490,'2020-10-26 13:30:00',0,'2020-11-02 13:30:00',2710,5040600),('B61',344,NULL,NULL,'2020-08-12 12:30:00',0,36867,9,12,72,64500,61275,'2020-08-18 12:30:00',0,'2020-08-25 12:30:00',3225,2580000),('A73',345,NULL,NULL,'2020-02-05 19:00:00',0,136288,19,1,72,1000,950,'2020-02-01 19:00:00',0,'2020-02-08 19:00:00',50,62000),('B42',346,NULL,NULL,'2020-02-10 12:00:00',0,91314,14,11,73,45700,43415,'2020-02-01 12:00:00',0,'2020-02-08 12:00:00',2285,2102200),('C22',347,NULL,NULL,'2020-04-20 11:30:00',0,171249,14,27,73,326700,310365,'2020-04-17 11:30:00',0,'2020-04-24 11:30:00',16335,29729700),('E7',348,NULL,NULL,'2020-03-14 13:00:00',0,94302,9,29,73,64533,61306,'2020-03-14 13:00:00',0,'2020-03-21 13:00:00',3227,2968518),('D19',349,'2021-08-12 09:30:00','2021-08-12 09:55:00','2021-08-12 09:30:00',1,145728,3,15,73,23500,22325,NULL,0,NULL,1175,2021000),('C55',350,NULL,NULL,'2021-01-22 08:30:00',0,48475,3,7,73,6500,6175,'2021-02-02 08:30:00',0,'2021-02-09 08:30:00',325,208000),('E6',351,'2021-08-17 15:30:00','2021-08-17 16:55:00','2021-08-17 15:30:00',1,151983,9,16,73,32600,30970,NULL,0,NULL,1630,912800),('C31',352,NULL,NULL,'2020-11-08 17:00:00',0,155533,20,26,74,326300,309985,'2020-11-17 17:00:00',0,'2020-11-24 17:00:00',16315,25451400),('C81',353,NULL,NULL,'2020-07-12 08:30:00',0,62082,20,20,74,53600,16080,'2020-07-15 08:30:00',34840,NULL,2680,53600),('B32',354,NULL,NULL,'2021-01-08 14:00:00',0,36867,20,15,74,23500,22325,'2021-01-01 14:00:00',0,'2021-01-08 14:00:00',1175,1692000),('E20',355,NULL,NULL,'2020-07-11 13:00:00',0,144810,20,1,74,1000,950,'2020-07-21 13:00:00',0,'2020-07-28 13:00:00',50,95000),('A34',356,NULL,NULL,'2020-12-01 13:30:00',0,54659,3,17,74,64100,60895,'2020-12-01 13:30:00',0,'2020-12-08 13:30:00',3205,4743400),('B43',357,NULL,NULL,'2020-07-21 16:30:00',0,48475,3,25,74,32400,30780,'2020-07-21 16:30:00',0,'2020-07-28 16:30:00',1620,3078000),('E43',358,NULL,NULL,'2019-05-05 19:00:00',0,103854,12,26,75,326300,309985,'2019-05-02 19:00:00',0,'2019-05-09 19:00:00',16315,17946500),('A85',359,NULL,NULL,'2019-08-16 11:00:00',0,162034,10,12,75,64500,61275,'2019-08-09 11:00:00',0,'2019-08-16 11:00:00',3225,258000),('C25',360,NULL,NULL,'2021-05-05 16:00:00',0,45051,12,1,75,1000,950,'2021-05-05 16:00:00',0,'2021-05-12 16:00:00',50,86000),('B26',361,'2021-07-19 17:00:00','2021-07-19 17:25:00','2021-07-19 17:00:00',1,162428,16,7,75,6500,6175,NULL,0,NULL,325,637000),('C34',362,'2021-07-20 13:30:00','2021-07-20 18:30:00','2021-07-20 13:30:00',1,151424,16,8,75,54200,51490,NULL,0,NULL,2710,4010800),('A34',363,NULL,NULL,'2020-07-20 08:30:00',0,89447,10,23,75,64300,61085,'2020-07-29 08:30:00',0,'2020-08-05 08:30:00',3215,6172800),('B70',364,'2021-12-02 10:00:00','2021-12-02 10:50:00','2021-12-02 10:00:00',1,77742,10,23,75,64300,19290,NULL,41795,NULL,3215,6172800),('A77',365,'2021-12-19 11:00:00','2021-12-19 11:50:00','2021-12-19 11:00:00',1,116781,15,26,76,326300,309985,NULL,0,NULL,16315,16967600),('B70',366,NULL,NULL,'2020-12-22 12:30:00',0,155533,15,7,76,6500,6175,'2021-01-01 12:30:00',0,'2021-01-08 12:30:00',325,351000),('B15',367,NULL,NULL,'2020-09-12 10:30:00',0,203912,2,29,76,64533,61306,'2020-09-10 10:30:00',0,'2020-09-17 10:30:00',3227,5549838),('A77',368,'2021-09-18 19:30:00','2021-09-18 20:05:00','2021-09-18 19:30:00',1,45051,7,1,76,1000,950,NULL,0,NULL,50,62000),('C77',369,NULL,NULL,'2020-06-02 18:00:00',0,62082,23,9,77,34334,10300,'2020-06-02 18:00:00',22317,NULL,1717,2712386),('A73',370,NULL,NULL,'2020-03-18 08:00:00',0,171249,10,8,77,54200,51490,'2020-03-03 08:00:00',0,'2020-03-10 08:00:00',2710,5257400),('D72',371,NULL,NULL,'2019-05-12 19:00:00',0,48475,17,15,77,23500,22325,'2019-05-07 19:00:00',0,'2019-05-14 19:00:00',1175,963500),('E95',372,NULL,NULL,'2020-01-18 14:00:00',0,91314,10,10,77,98700,93765,'2020-01-23 14:00:00',0,'2020-01-30 14:00:00',4935,7402500),('C81',373,NULL,NULL,'2021-05-13 14:30:00',0,44409,10,10,77,98700,93765,'2021-05-25 14:30:00',0,'2021-06-01 14:30:00',4935,7402500),('C54',374,NULL,NULL,'2021-05-22 10:00:00',0,116991,10,4,77,34300,32585,'2021-05-29 10:00:00',0,'2021-06-05 10:00:00',1715,3292800),('C54',375,NULL,NULL,'2020-09-28 16:00:00',0,203912,23,29,77,64533,61306,'2020-09-28 16:00:00',0,'2020-10-05 16:00:00',3227,2000523),('E57',376,'2021-10-15 17:30:00','2021-10-15 17:55:00','2021-10-15 17:30:00',1,196879,17,15,78,23500,22325,NULL,0,NULL,1175,963500),('C25',377,NULL,NULL,'2021-01-13 09:30:00',0,101004,17,6,78,34300,32585,'2021-01-19 09:30:00',0,'2021-01-26 09:30:00',1715,1337700),('C92',378,NULL,NULL,'2019-10-01 08:30:00',0,145728,17,15,78,23500,22325,'2019-09-24 08:30:00',0,'2019-10-01 08:30:00',1175,963500),('B70',379,NULL,NULL,'2019-08-13 13:00:00',0,62082,2,11,78,45700,13710,'2019-08-10 13:00:00',29705,NULL,2285,2650600),('B43',380,NULL,NULL,'2021-03-20 15:00:00',0,116991,23,2,78,23200,22040,'2021-03-15 15:00:00',0,'2021-03-22 15:00:00',1160,464000),('C66',381,'2021-11-24 12:30:00','2021-11-24 14:50:00','2021-11-24 12:30:00',1,62082,14,9,79,34334,10300,NULL,22317,NULL,1717,1098688),('A39',382,NULL,NULL,'2020-12-19 18:30:00',0,88244,15,23,79,64300,61085,'2020-12-13 18:30:00',0,'2020-12-20 18:30:00',3215,2572000),('B42',383,NULL,NULL,'2020-05-23 09:30:00',0,203912,3,15,79,23500,22325,'2020-05-28 09:30:00',0,'2020-06-04 09:30:00',1175,2021000),('D47',384,NULL,NULL,'2020-02-18 14:00:00',0,197201,14,7,79,6500,6175,'2020-02-23 14:00:00',0,'2020-03-01 14:00:00',325,422500),('E6',385,NULL,NULL,'2019-01-06 11:00:00',0,165294,15,26,79,326300,309985,'2019-01-07 11:00:00',0,'2019-01-14 11:00:00',16315,16967600),('C27',386,NULL,NULL,'2020-10-27 12:30:00',0,43074,3,22,79,64300,61085,'2020-11-03 12:30:00',0,'2020-11-10 12:30:00',3215,4436700),('B1',387,'2021-12-13 15:30:00','2021-12-13 17:00:00','2021-12-13 15:30:00',1,101004,12,6,80,34300,32585,NULL,0,NULL,1715,1543500),('B65',388,NULL,NULL,'2021-04-16 17:00:00',0,143805,10,10,80,98700,29610,'2021-04-15 17:00:00',64155,NULL,4935,7402500),('D20',389,NULL,NULL,'2020-11-12 14:00:00',0,196879,2,29,80,64533,61306,'2020-11-06 14:00:00',0,'2020-11-13 14:00:00',3227,5549838),('C18',390,NULL,NULL,'2019-06-20 14:00:00',0,122365,10,26,80,326300,309985,'2019-06-20 14:00:00',0,'2019-06-27 14:00:00',16315,26756600),('E9',391,NULL,NULL,'2020-04-04 14:30:00',0,155533,12,26,80,326300,309985,'2020-03-27 14:30:00',0,'2020-04-03 14:30:00',16315,17946500),('A79',392,NULL,NULL,'2020-10-21 08:30:00',0,196879,10,10,80,98700,93765,'2020-10-26 08:30:00',0,'2020-11-02 08:30:00',4935,7402500),('B91',393,'2021-08-16 17:30:00','2021-08-16 18:20:00','2021-08-16 17:30:00',1,103854,13,26,81,326300,309985,NULL,0,NULL,16315,7504900),('B62',394,NULL,NULL,'2021-02-17 17:00:00',0,151983,13,8,81,54200,51490,'2021-02-18 17:00:00',0,'2021-02-25 17:00:00',2710,4281800),('D33',395,NULL,NULL,'2020-09-10 17:30:00',0,54659,14,7,81,6500,6175,'2020-09-13 17:30:00',0,'2020-09-20 17:30:00',325,422500),('E18',396,NULL,NULL,'2020-08-25 10:30:00',0,62082,14,29,81,64533,19360,'2020-08-24 10:30:00',41946,NULL,3227,516264),('C50',397,NULL,NULL,'2021-06-10 15:00:00',0,116991,13,8,81,54200,51490,'2021-06-11 15:00:00',0,NULL,2710,4281800),('E49',398,'2021-09-22 17:00:00','2021-09-22 17:45:00','2021-09-22 17:00:00',1,143805,13,10,81,98700,29610,NULL,64155,NULL,4935,4935000),('A33',399,NULL,NULL,'2019-07-07 19:00:00',0,43074,12,8,82,54200,51490,'2019-07-01 19:00:00',0,'2019-07-08 19:00:00',2710,4986400),('C27',400,NULL,NULL,'2021-02-27 13:00:00',0,54659,12,17,82,64100,60895,'2021-02-20 13:00:00',0,'2021-02-27 13:00:00',3205,641000),('C14',401,NULL,NULL,'2019-02-14 10:00:00',0,88244,12,19,82,32600,30970,'2019-02-12 10:00:00',0,'2019-02-19 10:00:00',1630,358600),('C66',402,NULL,NULL,'2020-10-01 19:30:00',0,162428,15,7,83,6500,6175,'2020-10-09 19:30:00',0,'2020-10-16 19:30:00',325,351000),('A3',403,NULL,NULL,'2020-06-03 10:30:00',0,57203,16,7,83,6500,6175,'2020-05-29 10:30:00',0,'2020-06-05 10:30:00',325,637000),('C22',404,'2021-12-04 14:00:00','2021-12-04 18:35:00','2021-12-04 14:00:00',1,43074,15,3,83,34400,32680,NULL,0,NULL,1720,516000),('C70',405,'2021-10-24 11:30:00','2021-10-24 16:30:00','2021-10-24 11:30:00',1,45051,16,8,83,54200,51490,NULL,0,NULL,2710,4010800),('E49',406,NULL,NULL,'2020-01-01 12:30:00',0,79156,17,27,84,326700,310365,'2020-01-07 12:30:00',0,'2020-01-14 12:30:00',16335,24502500),('E20',407,'2021-06-23 17:00:00','2021-06-24 02:15:00','2021-06-23 16:30:00',1,162034,10,20,84,53600,50920,NULL,0,NULL,2680,482400),('E78',408,'2021-08-13 18:00:00','2021-08-13 18:35:00','2021-08-13 17:30:00',1,162034,10,22,84,64300,61085,NULL,0,NULL,3215,5144000),('D4',409,NULL,NULL,'2019-06-15 08:00:00',0,77742,10,26,84,326300,97890,'2019-06-06 08:00:00',212095,NULL,16315,26756600),('B77',410,NULL,NULL,'2020-04-22 12:00:00',0,145728,10,13,84,2455,2332,'2020-04-08 12:00:00',0,'2020-04-15 12:00:00',123,225860),('C50',411,'2021-08-24 19:00:00','2021-08-24 20:20:00','2021-08-24 19:00:00',1,57203,2,23,84,64300,61085,NULL,0,NULL,3215,4565300),('B42',412,NULL,NULL,'2020-05-06 16:30:00',0,193394,17,26,85,326300,97890,'2020-04-25 16:30:00',212095,NULL,16315,16315000),('A28',413,NULL,NULL,'2020-09-14 16:30:00',0,151424,13,20,85,53600,50920,'2020-09-16 16:30:00',0,'2020-09-23 16:30:00',2680,375200),('B23',414,NULL,NULL,'2020-09-21 08:30:00',0,116991,17,8,85,54200,51490,'2020-09-17 08:30:00',0,'2020-09-24 08:30:00',2710,2384800),('E0',415,NULL,NULL,'2020-12-20 11:00:00',0,196879,13,26,85,326300,309985,'2020-12-13 11:00:00',0,'2020-12-20 11:00:00',16315,7504900),('C25',416,NULL,NULL,'2019-05-05 15:30:00',0,182403,18,28,86,343400,326230,'2019-05-12 15:30:00',0,'2019-05-19 15:30:00',17170,6181200),('B26',417,NULL,NULL,'2019-11-23 14:30:00',0,116991,18,2,86,23200,22040,'2019-12-08 14:30:00',0,'2019-12-15 14:30:00',1160,1438400),('A79',418,NULL,NULL,'2020-05-06 13:30:00',0,116991,10,10,87,98700,93765,'2020-05-20 13:30:00',0,'2020-05-27 13:30:00',4935,7402500),('E69',419,NULL,NULL,'2020-07-12 10:30:00',0,143805,10,10,87,98700,29610,'2020-07-05 10:30:00',64155,NULL,4935,7402500),('D57',420,NULL,NULL,'2021-02-25 16:30:00',0,91314,10,10,87,98700,93765,'2021-02-26 16:30:00',0,'2021-03-05 16:30:00',4935,7402500),('C25',421,NULL,NULL,'2020-09-16 10:30:00',0,155533,10,20,87,53600,50920,'2020-09-13 10:30:00',0,'2020-09-20 10:30:00',2680,482400),('C54',422,NULL,NULL,'2020-10-22 11:30:00',0,48475,10,20,87,53600,50920,'2020-10-16 11:30:00',0,'2020-10-23 11:30:00',2680,482400),('E0',423,NULL,NULL,'2020-12-27 08:30:00',0,94302,14,9,88,34334,32617,'2020-12-25 08:30:00',0,'2021-01-01 08:30:00',1717,1098688),('D4',424,NULL,NULL,'2021-05-10 15:30:00',0,151424,14,9,88,34334,32617,'2021-05-09 15:30:00',0,'2021-05-16 15:30:00',1717,1098688),('E20',425,NULL,NULL,'2019-08-21 16:30:00',0,151434,14,20,88,53600,16080,'2019-08-17 16:30:00',34840,NULL,2680,2465600),('A79',426,'2021-11-11 12:30:00','2021-11-11 13:10:00','2021-11-11 12:30:00',1,151424,14,11,88,45700,43415,NULL,0,NULL,2285,2102200),('C87',427,'2021-12-14 11:30:00','2021-12-14 13:50:00','2021-12-14 11:30:00',1,94302,14,9,88,34334,32617,NULL,0,NULL,1717,1098688),('E49',428,NULL,NULL,'2019-11-27 08:30:00',0,36867,14,27,88,326700,310365,'2019-11-26 08:30:00',0,'2019-12-03 08:30:00',16335,29729700),('B79',429,NULL,NULL,'2020-12-28 18:30:00',0,10286,21,15,89,23500,22325,'2020-12-26 18:30:00',0,'2021-01-02 18:30:00',1175,258500),('B29',430,'2021-08-28 14:00:00','2021-08-28 14:45:00','2021-08-28 14:00:00',1,44409,21,10,89,98700,93765,NULL,0,NULL,4935,9771300),('C27',431,NULL,NULL,'2021-01-19 09:30:00',0,36867,21,17,89,64100,60895,'2021-01-31 09:30:00',0,'2021-02-07 09:30:00',3205,2948600),('E39',432,'2021-12-18 13:00:00','2021-12-18 13:25:00','2021-12-18 13:00:00',1,48475,16,7,89,6500,6175,NULL,0,NULL,325,637000),('D47',433,NULL,NULL,'2021-04-22 12:30:00',0,10286,21,13,89,2455,2332,'2021-04-14 12:30:00',0,'2021-04-21 12:30:00',123,81015),('E95',434,NULL,NULL,'2019-11-03 10:00:00',0,196879,21,10,89,98700,93765,'2019-10-18 10:00:00',0,'2019-10-25 10:00:00',4935,9771300),('B62',435,NULL,NULL,'2021-03-03 10:30:00',0,64372,15,22,90,64300,61085,'2021-03-14 10:30:00',0,'2021-03-21 10:30:00',3215,2764900),('C98',436,NULL,NULL,'2020-06-01 14:30:00',0,196879,2,2,90,23200,22040,'2020-06-16 14:30:00',0,'2020-06-23 14:30:00',1160,2041600),('B84',437,'2021-09-14 08:00:00','2021-09-14 13:00:00','2021-09-14 08:00:00',1,113545,18,8,91,54200,51490,NULL,0,NULL,2710,4444400),('C25',438,NULL,NULL,'2021-06-13 19:00:00',0,25304,18,8,91,54200,51490,'2021-06-07 19:00:00',0,'2021-06-14 19:00:00',2710,4444400),('E6',439,NULL,NULL,'2020-02-16 19:30:00',0,162428,7,10,91,98700,93765,'2020-02-11 19:30:00',0,'2020-02-18 19:30:00',4935,3750600),('B42',440,'2021-11-12 12:30:00','2021-11-12 13:05:00','2021-11-12 12:30:00',1,116781,17,22,91,64300,61085,NULL,0,NULL,3215,257200),('C54',441,NULL,NULL,'2020-06-21 14:30:00',0,165294,23,6,91,34300,32585,'2020-06-23 14:30:00',0,'2020-06-30 14:30:00',1715,2538200),('E7',442,'2021-07-16 08:30:00','2021-07-16 09:05:00','2021-07-16 08:30:00',1,145728,17,22,92,64300,61085,NULL,0,NULL,3215,257200),('D49',443,NULL,NULL,'2020-02-16 11:00:00',0,43074,15,3,92,34400,32680,'2020-02-12 11:00:00',0,'2020-02-19 11:00:00',1720,516000),('E20',444,NULL,NULL,'2020-02-21 10:30:00',0,182403,14,28,92,343400,326230,'2020-03-03 10:30:00',0,'2020-03-10 10:30:00',17170,33996600),('B1',445,'2021-07-01 16:30:00','2021-07-01 18:00:00','2021-07-01 16:30:00',1,54659,15,6,92,34300,32585,'2021-06-12 16:30:00',0,NULL,1715,2778300),('C88',446,NULL,NULL,'2020-09-14 08:00:00',0,119032,15,17,92,64100,60895,'2020-09-26 08:00:00',0,'2020-10-03 08:00:00',3205,2179400),('C27',447,NULL,NULL,'2020-04-08 16:00:00',0,116781,3,22,92,64300,61085,'2020-04-11 16:00:00',0,'2020-04-18 16:00:00',3215,4436700),('D59',448,NULL,NULL,'2020-06-27 18:00:00',0,116991,15,21,93,4540,4313,'2020-06-14 18:00:00',0,'2020-06-21 18:00:00',227,40860),('C97',449,NULL,NULL,'2020-05-27 13:30:00',0,48475,2,25,93,32400,30780,'2020-06-05 13:30:00',0,'2020-06-12 13:30:00',1620,2430000),('A39',450,NULL,NULL,'2020-10-24 11:00:00',0,36867,2,20,93,53600,50920,'2020-11-02 11:00:00',0,'2020-11-09 11:00:00',2680,589600),('C14',451,NULL,NULL,'2021-03-16 08:30:00',0,54659,2,17,93,64100,60895,'2021-04-01 08:30:00',0,'2021-04-08 08:30:00',3205,4487000),('A34',452,NULL,NULL,'2020-03-09 10:30:00',0,62082,15,29,93,64533,19360,'2020-03-01 10:30:00',41946,NULL,3227,1355193),('E20',453,'2021-08-27 11:00:00','2021-08-27 11:35:00','2021-08-27 11:00:00',1,136288,2,1,93,1000,950,NULL,0,NULL,50,97000),('B42',454,NULL,NULL,'2020-02-04 08:00:00',0,151424,2,1,93,1000,950,'2020-02-20 08:00:00',0,'2020-02-27 08:00:00',50,97000),('E72',455,NULL,NULL,'2021-03-28 10:30:00',0,183300,10,20,94,53600,50920,'2021-04-02 10:30:00',0,'2021-04-09 10:30:00',2680,482400),('B77',456,NULL,NULL,'2020-09-20 17:30:00',0,36867,10,10,94,98700,93765,'2020-09-08 17:30:00',0,'2020-09-15 17:30:00',4935,7402500),('B61',457,NULL,NULL,'2019-10-01 10:30:00',0,57203,9,10,94,98700,93765,'2019-09-21 10:30:00',0,'2019-09-28 10:30:00',4935,7205100),('D57',458,'2021-12-01 18:00:00','2021-12-01 18:40:00','2021-12-01 18:00:00',1,62082,9,11,94,45700,13710,NULL,29705,NULL,2285,4113000),('B65',459,NULL,NULL,'2019-08-06 08:30:00',0,162034,9,12,94,64500,61275,'2019-07-26 08:30:00',0,'2019-08-02 08:30:00',3225,2580000),('E78',460,NULL,NULL,'2020-09-15 09:30:00',0,58390,9,25,94,32400,30780,'2020-09-15 09:30:00',0,'2020-09-22 09:30:00',1620,1782000),('D20',461,'2021-11-19 17:30:00','2021-11-19 19:20:00','2021-11-19 17:30:00',1,145728,22,12,95,64500,61275,NULL,0,NULL,3225,3741000),('E20',462,'2021-08-07 12:00:00','2021-08-07 12:25:00','2021-08-07 12:00:00',1,199303,2,7,95,6500,6175,NULL,0,NULL,325,526500),('B17',463,'2021-08-06 15:30:00','2021-08-06 17:50:00','2021-08-06 15:30:00',1,25304,2,12,95,64500,61275,NULL,0,NULL,3225,5031000),('D19',464,NULL,NULL,'2021-05-18 16:30:00',0,155533,22,26,95,326300,309985,'2021-05-24 16:30:00',0,'2021-05-31 16:30:00',16315,12399400),('A98',465,'2021-12-22 18:30:00','2021-12-22 23:30:00','2021-12-22 18:00:00',1,151424,2,8,95,54200,51490,NULL,0,NULL,2710,2547400),('A85',466,'2021-11-21 16:00:00','2021-11-21 16:25:00','2021-11-21 15:30:00',1,119032,10,15,95,23500,22325,NULL,0,NULL,1175,1974000),('C88',467,NULL,NULL,'2019-11-23 18:00:00',0,43074,16,1,96,1000,950,'2019-11-26 18:00:00',0,'2019-12-03 18:00:00',50,85000),('D47',468,'2021-10-05 12:30:00','2021-10-05 14:00:00','2021-10-05 12:30:00',1,119032,16,6,96,34300,32585,NULL,0,NULL,1715,583100),('E95',469,NULL,NULL,'2020-04-28 10:00:00',0,151434,16,22,96,64300,19290,'2020-04-22 10:00:00',41795,NULL,3215,1350300),('D72',470,NULL,NULL,'2020-10-19 14:00:00',0,151434,18,22,97,64300,19290,'2020-10-24 14:00:00',41795,NULL,3215,6365700),('D19',471,NULL,NULL,'2021-01-27 10:30:00',0,62082,18,20,97,53600,16080,'2021-01-21 10:30:00',34840,NULL,2680,53600),('C77',472,'2021-06-25 19:00:00','2021-06-25 20:50:00','2021-06-25 19:00:00',1,48475,12,12,98,64500,61275,NULL,0,NULL,3225,2902500),('C46',473,NULL,NULL,'2020-09-20 12:00:00',0,203912,12,29,98,64533,61306,'2020-09-23 12:00:00',0,'2020-09-30 12:00:00',3227,4259178),('D22',474,'2021-08-16 17:30:00','2021-08-17 01:50:00','2021-08-16 17:30:00',1,116991,12,4,98,34300,32585,NULL,0,NULL,1715,2812600),('A39',475,NULL,NULL,'2020-09-21 15:30:00',0,54659,14,7,99,6500,6175,'2020-09-14 15:30:00',0,'2020-09-21 15:30:00',325,422500),('E95',476,NULL,NULL,'2020-09-02 16:00:00',0,56869,14,28,99,343400,326230,'2020-09-10 16:00:00',0,'2020-09-17 16:00:00',17170,33996600),('B65',477,NULL,NULL,'2020-09-20 11:30:00',0,56869,15,17,99,64100,60895,'2020-09-27 11:30:00',0,'2020-10-04 11:30:00',3205,2179400),('B66',478,NULL,NULL,'2020-08-24 14:00:00',0,171249,15,1,99,1000,950,'2020-08-25 14:00:00',0,'2020-09-01 14:00:00',50,38000),('C98',479,'2021-07-13 12:00:00','2021-07-13 21:15:00','2021-07-13 12:00:00',1,151424,15,20,99,53600,50920,NULL,0,NULL,2680,911200),('B32',480,'2021-06-23 12:30:00','2021-06-23 12:55:00','2021-06-23 12:30:00',1,48475,14,7,99,6500,6175,NULL,0,NULL,325,422500),('C22',481,NULL,NULL,'2020-10-04 18:30:00',0,36867,19,15,100,23500,22325,'2020-10-05 18:30:00',0,'2020-10-12 18:30:00',1175,1997500),('B42',482,'2021-09-26 08:30:00','2021-09-26 10:20:00','2021-09-26 08:30:00',1,119032,10,12,100,64500,61275,NULL,0,NULL,3225,258000),('B43',483,NULL,NULL,'2020-10-19 08:00:00',0,162034,19,17,100,64100,60895,'2020-10-25 08:00:00',0,'2020-11-01 08:00:00',3205,3333200),('E12',484,NULL,NULL,'2019-12-14 11:00:00',0,151983,19,6,100,34300,32585,'2019-12-14 11:00:00',0,'2019-12-21 11:00:00',1715,788900),('B79',485,NULL,NULL,'2020-10-08 12:30:00',0,36867,10,12,100,64500,61275,'2020-10-05 12:30:00',0,'2020-10-12 12:30:00',3225,258000);
/*!40000 ALTER TABLE `atendimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `atendimento_esperado`
--

LOCK TABLES `atendimento_esperado` WRITE;
/*!40000 ALTER TABLE `atendimento_esperado` DISABLE KEYS */;
INSERT INTO `atendimento_esperado` VALUES (1,15,1),(2,28,1),(3,11,1),(3,15,1),(3,10,1),(4,12,1),(4,3,1),(5,13,1),(5,19,1),(7,6,1),(7,21,1),(8,3,2),(8,28,1),(9,12,1),(9,17,1),(10,29,1),(10,23,1),(11,12,1),(11,29,1),(12,12,1),(13,2,1),(14,26,1),(14,15,1),(15,28,1),(15,6,1),(15,25,1),(16,22,1),(16,29,1),(17,19,1),(18,3,1),(18,11,1),(19,8,1),(19,23,1),(20,10,1),(20,20,1),(20,6,1),(21,13,1),(21,7,1),(21,12,1),(22,29,1),(22,13,1),(23,16,1),(23,15,1),(24,7,2),(24,26,1),(25,25,1),(25,28,1),(25,17,1),(26,27,1),(27,25,1),(27,2,1),(27,24,1),(27,4,1),(28,16,2),(28,12,1),(28,18,1);
/*!40000 ALTER TABLE `atendimento_esperado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (329284240),(364793066),(737990252),(1250648610),(1589288734),(1714718220),(3198488176),(3430711509),(3593172607),(4342416794),(4527619306),(5337369946),(5354711061),(5566953727),(6298844805),(6584679560),(6696400699),(7791511517),(7861925005),(7937549173),(8416305692),(8476452748),(8598182419),(8634570703),(9056572768),(9092362670),(10451575709),(10727181033),(10906781345),(11110462557),(11344611435),(11425163009),(11481243810),(12184002267),(13394207249),(13671282002),(13856670017),(13920353846),(14954213681),(15465538600),(15466993255),(17148124484),(17578761463),(17645947462),(17708584230),(18181950895),(18822853016),(19423082130),(19558005967),(19867987047),(20753754029),(20873560841),(20909274290),(20986784605),(21313568465),(22234407460),(22572592207),(22699221740),(22908536749),(23427394786),(24138815902),(24627304196),(24682635450),(25216530126),(25260448472),(25307761643),(25887839538),(26080581914),(26819739532),(26886583603),(26986509073),(27797849544),(28122239102),(28254626405),(28584997806),(28649949096),(28760833530),(29035094840),(29749795059),(30045277079),(30304235229),(31445777665),(32420488490),(32544925019),(32561192474),(32571287893),(32711854256),(32769179632),(32808974167),(34037847701),(34313544402),(35096115607),(36255152618),(36318340203),(36419357250),(36508069241),(36536612264),(36644644198),(37523394620),(39034982467),(39475689591),(39901584574),(40579108325),(41046973622),(41236579585),(41330042301),(42744337307),(42835822631),(43280277604),(43496886099),(44014290603),(44815243085),(44989192206),(45260805356),(45316901410),(45646445990),(45719916067),(46343993002),(46538800262),(47324887228),(47973983619),(48831860755),(48996775452),(49679103781),(50545756421),(50688853552),(50779316312),(52396548832),(52428464027),(52532234440),(53059492549),(53323765702),(53618832478),(54021790004),(54363183470),(55184680756),(55660804136),(56014520759),(56795159540),(57406880197),(57628641709),(57764822167),(57905062830),(58155378705),(58526741098),(58945523464),(59017731281),(59215658815),(59448025530),(59991183280),(60746306822),(60941347885),(61066925801),(63389803211),(63870575743),(64471672819),(64835994396),(65109676186),(65282579812),(65703055903),(66321367290),(67226748940),(67612101351),(67623427105),(67866307318),(68682153556),(68774455540),(68953481589),(69152157946),(71097518051),(71203415885),(71989485022),(72076214690),(72536160149),(72788307535),(73361774330),(73709938848),(74368936612),(74651112692),(75031099046),(75067939702),(75091874860),(75161774231),(76592921374),(76797441900),(77389542993),(78020911014),(78041888623),(78457619403),(79427301406),(79518559872),(79615086002),(79744673630),(80503609200),(80607402105),(80777506645),(80836338286),(80984826505),(81021127949),(81775960986),(81781167400),(81942804008),(82275369724),(82496974302),(82899672258),(83011250391),(83481243650),(83514192146),(84154897497),(84780417023),(85154275403),(85274634745),(87147552113),(87363997101),(88136905096),(88342743934),(88376250493),(88416650926),(88727447766),(88832309815),(89618408272),(90389664588),(90511268750),(90659644606),(91036258696),(91872231209),(92159547247),(92187426718),(93351677898),(93551770468),(93776063220),(94140959932),(94392601900),(94666735640),(94949979809),(94966055679),(95377504348),(95471657802),(95746044202),(95803358347),(96188904650),(96303624812),(96667322030),(97105293748),(97439730950),(98310402015),(98379200250),(98941098025),(99052657408),(99398575272);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger colocar_cliente_no_plano_nenhum
	after insert on cliente
	for each row
	begin
		insert into cliente_plano_de_saude 
        (cpf, plano_de_saude_id) values
        (new.cpf, 1);
	end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `cliente_plano_de_saude`
--

LOCK TABLES `cliente_plano_de_saude` WRITE;
/*!40000 ALTER TABLE `cliente_plano_de_saude` DISABLE KEYS */;
INSERT INTO `cliente_plano_de_saude` VALUES (329284240,1),(329284240,12),(329284240,14),(329284240,23),(364793066,1),(364793066,4),(364793066,9),(364793066,15),(364793066,18),(737990252,1),(737990252,2),(737990252,10),(737990252,17),(737990252,22),(1250648610,1),(1250648610,10),(1250648610,12),(1250648610,13),(1250648610,17),(1250648610,18),(1250648610,23),(1589288734,1),(1589288734,15),(1589288734,17),(1589288734,21),(1714718220,1),(1714718220,7),(1714718220,12),(1714718220,14),(1714718220,17),(1714718220,23),(3198488176,1),(3198488176,10),(3198488176,19),(3430711509,1),(3430711509,3),(3430711509,7),(3430711509,15),(3430711509,17),(3593172607,1),(3593172607,16),(3593172607,19),(4342416794,1),(4342416794,2),(4342416794,10),(4342416794,22),(4527619306,1),(4527619306,2),(4527619306,7),(4527619306,12),(4527619306,17),(4527619306,23),(5337369946,1),(5337369946,2),(5337369946,18),(5337369946,19),(5354711061,1),(5354711061,5),(5354711061,14),(5354711061,15),(5566953727,1),(5566953727,21),(5566953727,22),(6298844805,1),(6298844805,16),(6584679560,1),(6584679560,7),(6584679560,22),(6584679560,24),(6696400699,1),(6696400699,12),(6696400699,18),(6696400699,22),(7791511517,1),(7791511517,3),(7791511517,14),(7791511517,15),(7861925005,1),(7861925005,5),(7861925005,13),(7861925005,22),(7937549173,1),(7937549173,2),(8416305692,1),(8416305692,18),(8476452748,1),(8476452748,2),(8476452748,10),(8476452748,13),(8476452748,15),(8476452748,16),(8598182419,1),(8598182419,2),(8598182419,7),(8598182419,12),(8598182419,15),(8598182419,21),(8598182419,23),(8634570703,1),(8634570703,2),(8634570703,13),(8634570703,14),(8634570703,16),(8634570703,24),(9056572768,1),(9056572768,2),(9056572768,10),(9056572768,12),(9056572768,23),(9092362670,1),(9092362670,7),(9092362670,10),(9092362670,23),(10451575709,1),(10451575709,3),(10451575709,7),(10727181033,1),(10727181033,9),(10727181033,12),(10727181033,22),(10906781345,1),(10906781345,7),(10906781345,17),(10906781345,18),(10906781345,23),(11110462557,1),(11110462557,22),(11110462557,23),(11344611435,1),(11344611435,3),(11344611435,7),(11344611435,19),(11425163009,1),(11425163009,2),(11425163009,13),(11425163009,17),(11481243810,1),(11481243810,3),(11481243810,5),(11481243810,10),(11481243810,17),(11481243810,19),(12184002267,1),(12184002267,3),(12184002267,7),(12184002267,14),(12184002267,15),(12184002267,16),(13394207249,1),(13671282002,1),(13671282002,7),(13856670017,1),(13856670017,2),(13920353846,1),(13920353846,12),(13920353846,15),(13920353846,16),(14954213681,1),(14954213681,2),(14954213681,10),(14954213681,16),(14954213681,22),(15465538600,1),(15465538600,3),(15465538600,12),(15465538600,15),(15466993255,1),(15466993255,3),(15466993255,7),(15466993255,15),(17148124484,1),(17148124484,6),(17148124484,10),(17148124484,12),(17148124484,15),(17148124484,17),(17148124484,19),(17148124484,21),(17148124484,22),(17578761463,1),(17578761463,2),(17578761463,13),(17578761463,17),(17578761463,22),(17645947462,1),(17645947462,10),(17708584230,1),(17708584230,4),(17708584230,14),(17708584230,15),(17708584230,23),(18181950895,1),(18181950895,9),(18181950895,12),(18181950895,23),(18822853016,1),(18822853016,10),(19423082130,1),(19423082130,2),(19423082130,23),(19558005967,1),(19558005967,18),(19867987047,1),(19867987047,2),(19867987047,13),(20753754029,1),(20753754029,2),(20753754029,3),(20753754029,10),(20753754029,14),(20873560841,1),(20873560841,4),(20873560841,12),(20909274290,1),(20909274290,3),(20909274290,4),(20909274290,10),(20909274290,15),(20909274290,16),(20986784605,1),(20986784605,14),(20986784605,16),(21313568465,1),(21313568465,2),(22234407460,1),(22234407460,2),(22234407460,4),(22234407460,7),(22234407460,9),(22234407460,10),(22234407460,17),(22234407460,24),(22572592207,1),(22572592207,7),(22572592207,10),(22572592207,15),(22572592207,17),(22572592207,23),(22699221740,1),(22699221740,3),(22699221740,13),(22699221740,15),(22699221740,22),(22699221740,23),(22908536749,1),(22908536749,15),(22908536749,17),(22908536749,22),(23427394786,1),(23427394786,7),(23427394786,19),(24138815902,1),(24138815902,2),(24138815902,3),(24138815902,23),(24627304196,1),(24627304196,15),(24627304196,17),(24627304196,20),(24627304196,23),(24682635450,1),(24682635450,12),(24682635450,14),(24682635450,15),(25216530126,1),(25216530126,3),(25216530126,9),(25216530126,14),(25260448472,1),(25260448472,17),(25260448472,21),(25260448472,23),(25307761643,1),(25307761643,13),(25887839538,1),(25887839538,7),(25887839538,15),(25887839538,17),(25887839538,21),(26080581914,1),(26080581914,2),(26080581914,12),(26819739532,1),(26819739532,3),(26819739532,14),(26819739532,22),(26886583603,1),(26886583603,16),(26886583603,19),(26886583603,23),(26986509073,1),(26986509073,14),(26986509073,15),(26986509073,22),(27797849544,1),(27797849544,2),(27797849544,19),(27797849544,22),(28122239102,1),(28122239102,22),(28122239102,23),(28254626405,1),(28254626405,2),(28254626405,12),(28584997806,1),(28584997806,18),(28649949096,1),(28649949096,3),(28649949096,10),(28649949096,15),(28649949096,18),(28649949096,19),(28649949096,21),(28760833530,1),(28760833530,11),(28760833530,18),(28760833530,23),(29035094840,1),(29035094840,3),(29035094840,12),(29035094840,16),(29035094840,17),(29749795059,1),(29749795059,2),(29749795059,3),(29749795059,10),(29749795059,12),(29749795059,15),(29749795059,22),(30045277079,1),(30304235229,1),(30304235229,7),(30304235229,15),(31445777665,1),(31445777665,3),(31445777665,9),(31445777665,14),(31445777665,22),(31445777665,23),(32420488490,1),(32420488490,17),(32420488490,19),(32544925019,1),(32544925019,3),(32544925019,17),(32561192474,1),(32561192474,7),(32561192474,14),(32561192474,22),(32571287893,1),(32571287893,17),(32571287893,19),(32571287893,23),(32711854256,1),(32711854256,17),(32769179632,1),(32769179632,3),(32769179632,14),(32769179632,15),(32769179632,17),(32808974167,1),(32808974167,2),(32808974167,15),(32808974167,16),(32808974167,19),(34037847701,1),(34037847701,12),(34037847701,16),(34313544402,1),(34313544402,12),(35096115607,1),(35096115607,3),(35096115607,16),(35096115607,20),(36255152618,1),(36255152618,9),(36255152618,14),(36255152618,15),(36255152618,18),(36318340203,1),(36318340203,23),(36419357250,1),(36419357250,2),(36419357250,3),(36419357250,19),(36419357250,23),(36508069241,1),(36508069241,19),(36508069241,23),(36536612264,1),(36536612264,9),(36536612264,10),(36536612264,23),(36644644198,1),(36644644198,3),(36644644198,13),(36644644198,14),(36644644198,17),(37523394620,1),(37523394620,13),(37523394620,15),(39034982467,1),(39034982467,9),(39034982467,16),(39034982467,19),(39475689591,1),(39475689591,13),(39901584574,1),(39901584574,10),(39901584574,15),(39901584574,16),(39901584574,17),(40579108325,1),(40579108325,7),(40579108325,10),(40579108325,23),(41046973622,1),(41046973622,2),(41046973622,7),(41046973622,15),(41046973622,23),(41236579585,1),(41236579585,13),(41236579585,14),(41330042301,1),(41330042301,17),(41330042301,19),(42744337307,1),(42744337307,10),(42744337307,17),(42835822631,1),(42835822631,12),(43280277604,1),(43280277604,10),(43496886099,1),(43496886099,4),(43496886099,16),(43496886099,19),(44014290603,1),(44014290603,18),(44815243085,1),(44815243085,12),(44815243085,19),(44989192206,1),(45260805356,1),(45260805356,12),(45260805356,15),(45316901410,1),(45316901410,13),(45316901410,14),(45316901410,16),(45316901410,17),(45646445990,1),(45646445990,2),(45646445990,7),(45646445990,15),(45719916067,1),(45719916067,2),(45719916067,15),(46343993002,1),(46343993002,3),(46343993002,12),(46343993002,17),(46343993002,19),(46343993002,21),(46343993002,22),(46538800262,1),(46538800262,7),(46538800262,16),(47324887228,1),(47324887228,15),(47324887228,18),(47324887228,23),(47973983619,1),(47973983619,7),(47973983619,12),(47973983619,15),(47973983619,19),(47973983619,23),(48831860755,1),(48831860755,10),(48831860755,14),(48831860755,16),(48831860755,19),(48996775452,1),(48996775452,14),(49679103781,1),(49679103781,13),(49679103781,15),(49679103781,17),(49679103781,22),(50545756421,1),(50545756421,2),(50545756421,14),(50545756421,23),(50688853552,1),(50688853552,13),(50688853552,14),(50688853552,17),(50779316312,1),(50779316312,2),(50779316312,7),(50779316312,10),(52396548832,1),(52396548832,7),(52396548832,17),(52428464027,1),(52428464027,2),(52428464027,3),(52532234440,1),(52532234440,3),(52532234440,10),(52532234440,15),(53059492549,1),(53059492549,15),(53059492549,20),(53323765702,1),(53323765702,14),(53618832478,1),(53618832478,16),(53618832478,22),(54021790004,1),(54021790004,13),(54021790004,15),(54021790004,19),(54021790004,22),(54021790004,23),(54363183470,1),(54363183470,2),(54363183470,3),(54363183470,13),(54363183470,15),(54363183470,18),(54363183470,22),(55184680756,1),(55184680756,13),(55184680756,14),(55660804136,1),(55660804136,2),(55660804136,7),(55660804136,15),(56014520759,1),(56014520759,13),(56014520759,17),(56795159540,1),(56795159540,17),(57406880197,1),(57406880197,2),(57406880197,17),(57406880197,23),(57628641709,1),(57628641709,3),(57628641709,7),(57628641709,23),(57764822167,1),(57764822167,10),(57764822167,16),(57764822167,17),(57764822167,19),(57905062830,1),(57905062830,14),(57905062830,22),(58155378705,1),(58155378705,2),(58526741098,1),(58526741098,7),(58526741098,16),(58526741098,23),(58945523464,1),(58945523464,9),(59017731281,1),(59017731281,3),(59017731281,7),(59017731281,13),(59017731281,23),(59215658815,1),(59215658815,16),(59215658815,23),(59448025530,1),(59448025530,13),(59991183280,1),(59991183280,12),(59991183280,13),(60746306822,1),(60746306822,14),(60941347885,1),(60941347885,2),(61066925801,1),(61066925801,3),(61066925801,10),(61066925801,15),(61066925801,17),(63389803211,1),(63389803211,10),(63389803211,12),(63389803211,14),(63389803211,16),(63389803211,17),(63870575743,1),(63870575743,7),(64471672819,1),(64471672819,9),(64471672819,16),(64835994396,1),(64835994396,3),(64835994396,21),(64835994396,23),(65109676186,1),(65109676186,12),(65109676186,15),(65109676186,22),(65282579812,1),(65282579812,3),(65282579812,15),(65282579812,17),(65282579812,19),(65703055903,1),(65703055903,7),(65703055903,17),(65703055903,18),(66321367290,1),(66321367290,3),(66321367290,12),(66321367290,23),(67226748940,1),(67226748940,4),(67226748940,14),(67612101351,1),(67612101351,21),(67623427105,1),(67623427105,3),(67623427105,13),(67623427105,14),(67623427105,19),(67866307318,1),(67866307318,7),(67866307318,16),(67866307318,19),(67866307318,21),(67866307318,23),(68682153556,1),(68682153556,12),(68682153556,14),(68682153556,15),(68774455540,1),(68774455540,2),(68774455540,7),(68774455540,12),(68774455540,14),(68774455540,18),(68953481589,1),(68953481589,13),(68953481589,14),(68953481589,17),(69152157946,1),(69152157946,17),(71097518051,1),(71097518051,14),(71203415885,1),(71989485022,1),(71989485022,14),(71989485022,18),(71989485022,23),(72076214690,1),(72076214690,7),(72076214690,16),(72536160149,1),(72536160149,7),(72536160149,10),(72536160149,21),(72788307535,1),(72788307535,14),(72788307535,17),(72788307535,18),(73361774330,1),(73361774330,12),(73361774330,18),(73709938848,1),(73709938848,14),(73709938848,15),(74368936612,1),(74368936612,2),(74368936612,3),(74368936612,9),(74651112692,1),(75031099046,1),(75031099046,2),(75031099046,3),(75031099046,7),(75031099046,12),(75031099046,13),(75031099046,23),(75067939702,1),(75067939702,10),(75067939702,17),(75067939702,21),(75067939702,22),(75067939702,23),(75091874860,1),(75091874860,12),(75091874860,24),(75161774231,1),(75161774231,18),(75161774231,19),(75161774231,21),(76592921374,1),(76592921374,2),(76592921374,18),(76592921374,20),(76797441900,1),(76797441900,2),(76797441900,4),(76797441900,19),(76797441900,23),(77389542993,1),(77389542993,16),(78020911014,1),(78020911014,3),(78020911014,14),(78020911014,22),(78041888623,1),(78041888623,12),(78041888623,15),(78041888623,22),(78457619403,1),(78457619403,13),(78457619403,19),(79427301406,1),(79427301406,14),(79427301406,15),(79427301406,23),(79518559872,1),(79518559872,19),(79518559872,21),(79518559872,23),(79615086002,1),(79615086002,14),(79615086002,17),(79615086002,19),(79615086002,23),(79744673630,1),(79744673630,9),(79744673630,13),(79744673630,15),(79744673630,21),(79744673630,23),(80503609200,1),(80503609200,16),(80503609200,23),(80607402105,1),(80607402105,10),(80607402105,16),(80607402105,17),(80607402105,23),(80777506645,1),(80777506645,2),(80777506645,12),(80777506645,14),(80777506645,17),(80777506645,19),(80777506645,23),(80836338286,1),(80836338286,5),(80836338286,10),(80836338286,17),(80836338286,21),(80836338286,23),(80984826505,1),(80984826505,22),(81021127949,1),(81021127949,7),(81021127949,22),(81775960986,1),(81775960986,14),(81775960986,15),(81781167400,1),(81781167400,13),(81781167400,14),(81942804008,1),(81942804008,14),(81942804008,21),(82275369724,1),(82275369724,4),(82275369724,12),(82496974302,1),(82496974302,3),(82496974302,16),(82496974302,21),(82899672258,1),(82899672258,15),(82899672258,16),(83011250391,1),(83011250391,9),(83011250391,19),(83011250391,23),(83481243650,1),(83481243650,3),(83481243650,10),(83514192146,1),(83514192146,9),(84154897497,1),(84154897497,9),(84154897497,23),(84780417023,1),(84780417023,2),(84780417023,15),(85154275403,1),(85154275403,2),(85154275403,9),(85154275403,13),(85154275403,17),(85154275403,21),(85274634745,1),(85274634745,2),(85274634745,14),(85274634745,19),(87147552113,1),(87147552113,3),(87147552113,4),(87147552113,9),(87147552113,23),(87363997101,1),(87363997101,3),(87363997101,22),(88136905096,1),(88136905096,9),(88136905096,14),(88136905096,16),(88136905096,17),(88342743934,1),(88342743934,2),(88342743934,9),(88342743934,23),(88376250493,1),(88376250493,2),(88376250493,13),(88416650926,1),(88416650926,10),(88727447766,1),(88727447766,2),(88727447766,9),(88727447766,12),(88727447766,15),(88832309815,1),(88832309815,9),(88832309815,19),(89618408272,1),(89618408272,3),(89618408272,9),(90389664588,1),(90389664588,15),(90389664588,16),(90389664588,18),(90511268750,1),(90511268750,7),(90511268750,12),(90511268750,19),(90511268750,23),(90659644606,1),(90659644606,14),(90659644606,18),(91036258696,1),(91036258696,2),(91036258696,10),(91036258696,22),(91872231209,1),(91872231209,2),(91872231209,12),(91872231209,17),(92159547247,1),(92159547247,10),(92187426718,1),(92187426718,12),(92187426718,13),(92187426718,24),(93351677898,1),(93351677898,3),(93351677898,5),(93351677898,17),(93351677898,18),(93351677898,22),(93551770468,1),(93551770468,14),(93551770468,15),(93776063220,1),(93776063220,2),(93776063220,16),(93776063220,18),(93776063220,19),(93776063220,22),(93776063220,23),(94140959932,1),(94140959932,9),(94140959932,10),(94140959932,14),(94392601900,1),(94392601900,10),(94392601900,14),(94392601900,15),(94666735640,1),(94666735640,2),(94666735640,4),(94666735640,10),(94666735640,12),(94666735640,13),(94666735640,21),(94949979809,1),(94949979809,10),(94949979809,23),(94966055679,1),(94966055679,10),(94966055679,15),(94966055679,18),(94966055679,23),(95377504348,1),(95377504348,3),(95377504348,12),(95377504348,17),(95377504348,18),(95471657802,1),(95471657802,2),(95471657802,3),(95471657802,10),(95471657802,15),(95471657802,22),(95746044202,1),(95746044202,3),(95746044202,16),(95803358347,1),(95803358347,3),(95803358347,15),(96188904650,1),(96188904650,7),(96188904650,11),(96188904650,15),(96188904650,17),(96188904650,23),(96303624812,1),(96303624812,10),(96667322030,1),(96667322030,3),(96667322030,17),(97105293748,1),(97105293748,5),(97105293748,13),(97105293748,16),(97439730950,1),(97439730950,22),(98310402015,1),(98310402015,10),(98310402015,12),(98310402015,16),(98379200250,1),(98379200250,4),(98379200250,14),(98379200250,15),(98379200250,16),(98379200250,17),(98941098025,1),(99052657408,1),(99052657408,13),(99052657408,24),(99398575272,1);
/*!40000 ALTER TABLE `cliente_plano_de_saude` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `compete`
--

LOCK TABLES `compete` WRITE;
/*!40000 ALTER TABLE `compete` DISABLE KEYS */;
INSERT INTO `compete` VALUES (1,16),(2,1),(3,8),(4,14),(5,13),(6,4),(7,44),(8,16),(9,43),(10,26),(11,43),(12,38),(13,40),(14,41),(15,45),(16,49),(17,38),(18,68),(19,72),(20,21),(21,78),(22,93),(23,98),(24,23),(25,11),(26,100),(27,105),(28,42),(29,43);
/*!40000 ALTER TABLE `compete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `depedentes`
--

LOCK TABLES `depedentes` WRITE;
/*!40000 ALTER TABLE `depedentes` DISABLE KEYS */;
INSERT INTO `depedentes` VALUES (513365613,20028186656),(513365613,67352811362),(1183479778,614819393),(1183479778,29761187799),(1183479778,36421593461),(1183479778,52618210026),(4321135761,12194146466),(4321135761,87306696696),(6162159914,28722712950),(6162159914,79493103757),(14855728276,36127855403),(14855728276,44629985379),(14855728276,94161410468),(14855728276,97729276240),(17566531867,65020230294),(17566531867,81402045441),(21206363541,3157057103),(21206363541,4008005439),(21206363541,49068400606),(21600779760,1052023711),(21600779760,30667965408),(21600779760,47997536302),(21600779760,63339885885),(22238791604,7654155930),(22238791604,27022149321),(23326288948,18696443284),(23326288948,41138103705),(23326288948,72030108138),(23326288948,93305625074),(25798695573,35517196756),(25798695573,66321367290),(25798695573,71176261940),(26115330408,9677324250),(26115330408,13092934229),(26115330408,17628339808),(26115330408,46915149023),(26115330408,89106885217),(26115330408,93010253109),(26383945211,67184076079),(26383945211,92869747365),(29663284609,5958501704),(29663284609,65710411469),(29663284609,67668737286),(29663284609,97918610806),(30810234165,23878163401),(30810234165,53049729619),(30810234165,68201147022),(30880288124,46178479956),(30880288124,55667205440),(30880288124,74950603604),(32083741005,44636063813),(32083741005,88255075933),(32083741005,94091317820),(33920132424,59215658815),(33930614375,19673188084),(33930614375,28686440827),(33930614375,36765744002),(33930614375,65319988656),(33930614375,88929315801),(34709887144,27607982671),(34709887144,52774227658),(34709887144,73652414462),(36431704169,35590808278),(36431704169,67028196500),(37793323882,299528324),(37793323882,1990703267),(37793323882,5764568889),(37793323882,18736585084),(37793323882,59967183241),(37793323882,62061359930),(38939575024,23127693796),(38939575024,48723757345),(38978532993,19790157754),(38978532993,20878625240),(38978532993,44953969006),(38978532993,47412130307),(38978532993,97997286497),(39451309136,1858082200),(39451309136,35773274302),(39451309136,65811217200),(49988922663,18521105460),(49988922663,76512802101),(51829899546,7290779428),(51829899546,23348597021),(57934732899,59005996986),(57934732899,62816251373),(57934732899,86401381094),(58538792270,39858212674),(58538792270,70047448920),(58538792270,89233423948),(60675899745,59462916101),(60675899745,61825308985),(60675899745,83627619978),(60722045891,525593004),(60722045891,64785814039),(60722045891,73769338405),(61084050900,10844472239),(61084050900,16791409061),(61084050900,35511887005),(61084050900,77157056755),(61084050900,89872021945),(62992881597,15289739254),(62992881597,45291060476),(62992881597,65338204789),(62992881597,91654850330),(63333828090,37469415041),(63333828090,44075599345),(63333828090,82795793547),(63333828090,92459222866),(65178645804,25954886270),(65178645804,91450794203),(74610857278,7298461133),(74610857278,13553123028),(76407045290,34440677550),(76407045290,49967250100),(76407045290,94689234957),(76522189267,69527869617),(76522189267,82194747001),(76522189267,90759492867),(76522189267,96980910507),(77479340176,14911184078),(77479340176,42161730711),(77479340176,82167538618),(77479340176,99567988196),(79364178424,12776276575),(79364178424,38354349853),(79844029066,17228054989),(79844029066,24299771761),(79844029066,35231817392),(79844029066,64170564650),(81377156575,33849108937),(81377156575,60759108242),(84103453230,71587816822),(84103453230,81798327910),(85132371329,35815134392),(85132371329,40970794681),(85132371329,62359486110),(89612761744,4283238805),(89612761744,49659871520),(89612761744,68690513132),(92289773450,35373805696),(92289773450,93483226567),(92289773450,97305025950),(94638205909,64525583827),(94638205909,66916251026),(95499352801,48549805246),(95834117015,50179167766),(97189271902,41330042301),(97189271902,44989192206),(97189271902,56014520759),(97189271902,88342743934);
/*!40000 ALTER TABLE `depedentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `doenca`
--

LOCK TABLES `doenca` WRITE;
/*!40000 ALTER TABLE `doenca` DISABLE KEYS */;
INSERT INTO `doenca` VALUES (1,'Asma'),(2,'Bronquite'),(3,'Enfisema pulmonar'),(4,'Hipertensão'),(5,'Insuficiência cardíaca'),(6,'Diabetes'),(7,'Depressão'),(8,'Alcolismo'),(9,'Parkinson'),(10,'Alzheimer');
/*!40000 ALTER TABLE `doenca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `doencas_pre_existentes`
--

LOCK TABLES `doencas_pre_existentes` WRITE;
/*!40000 ALTER TABLE `doencas_pre_existentes` DISABLE KEYS */;
INSERT INTO `doencas_pre_existentes` VALUES (2,329284240),(3,329284240),(8,329284240),(1,364793066),(3,364793066),(8,364793066),(0,737990252),(3,737990252),(6,737990252),(8,737990252),(3,1250648610),(5,1250648610),(8,1250648610),(9,1250648610),(1,1589288734),(3,1589288734),(8,1589288734),(0,1714718220),(8,1714718220),(0,3198488176),(1,3198488176),(2,3198488176),(6,3198488176),(8,3198488176),(4,3430711509),(0,3593172607),(1,3593172607),(2,3593172607),(3,3593172607),(6,3593172607),(0,4342416794),(3,4342416794),(4,4342416794),(6,4342416794),(8,4342416794),(9,4342416794),(1,4527619306),(2,4527619306),(4,4527619306),(6,4527619306),(3,5337369946),(8,5337369946),(2,5354711061),(6,5354711061),(8,5354711061),(3,5566953727),(6,5566953727),(8,5566953727),(9,5566953727),(1,6298844805),(2,6298844805),(3,6298844805),(8,6298844805),(0,6584679560),(2,6584679560),(3,6584679560),(6,6584679560),(9,6584679560),(1,6696400699),(8,6696400699),(9,6696400699),(0,7791511517),(1,7791511517),(3,7791511517),(6,7791511517),(8,7791511517),(9,7791511517),(2,7861925005),(3,7861925005),(8,7861925005),(2,7937549173),(3,7937549173),(6,7937549173),(8,7937549173),(2,8416305692),(6,8416305692),(7,8416305692),(8,8416305692),(0,8476452748),(1,8476452748),(3,8476452748),(6,8476452748),(8,8476452748),(1,8598182419),(3,8598182419),(3,8634570703),(6,8634570703),(8,8634570703),(0,9056572768),(2,9056572768),(3,9056572768),(6,9056572768),(8,9056572768),(9,9056572768),(3,9092362670),(6,9092362670),(8,9092362670),(0,10451575709),(3,10451575709),(5,10451575709),(8,10451575709),(1,10727181033),(2,10727181033),(4,10727181033),(6,10727181033),(8,10727181033),(9,10727181033),(0,10906781345),(1,10906781345),(3,10906781345),(5,10906781345),(6,10906781345),(8,10906781345),(0,11110462557),(3,11110462557),(5,11110462557),(6,11110462557),(9,11110462557),(3,11344611435),(5,11344611435),(8,11344611435),(2,11425163009),(6,11425163009),(8,11425163009),(3,11481243810),(4,11481243810),(8,11481243810),(9,11481243810),(2,12184002267),(3,12184002267),(5,12184002267),(8,12184002267),(0,13394207249),(3,13394207249),(4,13394207249),(6,13394207249),(8,13394207249),(2,13671282002),(3,13671282002),(8,13671282002),(8,13856670017),(0,13920353846),(1,13920353846),(3,13920353846),(5,13920353846),(8,13920353846),(3,14954213681),(8,14954213681),(2,15465538600),(3,15465538600),(6,15465538600),(7,15465538600),(8,15465538600),(9,15465538600),(1,15466993255),(3,15466993255),(5,15466993255),(8,15466993255),(0,17148124484),(1,17148124484),(2,17148124484),(7,17148124484),(8,17148124484),(9,17148124484),(1,17578761463),(2,17578761463),(3,17578761463),(4,17578761463),(5,17578761463),(6,17578761463),(7,17578761463),(8,17578761463),(0,17645947462),(3,17645947462),(6,17645947462),(8,17645947462),(9,17645947462),(0,17708584230),(3,17708584230),(4,17708584230),(8,17708584230),(1,18181950895),(3,18181950895),(6,18181950895),(8,18181950895),(0,18822853016),(1,18822853016),(3,18822853016),(6,18822853016),(0,19423082130),(1,19423082130),(2,19423082130),(3,19423082130),(8,19423082130),(0,19558005967),(1,19558005967),(2,19558005967),(5,19558005967),(7,19558005967),(8,19558005967),(1,19867987047),(4,19867987047),(6,19867987047),(8,19867987047),(9,19867987047),(0,20753754029),(1,20753754029),(2,20753754029),(3,20753754029),(6,20753754029),(8,20753754029),(3,20873560841),(4,20873560841),(8,20873560841),(9,20873560841),(0,20909274290),(1,20909274290),(3,20909274290),(6,20909274290),(8,20909274290),(3,20986784605),(8,20986784605),(9,20986784605),(3,21313568465),(8,21313568465),(9,21313568465),(0,22234407460),(3,22234407460),(6,22234407460),(9,22234407460),(0,22572592207),(2,22572592207),(3,22572592207),(4,22572592207),(6,22572592207),(8,22572592207),(9,22572592207),(3,22699221740),(6,22699221740),(8,22699221740),(2,22908536749),(3,22908536749),(6,22908536749),(8,22908536749),(9,22908536749),(1,23427394786),(2,23427394786),(3,23427394786),(6,23427394786),(8,23427394786),(8,24138815902),(9,24138815902),(2,24627304196),(3,24627304196),(6,24627304196),(8,24627304196),(9,24627304196),(1,24682635450),(2,24682635450),(8,24682635450),(0,25216530126),(2,25216530126),(3,25216530126),(6,25216530126),(8,25216530126),(2,25260448472),(6,25260448472),(8,25260448472),(2,25307761643),(3,25307761643),(9,25307761643),(0,25887839538),(1,25887839538),(2,25887839538),(6,25887839538),(8,25887839538),(1,26080581914),(4,26080581914),(8,26080581914),(1,26819739532),(3,26819739532),(5,26819739532),(6,26819739532),(8,26819739532),(2,26886583603),(3,26886583603),(6,26886583603),(8,26886583603),(0,26986509073),(1,26986509073),(4,26986509073),(6,26986509073),(0,27797849544),(2,27797849544),(3,27797849544),(5,27797849544),(6,27797849544),(8,27797849544),(3,28122239102),(9,28122239102),(3,28254626405),(6,28254626405),(8,28254626405),(2,28584997806),(3,28584997806),(6,28584997806),(8,28584997806),(0,28649949096),(3,28649949096),(8,28649949096),(2,28760833530),(3,28760833530),(6,28760833530),(8,28760833530),(9,28760833530),(1,29035094840),(8,29035094840),(0,29749795059),(2,29749795059),(3,29749795059),(5,29749795059),(9,29749795059),(0,30045277079),(3,30045277079),(6,30045277079),(8,30045277079),(9,30045277079),(2,30304235229),(3,30304235229),(5,30304235229),(8,30304235229),(3,31445777665),(5,31445777665),(6,31445777665),(8,31445777665),(9,31445777665),(2,32420488490),(3,32420488490),(6,32420488490),(8,32420488490),(9,32420488490),(0,32544925019),(3,32544925019),(6,32544925019),(8,32544925019),(0,32561192474),(2,32561192474),(3,32561192474),(7,32561192474),(8,32561192474),(9,32561192474),(1,32571287893),(2,32571287893),(4,32571287893),(1,32711854256),(3,32711854256),(6,32711854256),(8,32711854256),(0,32769179632),(1,32769179632),(3,32769179632),(6,32769179632),(8,32769179632),(3,32808974167),(4,32808974167),(6,32808974167),(8,32808974167),(0,34037847701),(3,34037847701),(8,34037847701),(0,34313544402),(1,34313544402),(2,34313544402),(3,34313544402),(0,35096115607),(1,35096115607),(2,35096115607),(3,35096115607),(8,35096115607),(1,36255152618),(3,36255152618),(8,36255152618),(9,36255152618),(3,36318340203),(7,36318340203),(8,36318340203),(0,36419357250),(1,36419357250),(2,36419357250),(3,36419357250),(4,36419357250),(5,36419357250),(0,36508069241),(3,36508069241),(8,36508069241),(3,36536612264),(6,36536612264),(8,36536612264),(3,36644644198),(4,36644644198),(6,36644644198),(8,36644644198),(1,37523394620),(2,37523394620),(8,37523394620),(1,39034982467),(2,39034982467),(3,39034982467),(8,39034982467),(9,39034982467),(0,39475689591),(1,39475689591),(2,39475689591),(6,39475689591),(8,39475689591),(2,39901584574),(3,39901584574),(5,39901584574),(6,39901584574),(8,39901584574),(9,39901584574),(3,40579108325),(4,40579108325),(8,40579108325),(1,41046973622),(2,41046973622),(5,41046973622),(6,41046973622),(8,41046973622),(0,41236579585),(3,41236579585),(6,41236579585),(8,41236579585),(2,41330042301),(3,41330042301),(3,42744337307),(7,42744337307),(8,42744337307),(9,42744337307),(2,42835822631),(3,42835822631),(4,42835822631),(6,42835822631),(7,42835822631),(8,42835822631),(9,42835822631),(2,43280277604),(3,43280277604),(8,43280277604),(9,43280277604),(0,43496886099),(3,43496886099),(6,43496886099),(8,43496886099),(9,43496886099),(2,44014290603),(3,44014290603),(4,44014290603),(8,44014290603),(9,44014290603),(1,44815243085),(3,44815243085),(6,44815243085),(3,44989192206),(6,44989192206),(8,44989192206),(1,45260805356),(3,45260805356),(6,45260805356),(7,45260805356),(8,45260805356),(1,45316901410),(2,45316901410),(3,45316901410),(6,45316901410),(8,45316901410),(9,45316901410),(1,45646445990),(2,45646445990),(3,45646445990),(8,45646445990),(6,45719916067),(7,45719916067),(8,45719916067),(0,46343993002),(2,46343993002),(3,46343993002),(4,46343993002),(6,46343993002),(8,46343993002),(9,46343993002),(2,46538800262),(3,46538800262),(8,46538800262),(0,47324887228),(1,47324887228),(4,47324887228),(6,47324887228),(8,47324887228),(1,47973983619),(2,47973983619),(3,47973983619),(8,47973983619),(3,48831860755),(4,48831860755),(8,48831860755),(2,48996775452),(3,48996775452),(5,48996775452),(6,48996775452),(8,48996775452),(0,49679103781),(2,49679103781),(3,49679103781),(6,49679103781),(8,49679103781),(0,50545756421),(1,50545756421),(2,50545756421),(8,50545756421),(9,50545756421),(8,50688853552),(9,50688853552),(1,50779316312),(3,50779316312),(4,50779316312),(6,50779316312),(8,50779316312),(0,52396548832),(3,52396548832),(6,52396548832),(7,52396548832),(2,52428464027),(6,52428464027),(8,52428464027),(0,52532234440),(2,52532234440),(3,52532234440),(4,52532234440),(8,52532234440),(0,53059492549),(2,53059492549),(3,53059492549),(4,53059492549),(9,53059492549),(3,53323765702),(8,53323765702),(9,53323765702),(2,53618832478),(3,53618832478),(4,53618832478),(6,53618832478),(8,53618832478),(0,54021790004),(1,54021790004),(3,54021790004),(8,54021790004),(1,54363183470),(2,54363183470),(3,54363183470),(6,54363183470),(8,54363183470),(9,54363183470),(2,55184680756),(3,55184680756),(6,55184680756),(7,55184680756),(9,55184680756),(3,55660804136),(6,55660804136),(8,55660804136),(1,56014520759),(3,56014520759),(8,56014520759),(3,56795159540),(4,56795159540),(6,56795159540),(8,56795159540),(9,56795159540),(2,57406880197),(3,57406880197),(5,57406880197),(6,57406880197),(7,57406880197),(8,57406880197),(9,57406880197),(3,57628641709),(4,57628641709),(6,57628641709),(8,57628641709),(2,57764822167),(3,57764822167),(6,57764822167),(7,57764822167),(8,57764822167),(0,57905062830),(2,57905062830),(3,57905062830),(6,57905062830),(8,57905062830),(3,58155378705),(6,58155378705),(3,58526741098),(4,58526741098),(6,58526741098),(8,58526741098),(9,58526741098),(1,58945523464),(2,58945523464),(3,58945523464),(7,58945523464),(9,58945523464),(0,59017731281),(2,59017731281),(3,59017731281),(7,59017731281),(8,59017731281),(0,59215658815),(2,59215658815),(3,59215658815),(8,59215658815),(1,59448025530),(2,59448025530),(3,59448025530),(6,59448025530),(8,59448025530),(9,59448025530),(2,59991183280),(8,59991183280),(0,60746306822),(3,60746306822),(6,60746306822),(9,60746306822),(3,60941347885),(6,60941347885),(8,60941347885),(1,61066925801),(2,61066925801),(3,61066925801),(6,61066925801),(8,61066925801),(0,63389803211),(2,63389803211),(3,63389803211),(4,63389803211),(8,63389803211),(0,63870575743),(1,63870575743),(6,63870575743),(9,63870575743),(1,64471672819),(2,64471672819),(3,64471672819),(6,64471672819),(7,64471672819),(8,64471672819),(3,64835994396),(5,64835994396),(6,64835994396),(8,64835994396),(3,65109676186),(1,65282579812),(3,65282579812),(6,65282579812),(8,65282579812),(0,65703055903),(2,65703055903),(3,65703055903),(6,65703055903),(8,65703055903),(0,66321367290),(2,66321367290),(3,66321367290),(4,66321367290),(8,66321367290),(1,67226748940),(3,67226748940),(6,67226748940),(8,67226748940),(2,67612101351),(3,67612101351),(8,67612101351),(2,67623427105),(4,67623427105),(6,67623427105),(8,67623427105),(9,67623427105),(0,67866307318),(2,67866307318),(3,67866307318),(6,67866307318),(8,67866307318),(1,68682153556),(3,68682153556),(6,68682153556),(8,68682153556),(4,68774455540),(5,68774455540),(6,68774455540),(8,68774455540),(1,68953481589),(3,68953481589),(8,68953481589),(9,68953481589),(3,69152157946),(5,69152157946),(6,69152157946),(9,69152157946),(2,71097518051),(3,71097518051),(6,71097518051),(8,71097518051),(9,71097518051),(0,71203415885),(2,71203415885),(6,71203415885),(1,71989485022),(2,71989485022),(3,71989485022),(5,71989485022),(8,71989485022),(0,72076214690),(1,72076214690),(3,72076214690),(8,72076214690),(0,72536160149),(2,72536160149),(3,72536160149),(6,72536160149),(0,72788307535),(6,72788307535),(0,73361774330),(1,73361774330),(2,73361774330),(3,73361774330),(7,73361774330),(8,73361774330),(2,73709938848),(3,73709938848),(4,73709938848),(5,73709938848),(6,73709938848),(8,73709938848),(0,74368936612),(2,74368936612),(3,74368936612),(4,74368936612),(6,74368936612),(8,74368936612),(0,74651112692),(3,74651112692),(6,74651112692),(7,74651112692),(8,74651112692),(0,75031099046),(2,75031099046),(8,75031099046),(3,75067939702),(6,75067939702),(8,75067939702),(9,75067939702),(0,75091874860),(2,75091874860),(3,75091874860),(6,75091874860),(7,75091874860),(8,75091874860),(9,75091874860),(3,75161774231),(4,75161774231),(8,75161774231),(9,75161774231),(0,76592921374),(3,76592921374),(6,76592921374),(8,76592921374),(9,76592921374),(3,76797441900),(8,76797441900),(9,76797441900),(0,77389542993),(2,77389542993),(5,77389542993),(6,77389542993),(8,77389542993),(9,77389542993),(2,78020911014),(3,78020911014),(6,78020911014),(8,78020911014),(9,78020911014),(0,78041888623),(1,78041888623),(2,78041888623),(3,78041888623),(6,78041888623),(8,78041888623),(9,78041888623),(0,78457619403),(2,78457619403),(3,78457619403),(8,78457619403),(0,79427301406),(3,79427301406),(5,79427301406),(6,79427301406),(8,79427301406),(2,79518559872),(4,79518559872),(6,79518559872),(8,79518559872),(0,79615086002),(3,79615086002),(4,79615086002),(6,79615086002),(8,79615086002),(9,79615086002),(1,79744673630),(2,79744673630),(3,79744673630),(5,79744673630),(8,79744673630),(1,80503609200),(3,80503609200),(6,80503609200),(8,80503609200),(2,80607402105),(8,80607402105),(1,80777506645),(3,80777506645),(4,80777506645),(6,80777506645),(7,80777506645),(8,80777506645),(0,80836338286),(1,80836338286),(2,80836338286),(3,80836338286),(8,80836338286),(9,80836338286),(3,80984826505),(6,80984826505),(8,80984826505),(9,80984826505),(2,81021127949),(6,81021127949),(8,81021127949),(3,81775960986),(4,81775960986),(8,81775960986),(9,81775960986),(1,81781167400),(2,81781167400),(8,81781167400),(9,81781167400),(3,81942804008),(8,81942804008),(1,82275369724),(2,82275369724),(8,82275369724),(1,82496974302),(2,82496974302),(3,82496974302),(8,82496974302),(0,82899672258),(2,82899672258),(3,82899672258),(8,82899672258),(9,82899672258),(2,83011250391),(3,83011250391),(8,83011250391),(8,83481243650),(9,83481243650),(4,83514192146),(8,83514192146),(0,84154897497),(3,84154897497),(5,84154897497),(6,84154897497),(8,84154897497),(2,84780417023),(3,84780417023),(4,84780417023),(6,84780417023),(8,84780417023),(9,84780417023),(1,85154275403),(3,85154275403),(8,85154275403),(0,85274634745),(2,85274634745),(3,85274634745),(4,85274634745),(6,85274634745),(8,85274634745),(0,87147552113),(2,87147552113),(3,87147552113),(6,87147552113),(8,87147552113),(2,87363997101),(3,87363997101),(4,87363997101),(8,87363997101),(1,88136905096),(3,88136905096),(7,88136905096),(9,88136905096),(0,88342743934),(2,88342743934),(3,88342743934),(6,88342743934),(8,88342743934),(0,88376250493),(2,88376250493),(3,88376250493),(6,88376250493),(7,88376250493),(8,88376250493),(9,88376250493),(0,88416650926),(5,88416650926),(0,88727447766),(1,88727447766),(2,88727447766),(3,88727447766),(6,88727447766),(0,88832309815),(2,88832309815),(3,88832309815),(7,88832309815),(8,88832309815),(4,89618408272),(5,89618408272),(6,89618408272),(8,89618408272),(0,90389664588),(1,90389664588),(2,90389664588),(3,90389664588),(4,90389664588),(6,90389664588),(8,90389664588),(5,90511268750),(6,90511268750),(8,90511268750),(9,90511268750),(1,90659644606),(2,90659644606),(6,90659644606),(9,90659644606),(2,91036258696),(7,91036258696),(8,91036258696),(9,91036258696),(3,91872231209),(8,91872231209),(3,92159547247),(4,92159547247),(6,92159547247),(6,92187426718),(7,92187426718),(8,92187426718),(3,93351677898),(8,93351677898),(9,93351677898),(2,93551770468),(6,93551770468),(8,93551770468),(9,93551770468),(1,93776063220),(2,93776063220),(3,93776063220),(8,93776063220),(8,94140959932),(2,94392601900),(3,94392601900),(9,94392601900),(0,94666735640),(3,94666735640),(0,94949979809),(3,94949979809),(6,94949979809),(8,94949979809),(1,94966055679),(2,94966055679),(3,94966055679),(8,94966055679),(9,94966055679),(2,95377504348),(8,95377504348),(0,95471657802),(1,95471657802),(2,95471657802),(3,95471657802),(8,95471657802),(2,95746044202),(3,95746044202),(6,95746044202),(1,95803358347),(6,95803358347),(7,95803358347),(8,95803358347),(9,95803358347),(1,96188904650),(2,96188904650),(3,96188904650),(4,96188904650),(6,96188904650),(8,96188904650),(3,96303624812),(6,96303624812),(7,96303624812),(8,96303624812),(1,96667322030),(2,96667322030),(3,96667322030),(6,96667322030),(8,96667322030),(9,96667322030),(1,97105293748),(8,97105293748),(2,97439730950),(6,97439730950),(8,97439730950),(9,97439730950),(8,98310402015),(9,98310402015),(0,98379200250),(2,98379200250),(3,98379200250),(6,98379200250),(8,98379200250),(6,98941098025),(8,98941098025),(0,99052657408),(2,99052657408),(3,99052657408),(6,99052657408),(8,99052657408),(0,99398575272),(3,99398575272),(8,99398575272),(9,99398575272);
/*!40000 ALTER TABLE `doencas_pre_existentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `especialidade`
--

LOCK TABLES `especialidade` WRITE;
/*!40000 ALTER TABLE `especialidade` DISABLE KEYS */;
INSERT INTO `especialidade` VALUES ('Acupuntura',1),('Alergia e Imunologia',2),('Anestesiologia',3),('Angiologia',4),('Cancerologia',5),('Cardiologia',6),('Cirurgia Cardiovascular',7),('Cirurgia da Mão',8),('Cirurgia de Cabeça e Pescoço',9),('Cirurgia do Aparelho Digestivo',10),('Cirurgia Geral',11),('Cirurgia Pediátrica',12),('Cirurgia Plástica',13),('Cirurgia Torácica',14),('Cirurgia Vascular',15),('Clínica Médica',16),('Coloproctologia',17),('Dermatologia',18),('Endocrinologia e Metabologia',19),('Endoscopia',20),('Gastroenterologia',21),('Genética Médica',22),('Geriatria',23),('Ginecologia e Obstetrícia',24),('Hematologia e Hemoterapia',25),('Homeopatia',26),('Infectologia',27),('Mastologia',28),('Medicina de Família e Comunidade',29),('Medicina do Trabalho',30),('Medicina de Tráfego',31),('Medicina Esportiva',32),('Medicina Física e Reabilitação',33),('Medicina Intensiva',34),('Medicina Legal e Perícia Médica',35),('Medicina Nuclear',36),('Medicina Preventiva e Social',37),('Nefrologia',38),('Neurocirurgia',39),('Neurologia',40),('Nutrologia',41),('Oftalmologia',42),('Oncologia',43),('Ortopedia e Traumatologia',44),('Otorrinolaringologia',45),('Patologia',46),('Pediatria',47),('Pneumologia',48),('Psiquiatria',49),('Radiologia e Diagnóstico por Imagem',50),('Radioterapia',51),('Reumatologia',52),('Urologia',53),('Administração em Saúde',54),('Alergia e Imunologia Pediátrica',55),('Angiorradiologia e Cirurgia Endovascular',56),('Atendimento ao queimado',57),('Cardiologia Pediátrica',58),('Cirurgia Crânio-Maxilo-Facial',59),('Cirurgia do Trauma',60),('Cirurgia Videolaparoscópica',61),('Citopatologia',62),('Densitometria Óssea',63),('Dor',64),('Ecocardiografia',65),('Ecografia Vascular com Doppler',66),('Eletrofisiologia Clínica Invasiva',67),('Endocrinologia Pediátrica',68),('Endoscopia Digestiva',69),('Endoscopia Ginecológica',70),('Endoscopia Respiratória',71),('Ergometria',72),('Foniatria',73),('Gastroenterologia Pediátrica',74),('Hansenologia',75),('Hematologia e Hemoterapia Pediátrica',76),('Hemodinâmica e Cardiologia Intervencionista',77),('Hepatologia',78),('Infectologia Hospitalar',79),('Infectologia Pediátrica',80),('Mamografia',81),('Medicina de Urgência',82),('Medicina do Adolescente',83),('Medicina do Sono',84),('Medicina Fetal',85),('Medicina Intensiva Pediátrica',86),('Medicina Paliativa',87),('Medicina Tropical',88),('Nefrologia Pediátrica',89),('Neonatologia',90),('Neurofisiologia Clínica',91),('Neurologia Pediátrica',92),('Neurorradiologia',93),('Nutrição Parenteral e Enteral',94),('Nutrição Parenteral e Enteral Pediátrica',95),('Nutrologia Pediátrica',96),('Pneumologia Pediátrica',97),('Psicogeriatria',98),('Psicoterapia',99),('Psiquiatria da Infância e Adolescência',100),('Psiquiatria Forense',101),('Radiologia Intervencionista e Angiorradiologia',102),('Reumatologia Pediátrica',103),('Sexologia',104),('Transplante de Medula Óssea',105),('Ultrassonografia em Ginecologia e Obstetrícia',106);
/*!40000 ALTER TABLE `especialidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `funcao`
--

LOCK TABLES `funcao` WRITE;
/*!40000 ALTER TABLE `funcao` DISABLE KEYS */;
INSERT INTO `funcao` VALUES ('Medico',1),('Técnico de enfermagem',2),('Enfermeiro',3),('Recepcionista geral',4),('Auxiliar de escritório',5),('Recepcionista de consultório',6),('Auxiliar de enfermagem',7),('Assistente administrativo',8);
/*!40000 ALTER TABLE `funcao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES ('2006-07-11',208590,26115330408,1),('2011-07-11',210858,38939575024,1),('2008-10-12',225458,92289773450,1),('2011-04-11',220201,84103453230,1),('2008-06-04',216815,79364178424,1),('2011-03-07',225558,60675899745,1),('2007-08-07',177828,21206363541,1),('2006-05-05',160810,26383945211,2),('2016-02-09',168351,76407045290,2),('2016-10-22',160745,76522189267,2),('2009-04-13',186457,23326288948,2),('2010-11-28',192436,30880288124,2),('2009-07-28',147250,29663284609,2),('2012-08-03',171925,37793323882,2),('2014-07-25',376023,1183479778,3),('2010-02-15',320004,61084050900,3),('2010-11-13',373471,17566531867,3),('2014-05-16',287383,32083741005,3),('2000-03-11',336482,79844029066,3),('2011-10-09',403111,58538792270,3),('2007-04-10',134053,60722045891,4),('2012-11-14',130868,38978532993,4),('2005-01-01',114749,36431704169,4),('2007-09-15',116960,62992881597,4),('2016-03-11',133369,65178645804,4),('1996-05-15',135566,39451309136,4),('2003-07-04',142236,85132371329,5),('2010-01-05',158464,30810234165,5),('2017-02-17',167599,94638205909,5),('2010-10-07',141846,34709887144,5),('2016-04-12',150057,6162159914,5),('2014-06-11',167258,57934732899,5),('2001-05-16',122074,81377156575,6),('2019-11-27',130637,22238791604,6),('2013-05-14',140189,95499352801,6),('2011-12-24',136621,49988922663,6),('2015-10-04',118155,95834117015,6),('2015-03-04',149205,74610857278,6),('2009-11-15',177363,89612761744,7),('2003-01-01',172672,63333828090,7),('2007-11-06',176138,21600779760,7),('2013-04-09',183930,14855728276,7),('2016-06-18',178328,33930614375,7),('2006-02-03',169357,77479340176,7),('2018-04-23',161640,51829899546,8),('2004-11-24',170279,513365613,8),('2006-12-06',159296,4321135761,8),('2007-10-13',149644,25798695573,8),('2019-02-26',147882,33920132424,8),('2003-07-09',140349,97189271902,8);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
INSERT INTO `medico` VALUES (143805,'Universidade Federal De Minas Gerais (UFMG)',26),(62082,'Faculdade De Medicina De São José Do Rio Preto (FAMERP)',24),(193394,'Universidade Federal Da Paraíba (UFPB)',24),(151434,'Universidade Estadual De Maringá (UEM)',12),(77742,'Universidade Federal De São Carlos (UFSCAR)',39),(116991,'Universidade Estadual Paulista Júlio De Mesquita Filho (UNESP)',39),(101004,'Universidade Federal De Minas Gerais (UFMG)',26),(199303,'Universidade Federal Da Paraíba (UFPB)',11),(171249,'Universidade Estadual De Maringá (UEM)',10),(162300,'Universidade Federal Do Ceará (UFC)',40),(36867,'Universidade Federal De Viçosa (UFV)',11),(196879,'Universidade Federal De Mato Grosso (UFMT)',3),(110788,'Universidade Federal Do Ceará (UFC)',32),(89447,'Pontifícia Universidade Católica Do Rio Grande Do Sul (PUCRS)',30),(45166,'Universidade Federal De Viçosa (UFV)',11),(151424,'Universidade Estadual De Maringá (UEM)',31),(64372,'Universidade Federal De Mato Grosso (UFMT)',3),(48475,'Universidade Federal De Mato Grosso (UFMT)',36),(56869,'Faculdade De Medicina De São José Do Rio Preto (FAMERP)',41),(51202,'Universidade Federal De Mato Grosso (UFMT)',2),(197201,'Universidade De Pernambuco (UPE)',2),(94302,'Universidade Federal Do Rio Grande Do Norte (UFRN)',43),(116781,'Universidade Federal De Minas Gerais (UFMG)',33),(225777,'Universidade Federal De Viçosa (UFV)',34),(43074,'Universidade Federal Do Rio Grande Do Norte (UFRN)',8),(203912,'Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)',12),(27009,'Faculdade De Medicina De São José Do Rio Preto (FAMERP)',37),(151983,'Universidade Federal Do Ceará (UFC)',17),(183300,'Pontifícia Universidade Católica Do Rio Grande Do Sul (PUCRS)',17),(57203,'Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)',4),(88244,'Universidade Estadual De Maringá (UEM)',12),(91314,'Universidade Federal Do Ceará (UFC)',3),(158200,'Universidade Federal De Minas Gerais (UFMG)',5),(182403,'Universidade Federal Do Ceará (UFC)',1),(25304,'Universidade Estadual Paulista Júlio De Mesquita Filho (UNESP)',6),(162428,'Universidade Federal Do Ceará (UFC)',4),(58390,'Universidade Federal De Minas Gerais (UFMG)',29),(136288,'Universidade Estadual De Maringá (UEM)',17),(113545,'Universidade Estadual De Maringá (UEM)',13),(119032,'Universidade De Pernambuco (UPE)',17),(103854,'Universidade Federal Da Paraíba (UFPB)',17),(180980,'Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)',21),(10286,'Universidade Federal De Viçosa (UFV)',19),(218145,'Universidade Federal De Mato Grosso (UFMT)',34),(45051,'Universidade Federal De Minas Gerais (UFMG)',43),(146440,'Universidade Federal Do Rio Grande Do Norte (UFRN)',32),(56715,'Universidade Estadual Paulista Júlio De Mesquita Filho (UNESP)',23),(165294,'Universidade Federal De São Carlos (UFSCAR)',17),(145728,'Universidade Federal De Minas Gerais (UFMG)',24),(54659,'Universidade Federal Do Ceará (UFC)',39),(155533,'Universidade Federal De São Carlos (UFSCAR)',19),(113404,'Universidade Federal De Viçosa (UFV)',29),(170745,'Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)',18),(70454,'Faculdade De Medicina De São José Do Rio Preto (FAMERP)',1),(122365,'Universidade Federal Do Ceará (UFC)',30),(79156,'Universidade Estadual Paulista Júlio De Mesquita Filho (UNESP)',19),(144810,'Faculdade De Medicina De São José Do Rio Preto (FAMERP)',29),(162034,'Universidade Federal De Minas Gerais (UFMG)',43),(44409,'Universidade Federal Da Paraíba (UFPB)',37),(153362,'Universidade Federal Dos Vales Do Jequitinhonha E Mucuri (UFVJM)',4);
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger colocar_medico_no_plano_nenhum
	after insert on medico
	for each row
	begin
		insert into medico_plano_de_saude 
        (crm, plano_de_saude_id) values
        (new.crm, 1);
	end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger colocar_tipo_de_atendimento_no_plano_nenhum
	after insert on medico
	for each row
	begin
		insert into plano_de_saude_tipo_de_atendimento 
        (plano_de_saude_id, tipo_de_atendimento_id, desconto) values
        (1, new.crm, 0);
	end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `medico_especialidade`
--

LOCK TABLES `medico_especialidade` WRITE;
/*!40000 ALTER TABLE `medico_especialidade` DISABLE KEYS */;
INSERT INTO `medico_especialidade` VALUES (10286,3),(10286,13),(10286,16),(10286,40),(10286,43),(10286,45),(10286,58),(10286,80),(10286,84),(10286,101),(25304,14),(25304,15),(25304,16),(25304,17),(25304,29),(25304,38),(25304,51),(25304,61),(25304,81),(25304,95),(25304,104),(27009,5),(27009,12),(27009,19),(27009,27),(27009,43),(27009,50),(27009,59),(27009,75),(27009,81),(27009,82),(27009,85),(27009,101),(36867,21),(36867,26),(36867,37),(36867,38),(36867,45),(36867,59),(36867,77),(36867,82),(36867,88),(36867,101),(36867,105),(43074,8),(43074,16),(43074,17),(43074,18),(43074,24),(43074,29),(43074,50),(43074,51),(43074,79),(43074,88),(43074,93),(43074,98),(44409,2),(44409,3),(44409,12),(44409,14),(44409,17),(44409,25),(44409,26),(44409,45),(44409,52),(44409,67),(44409,95),(44409,99),(45051,16),(45051,25),(45051,51),(45051,61),(45051,69),(45051,73),(45051,81),(45051,91),(45166,15),(45166,29),(45166,34),(45166,37),(45166,38),(45166,49),(45166,59),(45166,61),(45166,66),(45166,104),(48475,7),(48475,11),(48475,21),(48475,36),(48475,38),(48475,42),(48475,44),(48475,45),(48475,51),(48475,64),(48475,96),(48475,102),(51202,31),(51202,36),(51202,50),(51202,75),(51202,90),(54659,4),(54659,17),(54659,20),(54659,34),(54659,36),(54659,38),(54659,44),(54659,53),(54659,56),(54659,64),(54659,69),(54659,75),(54659,78),(54659,90),(54659,93),(56715,24),(56715,35),(56715,51),(56715,53),(56715,79),(56869,3),(56869,10),(56869,15),(56869,34),(56869,38),(56869,42),(57203,3),(57203,26),(57203,44),(57203,45),(57203,50),(57203,66),(57203,82),(57203,88),(57203,96),(57203,97),(57203,98),(58390,7),(58390,11),(58390,12),(58390,22),(58390,37),(58390,50),(58390,54),(58390,69),(58390,79),(58390,101),(62082,0),(62082,16),(62082,19),(62082,21),(62082,24),(62082,43),(62082,50),(62082,69),(62082,93),(64372,24),(64372,54),(64372,60),(64372,66),(64372,69),(64372,83),(64372,93),(70454,24),(70454,26),(70454,37),(70454,46),(70454,52),(70454,53),(70454,71),(70454,81),(70454,88),(77742,2),(77742,12),(77742,34),(77742,37),(77742,45),(77742,52),(77742,64),(77742,69),(77742,82),(77742,94),(77742,98),(77742,100),(79156,2),(79156,3),(79156,12),(79156,21),(79156,34),(79156,36),(79156,51),(79156,53),(79156,60),(79156,75),(79156,100),(79156,105),(88244,10),(88244,22),(88244,24),(88244,36),(88244,52),(88244,72),(88244,81),(88244,98),(88244,101),(89447,24),(89447,28),(89447,31),(89447,48),(89447,59),(89447,60),(89447,63),(89447,75),(89447,98),(89447,104),(91314,6),(91314,16),(91314,19),(91314,26),(91314,28),(91314,35),(91314,43),(91314,47),(91314,58),(91314,62),(91314,81),(94302,7),(94302,22),(94302,27),(94302,28),(94302,34),(94302,43),(94302,51),(94302,59),(94302,66),(94302,90),(94302,91),(94302,102),(94302,103),(101004,4),(101004,13),(101004,50),(101004,52),(101004,56),(101004,74),(101004,79),(101004,93),(101004,96),(101004,102),(101004,103),(103854,2),(103854,10),(103854,15),(103854,31),(103854,36),(103854,39),(103854,64),(103854,96),(103854,100),(103854,104),(110788,0),(110788,12),(110788,50),(110788,90),(113404,4),(113404,27),(113404,34),(113404,74),(113404,81),(113404,83),(113404,88),(113404,95),(113404,99),(113545,0),(113545,2),(113545,16),(113545,25),(113545,27),(113545,36),(113545,42),(113545,49),(113545,60),(113545,67),(113545,70),(113545,74),(113545,85),(113545,92),(113545,101),(113545,104),(116781,10),(116781,22),(116781,34),(116781,36),(116781,79),(116781,90),(116781,93),(116781,100),(116781,101),(116781,104),(116991,1),(116991,14),(116991,16),(116991,20),(116991,22),(116991,26),(116991,78),(119032,2),(119032,4),(119032,14),(119032,28),(119032,38),(119032,45),(119032,48),(119032,58),(119032,92),(122365,0),(122365,43),(122365,44),(122365,59),(122365,67),(122365,90),(122365,100),(136288,6),(136288,16),(136288,24),(136288,63),(136288,90),(143805,4),(143805,10),(143805,22),(143805,26),(143805,32),(143805,37),(143805,72),(143805,76),(143805,85),(143805,96),(143805,104),(144810,0),(144810,4),(144810,16),(144810,27),(144810,37),(144810,53),(144810,54),(144810,75),(144810,82),(144810,103),(145728,0),(145728,7),(145728,8),(145728,22),(145728,38),(145728,40),(145728,45),(145728,92),(145728,93),(145728,104),(146440,39),(146440,52),(146440,56),(146440,60),(146440,84),(151424,16),(151424,21),(151424,22),(151424,37),(151424,43),(151424,49),(151424,64),(151424,82),(151424,88),(151424,94),(151424,100),(151434,20),(151434,21),(151434,58),(151434,60),(151434,84),(151434,90),(151434,93),(151983,2),(151983,4),(151983,12),(151983,16),(151983,17),(151983,25),(151983,45),(151983,49),(151983,53),(151983,67),(151983,74),(151983,80),(151983,81),(151983,90),(151983,91),(151983,99),(153362,8),(153362,15),(153362,31),(153362,37),(153362,47),(153362,54),(153362,65),(155533,0),(155533,21),(155533,28),(155533,44),(155533,68),(155533,84),(155533,92),(155533,95),(155533,100),(158200,3),(158200,17),(158200,20),(158200,22),(158200,45),(158200,54),(158200,73),(158200,96),(158200,98),(162034,21),(162034,25),(162034,38),(162034,44),(162034,57),(162034,58),(162034,92),(162034,93),(162034,96),(162300,3),(162300,19),(162300,34),(162300,40),(162300,53),(162300,81),(162300,96),(162300,102),(162428,6),(162428,7),(162428,15),(162428,24),(162428,26),(162428,36),(162428,44),(162428,51),(162428,60),(162428,62),(162428,69),(162428,82),(162428,93),(162428,95),(162428,98),(165294,4),(165294,18),(165294,24),(165294,31),(165294,60),(165294,64),(165294,69),(165294,92),(165294,94),(165294,99),(165294,100),(170745,4),(170745,15),(170745,32),(170745,37),(170745,56),(170745,63),(170745,74),(170745,80),(170745,85),(170745,88),(170745,93),(170745,101),(171249,16),(171249,17),(171249,22),(171249,47),(171249,54),(171249,63),(171249,67),(171249,82),(171249,83),(171249,84),(171249,85),(171249,94),(171249,96),(171249,105),(180980,3),(180980,10),(180980,15),(180980,29),(180980,65),(180980,79),(180980,91),(180980,104),(182403,24),(182403,34),(182403,37),(182403,42),(182403,83),(182403,88),(182403,100),(182403,103),(183300,7),(183300,10),(183300,21),(183300,28),(183300,29),(183300,83),(183300,90),(193394,10),(193394,24),(193394,28),(193394,31),(193394,47),(193394,100),(196879,1),(196879,2),(196879,11),(196879,15),(196879,17),(196879,26),(196879,28),(196879,43),(196879,45),(196879,48),(196879,65),(196879,90),(196879,98),(196879,100),(197201,29),(197201,44),(197201,59),(199303,6),(199303,13),(199303,17),(199303,36),(199303,44),(199303,60),(199303,80),(199303,101),(199303,104),(203912,26),(203912,37),(203912,43),(203912,45),(203912,56),(203912,57),(203912,59),(203912,61),(203912,74),(218145,17),(218145,20),(218145,26),(218145,37),(218145,60),(218145,64),(218145,81),(225777,6),(225777,19),(225777,25),(225777,36),(225777,37),(225777,76),(225777,84),(225777,91),(225777,101);
/*!40000 ALTER TABLE `medico_especialidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medico_funcionario`
--

LOCK TABLES `medico_funcionario` WRITE;
/*!40000 ALTER TABLE `medico_funcionario` DISABLE KEYS */;
INSERT INTO `medico_funcionario` VALUES (62082,38939575024),(77742,79364178424),(143805,26115330408),(151434,84103453230),(193394,92289773450);
/*!40000 ALTER TABLE `medico_funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medico_plano_de_saude`
--

LOCK TABLES `medico_plano_de_saude` WRITE;
/*!40000 ALTER TABLE `medico_plano_de_saude` DISABLE KEYS */;
INSERT INTO `medico_plano_de_saude` VALUES (1,143805),(1,62082),(1,193394),(1,151434),(1,77742),(1,116991),(1,101004),(1,199303),(1,171249),(1,162300),(1,36867),(1,196879),(1,110788),(1,89447),(1,45166),(1,151424),(1,64372),(1,48475),(1,56869),(1,51202),(1,197201),(1,94302),(1,116781),(1,225777),(1,43074),(1,203912),(1,27009),(1,151983),(1,183300),(1,57203),(1,88244),(1,91314),(1,158200),(1,182403),(1,25304),(1,162428),(1,58390),(1,136288),(1,113545),(1,119032),(1,103854),(1,180980),(1,10286),(1,218145),(1,45051),(1,146440),(1,56715),(1,165294),(1,145728),(1,54659),(1,155533),(1,113404),(1,170745),(1,70454),(1,122365),(1,79156),(1,144810),(1,162034),(1,44409),(1,153362),(4,143805),(5,143805),(6,143805),(10,143805),(11,143805),(12,143805),(13,143805),(14,143805),(15,143805),(16,143805),(17,143805),(18,143805),(22,143805),(2,62082),(3,62082),(4,62082),(5,62082),(6,62082),(8,62082),(9,62082),(10,62082),(11,62082),(13,62082),(14,62082),(15,62082),(17,62082),(18,62082),(21,62082),(22,62082),(3,193394),(4,193394),(5,193394),(6,193394),(11,193394),(12,193394),(14,193394),(17,193394),(18,193394),(22,193394),(24,193394),(3,151434),(5,151434),(6,151434),(11,151434),(12,151434),(13,151434),(14,151434),(18,151434),(22,151434),(23,151434),(3,77742),(4,77742),(5,77742),(6,77742),(17,77742),(18,77742),(22,77742),(24,77742),(4,116991),(5,116991),(6,116991),(10,116991),(12,116991),(17,116991),(18,116991),(19,116991),(22,116991),(4,101004),(5,101004),(6,101004),(9,101004),(12,101004),(13,101004),(14,101004),(15,101004),(17,101004),(18,101004),(21,101004),(22,101004),(24,101004),(4,199303),(5,199303),(6,199303),(9,199303),(11,199303),(13,199303),(14,199303),(18,199303),(22,199303),(24,199303),(2,171249),(3,171249),(4,171249),(5,171249),(6,171249),(7,171249),(8,171249),(10,171249),(11,171249),(12,171249),(14,171249),(15,171249),(17,171249),(18,171249),(22,171249),(24,171249),(4,162300),(5,162300),(10,162300),(11,162300),(12,162300),(14,162300),(15,162300),(17,162300),(18,162300),(22,162300),(23,162300),(24,162300),(4,36867),(5,36867),(6,36867),(9,36867),(11,36867),(12,36867),(14,36867),(15,36867),(17,36867),(18,36867),(21,36867),(22,36867),(24,36867),(4,196879),(5,196879),(6,196879),(11,196879),(14,196879),(15,196879),(17,196879),(18,196879),(20,196879),(22,196879),(5,110788),(6,110788),(8,110788),(10,110788),(11,110788),(12,110788),(18,110788),(21,110788),(22,110788),(23,110788),(2,89447),(3,89447),(4,89447),(5,89447),(6,89447),(10,89447),(11,89447),(12,89447),(14,89447),(15,89447),(17,89447),(18,89447),(22,89447),(23,89447),(4,45166),(5,45166),(6,45166),(8,45166),(10,45166),(12,45166),(14,45166),(15,45166),(17,45166),(18,45166),(20,45166),(21,45166),(22,45166),(23,45166),(4,151424),(6,151424),(10,151424),(11,151424),(12,151424),(13,151424),(14,151424),(15,151424),(17,151424),(18,151424),(21,151424),(22,151424),(23,151424),(24,151424),(4,64372),(5,64372),(6,64372),(11,64372),(12,64372),(14,64372),(15,64372),(17,64372),(18,64372),(21,64372),(22,64372),(3,48475),(4,48475),(5,48475),(6,48475),(8,48475),(11,48475),(12,48475),(14,48475),(15,48475),(18,48475),(21,48475),(22,48475),(24,48475),(4,56869),(5,56869),(6,56869),(9,56869),(11,56869),(12,56869),(13,56869),(14,56869),(15,56869),(17,56869),(18,56869),(20,56869),(21,56869),(22,56869),(4,51202),(5,51202),(6,51202),(11,51202),(14,51202),(15,51202),(17,51202),(18,51202),(21,51202),(22,51202),(24,51202),(2,197201),(6,197201),(11,197201),(12,197201),(17,197201),(18,197201),(21,197201),(22,197201),(4,94302),(5,94302),(6,94302),(9,94302),(10,94302),(12,94302),(13,94302),(14,94302),(15,94302),(17,94302),(18,94302),(22,94302),(24,94302),(4,116781),(5,116781),(6,116781),(9,116781),(10,116781),(11,116781),(14,116781),(15,116781),(17,116781),(18,116781),(20,116781),(22,116781),(24,116781),(3,225777),(4,225777),(5,225777),(10,225777),(11,225777),(12,225777),(13,225777),(15,225777),(17,225777),(18,225777),(22,225777),(23,225777),(24,225777),(4,43074),(5,43074),(9,43074),(10,43074),(11,43074),(13,43074),(14,43074),(15,43074),(17,43074),(18,43074),(20,43074),(22,43074),(4,203912),(5,203912),(6,203912),(7,203912),(9,203912),(10,203912),(11,203912),(12,203912),(13,203912),(14,203912),(15,203912),(18,203912),(22,203912),(23,203912),(24,203912),(3,27009),(4,27009),(5,27009),(6,27009),(14,27009),(15,27009),(17,27009),(18,27009),(22,27009),(24,27009),(2,151983),(3,151983),(4,151983),(5,151983),(6,151983),(8,151983),(12,151983),(13,151983),(14,151983),(15,151983),(17,151983),(18,151983),(19,151983),(20,151983),(22,151983),(4,183300),(5,183300),(9,183300),(12,183300),(14,183300),(15,183300),(16,183300),(17,183300),(18,183300),(22,183300),(23,183300),(4,57203),(5,57203),(6,57203),(7,57203),(8,57203),(10,57203),(11,57203),(14,57203),(15,57203),(17,57203),(18,57203),(20,57203),(22,57203),(5,88244),(6,88244),(9,88244),(10,88244),(11,88244),(12,88244),(15,88244),(18,88244),(20,88244),(22,88244),(23,88244),(24,88244),(2,91314),(4,91314),(6,91314),(8,91314),(12,91314),(13,91314),(15,91314),(17,91314),(18,91314),(22,91314),(24,91314),(3,158200),(4,158200),(5,158200),(6,158200),(10,158200),(11,158200),(14,158200),(15,158200),(18,158200),(22,158200),(24,158200),(5,182403),(6,182403),(8,182403),(10,182403),(11,182403),(12,182403),(13,182403),(14,182403),(15,182403),(16,182403),(17,182403),(18,182403),(20,182403),(22,182403),(24,182403),(2,25304),(4,25304),(5,25304),(6,25304),(9,25304),(11,25304),(12,25304),(13,25304),(14,25304),(15,25304),(17,25304),(18,25304),(22,25304),(23,25304),(2,162428),(4,162428),(5,162428),(6,162428),(9,162428),(10,162428),(11,162428),(12,162428),(14,162428),(15,162428),(17,162428),(18,162428),(22,162428),(24,162428),(2,58390),(3,58390),(4,58390),(5,58390),(11,58390),(12,58390),(18,58390),(22,58390),(2,136288),(4,136288),(5,136288),(6,136288),(11,136288),(12,136288),(14,136288),(15,136288),(17,136288),(18,136288),(20,136288),(21,136288),(22,136288),(23,136288),(24,136288),(3,113545),(4,113545),(5,113545),(6,113545),(9,113545),(10,113545),(11,113545),(12,113545),(14,113545),(16,113545),(17,113545),(18,113545),(19,113545),(20,113545),(22,113545),(24,113545),(3,119032),(4,119032),(5,119032),(6,119032),(9,119032),(10,119032),(11,119032),(13,119032),(14,119032),(15,119032),(18,119032),(19,119032),(21,119032),(22,119032),(23,119032),(24,119032),(4,103854),(5,103854),(10,103854),(12,103854),(14,103854),(15,103854),(16,103854),(17,103854),(18,103854),(19,103854),(20,103854),(22,103854),(3,180980),(4,180980),(5,180980),(6,180980),(9,180980),(10,180980),(11,180980),(13,180980),(14,180980),(15,180980),(17,180980),(18,180980),(22,180980),(24,180980),(4,10286),(5,10286),(6,10286),(7,10286),(11,10286),(12,10286),(13,10286),(14,10286),(15,10286),(17,10286),(18,10286),(20,10286),(22,10286),(23,10286),(24,10286),(4,218145),(6,218145),(10,218145),(12,218145),(14,218145),(18,218145),(21,218145),(22,218145),(24,218145),(4,45051),(5,45051),(6,45051),(10,45051),(11,45051),(12,45051),(14,45051),(15,45051),(16,45051),(17,45051),(18,45051),(22,45051),(24,45051),(2,146440),(3,146440),(4,146440),(5,146440),(7,146440),(9,146440),(13,146440),(14,146440),(15,146440),(17,146440),(18,146440),(19,146440),(22,146440),(24,146440),(5,56715),(6,56715),(8,56715),(11,56715),(12,56715),(14,56715),(15,56715),(17,56715),(18,56715),(22,56715),(23,56715),(3,165294),(4,165294),(5,165294),(6,165294),(9,165294),(12,165294),(14,165294),(17,165294),(18,165294),(19,165294),(22,165294),(24,165294),(2,145728),(4,145728),(5,145728),(6,145728),(11,145728),(12,145728),(15,145728),(17,145728),(18,145728),(21,145728),(22,145728),(3,54659),(4,54659),(5,54659),(6,54659),(9,54659),(10,54659),(11,54659),(12,54659),(13,54659),(14,54659),(15,54659),(17,54659),(18,54659),(19,54659),(20,54659),(22,54659),(4,155533),(5,155533),(6,155533),(11,155533),(12,155533),(13,155533),(14,155533),(15,155533),(17,155533),(18,155533),(20,155533),(22,155533),(24,155533),(4,113404),(5,113404),(6,113404),(7,113404),(8,113404),(11,113404),(12,113404),(15,113404),(16,113404),(17,113404),(18,113404),(21,113404),(22,113404),(4,170745),(5,170745),(6,170745),(8,170745),(9,170745),(10,170745),(11,170745),(12,170745),(13,170745),(14,170745),(17,170745),(18,170745),(22,170745),(3,70454),(4,70454),(5,70454),(6,70454),(10,70454),(11,70454),(12,70454),(14,70454),(15,70454),(17,70454),(18,70454),(22,70454),(24,70454),(2,122365),(4,122365),(5,122365),(8,122365),(10,122365),(11,122365),(12,122365),(14,122365),(17,122365),(18,122365),(21,122365),(22,122365),(23,122365),(24,122365),(4,79156),(5,79156),(6,79156),(11,79156),(14,79156),(17,79156),(18,79156),(20,79156),(22,79156),(24,79156),(2,144810),(3,144810),(4,144810),(6,144810),(10,144810),(11,144810),(12,144810),(14,144810),(15,144810),(18,144810),(22,144810),(2,162034),(4,162034),(6,162034),(11,162034),(12,162034),(13,162034),(14,162034),(15,162034),(16,162034),(17,162034),(18,162034),(20,162034),(22,162034),(24,162034),(4,44409),(5,44409),(6,44409),(8,44409),(10,44409),(11,44409),(12,44409),(13,44409),(14,44409),(15,44409),(16,44409),(17,44409),(18,44409),(22,44409),(24,44409),(3,153362),(4,153362),(5,153362),(6,153362),(9,153362),(10,153362),(11,153362),(12,153362),(14,153362),(15,153362),(17,153362),(18,153362),(20,153362),(22,153362),(23,153362),(24,153362);
/*!40000 ALTER TABLE `medico_plano_de_saude` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medico_prestador_de_servico`
--

LOCK TABLES `medico_prestador_de_servico` WRITE;
/*!40000 ALTER TABLE `medico_prestador_de_servico` DISABLE KEYS */;
INSERT INTO `medico_prestador_de_servico` VALUES (10286,82890214613),(25304,7195247333),(27009,97768843185),(36867,75722943916),(43074,57870661546),(44409,24918346774),(45051,10138587949),(45166,71109815336),(48475,40996755489),(51202,53794736109),(54659,62961135010),(56715,56057609557),(56869,64389507770),(57203,44124685262),(58390,88807030640),(64372,17379549901),(70454,15412947182),(79156,48890278820),(88244,26564252390),(89447,28447770150),(91314,20664491138),(94302,73604646332),(101004,8340023888),(103854,73179869844),(110788,23219576702),(113404,10141668539),(113545,82929946881),(116781,12292855712),(116991,38687089872),(119032,53177886687),(122365,36511482979),(136288,4792191920),(144810,11421991691),(145728,3534193547),(146440,32791834567),(151424,18094856572),(151983,15794785810),(153362,69476145463),(155533,16231207994),(158200,4892472379),(162034,83623759066),(162300,95667607522),(162428,16492651820),(165294,26673923296),(170745,60369302834),(171249,65378446813),(180980,20459506463),(182403,75542887503),(183300,96481473454),(196879,79566884508),(197201,63061988904),(199303,74605026428),(203912,3470674175),(218145,90916481719),(225777,96981349132);
/*!40000 ALTER TABLE `medico_prestador_de_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (26115330408,'Davi Kristiansen','Solteiro(a)',0,'1939-01-05',' 32606-8312','25721705','MT','Santo Antônio do Içá','Cangaíba','Rua José Paulino',276,81,'davikristiansen@gmail.com'),(38939575024,'Samuel Leite','Separado(a)',1,'1975-12-07',' 05802-5696','86414578','RN','Massaranduba','Morumbi','Avenida Engenheiro Luís Carlos Berrini',179,52,'samuelleite@gmail.com'),(92289773450,'Gabrielly Franceschet','Solteiro(a)',0,'1983-04-23',' 65420-1746','88541755','GO','Estância','Sapopemba','Avenida Doutor Chucri Zaidan',144,9,'gabriellyfranceschet@gmail.com'),(84103453230,'Santiago Mascarenhas','Divorciado(a)',1,'1967-02-13',' 8785-1982','34326439','PB','Bom Sucesso','Vila Formosa','Rua Augusta',65,87,'santiagomascarenhas@gmail.com'),(79364178424,'Lorenzo Balança','Separado(a)',1,'1954-06-30',' 84859-3196','52464913','MT','Jacupiranga','Saúde','Rua 25 de Março',201,87,'lorenzobalanca@gmail.com'),(60675899745,'Afonso Brisot','Divorciado(a)',1,'1998-10-22',' 1853-3797','61098486','MA','Emas','Lapa','Estrada Turística do Jaraguá',122,24,'afonsobrisot@gmail.com'),(21206363541,'Cristiano Plotegher','Solteiro(a)',1,'1979-10-06',' 9777-7935','49694499','MS','São João do Arraial','Socorro','Rua Augusto Tolle',190,95,'cristianoplotegher@gmail.com'),(26383945211,'Emanuelle Santos','Viúvo(a)',1,'1958-07-18',' 45212-7374','21254148','MA','Água Boa','Guaianases','Avenida São João',277,77,'emanuellesantos@gmail.com'),(76407045290,'Vinicius Liberator','Separado(a)',0,'1973-01-10',' 2259-6419','98113302','PB','Poços de Caldas','Vila Jacuí','Ruas de comércio especializado da cidade de São Paulo',117,36,'viniciusliberator@gmail.com'),(76522189267,'Beatriz Marcarini','Separado(a)',1,'2002-05-06',' 91433-5018','18898475','PI','Dormentes','Jaçanã','Avenida Marquês de São Vicente',65,81,'beatrizmarcarini@gmail.com'),(23326288948,'Rodrigo Henrichsdatter','Casado(a)',1,'1946-01-03',' 0485-4306','97701144','RS','Amaporã','Vila Formosa','Rua Frei Caneca',114,83,'rodrigohenrichsdatter@gmail.com'),(30880288124,'Guilherme Almeida','Solteiro(a)',1,'1956-01-19',' 9090-6841','81532183','RO','Rio Branco','Moema','Avenida Senador Teotônio Vilela',76,81,'guilhermealmeida@gmail.com'),(29663284609,'Miguel Dansi','Divorciado(a)',0,'1991-12-06',' 4694-2184','97764631','RO','Passo do Sobrado','Mandaqui','Rua Estados Unidos',172,57,'migueldansi@gmail.com'),(37793323882,'Anita Bonadiman','Solteiro(a)',1,'1978-05-20',' 4310-0789','16094910','MT','Alto Alegre','Jaraguá','Avenida Washington Luís',5,1,'anitabonadiman@gmail.com'),(1183479778,'Helena Bellon','Divorciado(a)',1,'1987-02-23',' 34850-7021','73872609','CE','Pilão Arcado','Pinheiros','Avenida Higienópolis',8,43,'helenabellon@gmail.com'),(61084050900,'Laila Araújo','Casado(a)',0,'1989-07-17',' 88816-8436','54418954','SP','Brodowski','Jaraguá','Avenida Waldemar Carlos Pereira',259,3,'lailaaraujo@gmail.com'),(17566531867,'Lívia De Mori','Divorciado(a)',1,'1994-03-02',' 2341-1613','29572926','AM','São Félix de Balsas','Jaguara','Rua do Ouvidor',77,88,'liviademori@gmail.com'),(32083741005,'Maitê Azevedo','Divorciado(a)',1,'1965-05-28',' 0518-6611','25776247','PB','Cachoeira do Piriá','Tatuapé','Avenida Salim Farah Maluf',270,84,'maiteazevedo@gmail.com'),(79844029066,'Estela Sousa','Solteiro(a)',1,'1923-06-20',' 76182-5059','17827489','ES','Feira Nova do Maranhão','Tremembé','Rua Turiaçu',247,40,'estelasousa@gmail.com'),(58538792270,'Samuel Buson','Casado(a)',0,'1945-10-18',' 4879-0189','32931511','ES','Itaueira','Cursino','Rua Sete de Abril',275,19,'samuelbuson@gmail.com'),(60722045891,'Luisa Meger','Casado(a)',0,'1947-07-19',' 7065-2221','25870172','BA','Fervedouro','Bela Vista','Marginal Tietê',177,67,'luisameger@gmail.com'),(38978532993,'Isabelly Brush','Divorciado(a)',0,'1930-10-07',' 1544-8412','88280393','RN','Boqueirão do Piauí','Vila Curuçá','Avenida Ipiranga',245,99,'isabellybrush@gmail.com'),(36431704169,'Rebeca Neto','Viúvo(a)',0,'1965-06-08',' 23294-1762','35641987','RO','Sapezal','São Lucas','Avenida Marechal Tito',244,40,'rebecaneto@gmail.com'),(62992881597,'Igor Sancao','Separado(a)',1,'1958-04-04',' 70789-5510','47301720','DF','Tabatinga','Consolação','Avenida Prof. Abraão de Morais',246,36,'igorsancao@gmail.com'),(65178645804,'Alícia Piasentin','Divorciado(a)',1,'1989-04-06',' 0960-4359','96522510','DF','Lago dos Rodrigues','Lapa','Avenida Renata',13,68,'aliciapiasentin@gmail.com'),(39451309136,'Ariana Tassinari','Viúvo(a)',0,'1940-02-11',' 00742-8264','53663716','AM','Santa Cruz do Arari','Socorro','Avenida Senador Teotônio Vilela',34,73,'arianatassinari@gmail.com'),(85132371329,'Alice Pinto','Viúvo(a)',1,'2002-04-07',' 0902-0134','27447486','SP','Água Boa','Perus','Avenida Rio Branco',152,94,'alicepinto@gmail.com'),(30810234165,'Diogo Bottega','Viúvo(a)',1,'1983-12-27',' 07953-1250','85938320','TO','Prata do Piauí','Alto de Pinheiros','Rua 15 de Novembro',219,41,'diogobottega@gmail.com'),(94638205909,'Michael Bruschi','Casado(a)',1,'1952-06-22',' 01049-5816','27711510','RJ','Novo Oriente de Minas','Jardim Helena','Avenida São João',168,10,'michaelbruschi@gmail.com'),(34709887144,'Clarissa Nielsen','Divorciado(a)',1,'1941-07-02',' 46404-4686','12156629','MS','Avelino Lopes','República','Marginal Pinheiros',69,61,'clarissanielsen@gmail.com'),(6162159914,'Davi Soave','Divorciado(a)',0,'1975-05-15',' 33008-5623','31542343','RN','Olho d\'Água Grande','Vila Mariana','Avenida Morumbi',168,23,'davisoave@gmail.com'),(57934732899,'Bryan de Araújo','Divorciado(a)',0,'1970-07-15',' 0811-4311','98860684','SE','Diamantino','Jardim Ângela','Avenida Angélica',272,22,'bryandearaujo@gmail.com'),(81377156575,'Yasmin de Sousa','Viúvo(a)',0,'1952-09-15',' 95649-6184','58419834','SP','Autazes','Jaguara','Rua Maria Antônia',293,25,'yasmindesousa@gmail.com'),(22238791604,'Ana Roriz','Casado(a)',1,'1953-11-24',' 4687-9837','35179994','SP','Florestópolis','Moema','Rua Pedroso Alvarenga',39,37,'anaroriz@gmail.com'),(95499352801,'Amanda de Moraes','Divorciado(a)',1,'1931-01-19',' 1519-7441','38330641','PR','Crato','Campo Grande','Avenida João XXIII',247,44,'amandademoraes@gmail.com'),(49988922663,'Melissa de Almada','Separado(a)',0,'1981-01-20',' 4257-7142','54831122','PE','Monsenhor Hipólito','Butantã','Avenida Luís Dumont Vilares',192,77,'melissadealmada@gmail.com'),(95834117015,'Rafael Rodrigues','Viúvo(a)',0,'1990-07-22',' 2552-0788','94028866','MA','Tupãssi','Vila Curuçá','Rua Vergueiro',298,72,'rafaelrodrigues@gmail.com'),(74610857278,'João Bianco','Separado(a)',0,'1998-05-08',' 04326-7888','37809122','ES','Guaiçara','Vila Guilherme','Avenida Doutor João Guimarães',112,5,'joaobianco@gmail.com'),(89612761744,'Lorena Scudeler','Solteiro(a)',0,'1992-07-19',' 4297-5420','63899338','ES','Independência','Vila Leopoldina','Avenida Brigadeiro Luís Antônio',68,34,'lorenascudeler@gmail.com'),(63333828090,'Pablo Ostigui Domingue','Separado(a)',1,'1946-03-21',' 0583-9333','92150775','RO','Celso Ramos','Vila Mariana','Avenida Luís Dumont Vilares',12,97,'pabloostiguidomingue@gmail.com'),(21600779760,'Yuri Rodrigues','Solteiro(a)',1,'1973-12-28',' 5703-8877','33759138','TO','Picada Café','Vila Andrade','Avenida Doutor Eduardo Cotching',27,30,'yurirodrigues@gmail.com'),(14855728276,'Isadora Pereira','Casado(a)',0,'1963-07-26',' 0792-5388','44104940','SC','Guaiçara','Jardim Paulista','Rua Líbero Badaró',9,31,'isadorapereira@gmail.com'),(33930614375,'Vitória Selvatici','Casado(a)',0,'1972-06-28',' 29636-7579','32798536','PR','São José do Cerrito','Jaçanã','Avenida Renata',240,91,'vitoriaselvatici@gmail.com'),(77479340176,'João Meneses','Divorciado(a)',0,'1955-03-07',' 0778-5518','17070131','RS','Gouveia','Carrão','Avenida Sumaré',103,42,'joaomeneses@gmail.com'),(51829899546,'Theo de Zan','Divorciado(a)',1,'1980-07-03',' 5610-4125','88339814','CE','Aloândia','Tremembé','Rua Amaral Gama',259,21,'theodezan@gmail.com'),(513365613,'Helena Reinehr','Viúvo(a)',0,'1920-07-22',' 02930-3762','38162290','PA','Coronel Freitas','Pedreira','Avenida Washington Luís',41,89,'helenareinehr@gmail.com'),(4321135761,'Marina Gregio','Divorciado(a)',0,'1931-12-22',' 7479-3341','86023232','AL','Navegantes','Marsilac','Ligação Leste-Oeste',287,37,'marinagregio@gmail.com'),(25798695573,'Davi Pedarccini','Casado(a)',1,'1931-10-27',' 1882-5413','39051958','AC','Guiricema','Pirituba','Avenida Brigadeiro Luís Antônio',299,23,'davipedarccini@gmail.com'),(33920132424,'Lucca Oliveira','Separado(a)',1,'1927-07-03',' 36775-1918','36891414','PE','Miguel Pereira','Belém','Alameda Ministro Rocha Azevedo',229,99,'luccaoliveira@gmail.com'),(97189271902,'Maria Lingiardi','Divorciado(a)',0,'1985-02-08',' 2951-1555','66748638','PE','Campina das Missões','Vila Sônia','Rua Conselheiro Saraiva',184,14,'marialingiardi@gmail.com'),(38687089872,'Augusto Claudino','Viúvo(a)',0,'1927-03-31',' 36429-7108','92958983','SP','Bonito de Santa Fé','Aricanduva','Rua Maria Antônia',274,9,'augustoclaudino@gmail.com'),(8340023888,'Benjamim Gasparello','Divorciado(a)',0,'1968-07-30',' 1005-1784','99275257','PB','Uirapuru','Cidade Dutra','Avenida Ipiranga',98,63,'benjamimgasparello@gmail.com'),(74605026428,'Pamela Esteves','Casado(a)',0,'1928-07-05',' 2657-5916','99590775','PB','Bela Vista de Goiás','Vila Jacuí','Rua Três Rios',77,73,'pamelaesteves@gmail.com'),(65378446813,'Pablo da Conceicao','Divorciado(a)',1,'1984-08-19',' 4611-6319','46115242','ES','Esmeraldas','Socorro','Rua Leite de Morais',61,72,'pablodaconceicao@gmail.com'),(95667607522,'Bruno Acátolli','Divorciado(a)',1,'1994-04-01',' 82135-8664','15112623','DF','Belém de Maria','Consolação','Rua Conselheiro Furtado',278,63,'brunoacatolli@gmail.com'),(75722943916,'Renato de Mattos','Divorciado(a)',0,'1980-07-24',' 7131-1748','48938704','DF','Mata','Vila Curuçá','Rua 25 de Março',24,30,'renatodemattos@gmail.com'),(79566884508,'Pablo Figueira','Separado(a)',1,'1995-06-18',' 38201-1087','29769116','MS','Cabaceiras','Jardim Helena','Rua Augusta',61,95,'pablofigueira@gmail.com'),(23219576702,'Helena Zampiroli','Casado(a)',1,'1960-04-20',' 21150-9110','82450203','AL','Coremas','Jaraguá','Avenida do Oratório',170,7,'helenazampiroli@gmail.com'),(28447770150,'Carol Domingues','Casado(a)',1,'1954-04-19',' 26085-5242','47564929','AL','Seropédica','Jaçanã','Avenida Doutor Eduardo Cotching ',190,53,'caroldomingues@gmail.com'),(71109815336,'Ariela Apolinário','Casado(a)',1,'1967-11-08',' 81387-5031','46040639','GO','Medeiros','Cangaíba','Avenida Engenheiro Caetano Álvares',228,46,'arielaapolinario@gmail.com'),(18094856572,'Iara Vargas','Separado(a)',0,'1921-02-23',' 7959-4081','58733320','AP','Rosário da Limeira','Jaçanã','Rua Peixoto Gomide',44,80,'iaravargas@gmail.com'),(17379549901,'Larissa Vaz','Casado(a)',1,'1951-07-23',' 7610-2639','19554628','MG','Pocinhos','Perus','Rua Doutor Antônio Bento',175,89,'larissavaz@gmail.com'),(40996755489,'Mariana Chagas','Separado(a)',0,'1955-12-08',' 6818-3432','56150642','PE','Coronel Ezequiel','Itaquera','Avenida Matteo Bei',189,72,'marianachagas@gmail.com'),(64389507770,'Cauã Corcos','Separado(a)',1,'1974-03-01',' 34825-0995','44238116','MG','São José do Barreiro','Jardim Ângela','Avenida Renata',255,81,'cauacorcos@gmail.com'),(53794736109,'Valentina Zambon','Viúvo(a)',1,'1999-02-10',' 0685-2480','48701570','AM','Comendador Levy Gasparian','Vila Jacuí','Avenida Santos Dumont',262,66,'valentinazambon@gmail.com'),(63061988904,'Clara de Queiroz','Divorciado(a)',1,'1972-06-14',' 85371-0330','55607103','TO','São José do Vale do Rio Preto','São Rafael','Ruas de comércio especializado da cidade de São Paulo',142,15,'claradequeiroz@gmail.com'),(73604646332,'Gustavo Amorim','Solteiro(a)',1,'1964-04-15',' 0446-0694','52423274','ES','Aricanduva','Sapopemba','Avenida Inajar de Souza',158,40,'gustavoamorim@gmail.com'),(12292855712,'Afonso Cabral','Solteiro(a)',0,'1935-09-15',' 8018-1000','12744353','TO','Tucunduva','Saúde','Rua da Consolação',89,60,'afonsocabral@gmail.com'),(96981349132,'Martim Araújo','Separado(a)',0,'1974-06-12',' 64686-4559','15237500','PB','São Félix do Tocantins','Itaim Bibi','Avenida Brigadeiro Faria Lima',212,88,'martimaraujo@gmail.com'),(57870661546,'Pietro Domo','Divorciado(a)',0,'1971-10-02',' 28270-8132','28288499','RN','Três Pontas','Cambuci','Avenida Santa Marina',81,10,'pietrodomo@gmail.com'),(3470674175,'Guilherme de Oliveria','Viúvo(a)',0,'1997-09-23',' 36721-6885','12480791','ES','Triunfo','Consolação','Rua Palestra Itália',53,98,'guilhermedeoliveria@gmail.com'),(97768843185,'Maurício Tonon','Solteiro(a)',0,'1932-08-03',' 1970-3140','56545662','RJ','Andradina','Perus','Avenida Inajar de Souza',261,52,'mauriciotonon@gmail.com'),(15794785810,'Laura Barnett','Casado(a)',0,'1984-09-19',' 6336-4600','76305276','MT','Santarém Novo','Belém','Rua Tuiuti',86,52,'laurabarnett@gmail.com'),(96481473454,'Calebe Zantonelli','Viúvo(a)',0,'1999-06-22',' 42282-5343','41726980','SP','Maracajá','Mooca','Rua Teodoro Sampaio',144,42,'calebezantonelli@gmail.com'),(44124685262,'Murilo George','Viúvo(a)',0,'1927-12-19',' 0422-6615','65969576','GO','Machado','Limão','Avenida Pompeia',70,7,'murilogeorge@gmail.com'),(26564252390,'Ana de Almada','Viúvo(a)',1,'2001-12-07',' 1984-6479','49945133','AL','União Paulista','Cangaíba','Rua Doutor César',68,39,'anadealmada@gmail.com'),(20664491138,'Marco Delaparte','Casado(a)',1,'1942-12-15',' 54775-0906','88715614','TO','Piripiri','Vila Guilherme','Avenida Rio Branco',64,18,'marcodelaparte@gmail.com'),(4892472379,'Fabrício Oliveira','Solteiro(a)',0,'1930-09-12',' 1141-5809','33427433','RJ','Vassouras','Jabaquara','Rua Doutor Antônio Bento',267,43,'fabriciooliveira@gmail.com'),(75542887503,'Amanda Benevenutte','Separado(a)',1,'2002-04-06',' 9038-4495','27086758','TO','Solidão','Parelheiros','Avenida Doutor Chucri Zaidan',15,36,'amandabenevenutte@gmail.com'),(7195247333,'Rafael Calliman','Solteiro(a)',0,'1954-12-10',' 97167-3388','46630811','PR','Santa Bárbara d\'Oeste','Consolação','Rua Sete de Abril',233,19,'rafaelcalliman@gmail.com'),(16492651820,'Alexander Gaucci','Viúvo(a)',1,'1989-03-21',' 1238-1379','57898264','MA','Alto Piquiri','Raposo Tavares','Rua Teodoro Sampaio',233,91,'alexandergaucci@gmail.com'),(88807030640,'Matheus Bullock','Viúvo(a)',1,'1948-05-17',' 3174-4322','41678366','PB','Mimoso de Goiás','Pinheiros','Complexo Viário Jacu Pêssego',224,72,'matheusbullock@gmail.com'),(4792191920,'Emanuel Donati','Viúvo(a)',1,'1997-09-15',' 3434-6668','25039864','SC','Piraquê','Capão Redondo','Rua Amaral Gama',277,35,'emanueldonati@gmail.com'),(82929946881,'Davi Espíndula','Viúvo(a)',1,'1923-11-22',' 5102-1500','94777761','ES','Pains','Lajeado','Marginal Pinheiros',220,93,'daviespindula@gmail.com'),(53177886687,'João Grobério','Solteiro(a)',1,'1921-03-06',' 04492-8864','15576965','AM','Ji-Paraná','Mooca','Avenida Juscelino Kubitschek',88,22,'joaogroberio@gmail.com'),(73179869844,'Laura Berard Lepine','Solteiro(a)',1,'1940-02-24',' 23104-1622','91365617','SC','Mara Rosa','Água Rasa','Rua Pedro Doll',96,80,'lauraberardlepine@gmail.com'),(20459506463,'Bianca Julio','Separado(a)',0,'1929-03-04',' 79311-1794','28759685','AP','Lajeado','Saúde','Avenida do Oratório',93,81,'biancajulio@gmail.com'),(82890214613,'Cauã Hypólito','Solteiro(a)',0,'1993-08-20',' 5472-3864','12656829','RS','Garrafão do Norte','Belém','Rua Francisca Júlia',155,39,'cauahypolito@gmail.com'),(90916481719,'David Filete','Viúvo(a)',0,'1999-03-08',' 2369-0637','77283728','AM','Colorado','Limão','Rua Leite de Morais',94,27,'davidfilete@gmail.com'),(10138587949,'Guilherme Fasoli','Solteiro(a)',1,'1929-04-20',' 0940-4108','96399404','RJ','Ponta Grossa','Vila Maria','Rua Palestra Itália',144,94,'guilhermefasoli@gmail.com'),(32791834567,'Maria Bergami','Solteiro(a)',0,'1945-11-02',' 8863-5248','61686150','RJ','Rio das Antas','Liberdade','Avenida dos Bandeirantes',206,85,'mariabergami@gmail.com'),(56057609557,'Gabriel Bezerra','Solteiro(a)',1,'1927-08-06',' 32228-3302','52933669','PB','Entre Rios do Sul','Parelheiros','Rua Conde de Sarzedas',264,98,'gabrielbezerra@gmail.com'),(26673923296,'Maria Rui','Casado(a)',0,'1961-08-15',' 6242-8772','13442787','MT','Senador Sá','Parelheiros','Avenida Presidente João Goulart ',123,16,'mariarui@gmail.com'),(3534193547,'Eva de Barcellos','Solteiro(a)',1,'1961-06-06',' 0185-5127','26389477','AP','Itambaracá','Morumbi','Rua Oscar Freire',284,99,'evadebarcellos@gmail.com'),(62961135010,'Carol Lachini','Separado(a)',0,'1969-10-27',' 7221-0158','81158240','RR','Ibaiti','Vila Medeiros','Rua Frei Caneca',269,59,'carollachini@gmail.com'),(16231207994,'Pablo Capucho','Casado(a)',1,'1996-08-14',' 3635-3375','87657369','RN','Icapuí','Butantã','Avenida Marquês de São Vicente',251,47,'pablocapucho@gmail.com'),(10141668539,'Jade Vivaldi','Solteiro(a)',1,'1927-01-15',' 4058-2110','32309432','RJ','Passagem Franca','Jaguaré','Avenida Prestes Maia',171,1,'jadevivaldi@gmail.com'),(60369302834,'Marina Penido','Solteiro(a)',0,'1978-01-05',' 1256-5394','51702269','PE','Ponto Novo','Vila Sônia','Rua Galvão Bueno',55,85,'marinapenido@gmail.com'),(15412947182,'Michael Tonet','Separado(a)',1,'1924-03-24',' 60444-3953','46750463','SP','Santa Rosa do Piauí','São Lucas','Rua Peixoto Gomide',135,5,'michaeltonet@gmail.com'),(36511482979,'Paulo Berard Lepine','Divorciado(a)',1,'1927-11-29',' 01015-8573','98833640','RN','Jupi','Jardim Paulista','Avenida Salim Farah Maluf',114,72,'pauloberardlepine@gmail.com'),(48890278820,'Alice Raposo','Separado(a)',1,'1988-03-22',' 5405-6824','31539245','GO','Mimoso do Sul','Morumbi','Rua Maria Antônia',34,79,'aliceraposo@gmail.com'),(11421991691,'Alexandre Beltrame','Casado(a)',0,'1948-08-29',' 12889-9624','38272336','SE','São Bernardo do Campo','Pirituba','Ruas de comércio especializado da cidade de São Paulo',36,33,'alexandrebeltrame@gmail.com'),(83623759066,'Levi De Stefani','Solteiro(a)',1,'1923-04-01',' 3691-1118','73066902','SE','Minaçu','Itaim Bibi','Avenida 23 de Maio',122,14,'levidestefani@gmail.com'),(24918346774,'Jonathan Zoppi','Viúvo(a)',1,'1930-09-30',' 36359-3622','15989643','AM','Serrita','Capão Redondo','Rua São Bento',122,78,'jonathanzoppi@gmail.com'),(69476145463,'Rafaela Araújo','Separado(a)',1,'1924-05-20',' 4856-8027','79882690','MA','Jaramataia','Cidade Dutra','Rua da Mooca',148,83,'rafaelaaraujo@gmail.com'),(17628339808,'Gustavo Paresqui','Solteiro(a)',1,'1996-07-30',' 1056-2228','27769450','AL','Olímpio Noronha','Capão Redondo','Rua Três Rios',187,40,'gustavoparesqui@gmail.com'),(89106885217,'Paloma Prati','Solteiro(a)',1,'1970-09-02',' 81633-4780','56436290','PE','Caconde','Vila Jacuí','Avenida do Estado',197,61,'palomaprati@gmail.com'),(13092934229,'André Pereira','Solteiro(a)',1,'1950-12-08',' 7990-9184','96674764','MA','Santa Tereza de Goiás','Cidade Líder','Avenida Brigadeiro Faria Lima',72,35,'andrepereira@gmail.com'),(9677324250,'Manuela Manfredo','Solteiro(a)',1,'1985-01-29',' 0335-4244','77903594','GO','Redenção do Gurguéia','Penha','Avenida Santo Amaro',135,60,'manuelamanfredo@gmail.com'),(46915149023,'Carol Denadai','Solteiro(a)',1,'1996-09-10',' 2017-8355','31750247','GO','Barra do Guarita','Vila Prudente','Avenida Doutor João Guimarães',136,66,'caroldenadai@gmail.com'),(93010253109,'Elisa Selvatici','Solteiro(a)',0,'1946-04-08',' 2466-5551','48421773','RO','Rianápolis','Lajeado','Rua Maria Antônia',218,20,'elisaselvatici@gmail.com'),(48723757345,'Cloe Valiati','Solteiro(a)',1,'1970-03-14',' 5611-1604','64338769','AC','Sumé','Pedreira','Avenida João XXIII',243,15,'cloevaliati@gmail.com'),(23127693796,'Vinicios Falsoni','Solteiro(a)',0,'1996-02-15',' 21178-0246','28425581','MA','Alexânia','Brás','Rua Doutor César',123,76,'viniciosfalsoni@gmail.com'),(35373805696,'Pamela Barros','Solteiro(a)',1,'1985-12-24',' 4399-4069','57497618','SE','Encruzilhada','Guaianases','Avenida Renata',152,36,'pamelabarros@gmail.com'),(97305025950,'Jorge Rizzato','Solteiro(a)',0,'1976-06-15',' 30825-2629','17545892','PI','Suzanápolis','Ponte Rasa','Radial Leste',41,76,'jorgerizzato@gmail.com'),(93483226567,'Raul Maifredi','Solteiro(a)',0,'1966-05-31',' 4952-3867','13568328','SP','Caldas','Casa Verde','Avenida Doutor Arnaldo',86,0,'raulmaifredi@gmail.com'),(71587816822,'Fabrício Morais','Solteiro(a)',0,'1948-04-23',' 89651-0307','89258805','PE','Terra de Areia','Belém','Avenida Regente Feijó',236,23,'fabriciomorais@gmail.com'),(81798327910,'Santiago Appolinario','Solteiro(a)',1,'1987-11-25',' 73894-2987','24968550','GO','Bacabal','Vila Formosa','Rua Palestra Itália',226,3,'santiagoappolinario@gmail.com'),(38354349853,'Pedro Sgario','Solteiro(a)',1,'1951-08-01',' 0026-7965','14233410','BA','São José do Divino','Pinheiros','Avenida Renata',49,57,'pedrosgario@gmail.com'),(12776276575,'Octávio Sara','Solteiro(a)',0,'1955-03-09',' 6689-3909','91756557','GO','Rio das Ostras','Limão','Avenida Renata',2,33,'octaviosara@gmail.com'),(59462916101,'Pedro Veloso','Solteiro(a)',0,'1972-01-03',' 51293-1504','74291789','RR','Rio de Contas','Cidade Tiradentes','Avenida Nova Cantareira',135,56,'pedroveloso@gmail.com'),(83627619978,'Emanuelly Brancaglioni','Solteiro(a)',1,'2002-01-22',' 6245-7950','51296788','CE','Andorinha','Mandaqui','Rua Haddock Lobo',188,44,'emanuellybrancaglioni@gmail.com'),(61825308985,'Miguel Cavalcanti','Solteiro(a)',1,'1964-12-09',' 73517-3504','58873870','RO','Irapuã','Vila Andrade','Complexo Viário Jacu Pêssego',243,16,'miguelcavalcanti@gmail.com'),(3157057103,'Caio Gaburro','Solteiro(a)',1,'1984-03-30',' 09199-2626','25156641','RR','Mantena','São Mateus','Avenida Santos Dumont',72,30,'caiogaburro@gmail.com'),(49068400606,'Otávio Bedard','Solteiro(a)',1,'1967-10-06',' 5225-8691','99382857','ES','Aratuípe','Marsilac','Avenida Sumaré',173,24,'otaviobedard@gmail.com'),(4008005439,'Heloísa Sartori','Solteiro(a)',1,'1923-11-19',' 1484-5512','11233463','PE','Marumbi','Guaianases','Avenida Waldemar Carlos Pereira',94,7,'heloisasartori@gmail.com'),(92869747365,'Mariana Kister','Solteiro(a)',0,'1942-02-15',' 2398-2746','36179316','GO','Porto Rico do Maranhão','Vila Medeiros','Rua Doutor César',234,67,'marianakister@gmail.com'),(67184076079,'Lívia Mastrantoni','Solteiro(a)',0,'1955-10-01',' 1722-1441','97194761','AP','Itaguajé','Liberdade','Avenida Regente Feijó',169,49,'liviamastrantoni@gmail.com'),(49967250100,'Igor Romanini','Solteiro(a)',1,'1931-07-13',' 72552-8249','69823856','RJ','Nilópolis','Vila Leopoldina','Avenida Nova Cantareira',261,56,'igorromanini@gmail.com'),(34440677550,'Francisco Romanholi','Solteiro(a)',1,'1978-11-23',' 1078-5404','34628777','MS','Santo Antônio do Palma','Santo Amaro','Rua Sete de Abril',11,54,'franciscoromanholi@gmail.com'),(94689234957,'Beatriz Freire','Solteiro(a)',1,'1932-08-31',' 79439-1759','86990611','AC','Cabreúva','Cidade Ademar','Rua Oscar Freire',211,23,'beatrizfreire@gmail.com'),(96980910507,'Maísa Mariotto','Solteiro(a)',0,'1921-08-15',' 2435-3016','25354731','RO','Nova Esperança do Piriá','Saúde','Avenida Luís Dumont Vilares',118,38,'maisamariotto@gmail.com'),(90759492867,'Rafael Panhoca','Solteiro(a)',0,'1955-05-27',' 9083-8188','43633662','ES','Rio Sono','Brasilândia','Avenida Aricanduva',224,46,'rafaelpanhoca@gmail.com'),(69527869617,'Otávio Cheibub ','Solteiro(a)',1,'1992-03-13',' 2248-5947','74502430','AC','Itaqui','Ponte Rasa','Rua do Ouvidor',134,2,'otaviocheibub@gmail.com'),(82194747001,'Luana Costa','Solteiro(a)',0,'1934-11-15',' 60793-9262','86515928','AM','Francisco Santos','Belém','Avenida Guapira',147,0,'luanacosta@gmail.com'),(41138103705,'Isabelly Bellè','Solteiro(a)',0,'1987-02-22',' 35677-9066','73880357','MG','Santa Cecília do Sul','Mooca','Radial Leste',29,53,'isabellybelle@gmail.com'),(18696443284,'Lia Guidini','Solteiro(a)',0,'1945-07-30',' 2375-6604','74701838','PE','Caputira','Rio Pequeno','Rua da Quitanda',253,80,'liaguidini@gmail.com'),(93305625074,'Marcos Zorzal','Solteiro(a)',1,'1942-09-12',' 1560-8160','47406183','MG','Rio Real','São Lucas','Avenida Professor Luis Inácio de Anhaia Melo',262,77,'marcoszorzal@gmail.com'),(72030108138,'Alexandre Coladeci','Solteiro(a)',1,'1925-03-06',' 1657-0033','11536603','RN','Joaquim Távora','Campo Limpo','Avenida Juscelino Kubitschek',61,0,'alexandrecoladeci@gmail.com'),(55667205440,'Yasmine Agrisi','Solteiro(a)',1,'1936-09-24',' 2323-0270','57135603','SC','Alto Jequitibá','Sapopemba','Avenida Luís Dumont Vilares',35,38,'yasmineagrisi@gmail.com'),(74950603604,'Sofia Shibuya','Solteiro(a)',0,'1977-01-17',' 6725-4346','85493309','AL','Oliveira dos Brejinhos','Ipiranga','Avenida Waldemar Carlos Pereira',204,51,'sofiashibuya@gmail.com'),(46178479956,'Ana Minet','Solteiro(a)',1,'1962-08-23',' 0058-8836','38201121','PA','São Sebastião da Vargem Alegre','Moema','Estrada de Itapecerica',232,99,'anaminet@gmail.com'),(97918610806,'Lara Rasmussen','Solteiro(a)',0,'1960-06-03',' 3530-6393','18808682','SC','Belém de Maria','Lajeado','Avenida Vereador Abel Ferreira',175,6,'lararasmussen@gmail.com'),(65710411469,'Helena Marim','Solteiro(a)',1,'1971-04-12',' 0581-5772','13062222','ES','Inhuma','Vila Sônia','Rua Peixoto Gomide',288,54,'helenamarim@gmail.com'),(67668737286,'Alícia Stelzer','Solteiro(a)',1,'1997-02-07',' 5584-7763','58533155','AC','Santo Antônio do Rio Abaixo','Vila Jacuí','Avenida Luís Dumont Vilares',92,98,'aliciastelzer@gmail.com'),(5958501704,'Ariana Rivero','Solteiro(a)',1,'1949-04-17',' 54518-7338','58317432','AC','Magalhães de Almeida','Rio Pequeno','Avenida da Liberdade',15,80,'arianarivero@gmail.com'),(62061359930,'Nicole Tavares','Solteiro(a)',0,'1922-09-13',' 4567-5294','92103816','CE','Juramento','Jardim São Luís','Marginal Pinheiros',26,75,'nicoletavares@gmail.com'),(1990703267,'Alice Antunes','Solteiro(a)',1,'1995-05-30',' 67578-6618','77052923','BA','Messias Targino','Anhangüera','Rua Líbero Badaró',252,95,'aliceantunes@gmail.com'),(5764568889,'Joaquim de Godoy','Solteiro(a)',1,'1959-09-17',' 73033-6660','83204906','PI','Heitoraí','Vila Guilherme','Rua Conselheiro Saraiva',229,19,'joaquimdegodoy@gmail.com'),(59967183241,'Cloe Miranda','Solteiro(a)',1,'1955-07-06',' 2333-1276','96207243','BA','Engenheiro Paulo de Frontin','Santana','Alameda Ministro Rocha Azevedo',89,84,'cloemiranda@gmail.com'),(18736585084,'Douglas Napoleão','Solteiro(a)',0,'1949-12-31',' 2636-7360','26580491','MA','Serafina Corrêa','Jaguaré','Avenida Rubem Berta',279,4,'douglasnapoleao@gmail.com'),(299528324,'Enzo Cosme','Solteiro(a)',0,'1984-10-30',' 70545-3570','95937968','DF','Nova Bréscia','Ermelino Matarazzo','Rua Turiaçu',183,59,'enzocosme@gmail.com'),(36421593461,'Beatriz Marinho','Solteiro(a)',1,'1934-01-26',' 2022-3435','88877509','SC','Riacho de Santana','Marsilac','Avenida Doutor João Guimarães',128,14,'beatrizmarinho@gmail.com'),(614819393,'Theo Scotte','Solteiro(a)',1,'1999-05-29',' 3925-0855','38912865','DF','Gália','Liberdade','Avenida Juscelino Kubitschek',144,98,'theoscotte@gmail.com'),(29761187799,'Sara Sandrini','Solteiro(a)',0,'1928-04-16',' 1776-4720','93978165','SE','Passagem','Santa Cecília','Avenida Rebouças',17,89,'sarasandrini@gmail.com'),(52618210026,'Sophia Marangon','Solteiro(a)',1,'1998-10-30',' 9524-0189','68116301','RO','Pinhal da Serra','Penha','Avenida Matteo Bei',283,97,'sophiamarangon@gmail.com'),(89872021945,'João Vasoler','Solteiro(a)',1,'1932-09-06',' 3309-9507','86095724','PI','Eirunepé','Barra Funda','Rua São Bento',286,38,'joaovasoler@gmail.com'),(16791409061,'Ana Bozzoli','Solteiro(a)',1,'1929-02-08',' 9916-6622','85624597','RJ','Groaíras','Cidade Tiradentes','Avenida Washington Luís',58,60,'anabozzoli@gmail.com'),(35511887005,'Bruno Gaucci ','Solteiro(a)',0,'1928-09-20',' 3237-9524','41913162','PB','Vale do Paraíso','Pirituba','Rua Haddock Lobo',228,3,'brunogaucci@gmail.com'),(10844472239,'Eduardo Daroz','Solteiro(a)',0,'1988-11-15',' 3342-6762','48031641','RR','Marialva','Cidade Ademar','Avenida Engenheiro Luís Carlos Berrini',69,95,'eduardodaroz@gmail.com'),(77157056755,'Rafael Vugarato','Solteiro(a)',1,'1929-03-05',' 63782-7689','67905718','MS','Cravinhos','Tatuapé','Avenida Angélica',149,79,'rafaelvugarato@gmail.com'),(65020230294,'Lorena Perota','Solteiro(a)',1,'1940-10-29',' 7641-0089','18686243','AM','Auriflama','Alto de Pinheiros','Avenida João XXIII',70,32,'lorenaperota@gmail.com'),(81402045441,'Álvaro Prata','Solteiro(a)',0,'1967-03-01',' 2837-8688','17827102','AC','Santa Maria do Oeste','Jardim Paulista','Rua Estados Unidos',67,76,'alvaroprata@gmail.com'),(94091317820,'Maísa Freyre','Solteiro(a)',0,'1991-06-13',' 46923-0249','35813440','PA','Torres','São Miguel Paulista','Rua 15 de Novembro',214,35,'maisafreyre@gmail.com'),(44636063813,'Alice Bindaco','Solteiro(a)',1,'1958-09-15',' 01243-2139','73008923','PR','Apiúna','Vila Jacuí','Rua Padre João Manuel',10,90,'alicebindaco@gmail.com'),(88255075933,'João Piassarolli','Solteiro(a)',0,'1921-06-15',' 6211-3976','81120877','AM','Nossa Senhora das Graças','Itaim Paulista','Avenida Professor Francisco Morato',87,79,'joaopiassarolli@gmail.com'),(64170564650,'Pedro Anna','Solteiro(a)',1,'1993-11-17',' 0572-3174','46128928','PE','Barra do Guarita','Jaguaré','Rua Pedro Doll',285,41,'pedroanna@gmail.com'),(17228054989,'Amanda Habib','Solteiro(a)',1,'1985-06-16',' 3000-1258','45498753','AC','Divinópolis do Tocantins','Barra Funda','Rua Conselheiro Moreira de Barros',268,47,'amandahabib@gmail.com'),(35231817392,'Eva Jordão','Solteiro(a)',0,'1953-10-18',' 0741-1932','31901165','SE','Dom Pedro de Alcântara','Perdizes','Rua Paulistânia',274,62,'evajordao@gmail.com'),(24299771761,'Felipe Barreto','Solteiro(a)',1,'1960-10-26',' 2897-5615','64301465','SC','Brasilândia do Tocantins','República','Rua Estados Unidos',224,28,'felipebarreto@gmail.com'),(89233423948,'Afonso Sgulmaro','Solteiro(a)',0,'1947-01-24',' 4204-5960','46842290','GO','Coronel Bicaco','Vila Leopoldina','Avenida Atlântica',3,92,'afonsosgulmaro@gmail.com'),(39858212674,'Vitória Mergár','Solteiro(a)',1,'1966-07-25',' 07760-3238','67930669','RN','Novo Aripuanã','Penha','Rua da Consolação',209,10,'vitoriamergar@gmail.com'),(70047448920,'Valentina Oliveira','Solteiro(a)',1,'1948-01-04',' 48319-2249','12993618','PB','Içara','Vila Leopoldina','Rua Heitor Penteado',72,95,'valentinaoliveira@gmail.com'),(73769338405,'Alícia Barreto','Solteiro(a)',0,'1988-02-15',' 79385-8071','62983483','PE','Trindade do Sul','Vila Mariana','Avenida Engenheiro Caetano Álvares',274,84,'aliciabarreto@gmail.com'),(525593004,'Isabella de Andrade','Solteiro(a)',1,'1950-08-06',' 2541-0378','75091327','SP','Cacique Doble','Vila Sônia','Avenida Celso Garcia',127,96,'isabelladeandrade@gmail.com'),(64785814039,'Bianca Lingiardi','Solteiro(a)',0,'1934-03-15',' 8989-7514','69595786','AC','São Sepé','Barra Funda','Rua Voluntários da Pátria',4,16,'biancalingiardi@gmail.com'),(97997286497,'Sabrina Anna','Solteiro(a)',1,'2001-01-22',' 73624-5440','64008265','ES','Salgado','Vila Medeiros','Avenida Marechal Tito',68,98,'sabrinaanna@gmail.com'),(20878625240,'Muriel Dall\'armellina','Solteiro(a)',1,'1990-01-15',' 8453-5446','27943858','BA','Quadra','Vila Leopoldina','Avenida Engenheiro Armando de Arruda Pereira',188,76,'murieldallarmellina@gmail.com'),(19790157754,'Heloísa Pontara','Solteiro(a)',1,'2000-02-14',' 0255-0050','88866442','RO','Iporanga','Vila Prudente','Avenida Doutor Ricardo Jafet',79,69,'heloisapontara@gmail.com'),(44953969006,'Duarte Correya','Solteiro(a)',1,'1938-05-24',' 76680-3762','24499415','RS','Nova Santa Rita','Jaguara','Rua Sete de Abril',55,20,'duartecorreya@gmail.com'),(47412130307,'Sofia Camiletti','Solteiro(a)',1,'1942-08-08',' 1737-3828','93126572','SC','Santa Terezinha','Jardim Ângela','Avenida Aricanduva',21,60,'sofiacamiletti@gmail.com'),(35590808278,'Alexandre Guidolini','Solteiro(a)',0,'1999-08-27',' 59185-9260','49589813','TO','Santo Antônio do Pinhal','Jaraguá','Avenida Regente Feijó',182,84,'alexandreguidolini@gmail.com'),(67028196500,'Theo Pancini','Solteiro(a)',0,'1926-07-20',' 8036-5268','87111351','MT','Groaíras','Pirituba','Rua Haddock Lobo',45,63,'theopancini@gmail.com'),(65338204789,'Isabelly Congo','Solteiro(a)',0,'1921-09-04',' 7361-0018','71865895','SE','Pedra Dourada','Casa Verde','Rua da Quitanda',68,73,'isabellycongo@gmail.com'),(91654850330,'Martim Marim','Solteiro(a)',0,'1995-05-04',' 4828-2786','19689952','PI','São Sebastião do Paraíso','Santo Amaro','Rua Barão de Itapetininga',172,56,'martimmarim@gmail.com'),(45291060476,'Estela Bragato','Solteiro(a)',1,'1972-11-25',' 6748-4161','18996495','DF','Cuitegi','Moema','Rua Augusto Tolle',295,97,'estelabragato@gmail.com'),(15289739254,'Bryan Dalla','Solteiro(a)',1,'1934-03-29',' 3056-8547','75357569','SE','Indianópolis','Perus','Rua Doutor Antônio Bento',163,57,'bryandalla@gmail.com'),(25954886270,'Maria Gaucci','Solteiro(a)',0,'1970-08-13',' 4478-7502','98283129','ES','Seringueiras','Lajeado','Avenida Prof. Abraão de Morais',4,52,'mariagaucci@gmail.com'),(91450794203,'Bruno Congo','Solteiro(a)',1,'1940-04-27',' 1236-2128','74141978','PB','Macururé','Vila Guilherme','Rua Voluntários da Pátria',277,29,'brunocongo@gmail.com'),(1858082200,'Anabela Pase','Solteiro(a)',0,'1926-11-28',' 51872-9975','68798361','PB','Alto Santo','Iguatemi','Rua do Orfanato',210,27,'anabelapase@gmail.com'),(35773274302,'Marco Zampirolli','Solteiro(a)',1,'1925-04-07',' 0864-5643','57005771','RO','Silveira Martins','Vila Mariana','Avenida Sapopemba',36,60,'marcozampirolli@gmail.com'),(65811217200,'Isadora Debona','Solteiro(a)',0,'1995-12-03',' 73986-8808','54194640','PI','Boa Esperança do Iguaçu','Cidade Dutra','Avenida Mutinga',220,19,'isadoradebona@gmail.com'),(62359486110,'Marcela Vescovi','Solteiro(a)',1,'1976-12-21',' 9193-0786','89666463','GO','Iuiú','Sapopemba','Rua Paulistânia',71,38,'marcelavescovi@gmail.com'),(40970794681,'Arthur Sartori','Solteiro(a)',1,'1958-07-13',' 8990-8389','25334230','DF','Juazeirinho','Cangaíba','Rua Pedroso Alvarenga',190,97,'arthursartori@gmail.com'),(35815134392,'Kelvin Volponi','Solteiro(a)',0,'1960-10-21',' 3439-4198','31300283','TO','Governador Celso Ramos','Ermelino Matarazzo','Avenida Paes de Barros',261,35,'kelvinvolponi@gmail.com'),(53049729619,'Vitória Fumaneri','Solteiro(a)',1,'1924-12-15',' 3248-9944','96701774','PE','Lobato','Butantã','Rua Estados Unidos',216,34,'vitoriafumaneri@gmail.com'),(68201147022,'Antônio Firme','Solteiro(a)',0,'1966-03-02',' 3864-0242','27991372','DF','Serra Redonda','Campo Belo','Rua Vergueiro',116,55,'antoniofirme@gmail.com'),(23878163401,'Santiago Brumana','Solteiro(a)',1,'1981-01-20',' 9199-3282','64464723','MT','Serra','Alto de Pinheiros','Rua Estados Unidos',238,63,'santiagobrumana@gmail.com'),(64525583827,'Lorena Domingues','Solteiro(a)',0,'2002-07-15',' 6208-3566','13101246','BA','Seridó','Sapopemba','Rua Alfredo Pujol',91,86,'lorenadomingues@gmail.com'),(66916251026,'Caio Pianezolla','Solteiro(a)',1,'1920-09-24',' 78011-5107','88106540','PA','Parobé','Morumbi','Rua da Quitanda',194,87,'caiopianezolla@gmail.com'),(52774227658,'Renato Vicente','Solteiro(a)',1,'1975-06-28',' 2132-3136','83317910','RN','Belmonte','Jabaquara','Avenida do Oratório',230,84,'renatovicente@gmail.com'),(73652414462,'Felipe Maneback','Solteiro(a)',0,'1963-11-01',' 2719-5266','45486877','PA','Barro Alto','Liberdade','Avenida Paes de Barros',123,48,'felipemaneback@gmail.com'),(27607982671,'Renan Matos','Solteiro(a)',0,'1926-01-31',' 94048-3940','36332952','BA','Lagoa Real','Freguesia do Ó','Avenida Aricanduva',8,53,'renanmatos@gmail.com'),(79493103757,'Emanuel Assis','Solteiro(a)',0,'1998-10-23',' 18638-9921','42742893','RR','Brejo do Cruz','Jardim Paulista','Veridiana da Silva Prado',230,0,'emanuelassis@gmail.com'),(28722712950,'Pablo Pauluccio','Solteiro(a)',1,'1929-03-29',' 8133-2534','67372954','SP','Cidreira','Parque do Carmo','Avenida Matteo Bei',213,90,'pablopauluccio@gmail.com'),(86401381094,'Diana Salvago','Solteiro(a)',1,'1983-01-02',' 6028-8884','85398715','CE','Piraquê','Jardim Ângela','Rua Haddock Lobo',73,0,'dianasalvago@gmail.com'),(59005996986,'Alana de Barros','Solteiro(a)',0,'1950-07-22',' 3954-8474','19385117','PA','Matias Barbosa','Jaçanã','Avenida Brigadeiro Luís Antônio',27,39,'alanadebarros@gmail.com'),(62816251373,'Joana Braceschi','Solteiro(a)',0,'1940-07-02',' 40148-0467','82647191','PB','Cordisburgo','Sapopemba','Avenida Europa',199,75,'joanabraceschi@gmail.com'),(60759108242,'Clarissa Stebenne','Solteiro(a)',0,'1996-07-01',' 7219-9413','96693459','CE','Coronel Macedo','Cidade Ademar','Avenida Salim Farah Maluf',200,86,'clarissastebenne@gmail.com'),(33849108937,'Miguel Xavier','Solteiro(a)',0,'1934-12-06',' 4198-1007','83155986','GO','Humaitá','Liberdade','Marginal Pinheiros',207,61,'miguelxavier@gmail.com'),(7654155930,'Caio Zacchi','Solteiro(a)',0,'1930-06-22',' 0266-7002','62056887','RS','Gararu','Água Rasa','Rua Turiaçu',216,66,'caiozacchi@gmail.com'),(27022149321,'Eva Josefa','Solteiro(a)',1,'1966-03-03',' 29474-1341','66388587','AP','Minador do Negrão','Jaraguá','Avenida Sapopemba',27,85,'evajosefa@gmail.com'),(48549805246,'Larissa Battisti','Solteiro(a)',0,'1975-11-05',' 1350-8089','11037341','MA','Conceição do Pará','Campo Limpo','Ruas de comércio especializado da cidade de São Paulo',274,9,'larissabattisti@gmail.com'),(18521105460,'Theo Gaiguer','Solteiro(a)',1,'1995-06-23',' 82163-6122','42048189','AC','São Sebastião da Bela Vista','Vila Leopoldina','Avenida Celso Garcia',26,88,'theogaiguer@gmail.com'),(76512802101,'Maurício Rozario','Solteiro(a)',1,'1972-03-01',' 6641-9535','94412685','RJ','Cidade Ocidental','Cachoeirinha','Rua Voluntários da Pátria',278,14,'mauriciorozario@gmail.com'),(50179167766,'Iara Vaccari','Solteiro(a)',1,'1920-11-07',' 45006-0151','23081491','AM','Santa Helena de Goiás','São Domingos','Veridiana da Silva Prado',60,68,'iaravaccari@gmail.com'),(7298461133,'Natália Selvatici','Solteiro(a)',1,'1989-08-25',' 2768-7705','78172636','RN','Ubaitaba','Alto de Pinheiros','Rua Santa Ifigênia',211,99,'nataliaselvatici@gmail.com'),(13553123028,'Isabella Cavalcanti','Solteiro(a)',0,'1961-11-28',' 2060-9836','76100617','PB','Macieira','Lajeado','Avenida Brigadeiro Faria Lima',165,21,'isabellacavalcanti@gmail.com'),(68690513132,'Nicole Nunes','Solteiro(a)',1,'1947-01-28',' 5153-0434','96160903','AM','Condor','Anhangüera','Rua Três Rios ',290,0,'nicolenunes@gmail.com'),(49659871520,'Alícia Forafo','Solteiro(a)',1,'1951-03-24',' 1579-3794','72885198','GO','Porto Real','Cidade Tiradentes','Rua Francisca Júlia',127,77,'aliciaforafo@gmail.com'),(4283238805,'Aurora Ghivan','Solteiro(a)',0,'1971-12-22',' 6684-9815','42537740','RR','João Costa','Vila Curuçá','Rua 25 de Março',247,74,'auroraghivan@gmail.com'),(92459222866,'Adriano Abreu','Solteiro(a)',0,'1965-09-08',' 9308-1531','13598628','PA','Uruana','Pirituba','Avenida Jornalista Roberto Marinho',227,44,'adrianoabreu@gmail.com'),(44075599345,'Álvaro Giacomeli','Solteiro(a)',1,'1941-03-09',' 9789-2172','21812840','CE','Rio do Oeste','Campo Belo ','Avenida Matteo Bei',225,73,'alvarogiacomeli@gmail.com'),(37469415041,'Yasmine Fittipaldi','Solteiro(a)',0,'1972-08-07',' 4447-1919','23812587','GO','Limoeiro de Anadia','Sacomã','Marginal Tietê',60,97,'yasminefittipaldi@gmail.com'),(82795793547,'Aarã Fioresi','Solteiro(a)',1,'1951-04-23',' 6981-5462','85046790','SP','Antonina do Norte','Marsilac','Rua Estados Unidos',162,68,'aarafioresi@gmail.com'),(30667965408,'Bryan Mendes','Solteiro(a)',1,'1959-11-05',' 6010-2429','88983300','RJ','Água Branca','República','Marginal Pinheiros',16,34,'bryanmendes@gmail.com'),(63339885885,'Anabela Pedersen','Solteiro(a)',1,'1984-04-20',' 54083-9473','36956729','AM','Cocalinho','Grajaú','Rua Vergueiro',208,11,'anabelapedersen@gmail.com'),(1052023711,'Érica Barbosa','Solteiro(a)',0,'1962-12-27',' 34347-2388','19000241','RJ','Figueirópolis d\'Oeste','Cidade Dutra','Avenida do Estado',106,49,'ericabarbosa@gmail.com'),(47997536302,'Caio Bernadini','Solteiro(a)',1,'1949-10-24',' 16012-2653','99052197','DF','Macau','Jaraguá','Avenida Rio Branco',214,39,'caiobernadini@gmail.com'),(97729276240,'Julia Nicolini','Solteiro(a)',0,'1963-02-10',' 97036-5283','88373726','RO','Acorizal','Cidade Tiradentes','Avenida Paulista',268,2,'julianicolini@gmail.com'),(36127855403,'Levi Bianche','Solteiro(a)',0,'1968-03-22',' 60807-8332','14343755','PI','Belém','Itaquera','Avenida Nova Cantareira',41,4,'levibianche@gmail.com'),(44629985379,'Samuel Toze','Solteiro(a)',0,'1935-04-04',' 3491-5971','25344955','TO','Matipó','Vila Leopoldina','Rua Bela Cintra',261,75,'samueltoze@gmail.com'),(94161410468,'Marcela de Andrade','Solteiro(a)',0,'1976-06-01',' 2954-0554','97766635','GO','Santana do Araguaia','Itaquera','Avenida São João',246,5,'marceladeandrade@gmail.com'),(28686440827,'Laura Fabis','Solteiro(a)',0,'1995-06-15',' 5752-3673','38765441','DF','Barras','Cangaíba','Rua Oscar Freire',259,97,'laurafabis@gmail.com'),(65319988656,'Pamela Alba','Solteiro(a)',1,'1947-07-13',' 0866-8592','77007695','MS','Barra de São Miguel','Jardim São Luís','Rua da Consolação',114,37,'pamelaalba@gmail.com'),(19673188084,'Danilo e Almeida','Solteiro(a)',1,'1971-01-09',' 8863-6828','41432229','RS','Coronel Murta','Alto de Pinheiros','Avenida Cupecê',93,1,'daniloealmeida@gmail.com'),(36765744002,'Sabrina de Jeus','Solteiro(a)',1,'1945-05-07',' 6880-9701','92597145','MA','Guamiranga','Freguesia do Ó','Avenida Rebouças',69,68,'sabrinadejeus@gmail.com'),(88929315801,'Bryan Rossi','Solteiro(a)',0,'1996-01-25',' 67412-7749','97055367','PI','Brotas','Parelheiros','Avenida Luís Dumont Vilares',16,78,'bryanrossi@gmail.com'),(82167538618,'Yara Solda\'','Solteiro(a)',0,'1986-12-19',' 1147-7679','17694143','DF','Belém','Vila Curuçá','Avenida São João',65,42,'yarasolda@gmail.com'),(14911184078,'Giovanna Sales','Solteiro(a)',1,'1984-02-14',' 65108-5309','97171155','GO','Ibirapitanga','Butantã','Avenida Pompeia',45,91,'giovannasales@gmail.com'),(99567988196,'Jonas Menegardo','Solteiro(a)',1,'1969-11-07',' 8471-1459','86944253','PR','Xapuri','Vila Mariana','Rua Normandia',211,97,'jonasmenegardo@gmail.com'),(42161730711,'Enzo Rubens','Solteiro(a)',0,'1939-06-28',' 64195-5358','36745350','MT','Serra','Vila Guilherme','Avenida Jornalista Roberto Marinho',130,31,'enzorubens@gmail.com'),(7290779428,'Bruno Gabriel','Solteiro(a)',1,'1963-08-27',' 3949-6555','73628508','PB','São Fidélis','Santo Amaro','Avenida Salim Farah Maluf',106,96,'brunogabriel@gmail.com'),(23348597021,'Fabrício Kristiansen','Solteiro(a)',1,'1973-05-14',' 18625-0874','98171393','PR','Pedro de Toledo','Vila Prudente','Avenida Cidade Jardim',283,25,'fabriciokristiansen@gmail.com'),(67352811362,'Aurora Martins','Solteiro(a)',0,'1993-06-07',' 1787-2429','76130641','PE','Campo do Meio','Parque do Carmo','Avenida Doutor Ricardo Jafet',95,74,'auroramartins@gmail.com'),(20028186656,'Leonardo Rui','Solteiro(a)',1,'1969-02-27',' 2308-5498','96468221','RJ','Teolândia','Freguesia do Ó','Avenida Aricanduva',296,84,'leonardorui@gmail.com'),(12194146466,'Bianca Rigon','Solteiro(a)',0,'1987-09-01',' 7620-6261','33614558','AP','Avelino Lopes','Sé','Rua Sete de Abril',187,22,'biancarigon@gmail.com'),(87306696696,'Larissa Carvalhido','Solteiro(a)',0,'1930-02-08',' 4223-6779','33582347','MA','Lagoa Real','Grajaú','Rua Vergueiro',26,51,'larissacarvalhido@gmail.com'),(35517196756,'Pamela Lima','Solteiro(a)',0,'1948-05-25',' 3000-2057','63427572','TO','Lagoa dos Gatos','Jardim São Luís','Avenida Washington Luís',97,44,'pamelalima@gmail.com'),(71176261940,'Yasmin Viana','Solteiro(a)',1,'1987-07-09',' 18907-2708','27679493','BA','Ponte Preta','Ipiranga','Rua Sete de Abril',125,45,'yasminviana@gmail.com'),(66321367290,'Maria Calassara','Solteiro(a)',0,'1928-06-07',' 6233-0076','29185568','AL','São Luís do Curu','Ermelino Matarazzo','Avenida Cupecê',68,52,'mariacalassara@gmail.com'),(59215658815,'Ricardo Perizin','Solteiro(a)',1,'1941-10-05',' 4273-7395','56854876','MS','Lavras da Mangabeira','São Rafael','Rua Capitão Manuel Novais ',76,96,'ricardoperizin@gmail.com'),(44989192206,'Bárbara Cardosa','Solteiro(a)',0,'1986-03-27',' 4730-7334','27972815','MT','Ernestina','Casa Verde','Avenida São João',186,19,'barbaracardosa@gmail.com'),(41330042301,'Ágata Wainer','Solteiro(a)',1,'1923-11-20',' 88287-0514','79802637','PI','Inhambupe','Vila Medeiros','Marginal Tietê',99,88,'agatawainer@gmail.com'),(88342743934,'Olívia Cassaro','Solteiro(a)',0,'1942-02-21',' 1155-3078','82672491','SE','Augustinópolis','Vila Sônia','Rua Francisca Júlia',218,72,'oliviacassaro@gmail.com'),(56014520759,'Heloísa Volponi','Solteiro(a)',1,'1990-05-27',' 8595-1305','98993652','SP','Cambira','Artur Alvim','Avenida Brigadeiro Luís Antônio',143,61,'heloisavolponi@gmail.com'),(85154275403,'Bruno Pedrazini','Solteiro(a)',0,'1964-10-10',' 45940-7949','84316583','AP','Francisco Dumont','Iguatemi','Avenida Santa Marina',159,75,'brunopedrazini@gmail.com'),(94392601900,'Karen Vescovi','Solteiro(a)',1,'1963-04-19',' 0894-4552','64310651','DF','Chapada','Campo Belo','Avenida Nova Cantareira',134,5,'karenvescovi@gmail.com'),(32769179632,'Maria Capucho','Solteiro(a)',0,'1939-04-24',' 1766-7819','14497683','RJ','Chapadinha','São Rafael','Rua Palestra Itália',109,34,'mariacapucho@gmail.com'),(19558005967,'Enzo Pedrazini','Solteiro(a)',1,'1923-11-01',' 0701-7252','56016343','AC','Ibema','São Domingos','Avenida Rebouças',84,22,'enzopedrazini@gmail.com'),(28649949096,'João Loureiro','Solteiro(a)',1,'1976-01-01',' 5537-1574','62615838','RJ','Criciúma','Jabaquara','Rua Três Rios',179,4,'joaoloureiro@gmail.com'),(20753754029,'Lis Gomes','Solteiro(a)',1,'1940-12-30',' 1776-6956','74163712','MS','Caieiras','Campo Belo','Avenida Angélica',239,26,'lisgomes@gmail.com'),(84780417023,'Vitor Dan','Solteiro(a)',0,'1966-01-28',' 7692-1933','49288664','PB','Quixeramobim','Santa Cecília','Avenida João XXIII',117,64,'vitordan@gmail.com'),(26986509073,'Alice Balarini','Solteiro(a)',1,'1993-03-29',' 62643-1556','21818622','RO','Rubelita','Vila Guilherme','Avenida Professor Francisco Morato',203,84,'alicebalarini@gmail.com'),(36318340203,'Theo Mantoan','Solteiro(a)',1,'1991-02-14',' 48186-9971','72874408','RN','Mundo Novo','Anhangüera','Avenida Marquês de São Vicente',105,49,'theomantoan@gmail.com'),(35096115607,'Muriel Bregesk','Solteiro(a)',1,'1939-11-09',' 4069-1943','71027409','AL','São Francisco do Brejão','Marsilac','Rua Teodoro Sampaio',13,77,'murielbregesk@gmail.com'),(364793066,'Clarisse Villares','Solteiro(a)',1,'1971-03-04',' 6405-2679','21796953','MT','Matupá','Jardim Paulista','Avenida João XXIII',267,98,'clarissevillares@gmail.com'),(57905062830,'Raul Joensdatter','Solteiro(a)',1,'1989-11-29',' 8570-2838','85173644','SC','Uruará','Perdizes','Avenida Rio Branco',241,55,'rauljoensdatter@gmail.com'),(45316901410,'Mariana Ambrozim','Solteiro(a)',1,'1968-09-25',' 3343-1998','16203233','RO','Cuité','Morumbi','Rua 25 de Março',18,29,'marianaambrozim@gmail.com'),(32711854256,'Enzo Cavalcanti','Solteiro(a)',0,'1979-06-21',' 2645-5199','97906519','AL','Pontalina','Raposo Tavares','Avenida dos Bandeirantes ',271,35,'enzocavalcanti@gmail.com'),(98941098025,'Jonas Pilati','Solteiro(a)',1,'1997-09-19',' 2538-1827','89576526','SC','Água Azul do Norte','Água Rasa','Avenida 9 de Julho',170,45,'jonaspilati@gmail.com'),(11344611435,'Tomás Zanchetta','Viúvo(a)',1,'2003-05-18',' 0235-2874','68175906','AP','Salgadinho','Lapa','Rua Conselheiro Furtado',288,39,'tomaszanchetta@gmail.com'),(87147552113,'Afonso Bitencourt','Viúvo(a)',0,'1922-08-07',' 01447-0630','11098198','MT','Agrestina','Cidade Ademar','Rua Pedroso Alvarenga',25,48,'afonsobitencourt@gmail.com'),(93776063220,'Carolina Peira','Solteiro(a)',1,'1927-06-19',' 52396-7715','91989653','MS','Jordânia','Itaim Bibi','Avenida Vereador Abel Ferreira',217,14,'carolinapeira@gmail.com'),(54021790004,'Cecília Conciani','Casado(a)',1,'1986-11-29',' 74243-3317','23864213','MT','Fortaleza do Tabocão','Bom Retiro','Rua Maranhão',45,41,'ceciliaconciani@gmail.com'),(98310402015,'Alexander Rubens','Solteiro(a)',1,'1958-07-08',' 4781-8071','48752562','AC','Trajano de Morais','Itaim Bibi','Avenida Santa Marina',287,14,'alexanderrubens@gmail.com'),(83514192146,'Isis da Camara','Solteiro(a)',1,'1951-12-02',' 1050-3335','22676177','SE','Montes Claros','Limão','Avenida do Oratório',154,68,'isisdacamara@gmail.com'),(29035094840,'Clara Moura','Viúvo(a)',1,'1935-11-10',' 8099-4246','18966600','SC','Maracaju','Guaianases','Avenida Brigadeiro Faria Lima',160,97,'claramoura@gmail.com'),(60941347885,'Diogo Araújo','Separado(a)',0,'1955-10-18',' 82990-7332','32268221','BA','Santópolis do Aguapeí','Pedreira','Avenida dos Bandeirantes',287,39,'diogoaraujo@gmail.com'),(4527619306,'Artur Piazzarollo','Solteiro(a)',0,'1964-12-13',' 45626-0139','43453739','CE','Catende','Vila Medeiros','Rua Três Rios',98,73,'arturpiazzarollo@gmail.com'),(42835822631,'Álvaro Romão','Separado(a)',1,'1992-06-05',' 4924-8494','32652740','PB','Arraial','Anhangüera','Rua Tuiuti',102,40,'alvaroromao@gmail.com'),(65282579812,'Bianca Christ','Divorciado(a)',0,'1996-09-16',' 0664-2614','64586247','AP','Trindade do Sul','Raposo Tavares','Avenida Engenheiro Luís Carlos Berrini',19,76,'biancachrist@gmail.com'),(81942804008,'Sophia do Espírito Santo','Separado(a)',1,'1983-01-04',' 40458-7987','79709117','DF','Cananéia','Itaim Paulista','Avenida Professor Francisco Morato',276,79,'sophiadoespiritosanto@gmail.com'),(95746044202,'Alícia Mathiello','Divorciado(a)',0,'1980-06-27',' 5915-2835','87318605','PA','Ipecaetá','Liberdade','Avenida Senador Teotônio Vilela',117,65,'aliciamathiello@gmail.com'),(96667322030,'Levi Thiago','Separado(a)',1,'1981-10-15',' 3508-6214','18926153','MT','Aracaju','Cidade Tiradentes','Avenida Salim Farah Maluf',119,77,'levithiago@gmail.com'),(13920353846,'Cristiano Scarcinelli','Separado(a)',0,'1989-11-24',' 8673-0555','78809755','ES','Iguaraçu','Cidade Líder','Ruas de comércio especializado da cidade de São Paulo',54,22,'cristianoscarcinelli@gmail.com'),(96303624812,'Júlio Campos','Casado(a)',1,'1953-07-23',' 1847-0177','33220318','PB','Teresina','Vila Maria','Rua da Consolação',88,52,'juliocampos@gmail.com'),(54363183470,'Kevin Muraro','Divorciado(a)',0,'1990-09-24',' 54992-4243','77022416','MA','Barão de Monte Alto','São Rafael','Rua do Ouvidor',170,79,'kevinmuraro@gmail.com'),(25887839538,'Aurora Lorençon','Separado(a)',0,'1981-08-02',' 67372-5149','37859606','RO','São José do Herval','Jabaquara','Avenida da Liberdade',104,51,'auroralorencon@gmail.com'),(52532234440,'Davi Busetti','Casado(a)',0,'1957-08-14',' 0816-1885','99508305','RJ','Pontão','Jardim Ângela','Avenida das Juntas Provisórias',195,66,'davibusetti@gmail.com'),(99398575272,'Pietro Guidini','Solteiro(a)',0,'1923-06-16',' 54104-4352','28981377','PA','Pedra Branca','Grajaú','Rua Galvão Bueno',184,9,'pietroguidini@gmail.com'),(5566953727,'Emanuelle Almeida','Viúvo(a)',0,'1962-05-24',' 6154-9426','95119610','TO','Dobrada','Jardim Paulista','Avenida Professor Luis Inácio de Anhaia Melo',20,58,'emanuellealmeida@gmail.com'),(3430711509,'Francisco Evarti','Casado(a)',1,'1995-01-31',' 3531-3030','82620509','MA','Lagoa Nova','Jaguaré','Rua 15 de Novembro',232,86,'franciscoevarti@gmail.com'),(20873560841,'Ricardo Matielo','Viúvo(a)',1,'1984-07-20',' 82273-9695','87895294','SE','Santo Inácio','Limão','Avenida Luís Dumont Vilares',109,37,'ricardomatielo@gmail.com'),(67623427105,'Jorge Bonicenha','Divorciado(a)',0,'1982-11-30',' 1495-9101','28984979','CE','Nova Bandeirantes','Santo Amaro','Avenida Interlagos',275,79,'jorgebonicenha@gmail.com'),(90659644606,'Diego Zocatelli','Separado(a)',0,'1940-10-07',' 6074-3960','94852391','DF','Resende','Vila Guilherme','Veridiana da Silva Prado',118,71,'diegozocatelli@gmail.com'),(81021127949,'Mariana Pin','Separado(a)',0,'1924-09-28',' 14774-7531','55763232','GO','Nova Módica','Butantã','Avenida 23 de Maio ',71,51,'marianapin@gmail.com'),(77389542993,'Davi de Lima','Solteiro(a)',1,'1926-06-27',' 46414-7000','48755198','AL','Tabaporã','Cambuci','Avenida Senador Teotônio Vilela',62,48,'davidelima@gmail.com'),(34313544402,'Agatha Destéfani','Separado(a)',0,'1959-04-30',' 8694-0992','74647457','SP','Araruna','Perdizes','Avenida Cidade Jardim',135,57,'agathadestefani@gmail.com'),(90389664588,'Murilo Pontara','Solteiro(a)',0,'1951-08-08',' 4064-0425','96542209','PA','São José de Piranhas','Ponte Rasa','Avenida Doutor Enéas Carvalho de Aguiar',97,55,'murilopontara@gmail.com'),(59448025530,'Fernanda De Osti','Separado(a)',0,'1954-03-18',' 07560-9801','47595353','MS','Carmo do Rio Claro ','Cidade Dutra','Rua Oscar Freire',106,87,'fernandadeosti@gmail.com'),(79518559872,'Octávio Passos','Viúvo(a)',0,'1958-02-03',' 45908-2949','48375761','ES','Valença','Parque do Carmo','Avenida Presidente João Goulart',152,27,'octaviopassos@gmail.com'),(26080581914,'Alan Fregolent','Viúvo(a)',1,'1931-08-04',' 91750-0453','67709174','PB','Bom Princípio do Piauí','Socorro','Avenida Marquês de São Vicente',25,23,'alanfregolent@gmail.com'),(24682635450,'Thiago Schael','Solteiro(a)',0,'1994-01-28',' 2303-6865','77436264','RJ','São Bento','Jardim São Luís','Avenida das Juntas Provisórias',165,16,'thiagoschael@gmail.com'),(1714718220,'Manuela Zanol','Casado(a)',1,'1996-08-24',' 7745-0249','46821667','RJ','Divina Pastora','Parque do Carmo','Ruas de comércio especializado da cidade de São Paulo',188,77,'manuelazanol@gmail.com'),(68682153556,'Bryan Bragagnolo','Viúvo(a)',1,'1945-11-21',' 86256-4332','27649957','SE','Vertente do Lério','Vila Maria','Avenida Itaquera',30,56,'bryanbragagnolo@gmail.com'),(96188904650,'Raquel Fornazier','Divorciado(a)',1,'1933-08-08',' 52785-5192','72634705','AL','Virgolândia','Cidade Dutra','Rua Augusta',286,37,'raquelfornazier@gmail.com'),(64835994396,'Vinicius Sa','Solteiro(a)',1,'1936-02-19',' 8967-2410','44501255','MA','Alagoinha','Água Rasa','Avenida Doutor Ricardo Jafet',7,51,'viniciussa@gmail.com'),(44014290603,'Jade de Marchi','Solteiro(a)',0,'1930-03-18',' 83693-1735','68928345','PA','Presidente Médici','Cidade Dutra','Rua Teodoro Sampaio',268,90,'jadedemarchi@gmail.com'),(17708584230,'Martim do Amparo','Casado(a)',0,'1990-09-07',' 9547-0726','62630432','MA','Capão Bonito do Sul','Vila Medeiros','Avenida Angélica',143,75,'martimdoamparo@gmail.com'),(39475689591,'Alexander Botti','Divorciado(a)',0,'1946-06-05',' 4763-1875','84772557','PE','Itanhém','Saúde','Rua Doutor Antônio Bento',231,29,'alexanderbotti@gmail.com'),(73361774330,'Gustavo Tessinari','Solteiro(a)',1,'1933-12-29',' 76648-8148','39695995','RS','Jitaúna','Morumbi','Avenida Brasil',184,62,'gustavotessinari@gmail.com'),(85274634745,'Beatriz Cansi','Divorciado(a)',0,'1939-05-10',' 2785-2557','58876734','PE','Águas Formosas','Vila Prudente','Rua Vergueiro',146,61,'beatrizcansi@gmail.com'),(68953481589,'Maria Baldotto','Divorciado(a)',1,'1935-01-10',' 7216-1133','94574966','MS','Arame','Cidade Ademar','Avenida Brigadeiro Luís Antônio',77,4,'mariabaldotto@gmail.com'),(60746306822,'Paulo Taylor','Casado(a)',1,'1990-09-17',' 62300-8886','23492293','MG','Águas de Santa Bárbara','José Bonifácio','Rua José Paulino',49,97,'paulotaylor@gmail.com'),(78457619403,'Nicolas Moraes','Divorciado(a)',0,'1988-02-06',' 3835-0046','19203313','BA','Salto do Lontra','Iguatemi','Rua Paulistânia',123,3,'nicolasmoraes@gmail.com'),(26819739532,'Diego Freire','Divorciado(a)',0,'1948-04-08',' 7170-7076','55804716','PE','Timburi','Sé','Avenida Higienópolis',268,34,'diegofreire@gmail.com'),(97439730950,'Laís Partelli','Viúvo(a)',0,'1942-09-20',' 7956-1467','52790465','SE','Armação de Búzios','São Miguel Paulista','Ruas de comércio especializado da cidade de São Paulo',221,35,'laispartelli@gmail.com'),(17645947462,'Melissa Alvez','Divorciado(a)',0,'1979-05-21',' 6919-8510','47208539','SC','Cerro Corá','Campo Belo','Ligação Leste-Oeste',218,52,'melissaalvez@gmail.com'),(3198488176,'Valentina Molinaroli','Casado(a)',1,'1942-05-08',' 0787-4071','43689531','PI','Goiabeira','República','Estrada Turística do Jaraguá',220,99,'valentinamolinaroli@gmail.com'),(11425163009,'Gustavo Christophersen','Casado(a)',0,'1948-11-03',' 8126-7200','95764335','CE','Saúde','Mandaqui','Rua Haddock Lobo',181,65,'gustavochristophersen@gmail.com'),(47324887228,'Benjamin Dall\'ava','Separado(a)',1,'1971-02-14',' 1837-8577','62518434','MG','Rifaina','Vila Matilde','Avenida Doutor Chucri Zaidan',81,78,'benjamindallava@gmail.com'),(3593172607,'Victor Luis','Casado(a)',0,'1924-08-25',' 34044-0437','23645753','PA','São Félix do Tocantins','Saúde','Rua Maria Antônia',6,51,'victorluis@gmail.com'),(74651112692,'Raquel Onhas','Divorciado(a)',0,'1930-02-20',' 0117-4683','42943321','PI','Lucélia','Vila Curuçá','Rua Vergueiro',258,64,'raquelonhas@gmail.com'),(7861925005,'Maria Pedrazini','Divorciado(a)',1,'1988-12-06',' 8201-8613','34435107','MT','Conchas','República','Ladeira Porto Geral',226,36,'mariapedrazini@gmail.com'),(22572592207,'Davi Sancao','Viúvo(a)',1,'1996-07-22',' 2769-2036','15999717','MG','Tabaí','São Domingos','Avenida Cidade Jardim',178,53,'davisancao@gmail.com'),(15465538600,'Júlio Guimarães','Separado(a)',0,'1993-05-20',' 47232-1629','92776591','ES','Dom Pedro de Alcântara','Cangaíba','Avenida Prestes Maia',54,55,'julioguimaraes@gmail.com'),(41046973622,'Yuri Tassinari','Solteiro(a)',0,'1976-12-24',' 6305-1846','27655315','TO','Santa Terezinha de Itaipu','Aricanduva','Avenida Santa Marina',34,48,'yuritassinari@gmail.com'),(1250648610,'Alice de Martin','Divorciado(a)',0,'1981-06-21',' 28409-7303','92050322','PB','Penaforte','Pari','Avenida Professor Francisco Morato',10,45,'alicedemartin@gmail.com'),(46538800262,'Santiago Solda\'','Viúvo(a)',0,'1929-04-10',' 8554-4678','14225953','RS','Clevelândia','Raposo Tavares','Rua Peixoto Gomide',224,40,'santiagosolda@gmail.com'),(11481243810,'Ivan Cunshnir','Viúvo(a)',1,'1977-05-09',' 61056-4110','35323856','AP','Colares','Aricanduva','Rua Maria Antônia',226,87,'ivancunshnir@gmail.com'),(72788307535,'Pietro Francisqueto','Separado(a)',1,'1933-03-16',' 2003-6120','65581842','RJ','Murici','Campo Limpo','Avenida Santos Dumont',83,84,'pietrofrancisqueto@gmail.com'),(48996775452,'Frederico Azevedo','Solteiro(a)',1,'1974-06-20',' 87105-2059','49504134','RR','Mirante da Serra','Moema','Avenida Sumaré',235,80,'fredericoazevedo@gmail.com'),(8598182419,'Matheus Barbosa','Separado(a)',0,'1953-08-05',' 97826-3461','38710677','RO','Muaná','Itaquera','Ruas de comércio especializado da cidade de São Paulo',53,34,'matheusbarbosa@gmail.com'),(72076214690,'Lorena Fulaneti','Viúvo(a)',1,'1930-06-17',' 9555-3498','75725680','PB','Pirapetinga','Parelheiros','Rua Francisca Júlia',157,75,'lorenafulaneti@gmail.com'),(75091874860,'Santiago George','Solteiro(a)',1,'2001-02-18',' 8095-7116','62119263','MS','Trabiju','Tremembé','Rua Santa Ifigênia',44,69,'santiagogeorge@gmail.com'),(93551770468,'Yuri Thirine','Viúvo(a)',1,'1949-09-15',' 93019-9414','37299436','RO','Paulistana','Consolação','Avenida Doutor Arnaldo',271,16,'yurithirine@gmail.com'),(30304235229,'Guilherme Valiatti','Casado(a)',0,'1964-12-19',' 05706-9852','92278427','PR','Coluna','Sacomã','Rua do Orfanato',135,74,'guilhermevaliatti@gmail.com'),(79615086002,'Luana Conte','Solteiro(a)',1,'1922-05-24',' 87458-6541','27001958','TO','Riversul','Penha','Avenida Waldemar Carlos Pereira',163,98,'luanaconte@gmail.com'),(23427394786,'Júlio Burrows','Viúvo(a)',0,'1965-03-24',' 0966-5447','55643409','RR','Triunfo Potiguar','Vila Prudente','Rua Líbero Badaró',74,6,'julioburrows@gmail.com'),(65703055903,'Júlio Minette','Separado(a)',0,'1997-09-30',' 6195-6353','79943222','PE','Bocaina de Minas','Jardim São Luís','Rua Teodoro Sampaio',114,11,'juliominette@gmail.com'),(64471672819,'Giovanna Kuiger','Separado(a)',0,'1956-12-27',' 45082-2386','36795765','PI','Divinésia','Campo Limpo','Avenida Inajar de Souza',22,88,'giovannakuiger@gmail.com'),(737990252,'Elisa Botteon','Separado(a)',0,'1946-04-18',' 96667-6089','27160973','RS','Manoel Urbano','Carrão','Rua Vergueiro',154,9,'elisabotteon@gmail.com'),(12184002267,'Ricardo Cosme','Solteiro(a)',0,'1957-09-26',' 5640-4721','41901314','PI','Avanhandava','Cidade Tiradentes','Rua Maranhão',37,31,'ricardocosme@gmail.com'),(43496886099,'Manuela Zaia','Solteiro(a)',0,'1936-11-25',' 1900-3030','68819173','GO','Vila Nova dos Martírios','Tucuruvi','Avenida Atlântica',241,57,'manuelazaia@gmail.com'),(67226748940,'Mariana Venturini','Separado(a)',0,'1974-10-10',' 6776-6526','35893274','AC','Novo Progresso','Ipiranga','Veridiana da Silva Prado',201,56,'marianaventurini@gmail.com'),(18822853016,'Ivan Angelo','Casado(a)',0,'1972-11-16',' 7942-4659','28103822','AC','Janiópolis','Cidade Dutra','Ligação Leste-Oeste',97,14,'ivanangelo@gmail.com'),(32571287893,'Aarã Kolberg','Casado(a)',0,'1946-10-15',' 0405-9965','11429942','PI','São João de Pirabas','Guaianases','Avenida Paes de Barros',119,72,'aarakolberg@gmail.com'),(63870575743,'Manuela Sangalli','Casado(a)',1,'1971-01-24',' 5904-4904','32609960','AM','Serra de São Bento','Cursino','Rua Doutor Antônio Bento',173,69,'manuelasangalli@gmail.com'),(82899672258,'Beatriz Prieto Garcia','Solteiro(a)',1,'1974-09-10',' 3582-7243','92054321','BA','Retirolândia','Itaquera','Marginal Tietê',104,53,'beatrizprietogarcia@gmail.com'),(26886583603,'Aarã Alves','Separado(a)',1,'1977-12-26',' 5169-0112','69736486','MA','Jucati','Parelheiros','Complexo Viário Jacu Pêssego',153,10,'aaraalves@gmail.com'),(91872231209,'Beatriz Netto ','Separado(a)',1,'1999-09-18',' 5416-1907','46413906','AL','Águas Vermelhas','Sapopemba','Rua Conselheiro Moreira de Barros',111,38,'beatriznetto@gmail.com'),(19867987047,'Daniela Pires','Viúvo(a)',0,'1971-08-26',' 64044-2660','47178354','PI','Damião','Pirituba','Avenida Higienópolis',94,5,'danielapires@gmail.com'),(57628641709,'Henrique Hostey','Solteiro(a)',1,'1921-06-26',' 5624-3937','53489607','DF','Douradina','Jaguaré','Avenida Engenheiro Luís Carlos Berrini',150,24,'henriquehostey@gmail.com'),(25307761643,'Mariana Christophersen','Separado(a)',1,'1978-02-05',' 9808-5594','28690437','AM','Maracajá','Saúde','Avenida Rebouças',203,10,'marianachristophersen@gmail.com'),(78041888623,'Benjamin Tomasi','Divorciado(a)',1,'1981-10-20',' 1035-9969','99985180','AC','Dores do Turvo','Vila Sônia','Rua Barão de Itapetininga',139,48,'benjamintomasi@gmail.com'),(95803358347,'Joaquim Scott','Divorciado(a)',1,'1951-03-24',' 4657-4199','68472743','RR','Alto Bela Vista','Parelheiros','Rua Tuiuti',250,70,'joaquimscott@gmail.com'),(20986784605,'Nicolas Bossoli','Separado(a)',0,'1959-05-22',' 4536-3047','56037817','RR','Matupá','Pari','Estrada Turística do Jaraguá',109,53,'nicolasbossoli@gmail.com'),(58526741098,'João Santos','Solteiro(a)',0,'1963-10-29',' 3323-6019','64116236','AC','Dois Córregos','Capão Redondo','Avenida Brigadeiro Faria Lima',134,79,'joaosantos@gmail.com'),(43280277604,'Danilo Gargan','Solteiro(a)',0,'1967-12-20',' 20429-3997','89422109','RS','Rodelas','Cangaíba','Rua Capitão Manuel Novais',170,75,'danilogargan@gmail.com'),(71097518051,'Camila Pacheca','Viúvo(a)',1,'1951-07-25',' 0656-8273','94255923','AC','Boa Nova','Mandaqui','Avenida Cidade Jardim',196,47,'camilapacheca@gmail.com'),(88376250493,'Rodrigo Ferrighetto ','Casado(a)',1,'1922-02-10',' 0105-6076','11706887','PA','Pedra do Anta','Vila Maria','Avenida Professor Luis Inácio de Anhaia Melo',112,29,'rodrigoferrighetto@gmail.com'),(8476452748,'Kevin Tozzi','Separado(a)',0,'1955-06-29',' 3344-6229','37432180','AC','Cândido Godói','Jardim Helena','Avenida Vereador Abel Ferreira',270,9,'kevintozzi@gmail.com'),(68774455540,'Diogo Fornazier','Casado(a)',1,'1963-11-26',' 18920-3079','53157248','RO','Lambari','Vila Guilherme','Rua da Mooca',140,67,'diogofornazier@gmail.com'),(97105293748,'Cristiano Lanes','Solteiro(a)',1,'2003-01-07',' 69443-3935','89174528','SE','Relvado','Cidade Dutra','Avenida João XXIII',35,48,'cristianolanes@gmail.com'),(36419357250,'Mariana Trabach','Separado(a)',0,'1975-09-18',' 01522-7457','51707786','PI','Queimadas','Itaim Paulista','Avenida Pompeia',21,83,'marianatrabach@gmail.com'),(79427301406,'Ana Donato','Casado(a)',0,'1931-04-28',' 7115-7954','52411884','GO','Turvo','Santana','Rua da Mooca',124,43,'anadonato@gmail.com'),(94966055679,'Danilo Lorenzini','Viúvo(a)',1,'1938-07-03',' 61579-8178','77550356','AC','Mutunópolis','Itaquera','Rua Conselheiro Moreira de Barros',60,57,'danilolorenzini@gmail.com'),(50688853552,'João Donald','Solteiro(a)',1,'1922-06-06',' 6717-8368','35358720','AP','Inhapi','República','Rua Estados Unidos',169,53,'joaodonald@gmail.com'),(50779316312,'Bruno Berard Lepine','Casado(a)',1,'1938-09-13',' 5565-2008','95637880','SC','Cajazeirinhas','Vila Leopoldina','Rua João Cachoeira',214,48,'brunoberardlepine@gmail.com'),(88727447766,'Theo Jordão','Casado(a)',1,'1939-03-22',' 9404 - 3509','87682103','RR','Vale do Anari','Pinheiros','Avenida Sumaré',119,8,'theojordao@gmail.com'),(95377504348,'Lívia Toneto','Viúvo(a)',0,'2000-04-23',' 14560-6680','13474233','PB','Bertópolis','Iguatemi','Avenida Prof. Abraão de Morais',19,5,'liviatoneto@gmail.com'),(59991183280,'Sarah Vitorazzi','Divorciado(a)',0,'1961-07-31',' 9558-0765','61747844','SC','Rifaina','Jabaquara','Avenida Luís Dumont Vilares',203,83,'sarahvitorazzi@gmail.com'),(52396548832,'Daniela Vereza','Casado(a)',0,'1947-07-07',' 5456-0835','75499268','RR','Guiratinga','Capão Redondo','Complexo Viário Jacu Pêssego',4,68,'danielavereza@gmail.com'),(74368936612,'Henrique de Almada','Separado(a)',1,'1969-12-22',' 6076-4931','94967864','RJ','Cravolândia','Lajeado','Rua 15 de Novembro',288,41,'henriquedealmada@gmail.com'),(71203415885,'Sofia Bortolini','Separado(a)',0,'1982-01-10',' 0132-2580','11765229','MS','Ipaumirim','Tremembé','Rua Turiaçu',61,83,'sofiabortolini@gmail.com'),(55660804136,'Pablo Mascarelo','Viúvo(a)',1,'1944-11-25',' 89850-1571','89458323','MA','Maracás','Santo Amaro','Rua São Bento',13,9,'pablomascarelo@gmail.com'),(59017731281,'João Zampiroli','Separado(a)',1,'1969-08-21',' 74194-0042','61747516','PB','Manoel Ribas','José Bonifácio','Rua Direita',168,75,'joaozampiroli@gmail.com'),(45719916067,'Ariela Lovatti','Separado(a)',0,'1952-10-03',' 1741-1997','69237476','RO','Axixá','Vila Prudente','Alameda Ministro Rocha Azevedo',248,15,'arielalovatti@gmail.com'),(39901584574,'Diogo Rodrigues','Casado(a)',0,'1994-04-15',' 01096-8974','14929580','PA','Jucuruçu','Cursino','Rua Francisca Júlia',81,27,'diogorodrigues@gmail.com'),(32561192474,'Milene Francisqueti','Separado(a)',0,'1953-06-24',' 3058-9638','13267153','MT','Santana do Maranhão','Barra Funda','Rua Estados Unidos',254,62,'milenefrancisqueti@gmail.com'),(45260805356,'Lis Chapiniti','Casado(a)',0,'1927-12-03',' 04695-1694','95410379','RJ','Sebastianópolis do Sul','Bela Vista','Rua Pedroso Alvarenga',257,52,'lischapiniti@gmail.com'),(65109676186,'Julia Rivero','Viúvo(a)',0,'1923-07-07',' 3828-4898','66633295','TO','São Lourenço do Oeste','Casa Verde','Rua Doutor César',264,65,'juliarivero@gmail.com'),(88832309815,'Carlos Salles','Solteiro(a)',0,'1952-03-02',' 86779-9866','88164619','DF','Serra Alta','Jaguaré','Avenida Pompeia',227,87,'carlossalles@gmail.com'),(71989485022,'Isadora Zanellato','Separado(a)',1,'1923-11-15',' 6956-4000','73127423','ES','Umari','Mooca','Avenida Prof. Abraão de Morais',140,4,'isadorazanellato@gmail.com'),(75067939702,'Otávio Moura Filho','Viúvo(a)',0,'1954-10-21',' 6284-5005','72763276','RJ','Nova Mamoré','Bela Vista','Rua Frei Caneca',254,85,'otaviomourafilho@gmail.com'),(28122239102,'Pamela Volpato','Solteiro(a)',1,'1987-10-18',' 1421-0603','38358359','AM','Imbaú','Santo Amaro','Avenida Itaquera',9,33,'pamelavolpato@gmail.com'),(58155378705,'Rodrigo Olausen','Casado(a)',0,'1956-08-17',' 04062-0733','43619565','PB','Itambé','Água Rasa','Avenida João XXIII',144,90,'rodrigoolausen@gmail.com'),(91036258696,'Ramom Falqueto','Casado(a)',1,'1989-11-27',' 1474-6403','39419774','RO','Triunfo','Ponte Rasa','Rua José Paulino',163,62,'ramomfalqueto@gmail.com'),(75031099046,'Isadora Feitoza','Viúvo(a)',1,'1992-04-25',' 4945-3333','31409365','MT','Ibiaí','Itaim Paulista','Avenida Giovanni Gronchi',278,80,'isadorafeitoza@gmail.com'),(32544925019,'Clara Dalla Marta','Divorciado(a)',1,'1925-10-14',' 7515-3416','99705358','PE','Confins','Artur Alvim','Avenida João XXIII',205,84,'claradallamarta@gmail.com'),(80503609200,'Heloísa Antunes','Viúvo(a)',0,'1994-03-23',' 13083-9057','99320253','RS','Santo Antônio de Goiás','Santa Cecília','Avenida Luís Dumont Vilares',175,95,'heloisaantunes@gmail.com'),(7937549173,'Nicole Akechi','Viúvo(a)',0,'1936-11-23',' 93413-6243','57341463','AC','Itirapina','Rio Pequeno','Avenida Prof. Abraão de Morais ',81,7,'nicoleakechi@gmail.com'),(22699221740,'Bruno Mascarelo','Separado(a)',1,'1961-02-17',' 9433-5464','87090837','BA','Seringueiras','Aricanduva','Avenida Higienópolis',216,15,'brunomascarelo@gmail.com'),(1589288734,'Álvaro Berger','Solteiro(a)',0,'1933-08-13',' 1123-5235','59456711','BA','Rio do Antônio','Itaim Paulista','Rua Frei Caneca',38,41,'alvaroberger@gmail.com'),(69152157946,'Renan Lessa','Casado(a)',1,'1943-10-26',' 0747-4212','17782553','CE','Santa Efigênia de Minas','Cidade Tiradentes','Avenida Cidade Jardim',196,60,'renanlessa@gmail.com'),(45646445990,'Benjamin Francisca','Viúvo(a)',0,'1934-09-23',' 0235-3475','17085942','PR','Tocantins','Mandaqui','Avenida Brigadeiro Luís Antônio',246,1,'benjaminfrancisca@gmail.com'),(19423082130,'Lorena Faccitin','Separado(a)',1,'1971-01-18',' 64184-6127','37306799','CE','Buritis','Tremembé','Avenida Sapopemba',70,49,'lorenafaccitin@gmail.com'),(53059492549,'Lívia Monteiro','Divorciado(a)',1,'1950-06-10',' 4318-8148','24436114','CE','Mineiros','Limão','Avenida Doutor João Guimarães',278,38,'liviamonteiro@gmail.com'),(73709938848,'Manuela dos Santos','Separado(a)',1,'1971-01-24',' 7350-2621','69838217','GO','Foz do Jordão','Aricanduva','Avenida Prof. Abraão de Morais',243,9,'manueladossantos@gmail.com'),(6696400699,'Vinicios Milanezi','Viúvo(a)',0,'1997-02-06',' 98051-4043','39758704','PI','Cândido Mendes','Sé','Avenida Giovanni Gronchi',117,9,'viniciosmilanezi@gmail.com'),(13856670017,'Bárbara Leite','Casado(a)',1,'1968-05-31',' 3086-6808','95856915','RS','Pontes Gestal','São Domingos','Rua Direita',217,26,'barbaraleite@gmail.com'),(76797441900,'Paloma Andersen','Casado(a)',0,'1972-09-17',' 5834-2210','35335676','BA','Jussara','Parelheiros','Avenida Doutor Chucri Zaidan',64,8,'palomaandersen@gmail.com'),(83011250391,'Sarah Fasoli','Solteiro(a)',0,'1952-06-18',' 9366-1277','45485274','TO','Alagoinha','Moema','Avenida Vereador Abel Ferreira',271,47,'sarahfasoli@gmail.com'),(90511268750,'Nicole Hoffmann','Separado(a)',1,'1940-01-01',' 1088-8027','42891294','MG','Marilândia do Sul','Carrão','Avenida Morumbi',72,49,'nicolehoffmann@gmail.com'),(27797849544,'Davi Thirine','Solteiro(a)',1,'1985-06-21',' 14717-9434','38793489','AM','Ituporanga','Vila Sônia','Avenida Cidade Jardim',170,11,'davithirine@gmail.com'),(56795159540,'Maria Mathiello','Viúvo(a)',0,'2001-10-18',' 4915-3525','85654153','BA','Parobé','Jaguara','Avenida Guapira',124,88,'mariamathiello@gmail.com'),(81781167400,'Raquel Rossi','Casado(a)',0,'1968-07-15',' 4973-9220','43635449','RJ','Viana','Jaraguá','Rua Cardeal Arcoverde',216,5,'raquelrossi@gmail.com'),(22908536749,'Lucas Breda','Separado(a)',1,'1967-06-01',' 1329-3343','75416692','AL','Monte Aprazível','Água Rasa','Alameda Ministro Rocha Azevedo',176,81,'lucasbreda@gmail.com'),(28760833530,'Julia Nielson','Separado(a)',0,'1922-06-23',' 01307-1019','98405959','DF','Orós','São Rafael','Rua Bela Cintra',156,57,'julianielson@gmail.com'),(36536612264,'Valentina di Boscarato','Solteiro(a)',1,'1946-09-30',' 39634-7507','55296649','BA','São Paulo do Potengi','Perdizes','Avenida Doutor João Guimarães',289,77,'valentinadiboscarato@gmail.com'),(40579108325,'Débora Silva','Viúvo(a)',0,'1975-08-22',' 87707-9662','11003541','RS','Três Pontas','Jabaquara','Avenida Brasil',29,87,'deborasilva@gmail.com'),(17578761463,'Kelvin Josefa','Casado(a)',1,'1998-01-29',' 3992-9487','18892282','RS','Santana do Deserto','Capão Redondo','Avenida Brigadeiro Luís Antônio',124,4,'kelvinjosefa@gmail.com'),(9092362670,'Francisco Gonçalves','Solteiro(a)',1,'1960-02-28',' 4777-4569','26967274','SC','Japurá','Morumbi','Avenida Prestes Maia',233,96,'franciscogoncalves@gmail.com'),(55184680756,'Heitor Bianco','Viúvo(a)',1,'1939-05-04',' 2693-9008','23875367','SC','Ibiapina','Butantã','Avenida Doutor João Guimarães',235,93,'heitorbianco@gmail.com'),(82275369724,'Sabrina Hoffmann','Casado(a)',1,'1968-04-25',' 1355-5614','43586508','PB','Ipiguá','Sé','Rua Maria Antônia',43,7,'sabrinahoffmann@gmail.com'),(41236579585,'Valentim Bortoloti','Solteiro(a)',1,'1989-11-22',' 3971-7422','15131127','RO','São José do Egito','Rio Pequeno','Avenida Rubem Berta',204,83,'valentimbortoloti@gmail.com'),(13394207249,'Lia Pêgas','Casado(a)',0,'1931-06-02',' 2899-7789','49100311','MA','Andradina','Cachoeirinha','Avenida Inajar de Souza',64,10,'liapegas@gmail.com'),(82496974302,'André Olsdatter','Viúvo(a)',1,'1998-09-24',' 83503-9019','65910940','RN','Ivaí','Capão Redondo','Avenida Vereador Abel Ferreira',4,19,'andreolsdatter@gmail.com'),(58945523464,'Ariela Riguetto','Divorciado(a)',0,'1927-01-03',' 60840-4095','66360727','TO','Corumbá de Goiás','Butantã','Avenida Marquês de São Vicente',164,65,'arielariguetto@gmail.com'),(92187426718,'Beatriz Buffo','Solteiro(a)',1,'1939-07-17',' 17625-0857','88273889','PE','Pedreira','Morumbi','Avenida Renata',252,84,'beatrizbuffo@gmail.com'),(7791511517,'Pedro Cansi','Divorciado(a)',0,'1985-12-19',' 64681-5933','92584844','MT','Echaporã','Itaim Bibi','Avenida da Liberdade',57,29,'pedrocansi@gmail.com'),(57764822167,'Caio Molinaroli','Viúvo(a)',0,'1977-03-08',' 0373-2032','28665910','PE','Carmo do Rio Verde','Vila Jacuí','Rua Cardeal Arcoverde',209,63,'caiomolinaroli@gmail.com'),(24138815902,'Diego Canal','Divorciado(a)',1,'1980-08-14',' 3409-5084','37521461','RR','Mateus Leme','Cidade Dutra','Rua Santa Ifigênia',19,51,'diegocanal@gmail.com'),(13671282002,'Henrique Pontara','Viúvo(a)',1,'1994-12-09',' 2898-9244','19832416','ES','Santo Antônio do Tauá','São Miguel Paulista','Avenida Rio Branco',200,58,'henriquepontara@gmail.com'),(329284240,'Bianca Botti','Separado(a)',1,'1941-02-16',' 91119-8857','73796164','TO','Xaxim','Sé','Rua João Cachoeira',208,79,'biancabotti@gmail.com'),(48831860755,'Bianca Cei','Separado(a)',1,'1932-01-19',' 9230-7369','13659481','PB','Passo de Torres','Limão','Rua Padre João Manuel',83,63,'biancacei@gmail.com'),(15466993255,'Adriano Lima','Viúvo(a)',0,'1992-03-04',' 62798-2174','21913840','AL','Monte Belo do Sul','Morumbi','Avenida Rubem Berta',219,37,'adrianolima@gmail.com'),(8416305692,'Lara Soave','Separado(a)',1,'1979-07-30',' 7490-8889','23578122','AM','Mallet','Jardim São Luís','Avenida Engenheiro Luís Carlos Berrini',137,80,'larasoave@gmail.com'),(37523394620,'Alexandre Luis','Solteiro(a)',0,'1965-05-18',' 3991-8737','14539529','PB','Lambari','Alto de Pinheiros','Rua Líbero Badaró',224,99,'alexandreluis@gmail.com'),(36644644198,'Joaquim Albernaz','Separado(a)',1,'1980-09-13',' 4888-1942','88351606','RJ','Oliveira Fortes','Itaquera','Avenida Doutor Chucri Zaidan',181,86,'joaquimalbernaz@gmail.com'),(61066925801,'Patrícia Fávero','Divorciado(a)',0,'2003-01-31',' 7175-9637','82637212','PR','Tibau do Sul','Santana','Radial Leste',280,76,'patriciafavero@gmail.com'),(88416650926,'Marcelo Vekar','Solteiro(a)',0,'1962-08-22',' 2867-4245','22388159','RR','Fruta de Leite','Brasilândia','Ladeira Porto Geral',192,58,'marcelovekar@gmail.com'),(25216530126,'Santiago Cardoso','Solteiro(a)',1,'1993-12-26',' 9133-9329','33148113','SC','Vila Boa','Sapopemba','Rua Três Rios',36,93,'santiagocardoso@gmail.com'),(94666735640,'Elisa Andrião','Viúvo(a)',0,'1940-05-15',' 2505-6472','56143336','MT','São José da Vitória','Cidade Dutra','Avenida Jornalista Roberto Marinho',201,70,'elisaandriao@gmail.com'),(32420488490,'Marco Oliveira','Separado(a)',0,'1957-02-18',' 6271-1520','67523463','MS','Toledo','Vila Leopoldina','Veridiana da Silva Prado',37,19,'marcooliveira@gmail.com'),(80777506645,'Leticia Barbosa','Solteiro(a)',1,'1984-02-26',' 06924-9308','19591770','TO','Rubiataba','Ermelino Matarazzo','Rua Líbero Badaró',48,11,'leticiabarbosa@gmail.com'),(30045277079,'João Falquetto','Casado(a)',1,'2002-02-06',' 38583-4069','41324727','SP','Santa Helena','Tremembé','Veridiana da Silva Prado',12,48,'joaofalquetto@gmail.com'),(42744337307,'Augusto Gago','Casado(a)',1,'1966-01-27',' 42673-3471','13074212','PE','Goianira','Lapa','Rua João Cachoeira',88,64,'augustogago@gmail.com'),(49679103781,'Lorenzo Gabriel','Separado(a)',1,'2001-11-01',' 54056-3054','17510815','RS','Extremoz','Vila Sônia','Avenida Santos Dumont',235,3,'lorenzogabriel@gmail.com'),(10906781345,'Leonardo Stebenne','Solteiro(a)',0,'1966-08-06',' 3707-6898','21955566','BA','Serra do Navio','Raposo Tavares','Avenida das Juntas Provisórias',36,21,'leonardostebenne@gmail.com'),(39034982467,'Alana Firme','Solteiro(a)',1,'1987-01-22',' 6097-2586','26408703','AL','Pedras Altas','Campo Grande','Rua Sete de Abril',20,80,'alanafirme@gmail.com'),(20909274290,'Isabelly Zandonadi','Casado(a)',0,'1979-11-24',' 0404-1591','22231728','RS','Conceição do Rio Verde','Sacomã','Rua Augusta',118,23,'isabellyzandonadi@gmail.com'),(95471657802,'Isabelly Almeida','Casado(a)',0,'1949-03-30',' 8877-0785','66153212','AL','Carmo do Cajuru','Raposo Tavares','Ruas de comércio especializado da cidade de São Paulo',254,30,'isabellyalmeida@gmail.com'),(67866307318,'Samuel Brum','Divorciado(a)',1,'1964-08-29',' 1621-5364','93131428','MG','Piracicaba','Cidade Líder','Rua Pedro Doll',171,60,'samuelbrum@gmail.com'),(63389803211,'Rafael Justi','Solteiro(a)',0,'2002-01-07',' 48576-2702','56322951','PA','Caraíbas','Santa Cecília','Rua Sete de Abril',248,84,'rafaeljusti@gmail.com'),(57406880197,'Leonardo Simoes','Solteiro(a)',1,'1962-07-23',' 9856-1438','98878821','DF','Nova Olímpia','Vila Guilherme','Avenida Itaquera',82,13,'leonardosimoes@gmail.com'),(10727181033,'Amanda Maida','Separado(a)',1,'1953-03-05',' 73516-3700','31768621','SC','Laranjal Paulista','Vila Leopoldina','Rua Francisca Júlia',230,97,'amandamaida@gmail.com'),(36508069241,'Bruna Pachequa','Viúvo(a)',1,'1983-11-24',' 0325-5121','88677945','ES','Medeiros Neto','Tremembé','Avenida Atlântica',36,86,'brunapachequa@gmail.com'),(53618832478,'Ian Francisco','Divorciado(a)',0,'1945-08-18',' 6202-8946','57051702','RJ','Peritiba','Brasilândia','Avenida Doutor João Guimarães',125,2,'ianfrancisco@gmail.com'),(53323765702,'Sarah Pauluccio','Divorciado(a)',1,'1958-03-06',' 61955-6477','19008382','PE','Edéia','José Bonifácio','Rua Leite de Morais',186,16,'sarahpauluccio@gmail.com'),(80836338286,'Pedro Louzada','Casado(a)',1,'1974-07-10',' 3931-2654','85424811','AP','Manoel Viana','Freguesia do Ó','Avenida Morumbi',198,38,'pedrolouzada@gmail.com'),(83481243650,'Hugo Binelle de Pietro','Divorciado(a)',1,'1941-11-26',' 7128-2206','49663302','PA','Tabuleiro do Norte','Campo Grande','Avenida Brás Leme ',75,94,'hugobinelledepietro@gmail.com'),(24627304196,'Débora Bonicenha','Separado(a)',0,'1973-12-02',' 43746-5695','28104348','GO','Serra Azul','Alto de Pinheiros','Avenida João XXIII',250,87,'deborabonicenha@gmail.com'),(76592921374,'Ester Barnett','Solteiro(a)',1,'1938-02-04',' 2205-0273','44198586','ES','Lafaiete Coutinho','Saúde','Rua Três Rios',173,56,'esterbarnett@gmail.com'),(34037847701,'Aarã Farace','Solteiro(a)',1,'1992-06-30',' 2468-4772','12448140','PE','Itatira','Santana','Avenida Inajar de Souza',216,2,'aarafarace@gmail.com'),(14954213681,'Heloísa Jacinto','Casado(a)',0,'1997-03-14',' 1337-8857','78557599','SE','Faria Lemos','Jardim Ângela','Avenida São João',274,66,'heloisajacinto@gmail.com'),(5354711061,'Miguel Brandão','Casado(a)',1,'1953-03-05',' 84536-2424','41274297','ES','Porto Esperidião','Vila Curuçá','Alameda Joaquim Eugênio de Lima',247,3,'miguelbrandao@gmail.com'),(5337369946,'Gabriel Pitanga','Casado(a)',1,'1930-09-21',' 7081-1414','84948144','AM','Nova Santa Rita','Tucuruvi','Avenida Jornalista Roberto Marinho',53,87,'gabrielpitanga@gmail.com'),(94949979809,'Beatriz Belinato','Viúvo(a)',0,'1941-04-10',' 1076-0568','66502462','PR','Pacoti','Cangaíba','Avenida Santa Marina',103,4,'beatrizbelinato@gmail.com'),(89618408272,'Ana Rassato','Casado(a)',1,'1991-02-14',' 32918-2836','52562249','RO','General Carneiro','Cidade Ademar','Complexo Viário Jacu Pêssego',62,17,'anarassato@gmail.com'),(11110462557,'Leonardo Colombi','Divorciado(a)',1,'1959-10-08',' 3561-9803','45550875','DF','São João da Urtiga','Cidade Ademar','Avenida Pompeia',256,17,'leonardocolombi@gmail.com'),(17148124484,'Ricardo Simonato','Casado(a)',1,'1942-03-16',' 3825-2150','39081634','PE','Cambará','Barra Funda','Avenida Giovanni Gronchi',36,20,'ricardosimonato@gmail.com'),(78020911014,'Bianca Sossai','Viúvo(a)',1,'1944-09-20',' 45399-0798','56452920','PR','Santa Bárbara d\'Oeste','Jardim Ângela','Avenida Renata ',209,17,'biancasossai@gmail.com'),(98379200250,'Rodrigo Bernardi','Divorciado(a)',1,'1997-11-23',' 6511-6976','87868454','MT','Rio Preto da Eva','Ermelino Matarazzo','Rua Capitão Manuel Novais',263,14,'rodrigobernardi@gmail.com'),(84154897497,'Cecília do Carmo','Separado(a)',0,'1992-09-06',' 59459-4259','73992123','PR','Padre Marcos','Cidade Líder','Avenida Celso Garcia',83,23,'ceciliadocarmo@gmail.com'),(80984826505,'Heitor Sobrinho','Casado(a)',1,'1935-04-24',' 69253-6842','49022258','AC','São José do Vale do Rio Preto','Vila Matilde','Avenida Interlagos',289,88,'heitorsobrinho@gmail.com'),(93351677898,'Mariana Bastos','Solteiro(a)',1,'1935-10-08',' 4597-4772','18640521','PR','Platina','Vila Jacuí','Avenida Prof. Abraão de Morais',240,77,'marianabastos@gmail.com'),(21313568465,'Jorge Olimpio','Viúvo(a)',1,'1982-08-21',' 7707-9896','46259415','SE','Ivoti','Consolação','Rua Vergueiro',74,79,'jorgeolimpio@gmail.com'),(75161774231,'Lia Martins','Solteiro(a)',1,'1997-05-05',' 5230-1354','62363446','MG','Jussari','Vila Mariana','Rua 25 de Março',155,84,'liamartins@gmail.com'),(31445777665,'Isadora Bottega','Solteiro(a)',0,'1950-12-25',' 33014-1412','47415311','AL','Palmital','Vila Sônia','Avenida Giovanni Gronchi',76,74,'isadorabottega@gmail.com'),(6298844805,'Daniel Roriz','Separado(a)',1,'1953-04-15',' 4588-8866','46029494','AM','Alto Paraná','Jaraguá','Alameda Ministro Rocha Azevedo',84,74,'danielroriz@gmail.com'),(52428464027,'Luisa Brush','Divorciado(a)',1,'1954-07-13',' 8503-3139','33656525','PI','Derrubadas','Pirituba','Rua Conde de Sarzedas',42,59,'luisabrush@gmail.com'),(28254626405,'Felipe Piasentin','Divorciado(a)',1,'1948-05-27',' 96883-9749','38049381','RN','Novo Gama','Guaianases','Avenida Salim Farah Maluf ',140,97,'felipepiasentin@gmail.com'),(50545756421,'Beatriz Barreira','Separado(a)',0,'1963-03-31',' 08909-8051','21296429','PR','Cachoeira de Pajeú','Tremembé','Avenida Regente Feijó',68,18,'beatrizbarreira@gmail.com'),(6584679560,'Cecília Morais','Solteiro(a)',1,'1944-03-31',' 3265-7998','63947636','GO','Palmas','Butantã','Avenida Itaquera',129,2,'ceciliamorais@gmail.com'),(28584997806,'Ricardo Gato','Viúvo(a)',0,'1932-06-28',' 74453-7235','11027446','PA','Marmeleiro','Cambuci','Ligação Leste-Oeste',73,36,'ricardogato@gmail.com'),(44815243085,'Luana Sobrinho','Casado(a)',1,'1998-02-06',' 08064-2223','58827543','AC','Barreirinhas','Jardim Ângela','Avenida Nova Cantareira',209,57,'luanasobrinho@gmail.com'),(87363997101,'Benjamim Romanini','Solteiro(a)',0,'1978-05-20',' 00258-0486','52595440','TO','Barra de São Francisco','Vila Andrade','Avenida Celso Garcia',123,77,'benjamimromanini@gmail.com'),(79744673630,'Laís Longo','Viúvo(a)',1,'1945-06-16',' 26414-1843','25833985','MG','Timbiras','Iguatemi','Avenida Waldemar Carlos Pereira',163,53,'laislongo@gmail.com'),(80607402105,'Bryan Bernardi','Viúvo(a)',0,'1937-02-16',' 5592-3059','78737117','PA','Governador Nunes Freire','Aricanduva','Avenida Brasil',125,27,'bryanbernardi@gmail.com'),(88136905096,'Fernando de Jesus','Viúvo(a)',0,'1946-08-18',' 66585-0480','49902141','PI','Belo Horizonte','Iguatemi','Rua Heitor Penteado',169,71,'fernandodejesus@gmail.com'),(18181950895,'Joaquim Landeira','Viúvo(a)',0,'1946-02-08',' 9404-6957','47916896','MG','Xapuri','Jabaquara','Avenida Brás Leme',187,39,'joaquimlandeira@gmail.com'),(99052657408,'David Rosalina','Solteiro(a)',1,'1988-11-30',' 6889-8051','24172380','BA','Paranaíba','José Bonifácio','Avenida Aricanduva',297,58,'davidrosalina@gmail.com'),(47973983619,'Lucca Martha','Casado(a)',0,'1923-12-16',' 9772-0026','59359471','SE','Areial','Mooca','Avenida Salim Farah Maluf',217,86,'luccamartha@gmail.com'),(94140959932,'Emanuel Majeski','Viúvo(a)',0,'1940-08-21',' 54897-1122','64079319','PR','Arroio Trinta','Jaguaré','Avenida Rio Branco',215,40,'emanuelmajeski@gmail.com'),(22234407460,'Patrícia Pedroza','Casado(a)',1,'1988-01-02',' 83056-0457','63327872','RO','Tururu','Saúde','Rua Líbero Badaró',119,2,'patriciapedroza@gmail.com'),(32808974167,'Theo Serata','Casado(a)',1,'1997-12-08',' 72081-3033','32094253','RJ','Pilão Arcado','Itaim Paulista','Avenida Doutor Enéas Carvalho de Aguiar',192,3,'theoserata@gmail.com'),(92159547247,'Miguel Ceolin','Divorciado(a)',0,'1927-05-02',' 1678-6080','83060359','RJ','Major Vieira','Cidade Dutra','Avenida Cidade Jardim',111,47,'miguelceolin@gmail.com'),(81775960986,'Davi Cipriano','Divorciado(a)',1,'1976-10-15',' 07938-1938','36040175','PE','Divino das Laranjeiras','Itaim Bibi','Alameda Ministro Rocha Azevedo',289,84,'davicipriano@gmail.com'),(67612101351,'Ana Manoel','Solteiro(a)',1,'1938-03-25',' 39735-4742','59483629','BA','Mamonas','Campo Limpo','Avenida Sumaré',246,1,'anamanoel@gmail.com'),(4342416794,'Eduardo Madsen','Viúvo(a)',0,'1935-03-23',' 94236-4864','93238388','BA','Passa Tempo','Lajeado','Avenida Santo Amaro',24,49,'eduardomadsen@gmail.com'),(29749795059,'Henrique Moniz','Viúvo(a)',0,'2000-08-04',' 8209-1313','56916620','RS','Ibipeba','Belém','Avenida Luís Dumont Vilares',204,22,'henriquemoniz@gmail.com'),(46343993002,'Raquel Costa Longa','Solteiro(a)',0,'1943-10-01',' 4693-0265','36274336','RN','Sucupira do Norte','Pedreira','Rua do Orfanato',13,9,'raquelcostalonga@gmail.com'),(10451575709,'Luisa Solda\'','Solteiro(a)',1,'2002-04-04',' 5056-6491','78291735','SC','Mar de Espanha','Mandaqui','Avenida Santo Amaro',97,57,'luisasolda@gmail.com'),(36255152618,'Larissa Rizzo','Solteiro(a)',0,'1992-07-17',' 4702-1727','89812393','RJ','Igaporã','Água Rasa','Avenida Higienópolis',154,17,'larissarizzo@gmail.com'),(9056572768,'Guilherme Onhas','Separado(a)',0,'1922-06-01',' 2406-2874','45644727','PE','Herval','Belém','Rua Três Rios',165,49,'guilhermeonhas@gmail.com'),(25260448472,'Isabella Joao','Viúvo(a)',0,'1923-11-20',' 13669-8210','24072871','AM','Brejetuba','Anhangüera','Marginal Pinheiros',275,84,'isabellajoao@gmail.com'),(8634570703,'Ana Fae','Solteiro(a)',0,'1992-12-20',' 17862-3061','29716382','MS','Caxingó','Cangaíba','Avenida da Liberdade',69,60,'anafae@gmail.com'),(72536160149,'Marcos Freitas','Divorciado(a)',1,'1971-09-30',' 6838-8181','85086616','RR','Barretos','Vila Leopoldina','Rua Conselheiro Furtado',84,11,'marcosfreitas@gmail.com');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `plano_de_saude`
--

LOCK TABLES `plano_de_saude` WRITE;
/*!40000 ALTER TABLE `plano_de_saude` DISABLE KEYS */;
INSERT INTO `plano_de_saude` VALUES (1,'nenhum',0),(2,'Amil',934483),(3,'Avimed',578679),(4,'Samcil',715883),(5,'Blue life',543925),(6,'Omint',461967),(7,'Prevent Senior',227480),(8,'Serma',740914),(9,'Dix saúde',125168),(10,'GreenLine',409006),(11,'Sim',409951),(12,'amesp',436047),(13,'Itálica',840576),(14,'Intermédica',633579),(15,'Porto seguro',334498),(16,'Santamália',383874),(17,'Unimed',216187),(18,'SulAmérica',259554),(19,'Medial saúde',767918),(20,'Bradesco Saúde',968190),(21,'Saúde é tudo',660609),(22,'Oral Pró',543814),(23,'DentalPar',189949),(24,'Green Card',700945);
/*!40000 ALTER TABLE `plano_de_saude` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `plano_de_saude_tipo_de_atendimento`
--

LOCK TABLES `plano_de_saude_tipo_de_atendimento` WRITE;
/*!40000 ALTER TABLE `plano_de_saude_tipo_de_atendimento` DISABLE KEYS */;
INSERT INTO `plano_de_saude_tipo_de_atendimento` VALUES (1,143805,0),(1,62082,0),(1,193394,0),(1,151434,0),(1,77742,0),(1,116991,0),(1,101004,0),(1,199303,0),(1,171249,0),(1,162300,0),(1,36867,0),(1,196879,0),(1,110788,0),(1,89447,0),(1,45166,0),(1,151424,0),(1,64372,0),(1,48475,0),(1,56869,0),(1,51202,0),(1,197201,0),(1,94302,0),(1,116781,0),(1,225777,0),(1,43074,0),(1,203912,0),(1,27009,0),(1,151983,0),(1,183300,0),(1,57203,0),(1,88244,0),(1,91314,0),(1,158200,0),(1,182403,0),(1,25304,0),(1,162428,0),(1,58390,0),(1,136288,0),(1,113545,0),(1,119032,0),(1,103854,0),(1,180980,0),(1,10286,0),(1,218145,0),(1,45051,0),(1,146440,0),(1,56715,0),(1,165294,0),(1,145728,0),(1,54659,0),(1,155533,0),(1,113404,0),(1,170745,0),(1,70454,0),(1,122365,0),(1,79156,0),(1,144810,0),(1,162034,0),(1,44409,0),(1,153362,0),(2,19,99),(2,23,71),(2,20,11),(2,4,14),(2,16,60),(2,9,85),(2,17,70),(2,7,81),(2,21,81),(2,2,88),(2,14,76),(2,5,4),(2,13,43),(2,22,66),(2,1,97),(2,15,54),(2,18,31),(2,10,24),(2,29,86),(2,26,44),(2,25,75),(2,6,82),(2,12,78),(2,8,47),(2,28,22),(2,11,58),(3,22,69),(3,11,28),(3,25,95),(3,27,18),(3,17,74),(3,7,32),(3,3,68),(3,4,81),(3,15,86),(4,10,35),(4,9,80),(4,16,80),(4,23,53),(4,5,85),(4,21,40),(4,6,60),(4,13,9),(4,22,0),(4,27,53),(4,18,72),(4,24,61),(4,8,87),(4,26,93),(5,28,14),(5,25,81),(5,22,91),(5,12,71),(5,11,80),(5,6,31),(5,5,95),(5,17,82),(5,21,46),(6,12,98),(6,3,13),(6,24,72),(6,2,93),(6,18,65),(6,11,29),(6,13,95),(6,9,33),(6,29,30),(6,17,41),(6,10,0),(6,20,54),(6,1,5),(6,26,39),(6,21,21),(6,23,70),(6,16,3),(6,4,33),(6,5,46),(6,19,58),(6,8,91),(6,7,29),(6,22,85),(6,6,36),(6,25,6),(6,15,72),(7,19,40),(7,15,60),(7,28,76),(7,16,23),(7,29,83),(7,1,62),(7,18,37),(7,14,70),(7,10,38),(8,24,65),(8,20,10),(8,1,16),(8,17,30),(8,13,58),(8,28,97),(8,2,45),(8,10,42),(8,26,2),(9,21,77),(9,26,39),(9,22,79),(9,29,46),(9,28,37),(9,18,26),(9,11,90),(9,10,73),(9,12,40),(9,9,65),(9,2,99),(9,16,28),(9,15,1),(9,25,55),(10,23,96),(10,22,80),(10,27,73),(10,12,4),(10,10,75),(10,7,12),(10,26,82),(10,8,97),(10,1,35),(10,15,84),(10,19,32),(10,4,96),(10,13,92),(10,20,9),(11,23,10),(11,5,35),(11,2,53),(11,14,54),(11,27,14),(11,3,7),(11,24,70),(11,18,8),(11,4,52),(11,12,87),(11,29,40),(11,19,3),(11,6,75),(11,25,32),(11,20,83),(11,10,77),(11,1,40),(11,7,21),(11,15,82),(11,8,16),(11,26,18),(11,9,27),(11,13,57),(11,17,93),(11,16,78),(11,28,5),(12,23,7),(12,5,33),(12,6,45),(12,10,87),(12,12,45),(12,29,66),(12,18,65),(12,9,14),(12,16,73),(12,28,32),(12,15,11),(12,2,70),(12,11,41),(12,21,27),(12,3,82),(12,24,86),(12,14,60),(12,1,86),(12,8,92),(12,4,82),(12,22,90),(12,27,60),(12,17,10),(12,20,50),(12,19,11),(12,26,55),(13,14,68),(13,9,39),(13,29,69),(13,11,32),(13,7,47),(13,19,30),(13,3,91),(13,13,43),(13,16,26),(13,28,32),(13,6,3),(13,8,79),(13,15,82),(13,4,50),(13,1,81),(13,17,92),(13,27,50),(13,21,39),(13,2,93),(13,22,18),(13,26,23),(13,18,95),(13,25,1),(13,10,50),(13,24,10),(13,20,7),(14,28,99),(14,20,46),(14,19,20),(14,29,8),(14,14,11),(14,9,32),(14,11,46),(14,7,65),(14,27,91),(15,3,15),(15,10,94),(15,29,21),(15,1,38),(15,11,81),(15,2,79),(15,24,6),(15,27,25),(15,23,40),(15,20,17),(15,25,88),(15,15,75),(15,22,43),(15,6,81),(15,19,43),(15,13,75),(15,7,54),(15,9,28),(15,21,9),(15,17,34),(15,5,80),(15,12,81),(15,26,52),(15,28,71),(15,18,1),(15,14,22),(16,13,68),(16,19,42),(16,9,84),(16,20,82),(16,3,94),(16,23,91),(16,12,68),(16,10,61),(16,1,85),(16,16,41),(16,28,99),(16,18,41),(16,26,24),(16,15,77),(16,27,62),(16,21,33),(16,4,28),(16,14,42),(16,7,98),(16,8,74),(16,22,21),(16,17,17),(16,5,29),(16,11,36),(16,24,54),(16,6,17),(17,25,65),(17,7,59),(17,8,44),(17,26,50),(17,27,75),(17,22,4),(17,6,39),(17,3,32),(17,23,47),(17,16,51),(17,19,84),(17,2,68),(17,15,41),(17,24,12),(18,24,74),(18,12,9),(18,8,82),(18,3,49),(18,1,6),(18,6,21),(18,29,59),(18,23,84),(18,14,28),(18,2,62),(18,10,49),(18,19,65),(18,25,44),(18,20,1),(18,7,79),(18,11,49),(18,16,89),(18,21,93),(18,26,74),(18,17,88),(18,28,18),(18,4,41),(18,27,50),(18,22,99),(18,15,21),(18,18,99),(19,29,88),(19,18,56),(19,13,64),(19,15,85),(19,1,62),(19,21,31),(19,14,92),(19,23,95),(19,3,88),(19,12,16),(19,27,60),(19,10,25),(19,24,85),(19,8,93),(19,20,34),(19,11,14),(19,9,24),(19,2,6),(19,19,53),(19,6,23),(19,17,52),(19,5,70),(19,26,31),(19,28,13),(19,7,95),(19,4,56),(20,11,28),(20,8,44),(20,26,78),(20,9,27),(20,6,65),(20,2,92),(20,15,72),(20,1,95),(20,16,46),(20,22,0),(20,14,96),(20,25,29),(20,7,12),(20,21,75),(20,28,97),(20,17,93),(20,20,1),(20,18,76),(20,12,41),(20,27,23),(20,29,63),(20,19,72),(20,4,17),(20,13,95),(20,23,63),(20,3,5),(21,13,33),(21,22,8),(21,17,46),(21,7,97),(21,9,70),(21,6,59),(21,29,92),(21,24,27),(21,11,27),(21,16,8),(21,23,79),(21,21,9),(21,26,36),(21,10,99),(21,5,24),(21,4,21),(21,15,11),(21,1,68),(21,28,92),(21,3,69),(21,19,91),(21,27,18),(21,8,81),(21,12,94),(21,18,13),(21,2,14),(22,12,58),(22,10,53),(22,2,9),(22,14,16),(22,26,38),(22,18,76),(22,17,77),(22,25,93),(22,5,34),(23,29,31),(23,10,14),(23,7,19),(23,20,32),(23,9,79),(23,2,20),(23,6,74),(23,1,63),(23,14,67),(24,10,59),(24,16,30),(24,21,87),(24,20,68),(24,17,26),(24,22,1),(24,13,64),(24,18,16),(24,12,58),(24,25,17),(24,4,38),(24,24,68),(24,2,14),(24,1,51),(24,11,23),(24,23,36),(24,27,68),(24,19,3),(24,15,84),(24,9,6),(24,28,33),(24,6,20),(24,14,62),(24,5,26),(24,7,37),(24,26,4);
/*!40000 ALTER TABLE `plano_de_saude_tipo_de_atendimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipo_de_atendimento`
--

LOCK TABLES `tipo_de_atendimento` WRITE;
/*!40000 ALTER TABLE `tipo_de_atendimento` DISABLE KEYS */;
INSERT INTO `tipo_de_atendimento` VALUES (1,'Ressonância magnetica na região da cabeça','00:35:00','Não possui efeitos colaterais.',1000),(2,'Acupuntura','01:15:00','Não possui efeitos colaterais.',23200),(3,'Cirurgia','04:35:00','Possui riscos de efeitos colaterais de perda de movimento da mão, perda do movimento dos dedos.',34400),(4,'Cirurgia Torácica','08:20:00','O principal efeito colateral da simpatectomia é o chamado efeito compensatório. Esse efeito é descrito quando ocorrem episódios de sudorese em outras partes do corpo que não eram habituais antes da cirurgia. Habitualmente, o efeito compensatório ocorre no tronco, pernas, abdome, coxas, virilhas, pés e glúteos. O efeito compensatório tem grande relevância, pois seu grau de intensidade influencia diretamente a qualidade de vida do paciente.',34300),(5,'Consulta períodica','00:30:00','Não possui efeitos colaterais',43300),(6,'Cirurgia Vascular','01:30:00','Possui riscos de inchaço e escoriações',34300),(7,'Fisioterapia para as pernas','00:25:00','Não possui efeitos colaterais',6500),(8,'Consulta periódica','05:00:00','O paciente pode sentir dor leve no momento da punção da fístula com as agulhas. Quanto aos efeitos colaterais, no geral, os pacientes são sentem nada, mas pode ocorrer queda da pressão arterial, câimbras ou dor de cabeça.',54200),(9,'Quimioterapia','02:20:00','O tratamento com quimioterapia pode causar diferentes efeitos colaterais, como queda de cabelo, diarreia, feridas na boca, náuseas e vômitos, pele sensível e até mesmo infertilidade.',34334),(10,'Consulta','00:45:00','Não possui efeitos colaterais',98700),(11,'Quimioterapia','00:40:00','O tratamento com quimioterapia pode causar diferentes efeitos colaterais, como queda de cabelo, diarreia, feridas na boca, náuseas e vômitos, pele sensível e até mesmo infertilidade.',45700),(12,'Diagnóstico e tratamento da doença renal crônica','01:50:00','Não possui efeitos colaterais',64500),(13,'Cirurgia','08:15:00','As complicações neurológicas incluem diminuição do nível de consciência, vasoespasmo, convulsões, hipertensão intracraniana, déficits motores, entre outros. Já as complicações sistêmicas incluem náuseas e vômitos, hipotensão, desconforto respiratório e infecção do sítio cirúrgico, dor e infecções nosocomiais.',2455),(14,'Consulta','00:30:00','Não possui efeitos colaterais',23000),(15,'Consulta','00:25:00','Não possui efeitos colaterais',23500),(16,'Consulta','00:55:00','Não possui efeitos colaterais',32600),(17,'Remoção das pedras nos rins','04:15:00','É comum sentir uma dor lombar aguda, unilateral, que tende a se deslocar para as partes mais baixas do abdome. Em alguns casos, os homens também sofrem um desconforto nos testículos e as mulheres, nos grandes lábios.',64100),(18,'Examinação das  glândulas','00:30:00','Não possui efeitos colaterais',56400),(19,'Diagnóstico de doenças cardiovasculares','01:30:00','Não possui efeitos colaterais',32600),(20,'Cirurgia bariátrica','09:15:00','Alguns efeitos colaterais, dependendo do tipo de cirurgia, são até comuns. Nos meses imediatamente posteriores à operação, relatos de perda leve de memória, irritação e insônia tornam-se habituais em hospitais e consultórios',53600),(21,'Transplante de fígado','04:40:00','Com o uso de imunossupressores podem surgir sintomas como inchaço corporal, aumento do peso, aumento da quantidade de pelos no corpo, especialmente no rosto das mulheres, osteoporose, má digestão, queda de cabelo e aftas. Assim, deve-se observar os sintomas que aparecem e conversar com o médico para que ele indique o que se pode fazer para controlar estes sintomas desagradáveis, sem prejudicar o esquema de imunossupressão.',4540),(22,'Acompanhamento médico','00:35:00','Não possui efeitos colaterais',64300),(23,'Consulta','00:50:00','Não possui efeitos colaterais',64300),(24,'Ultrassom','00:25:00','Não possui efeitos colaterais',98700),(25,'Cirurgia na região bucal','00:15:00',' O edema ou inchaço pode ocorrer em maior, ou menor grau dependendo da pessoa;Dor no local. Devido à intervenção, é comum que o local fique bastante dolorido; Cicatrização. O processo de cicatrização é relativo e pode demorar mais ou menos dependendo da pessoa; Trismo; Mau hálito; Parestesia; Dores de garganta.',32400),(26,'Terapia','00:50:00','Não possui efeitos colaterais',326300),(27,'Substituição de uma medula óssea','06:50:00','Náusea e vômito; Feridas na boca; Fadiga; Níveis baixos de plaquetas, dificultando a coagulação do sangue; Níveis baixos de glóbulos vermelhos, causando anemia; Diarreia.',326700),(28,'Cirurgia','10:15:00','Os efeitos colaterais pós-cirúrgicos costumam desaparecer por volta dos primeiros 7 a 10 dias. A maioria dos pacientes se queixa de irritação ou sensação leve de areia nos olhos, coceira e sensibilidade a luz. ',343400),(29,'Quimioterapia','00:40:00','O tratamento com quimioterapia pode causar diferentes efeitos colaterais, como queda de cabelo, diarreia, feridas na boca, náuseas e vômitos, pele sensível e até mesmo infertilidade.',64533);
/*!40000 ALTER TABLE `tipo_de_atendimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipo_de_residencia_medica`
--

LOCK TABLES `tipo_de_residencia_medica` WRITE;
/*!40000 ALTER TABLE `tipo_de_residencia_medica` DISABLE KEYS */;
INSERT INTO `tipo_de_residencia_medica` VALUES (1,'Acupuntura'),(2,'Alergia e Imunologia'),(3,'Anestesiologia'),(4,'Angiologia'),(5,'Oncologia'),(6,'Cardiologia'),(7,'Cirugia cardiovascular'),(8,'Cirugia da mão'),(9,'Cirugia de cabeça e pescoço'),(10,'Cirugia Geral'),(11,'Cirugia o aparelho digestivo'),(12,'Cirugia pediátrica'),(13,'Cirugia plástica'),(14,'Cirugia torácica'),(15,'Clínica médica'),(16,'Coloproctologia'),(17,'Dermatologia'),(18,'Endocrinologia'),(19,'Endoscopia'),(20,'Gastroenterologia'),(21,'Genética médica'),(22,'Geriatria'),(23,'Ginecologia e obstetríca'),(24,'Hematologia'),(25,'Homeopatia'),(26,'Infectologia'),(27,'Mastologia'),(28,'Nefrologia'),(29,'Neurocirurgia'),(30,'Neurologia'),(31,'Nutrologia'),(32,'Oftalmologia'),(33,'Ortopedia'),(34,'Otorrinolaringologia'),(35,'Patologia'),(36,'Patologia Clínica'),(37,'Pediatria'),(38,'Pneumologia'),(39,'Psiquiatria'),(40,'Radiologia'),(41,'Radioterapia'),(42,'Reumatologia'),(43,'Urologia');
/*!40000 ALTER TABLE `tipo_de_residencia_medica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tipo_de_tratamento`
--

LOCK TABLES `tipo_de_tratamento` WRITE;
/*!40000 ALTER TABLE `tipo_de_tratamento` DISABLE KEYS */;
INSERT INTO `tipo_de_tratamento` VALUES (14,0,1,'Ressonância'),(6,0,2,'Acupuntura'),(2,0,3,'Cirurgia da Mão'),(2,1,4,'Simpatectomia'),(25,0,5,'Cirurgia Plástica'),(2,1,6,'Angiologia'),(10,1,7,'Fisioterapia'),(5,1,8,'Hemodiálise'),(2,1,9,'Cancer no estomago'),(3,0,10,'Terapia pseudocientífica'),(3,1,11,'Cancer de pele'),(3,1,12,'Prevenção de doenças renais'),(8,1,13,'Cirurgia neurológica'),(9,0,14,'Nutrologia'),(10,0,15,'Rinologia'),(18,0,16,'Psiquiatria'),(7,1,17,'Cálculo renal'),(4,0,18,'Endocrinologia Pediátrica'),(2,0,19,'Ergometria'),(1,1,20,'Gastroplastia'),(1,1,21,'Hepatologia'),(15,0,22,'Neonatologia'),(3,0,23,'Psicogeriatria'),(4,0,24,'Pré-Natal'),(4,0,25,'Remoção de siso'),(6,0,26,'Psicólogo'),(3,1,27,'Transplante de Medula Óssea'),(8,1,28,'Tranplante de córnea'),(12,1,29,'Cancer no pulmão');
/*!40000 ALTER TABLE `tipo_de_tratamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tratamento`
--

LOCK TABLES `tratamento` WRITE;
/*!40000 ALTER TABLE `tratamento` DISABLE KEYS */;
INSERT INTO `tratamento` VALUES (1,24,94140959932),(2,22,5566953727),(3,18,94949979809),(4,13,96188904650),(5,18,25260448472),(6,29,28584997806),(7,21,19423082130),(8,10,8476452748),(9,8,737990252),(10,12,93776063220),(11,3,39475689591),(12,25,47973983619),(13,28,44989192206),(14,27,96667322030),(15,29,57406880197),(16,20,58526741098),(17,27,72788307535),(18,15,98379200250),(19,21,45260805356),(20,27,53618832478),(21,24,96667322030),(22,12,34313544402),(23,26,9092362670),(24,24,90511268750),(25,21,88832309815),(26,21,58945523464),(27,5,25260448472),(28,19,20909274290),(29,23,98941098025),(30,28,78457619403),(31,19,71203415885),(32,17,65109676186),(33,2,45646445990),(34,28,5566953727),(35,7,75031099046),(36,8,65282579812),(37,7,67612101351),(38,10,329284240),(39,26,32808974167),(40,26,87363997101),(41,21,7861925005),(42,3,82275369724),(43,5,20986784605),(44,18,71097518051),(45,13,88832309815),(46,2,41236579585),(47,20,78041888623),(48,7,52428464027),(49,16,10727181033),(50,9,92159547247),(51,19,17645947462),(52,28,9056572768),(53,14,22908536749),(54,25,72788307535),(55,3,48996775452),(56,11,79744673630),(57,8,65703055903),(58,12,13671282002),(59,14,11110462557),(60,22,98941098025),(61,17,46343993002),(62,19,75091874860),(63,2,48996775452),(64,21,14954213681),(65,26,59448025530),(66,7,32420488490),(67,21,13671282002),(68,15,95746044202),(69,25,42835822631),(70,18,9092362670),(71,6,97105293748),(72,5,88832309815),(73,22,25216530126),(74,5,35096115607),(75,11,98310402015),(76,2,45646445990),(77,3,80607402105),(78,10,57406880197),(79,23,32769179632),(80,14,9056572768),(81,3,41236579585),(82,21,42835822631),(83,23,82899672258),(84,16,737990252),(85,23,45316901410),(86,14,19558005967),(87,24,88416650926),(88,19,60746306822),(89,7,82496974302),(90,11,45719916067),(91,9,10906781345),(92,19,32769179632),(93,29,84780417023),(94,15,36536612264),(95,19,4342416794),(96,20,53618832478),(97,12,47324887228),(98,10,6696400699),(99,9,26986509073),(100,24,3198488176);
/*!40000 ALTER TABLE `tratamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hospital'
--

--
-- Dumping routines for database 'hospital'
--
/*!50003 DROP FUNCTION IF EXISTS `CRM_para_CPF` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CRM_para_CPF`(crm bigint) RETURNS bigint(20)
begin
	declare result bigint;

	select cpf into result from pessoa join 
		(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
		where A.CRM = crm;
        
	return result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_data_de_adminissao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_data_de_adminissao`(cpf_entrada bigint) RETURNS date
begin
	declare result date;
    
	select data_de_adminissao into result
	from funcionario
	where CPF = 26115330408;
    
    return result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_agendados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_agendados`(horario_inicio date, horario_fim date) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		FROM atendimento
		join tratamento using(tratamento_id)
        join pessoa using(cpf)
		where horario_agendado between horario_inicio and horario_fim
        and atendimento.estado = 0;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_agendados_por_um_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_agendados_por_um_cliente`(cpf_entrada bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_agendado, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=0
	) as r
	where nome_medico like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_agendados_por_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_agendados_por_um_medico`(crm bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_agendado, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_cliente like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_proximo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_proximo`() RETURNS int(11)
begin
		declare n int; 
		
		select ceil(count(*)/10) into n
		from atendimento
		join (
				select nome, numero_do_telefone, tratamento_id, cpf from pessoa join tratamento using (cpf)
			) as A using (tratamento_id)
		where DATEDIFF(horario_agendado, now()) between 0 and 14;
        
        return n;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_realizados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_realizados`(horario_inicio date, horario_fim date) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		FROM atendimento
		join tratamento using(tratamento_id)
        join pessoa using(cpf)
		where horario_inicio_real between horario_inicio and horario_fim
        and atendimento.estado = 1;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_realizados_por_um_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_realizados_por_um_cliente`(cpf_entrada bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_inicio_real, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_atendimentos_realizados_por_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_atendimentos_realizados_por_um_medico`(crm bigint, filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_inicio_real, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_cliente like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_depedentes_de_um_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_depedentes_de_um_funcionario`(cpf_entrada bigint) RETURNS int(11)
begin
	declare result int;
    
	select ceil(count(*)/10) into result
	from depedentes
	join pessoa
	on depedentes.CPF_depedente = pessoa.CPF
	where depedentes.CPF = cpf_entrada;
    
    return result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_especialidades_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_especialidades_de_um_medico`(crm_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from medico_especialidade join especialidade using(especialidade_id)
		where CRM = crm_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_clientes`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from pessoa join cliente using (cpf)
	where nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_funcionarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_funcionarios`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from pessoa join funcionario using (cpf)
	where nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_medicos`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_medicos_funcionarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_medicos_funcionarios`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join medico_funcionario using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_medicos_prestadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_medicos_prestadores`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from pessoa
		join medico_prestador_de_servico as r using (cpf)
		where nome like CONCAT("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_planos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_planos`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from plano_de_saude
	where nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_lista_de_tratamentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_lista_de_tratamentos`(filtro varchar(50)) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
	from tratamento	join pessoa using (cpf)
	where pessoa.nome like concat("%",filtro,"%");
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_planos_de_saude_de_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_planos_de_saude_de_um_cliente_lista`(cpf_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
    from plano_de_saude
	join cliente_plano_de_saude using(plano_de_saude_id)
	where cpf = cpf_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_planos_de_saude_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_planos_de_saude_de_um_medico`(crm_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
		from plano_de_saude	join medico_plano_de_saude using(plano_de_saude_id)
		where CRM = crm_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_tratamentos_cronicos_proximos_de_estourar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_tratamentos_cronicos_proximos_de_estourar`() RETURNS int(11)
begin
		declare result int;
        
		select ceil(count(*)/10) into result
		from tratamento
			join tipo_de_tratamento using(tipo_de_tratamento_id)
			join pessoa using(cpf)
		where tipo_de_tratamento.eh_cronico = 1
			and not exists (
				select * from atendimento where atendimento.tratamento_id = tratamento.tratamento_id and estado = 1
				)
			and 14 >= all(
				select datediff(date_add(horario_agendado, interval 6 month), now())
				from atendimento
				where atendimento.estado = 0
					and atendimento.tratamento_id = tratamento.tratamento_id);
		return result;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obter_n_tratamento_por_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obter_n_tratamento_por_cliente`(cpf_entrada bigint) RETURNS int(11)
begin
	declare n int;

	select ceil(count(*)/10) into n
    from tratamento
    where cpf = cpf_entrada;
    
    return n;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `verificar_se_existe_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `verificar_se_existe_cliente`(cpf bigint) RETURNS int(11)
begin
		declare n int;
    
		select exists (
			select *
            from cliente
            where cliente.cpf = cpf
        ) into n from dual;
        
        return n;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `verificar_se_existe_pessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `verificar_se_existe_pessoa`(cpf bigint) RETURNS int(11)
begin
		declare n int;
    
		select exists (
			select *
            from pessoa
            where pessoa.cpf = cpf
        ) into n from dual;
        
        return n;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agendar_atendimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agendar_atendimento`(in info json)
begin
	#calcular:
    #comissao_da_clinica, valor_recebidos_por_medico, importo_retido, valor_pago_pelo_plano
    
    declare valor int;
	declare imposto_retido int;
    declare comissao_da_clinica int;
    declare valor_recebidos_por_medico int;
    declare eh_funcionario bool;
    declare valor_pago_pelo_plano int;
    declare tipo_de_atendimento_id int;
    declare plano_de_saude_id int;
    declare crm int;
    
    #JSON_UNQUOTE(JSON_EXTRACT(info, '$.salario_bruto'))
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.tipo_de_atendimento_id')) into tipo_de_atendimento_id;
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.plano_de_saude_id')) into plano_de_saude_id;
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.crm')) into crm;
    
    set comissao_da_clinica = 0;
    set valor_recebidos_por_medico = 0;
    
	select preco into valor
	from tipo_de_atendimento
	where tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id;
    
    set imposto_retido = floor(valor * 0.05);
	
    select exists (
	select *
	from medico_funcionario
	where medico_funcionario.CRM = crm) into eh_funcionario;
	
    if eh_funcionario then
		set comissao_da_clinica = floor(valor * 0.3);
        set valor_recebidos_por_medico = floor(valor * 0.65);
    else
		set comissao_da_clinica = floor(valor * 0.95);
    end if;
    
    select floor(desconto * valor / 100) into valor_pago_pelo_plano
		from plano_de_saude_tipo_de_atendimento
		where plano_de_saude_tipo_de_atendimento.plano_de_saude_id = plano_de_saude_id
		and plano_de_saude_tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id;
    
    if valor_pago_pelo_plano is null then
		set valor_pago_pelo_plano = 0;
    end if;
    
    insert atendimento (sala, horario_agendado, 
    estado, crm, plano_de_saude_id,
    tipo_de_atendimento_id, tratamento_id, valor,
    comissao_da_clinica, valor_recebidos_por_medico,
    imposto_retido, valor_pago_pelo_plano)
	select JSON_UNQUOTE(JSON_EXTRACT(info, '$.sala')),
    JSON_UNQUOTE(JSON_EXTRACT(info, '$.horario_agendado')),
    0,
    crm,
    plano_de_saude_id,
    tipo_de_atendimento_id,
    JSON_UNQUOTE(JSON_EXTRACT(info, '$.tratamento_id')),
    valor,
    comissao_da_clinica,
    valor_recebidos_por_medico,
    imposto_retido,
    valor_pago_pelo_plano;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_cliente_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_cliente_dados`(cpf bigint)
begin
	select count(*) as quant, min(horario_agendado) as data_proxima_consulta
		from atendimento join tratamento
		where estado=0 and tratamento.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_medico_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_medico_dados`(crm bigint)
begin
	select count(*) as quant, min(horario_agendado) as data_proxima_consulta
		from atendimento
		where estado=0 and atendimento.crm = crm;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_um_cliente_lista`(in k int, cpf_entrada bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_agendado, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=0
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_agendados_por_um_medico_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_agendados_por_um_medico_lista`(in k int, crm bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_medico, sala, horario_agendado, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_proximos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_proximos`(in k int)
begin
		set k = k * 10;
    
		select A.nome, A.numero_do_telefone,
				(
					select nome from pessoa join 
						(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
						where A.CRM = atendimento.crm
				) as nome_medico,
				(
					select nome from tipo_de_atendimento where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
				) as tipo_de_atendimento, horario_agendado,
                atendimento_id
		from atendimento
		join (
				select nome, numero_do_telefone, tratamento_id, cpf from pessoa join tratamento using (cpf)
			) as A using (tratamento_id)
		where DATEDIFF(horario_agendado, now()) between 0 and 14
		order by horario_agendado
        limit k, 10;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_cliente_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_cliente_dados`(cpf bigint)
begin
	select count(*) as quant, max(horario_inicio_real) as data_ultima_consulta
		from atendimento join tratamento
		where atendimento.estado=1 and tratamento.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_medico_dados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_medico_dados`(crm bigint)
begin
	select count(*) as quant, max(horario_inicio_real) as data_ultima_consulta
		from atendimento
		where estado=1 and atendimento.crm = crm;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_um_cliente_lista`(in k int, cpf_entrada bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from (select * from medico_funcionario union select * from medico_prestador_de_servico) as r
				join pessoa using(cpf)
				where crm = atendimento.crm
			) as nome_medico, sala, horario_inicio_real, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where tratamento.cpf = cpf_entrada and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `atendimentos_realizados_por_um_medico_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `atendimentos_realizados_por_um_medico_lista`(in k int, crm bigint, filtro varchar(50))
begin
	set k = k * 10;
    
	select *
	from (
		select tratamento.cpf, (
			select nome
				from pessoa
				where tratamento.cpf = pessoa.cpf
			) as nome_cliente, sala, horario_inicio_real, valor_recebidos_por_medico, atendimento_id
		from atendimento
		join tratamento using(tratamento_id)
		where atendimento.crm = crm and 
			atendimento.estado=1
	) as r
	where nome_medico like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_cliente`(in info json)
begin
	declare doencas_do_cliente json;
    declare planos_de_saude_do_cliente json;
    DECLARE i INT;
    declare atual bigint;
    declare client_cpf bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')) into client_cpf from dual; 
    
    insert cliente(cpf) values (client_cpf);
    
   select JSON_EXTRACT(info, '$.doencas_pre_existentes') into doencas_do_cliente  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(doencas_do_cliente, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert doencas_pre_existentes(CPF, doenca_id)
            select client_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
    
    select JSON_EXTRACT(info, '$.planos_de_saude') into planos_de_saude_do_cliente  from dual;
   
   set i = 0;
	label2:loop
		select JSON_EXTRACT(planos_de_saude_do_cliente, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label2;
		else
			insert cliente_plano_de_saude(CPF, plano_de_saude_id)
            select client_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_funcionario`(in info json)
begin
	declare dependetes_do_funcionario json;
    DECLARE i INT;
    declare atual bigint;
    declare func_cpf bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')) into func_cpf from dual; 
    
    insert funcionario(data_de_adminissao, salario_bruto, CPF, funcao_id)
	select
		now(),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.salario_bruto')),
        func_cpf,
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.funcao_id'))
	from dual;
    
   select JSON_EXTRACT(info, '$.depedentes') into dependetes_do_funcionario  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(dependetes_do_funcionario, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert depedentes(CPF, CPF_depedente)
            select func_cpf, atual;
            set i = i + 1;
		end if;
	end loop;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_medico`(in info json)
begin
	declare especialidades_do_medico json;
    declare plano_de_saude_do_medico json;
    DECLARE i INT;
    declare atual bigint;
    declare medic_crm bigint;
    
    select JSON_UNQUOTE(JSON_EXTRACT(info, '$.CRM')) into medic_crm from dual; 
    
    insert medico(crm, escola_de_origem, tipo_de_residencia_medica_id)
	select
		medic_crm,
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.escola_de_origem')),
        JSON_UNQUOTE(JSON_EXTRACT(info, '$.tipo_de_residencia_medica_id'))
	from dual;
    
   select JSON_EXTRACT(info, '$.especialidades') into especialidades_do_medico  from dual;
   select JSON_EXTRACT(info, '$.planos_de_saude') into plano_de_saude_do_medico  from dual;
   
   set i = 0;
	label1:loop
		select JSON_EXTRACT(especialidades_do_medico, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label1;
		else
			insert medico_especialidade(CRM, especialidade_id)
            select medic_crm, atual;
            set i = i + 1;
		end if;
	end loop;
    
    set i = 0;
	label2:loop
		select JSON_EXTRACT(plano_de_saude_do_medico, concat('$[',i,']')) into atual from dual;
		
		if atual is null then
			leave label2;
		else
			insert medico_plano_de_saude(CRM, plano_de_saude_id)
            select medic_crm, atual;
            set i = i + 1;
		end if;
	end loop;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_medico_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_medico_funcionario`(in crm bigint, in cpf bigint)
begin
	insert into medico_funcionario (CRM, CPF)
    values (crm, cpf);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_medico_prestador_de_servico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_medico_prestador_de_servico`(in crm bigint, in cpf bigint)
begin
	insert into medico_prestador_de_servico (CRM, CPF)
    values (crm, cpf);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cadastrar_pessoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_pessoa`(in info json)
begin
	
    insert into pessoa (
		CPF,nome,estado_civil,sexo,data_de_nascimento,numero_do_telefone,cep,estado,cidade,bairro,logradouro,complemento,numero,email
    ) select 
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.CPF')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.nome')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.estado_civil')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.sexo')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.data_de_nascimento')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.numero_do_telefone')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.cep')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.estado')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.cidade')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.bairro')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.logradouro')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.complemento')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.numero')),
		JSON_UNQUOTE(JSON_EXTRACT(info, '$.email'))
from dual;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `criar_tratamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `criar_tratamento`(in tipo_de_tratamento int, in cpf bigint)
begin
	insert into tratamento(tipo_de_tratamento_id, cpf)
    values (tipo_de_tratamento, cpf);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_clientes_estado_civil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_clientes_estado_civil`()
begin
        select estado_civil, count(*) as quant
		from pessoa join cliente using(cpf)
		group by estado_civil;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_clientes_idade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_clientes_idade`(out media real, out mediana real, out desvio real)
begin
		declare quant int;
        declare amplitude int;
        declare classes int;
        
		select avg(idade) into media
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join cliente using(cpf)) as A;
            
		select std(idade) into desvio
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join cliente using(cpf)) as A;
            
        select count(cpf) into quant from pessoa join cliente using(cpf);
        
        select avg(idade) into mediana
        from (
			select @linha:=@linha+1 as pos, timestampdiff(YEAR,data_de_nascimento,now()) as idade
				from pessoa join cliente using(cpf), (select @linha := 0) as r
        ) as valores_medios
        where pos = floor(250/2) or pos = ceil(250/2);
        
        select max(idade) - min(idade) into amplitude
        from(
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join cliente using(cpf)
        ) as A;      
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(idade/classes) * classes) as  x, count(*) as y
        from (
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join cliente using(cpf)
        ) as A
        group by floor(idade/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_das_especialidades_quant_atendimentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_das_especialidades_quant_atendimentos`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome as nome, count(crm) as valor
				from especialidade
				join medico_especialidade using (especialidade_id)
				join atendimento using (crm)
				group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_das_especialidades_quant_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_das_especialidades_quant_medicos`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome as nome, count(crm) as valor
				from especialidade
				join medico_especialidade using (especialidade_id)
				group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_das_especialidades_valores_arrecadados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_das_especialidades_valores_arrecadados`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select especialidade.nome, sum(atendimento.valor) as valor
				from especialidade
				join medico_especialidade using(especialidade_id)
				join atendimento using(crm)
                group by especialidade_id;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_funcionarios_estado_civil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_funcionarios_estado_civil`()
begin
        select estado_civil, count(*)
		from pessoa join funcionario using(cpf)
		group by estado_civil;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_funcionarios_idade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_funcionarios_idade`(out media real, out mediana real, out desvio real)
begin
		declare quant int;
        declare amplitude int;
        declare classes int;
        
		select avg(idade) into media
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join funcionario using(cpf)) as A;
            
		select std(idade) into desvio
		from (
			select timestampdiff(YEAR,data_de_nascimento,now()) as idade
			from pessoa join funcionario using(cpf)) as A;
            
        select count(cpf) into quant from pessoa join funcionario using(cpf);
        
        select avg(idade) into mediana
        from (
			select @linha:=@linha+1 as pos, timestampdiff(YEAR,data_de_nascimento,now()) as idade
				from pessoa join funcionario using(cpf), (select @linha := 0) as r
        ) as valores_medios
        where pos = floor(quant/2) or pos = ceil(quant/2);
        
        select max(idade) - min(idade) into amplitude
        from(
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join funcionario using(cpf)
        ) as A;      
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(idade/classes) * classes) as  x, count(*) as y
        from (
            select timestampdiff(YEAR,data_de_nascimento,now()) as idade
            from pessoa join funcionario using(cpf)
        ) as A
        group by floor(idade/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_funcionarios_salario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_funcionarios_salario`(out media real, out desvio real)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, salario_bruto
				from funcionario
				join pessoa using(cpf);
        
		select avg(salario_bruto) into media from temp_view;
            
		select std(salario_bruto) into desvio from temp_view;
        
        select max(salario_bruto) - min(salario_bruto) into amplitude from temp_view;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(salario_bruto/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(salario_bruto/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_medicos_vs_quant_pacientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_medicos_vs_quant_pacientes`(out media real, out desvio_padrao real, out maximo int, out minimo int)
begin       
        drop view if exists temp_view;
        create view temp_view
			as select (
				select nome from pessoa join 
						(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
						where A.CRM = atendimento.crm
				) as nome, count(cpf) as valor
				from atendimento
				join tratamento using(tratamento_id)
				group by(crm)
				order by valor;

		select avg(valor) into media from temp_view;
        select std(valor) into desvio_padrao from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
              
        select valor as x, count(*) as y
        from temp_view
        group by x;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_atendimentos_aceitos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_atendimentos_aceitos`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(tipo_de_atendimento_id) as valor
			from plano_de_saude
			join plano_de_saude_tipo_de_atendimento using (plano_de_saude_id)
			group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select valor as  x, count(*) as y
        from temp_view
        group by valor;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_quantidade_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_quantidade_cliente`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(cpf) as valor
				from plano_de_saude
				join cliente_plano_de_saude using(plano_de_saude_id)
				group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(valor/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(valor/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_quantidade_de_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_quantidade_de_medicos`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, count(crm) as valor
			from plano_de_saude
			join medico_plano_de_saude using (plano_de_saude_id)
			group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select (floor(valor/classes) * classes) as  x, count(*) as y
        from temp_view
        group by floor(valor/classes);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_plano_de_saude_vs_desconto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_plano_de_saude_vs_desconto`(out media real, out desvio real, out minimo int, out maximo int)
begin       
        declare quant int;
        declare amplitude int;
        declare classes int;
        declare linha int;
        
        drop view if exists temp_view;
        create view temp_view
			as select nome, sum(valor_pago_pelo_plano) as valor
				from plano_de_saude
				join atendimento using(plano_de_saude_id)
				group by plano_de_saude_id;
        
		select avg(valor) into media from temp_view;
		select std(valor) into desvio from temp_view;
        
		select max(valor) into maximo from temp_view;
        select min(valor) into minimo from temp_view;
        
        select nome from temp_view where valor = maximo;
        select nome from temp_view where valor = minimo;
        
        select maximo - minimo into amplitude from dual;
        
        select floor(amplitude/20) into classes from dual;
        
        select * from temp_view;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dados_sobre_atendimento_realizado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `dados_sobre_atendimento_realizado`(in atendimento_id int)
begin
		select horario_agendado, horario_inicio_real, horario_fim_real,
		(
			select nome
			from tratamento
			join pessoa using(cpf)
			where tratamento.tratamento_id = atendimento.tratamento_id
		) as nome_cliente,
		(
			select nome
			from pessoa join
			(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
			where A.CRM = atendimento.crm
		) as nome_medico,
		valor, comissao_da_clinica, valor_recebidos_por_medico, data_de_recebimento, data_do_reparsse_ao_medico, 
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento
	from atendimento
	where atendimento.atendimento_id=8; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `depedentes_de_um_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `depedentes_de_um_funcionario`(in k int, in cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome, pessoa.cpf
	from depedentes
	join pessoa
	on depedentes.CPF_depedente = pessoa.CPF
	where depedentes.CPF = cpf_entrada
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `especialidades_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `especialidades_de_um_medico`(in k int, crm_entrada bigint)
begin
	set k = k * 10;

	select nome
	from medico_especialidade join especialidade using(especialidade_id)
	where CRM = crm_entrada
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `informacoes_escolares_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `informacoes_escolares_de_um_medico`(in crm bigint)
begin
	select escola_de_origem, nome as tipo_de_residencia_medica
	from medico
	join tipo_de_residencia_medica using(tipo_de_residencia_medica_id)
	where crm = 3;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_atendimentos_agendados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_atendimentos_agendados`(in k int, horario_inicio date, horario_fim date)
begin
	set k = k * 10;

	SELECT cliente.nome as nome_cliente,
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento,
		(
			select nome
			from pessoa
			join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
			where r.crm = atendimento.crm
		) as nome_medico, horario_agendado, 
		atendimento_id
	FROM atendimento
	join tratamento using(tratamento_id)
    join pessoa as cliente using(cpf)
	where horario_agendado between horario_inicio and horario_fim
    and atendimento.estado = 0
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_atendimentos_realizados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_atendimentos_realizados`(in k int, horario_inicio date, horario_fim date)
begin
	set k = k * 10;

	SELECT cliente.nome as nome_cliente,
		(
			select nome
			from tipo_de_atendimento
			where tipo_de_atendimento.tipo_de_atendimento_id = atendimento.tipo_de_atendimento_id
		) as tipo_de_atendimento,
		(
			select nome
			from pessoa
			join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
			where r.crm = atendimento.crm
		) as nome_medico, horario_inicio_real, 
		atendimento_id
	FROM atendimento
	join tratamento using(tratamento_id)
    join pessoa as cliente using(cpf)
	where horario_inicio_real between horario_inicio and horario_fim
    and atendimento.estado = 1
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_clientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_clientes`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, sexo, numero_do_telefone, cpf
	from pessoa join cliente using (cpf)
    where nome like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_doencas_pre_existentes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_doencas_pre_existentes`(in cpf bigint)
begin
	select nome
	from doenca
	join doencas_pre_existentes using(doenca_id)
	where doencas_pre_existentes.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_funcionario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_funcionario`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select pessoa.nome, funcao.nome as cargo, data_de_adminissao, sexo, numero_do_telefone, pessoa.cpf
	from pessoa join funcionario using (cpf)
    join funcao using(funcao_id)
    where pessoa.nome like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_medicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_medicos`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join (select * from medico_funcionario union select * from medico_prestador_de_servico) as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_medicos_funcionarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_medicos_funcionarios`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join medico_funcionario using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_medicos_prestadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_medicos_prestadores`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, timestampdiff(YEAR,data_de_nascimento,now()) as idade, crm, sexo, numero_do_telefone
	from pessoa
	join medico_prestador_de_servico as r using (cpf)
	where nome like CONCAT("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_planos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_planos`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select nome, plano_de_saude_id
	from plano_de_saude
    where nome like concat("%",filtro,"%")
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_de_tratamentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_de_tratamentos`(in k int, filtro varchar(50))
begin
	set k = k * 10;

	select tratamento_id, pessoa.nome as cliente_nome, tipo_de_tratamento.nome as tipo_de_tratamento, count(*) as quant_de_atendimentos
	from tratamento
		join tipo_de_tratamento using (tipo_de_tratamento_id)
		join pessoa using (cpf)
		join atendimento using(tratamento_id)
	group by tratamento_id
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `medicos_funcionarios_vs_prestadores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `medicos_funcionarios_vs_prestadores`()
begin
		declare total real;
        declare funcionarios real;
		
        select count(*) into total from medico;
		select count(*) into funcionarios from medico_funcionario;
		
        
        select total, funcionarios, total - funcionarios as prestadores from dual;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_atendimentos_agendados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_atendimentos_agendados`(in inicio date, in fim date)
begin
	select
		avg(valor) as valor_recebido_media,
		std(valor) as valor_recebido_desvio,
		sum(valor) as valor_recebido_soma,
		avg(comissao_da_clinica) as valor_arrecadado_media,
		std(comissao_da_clinica) as valor_arrecadado_desvio,
		sum(comissao_da_clinica) as valor_arrecadado_total,
		count(*) as quantidade
	from atendimento
	where horario_agendado between inicio and fim
    and atendimento.estado = 0;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_atendimentos_realizados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_atendimentos_realizados`(in inicio date, in fim date)
begin
	select
		avg(valor) as valor_recebido_media,
		std(valor) as valor_recebido_desvio,
		sum(valor) as valor_recebido_soma,
		avg(comissao_da_clinica) as valor_arrecadado_media,
		std(comissao_da_clinica) as valor_arrecadado_desvio,
		sum(comissao_da_clinica) as valor_arrecadado_total,
		count(*) as quantidade
	from atendimento
	where horario_inicio_real between inicio and fim
    and estado = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_pessoais` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_pessoais`(cpf bigint)
begin
	select cpf, nome, estado_civil, sexo, data_de_nascimento, timestampdiff(YEAR,data_de_nascimento,now()) as idade, cep, estado, cidade, bairro, logradouro, numero, complemento, email, numero_do_telefone
from pessoa
join cliente using(cpf)
where cliente.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_tratamentos_cronicos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_tratamentos_cronicos`()
begin
    select eh_cronico, count(*) as quant
    from tratamento join tipo_de_tratamento using(tipo_de_tratamento_id)
    group by eh_cronico;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_dados_tratamentos_quantidades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_dados_tratamentos_quantidades`()
begin
    select nome, count(*) as quant
    from tratamento join tipo_de_tratamento using(tipo_de_tratamento_id)
    group by tipo_de_tratamento_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_doencas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_doencas`()
begin
	select doenca_id, nome
    from doenca;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_especialidades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_especialidades`()
begin
	select especialidade_id, nome
    from especialidade;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_funcoes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_funcoes`()
begin
	select funcao_id, nome
    from funcao;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_lista_completa_tratamentos_do_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_lista_completa_tratamentos_do_cliente`(in cpf bigint)
begin
	SELECT nome FROM tratamento join cliente using(cpf) join tipo_de_tratamento using(tipo_de_tratamento_id);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_medicos_validos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_medicos_validos`(in plano_de_saude_id int, in tipo_de_atendimento_id int)
begin
	drop temporary table if exists crms;
	CREATE TEMPORARY TABLE crms(crm bigint);
	
    INSERT INTO crms(crm)
		select distinct medico_plano_de_saude.crm
		from medico_plano_de_saude join medico_especialidade using(crm)
		join compete using(especialidade_id)
		where compete.tipo_de_atendimento_id = tipo_de_atendimento_id
		and medico_plano_de_saude.plano_de_saude_id = plano_de_saude_id;
	
    select nome from pessoa join 
		(select * from medico_funcionario union select * from medico_prestador_de_servico) as A using(CPF)
		join crms using(crm);
	drop temporary table if exists crms;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_planos_de_saude_validos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_planos_de_saude_validos`(in cpf bigint, in tipo_de_atendimento_id int)
begin
	select nome
	from plano_de_saude
	join plano_de_saude_tipo_de_atendimento using(plano_de_saude_id)
	join cliente_plano_de_saude using(plano_de_saude_id)
	where plano_de_saude_tipo_de_atendimento.tipo_de_atendimento_id = tipo_de_atendimento_id and
	cliente_plano_de_saude.cpf = cpf;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_plano_de_saude` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_plano_de_saude`()
begin
	select plano_de_saude_id, nome
    from plano_de_saude;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_tipos_de_atendimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_tipos_de_atendimento`()
begin
	SELECT nome FROM tipo_de_atendimento;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_tipos_de_residencia_medica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_tipos_de_residencia_medica`()
begin
	select tipo_de_residencia_medica_id, nome
    from tipo_de_residencia_medica;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obter_tipos_de_tratamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obter_tipos_de_tratamento`()
begin
	SELECT nome FROM hospital.tipo_de_tratamento;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `planos_de_saude_de_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `planos_de_saude_de_um_cliente_lista`(in k int,in cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome,
		(
		select count(tratamento_id)
		from tratamento
		join atendimento using(tratamento_id)
		where tratamento.cpf = cliente_plano_de_saude.cpf
			and atendimento.plano_de_saude_id = plano_de_saude.plano_de_saude_id
			and atendimento.estado=1
		) as quant_realizadas, (
			select count(tratamento_id)
			from tratamento
			join atendimento using(tratamento_id)
			where tratamento.cpf = cliente_plano_de_saude.cpf
				and atendimento.plano_de_saude_id = plano_de_saude.plano_de_saude_id
				and atendimento.estado=0
	) as quant_agendados from plano_de_saude
	join cliente_plano_de_saude using(plano_de_saude_id)
	where cpf = cpf_entrada
	group by plano_de_saude.plano_de_saude_id
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `planos_de_saude_de_um_medico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `planos_de_saude_de_um_medico`(in k int, crm_entrada bigint)
begin
	set k = k * 10;

	select nome
	from plano_de_saude	join medico_plano_de_saude using(plano_de_saude_id)
	where CRM = crm_entrada
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tratamentos_cronicos_proximos_de_estourar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tratamentos_cronicos_proximos_de_estourar`(in k int)
begin
		set k = k * 10;
    
		select pessoa.nome as nome_do_cliente,
			tipo_de_tratamento.nome as tipo_de_tratamento,
			pessoa.numero_do_telefone as numero_do_telefone,
			tratamento.tratamento_id as tratamento_id
		from tratamento
			join tipo_de_tratamento using(tipo_de_tratamento_id)
			join pessoa using(cpf)
		where tipo_de_tratamento.eh_cronico = 1
			and not exists (
				select * from atendimento where atendimento.tratamento_id = tratamento.tratamento_id and estado = 1
				)
			and 14 >= all(
				select datediff(date_add(horario_agendado, interval 6 month), now())
				from atendimento
				where atendimento.estado = 0
					and atendimento.tratamento_id = tratamento.tratamento_id)
		limit k, 10;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tratamentos_por_um_cliente_lista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tratamentos_por_um_cliente_lista`(in k int, cpf_entrada bigint)
begin
	set k = k * 10;
    
	select nome, count(atendimento_id) as quant_consultas, tratamento_id
	from tratamento
	join tipo_de_tratamento using(tipo_de_tratamento_id)
	join atendimento using(tratamento_id)
	where cpf = cpf_entrada
	group by tratamento_id
    limit k, 10;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-15 15:55:34
