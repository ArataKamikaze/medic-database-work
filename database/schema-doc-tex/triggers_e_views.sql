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

drop view if exists crm_e_cpf;$$
create view crm_e_cpf as select * from (select * from medico_funcionario union select * from medico_prestador_de_servico) as A;$$
        
select * from crm_e_cpf;

drop trigger if exists atualizar_crm_e_cpf_1;$$
create trigger atualizar_crm_e_cpf_1
	after insert on medico_funcionario
	for each row
	begin
		insert into crm_e_cpf 
        (crm, cpf) values
        (new.crm, new.cpf);
	end$$
    
drop trigger if exists atualizar_crm_e_cpf_2;$$
create trigger atualizar_crm_e_cpf_2
	after insert on medico_prestador_de_servico
	for each row
	begin
		insert into crm_e_cpf 
        (crm, cpf) values
        (new.crm, new.cpf);
	end$$