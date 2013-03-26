<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

// Heading
$_['heading_title']							= 'Newsletter Enhancements';

// Text
$_['text_success']							= 'Sucesso: Você modificou módulo Newsletter Enhancements!';
$_['text_module']							= 'Módulos';
$_['text_module_settings']  				= 'Assinar caixa de convidado';
$_['text_module_localization']  			= 'Localição';
$_['text_ne']  								= 'Newsletter';
$_['text_ne_email']  						= 'Criar e Enviar';
$_['text_ne_draft']  						= 'Rascunho Newsletter';
$_['text_ne_marketing']  					= 'Assinantes de Marketing';
$_['text_ne_subscribers']  					= 'Lista de Inscritos';
$_['text_ne_stats']  						= 'Estatísticas Newsletter';
$_['text_ne_robot']  						= 'Programar Newsletter';
$_['text_ne_template']  					= 'Modelos Newsletter';
$_['text_ne_support']  						= 'Suporte';
$_['text_ne_support_register']  			= 'Registo para obter o Suporte';
$_['text_ne_support_login']  				= 'Login para obter Suporte';
$_['text_ne_support_dashboard']  			= 'Painel Suporte';
$_['text_ne_update_check']  				= 'Verificar atualizações';
$_['text_default']		  					= 'Padrão';
$_['text_general_settings']		  			= 'Geral';
$_['text_bounce_settings']		  			= 'Emails Devolvidos';
$_['text_throttle_settings']		  		= 'Acelerador';

$_['text_content_top']    					= 'Topo do Conteudo';
$_['text_content_bottom'] 					= 'Rodape do Conteudo';
$_['text_column_left']    					= 'Coluna Esquerda';
$_['text_column_right']   					= 'Coluna Direta';

$_['text_cron_command']   					= '0 * * * * /usr/bin/wget "%s"';
$_['text_help'] 							= '* * * * * comando a ser executado<br/>- - - - -<br/>| | | | |<br/>| | | | +- - - - dias da semana (0 - 6) (Domingo=0)<br/>| | | +- - - - - mês (1 - 12)<br/>| | +- - - - - - dia do mês (1 - 31)<br/>| +- - - - - - - hora (0 - 23)<br/>+- - - - - - - - minutos (0 - 59)';
$_['text_licence_info'] 					= 'Para ativar o módulo de fornecer seu e-mail que foi usado para a compra do módulo e ordem identificação.';

// Entry
$_['entry_use_throttle']					= 'Use acelerador quando o envio de e-mails:';
$_['entry_use_embedded_images']				= 'Use imagens embutidas no boletim:.<br /> <span class="help"> Não suportado pelo Gmail web app </span>';
$_['entry_throttle_emails']					= 'E-mails para enviar uma iteração:. <br /> <span Class="help"> Número de e-mails para enviar </span>';
$_['entry_throttle_time']					= 'Intervalo de acelerador:<br /><span class="help">Time in hours.</span>';
$_['entry_sent_retries']					= 'Tentativas contar:<br /><span class="help">Quantidade de tentativas para enviar newsletter para endereço de e-mail especificado.</span>';
$_['entry_show_unloginned_subscribe']		= 'Mostrar caixa para "Inscrever":';
$_['entry_show_unloginned_modal']			= '"Inscrever" como pop-up modal:';
$_['entry_unloginned_subscribe_fields']		= 'Campos de caixa "Inscrever":';
$_['entry_modal_timeout']					= 'Tempo limite de pop-up modal:<br/><span class="help">Tempo em segundos antes de pop-up será fechada. Se não especificado ou zero, botão fechar será adicionado.</span>';
$_['entry_subscribe_email']					= 'Apenas o email';
$_['entry_subscribe_email_name']			= 'E-mail e nome';
$_['entry_subscribe_email_name_lastname']	= 'Email, nome e sobrenome';
$_['entry_name']							= 'Nome';
$_['entry_yes']								= 'Sim';
$_['entry_no']								= 'Não';
$_['entry_layout']        					= 'Layout:';
$_['entry_position']      					= 'Posição:';
$_['entry_status']        					= 'Status:';
$_['entry_sort_order']    					= 'Ordem:';
$_['entry_cron_code']						= 'Comando Cron:';
$_['entry_cron_help']						= 'Ajuda comando Cron:';
$_['entry_list']							= 'Listas de marketing:';
$_['entry_weekdays']						= 'Dias da semana:';
$_['entry_months']							= 'Mês:';
$_['entry_january']							= 'Janeiro';
$_['entry_february']						= 'Fevereiro';
$_['entry_march']							= 'Março';
$_['entry_april']							= 'Abril';
$_['entry_may']								= 'Maio';
$_['entry_june']							= 'Junho';
$_['entry_july']							= 'Julho';
$_['entry_august']							= 'Agosto';
$_['entry_september']						= 'Setembro';
$_['entry_october']							= 'Outubro';
$_['entry_november']						= 'Novembro';
$_['entry_december']						= 'Dezembro';
$_['entry_sunday']							= 'Domingo';
$_['entry_monday']							= 'Segunda';
$_['entry_tuesday']							= 'Terça';
$_['entry_wednesday']						= 'Quarta';
$_['entry_thursday']						= 'Quinta';
$_['entry_friday']							= 'Sexta';
$_['entry_saturday']						= 'Sábado';
$_['entry_use_bounce_check']				= 'Verificar e-mails devolvidos';
$_['entry_bounce_email']					= 'Endereço de email para e-mails devolvidos<br/><span class="help">Endereço de e-mail para receber e-mails devolvidos</span>';
$_['entry_bounce_pop3_server']				= 'POP3 servidor de e-mails devolvidos<br/><span class="help">POP3 nome de servidor ou endereço IP</span>';
$_['entry_bounce_pop3_user']				= 'POP3 login do servidor<br/><span class="help">Faça Login para autenticar no servidor</span>';
$_['entry_bounce_pop3_password']			= 'POP3 senha do servidor<br/><span class="help">Senha para autenticação no servidor</span>';
$_['entry_bounce_pop3_port']				= 'POP3 porta do servidor<br/><span class="help">Se a porta, vazio 110 será usado</span>';
$_['entry_bounce_delete']					= 'Excluir e-mails saltado<br/><span class="help">Se sim, conhecidos emails que serão excluídos da caixa de correio</span>';
$_['entry_all']								= 'Todos';
$_['entry_guests']							= 'Convidados';
$_['entry_nobody']							= 'Ninguém';
$_['entry_transaction_id'] 					= 'ID da Compra:';
$_['entry_transaction_email'] 				= 'E-mail:';

// Button
$_['button_add_list']   					= 'Adicionar';

// Error
$_['error_permission']						= 'Aviso: Você não tem permissão para modificar o módulo Newsletter Enhancements!';

$_['entry_use_smtp']						= 'Use a configuração de e-mail personalizado:';
$_['entry_mail_protocol']					= 'Mail Protocolo:<span class="help">Apenas escolher \'Mail\' a menos que seu host desativou a função php mail.';
$_['text_mail']								= 'Mail';
$_['text_smtp']								= 'SMTP';
$_['entry_email']							= 'Endereço de email:';
$_['entry_mail_parameter']					= 'Parâmetros de e-mail:<span class="help">quando se utiliza \'Mail\', parâmetros de correio adicionais podem ser adicionados aqui (e.g. "-femail@storeaddress.com".';
$_['entry_smtp_host']						= 'SMTP Host:';
$_['entry_smtp_username']					= 'SMTP Usuário:';
$_['entry_smtp_password']					= 'SMTP Senha:';
$_['entry_smtp_port']						= 'SMTP Porta:';
$_['entry_smtp_timeout']					= 'SMTP Timeout:';
$_['entry_stores']							= 'Lojas:';
$_['text_smtp_settings']					= 'Configurações de e-mail';

?>
