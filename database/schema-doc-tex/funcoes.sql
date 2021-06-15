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
	where horario_inicio_real between inicio and fim
    and estado = 0;
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
        and atendimento.estado = 0
        and estado = 0;
    
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
    and estado = 0
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
		where estado=1 and tratamento.cpf = cpf;
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