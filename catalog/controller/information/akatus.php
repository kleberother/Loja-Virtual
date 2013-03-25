<?php
/*
+---------------------------------------------------+
| 			 MÓDULO DE PAGAMENTO AKATUS 			|
|---------------------------------------------------|
|													|
|  Este módulo permite receber pagamentos através   |
|  do gateway de pagamentos Akatus em lojas			|
|  utilizando a plataforma Prestashop				|
|													|
|---------------------------------------------------|
|													|
|  Desenvolvido por: www.andresa.com.br				|
|					 contato@andresa.com.br			|
|													|
+---------------------------------------------------+
*/

/**
 * @author Andresa Martins da Silva
 * @copyright Andresa Web Studio
 * @site http://www.andresa.com.br
 * @version 1.0 Beta
 **/

class Transacao
{
    const AGUARDANDO_PAGAMENTO  = 'Aguardando Pagamento';
    const EM_ANALISE            = 'Em Análise';
    const APROVADO              = 'Aprovado';
    const CANCELADO             = 'Cancelado';
    const DEVOLVIDO             = 'Devolvido';
    const COMPLETO              = 'Completo';
    
    const ID_PROCESSING             = 2;
    
    const ID_AGUARDANDO_PAGAMENTO   = 10200;
    const ID_EM_ANALISE             = 10201;
    const ID_APROVADO               = 10202;
    const ID_CANCELADO              = 10203;
    const ID_COMPLETO               = 10204;
    const ID_DEVOLVIDO              = 10205;
}

class ControllerInformationAkatus extends Controller
{
	private $error = array();
      
	public function index() {
		
		$this->language->load('information/akatus'); 
		
		$this->data['breadcrumbs'] = array();
		
		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),           
			'separator' => false
		);
		
		$this->data['breadcrumbs'][] = array(
			'text'      => 'head title',
			'href'      => $this->url->link('information/akatus'),
			'separator' => '/'
		);   
		
		$tipo=$_REQUEST['tipo'];
		
		if( $tipo == 1 ) {
			
			$this->document->setTitle('Pedido Concluído - Pagamento em Análise'); 
			$this->data['heading_title'] = 'Pagamento em Análise'; 
			$this->data['conteudo_centro'] = 'Obrigado por seu pedido! Seu pagamento encontra-se em análise pela operadora do seu cartão e assim que aprovado, você receberá um e-mail informando.';
			
		}else if ( $tipo == 2 ) {
			
			$this->document->setTitle('Pagamento não autorizado'); 
			$this->data['heading_title'] = 'Pagamento não autorizado'; 
			$this->data['conteudo_centro'] = 'Seu pagamento não foi autorizado pela operadora do cartão. Você pode ter digitado algum dado errado, ou a operação ultrapassa o limite atual disponível no seu cartão de crédito. Por favor, efetue um novo pedido e verifique se os seus dados estão corretos. Caso seja necessário, você também poderá escolher uma outra forma de pagamento.';
		
		}else if($tipo==3){
			#pagamento aprovado
			
			$this->document->setTitle('Pedido Concluído - Pagamento Aprovado'); 
			$this->data['heading_title'] = 'Pagamento Aprovado'; 
			$this->data['conteudo_centro'] = 'Obrigado por seu pedido! Seu pagamento foi Aprovado com sucesso pela operadora do seu cartão de crédito e em breve o envio começará a ser processado. Você receberá por e-mail novas informações de acordo com o andamento do seu pedido.';
			
		}
		else if($tipo==4)
		{
			#erro
			
			$this->document->setTitle('Erro no pagamento'); 
			$this->data['heading_title'] = "O seguinte erro ocorreu:"; 
			$this->data['conteudo_centro'] = urldecode($_REQUEST['msg']).'<BR>';
		
		}
		else if($tipo==5)
		{
			$this->data['heading_title'] = "Obrigado por seu pedido!"; 
			$this->data['conteudo_centro'] = 'Seu pedido foi enviado com sucesso. Contudo, é necessário que seja efetuado o pagamento do boleto bancário para que ele possa ser processado. Para imprimir seu boleto, clique no botão abaixo:<BR><BR><a href="'.urldecode($_REQUEST['url_boleto']).'" target="_blank"><img src="/catalog/view/theme/default/image/botao_imprimir_boleto.png" /></a><BR>';
		
		}
		else if($tipo==6)
		{
			#Pagamento concluído com TEF / Débito
			$this->document->setTitle('Pedido Concluído - Pagamento Aprovado'); 
			$this->data['heading_title'] = 'Pagamento Aprovado'; 
			$this->data['conteudo_centro'] = 'Obrigado por seu pedido! Seu pagamento foi Aprovado com sucesso pelo seu banco e em breve o envio começará a ser processado. Você receberá por e-mail novas informações de acordo com o andamento do seu pedido.';
		}
			else
		{
			exit;
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/akatus.tpl')) 
		{ 
			$this->template = $this->config->get('config_template') . '/template/information/akatus.tpl';
		} else {
			$this->template = 'default/template/information/akatus.tpl'; 
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
		
		$this->response->setOutput($this->render());      
	}
	 
	 
	 
     
     
	public function retorno(){
	
		if($this->request->server['REQUEST_METHOD'] == 'POST')
		{	
			//verifica o token cadastrado no sistema;
			$tokenNip = $this->config->get('akatus_token_nip');			
			if($tokenNip != $this->request->post['token']) die;
			
			//pega o pedido pela refencia
			$this->load->model('account/order');			
			$order = $this->model_account_order->getOrder($this->request->post["referencia"]);

			$novoStatus = $this->getNovoStatus($this->request->post['status'], $order['order_status_id']);
		
			if ($novoStatus) {
				$this->load->model('payment/akatus');
				$this->model_payment_akatus->setOrderStatus($order['order_id'],$novoStatus);
			}
		}
	}
     
     
    private function getNovoStatus($statusRecebido, $statusAtual)
	{
    	switch ($statusRecebido) {

        case Transacao::AGUARDANDO_PAGAMENTO:
            if ($statusAtual == Transacao::ID_PROCESSING) {
                return Transacao::ID_AGUARDANDO_PAGAMENTO;
            } else {
                return false;
            }

        case Transacao::EM_ANALISE:
            $listaStatus = array(
                Transacao::ID_PROCESSING,
                Transacao::ID_AGUARDANDO_PAGAMENTO
            );            
            
            if (in_array($statusAtual, $listaStatus)) {
                return Transacao::ID_EM_ANALISE;
            } else {
                return false;
            }

        case Transacao::APROVADO:
            $listaStatus = array(
                Transacao::ID_PROCESSING,                
                Transacao::ID_AGUARDANDO_PAGAMENTO,
                Transacao::ID_EM_ANALISE
            );
            
            if (in_array($statusAtual, $listaStatus)) {
                return Transacao::ID_APROVADO;
            }

        case Transacao::CANCELADO:
            $listaStatus = array(
                Transacao::ID_PROCESSING,
                Transacao::ID_AGUARDANDO_PAGAMENTO,
                Transacao::ID_EM_ANALISE
            );
            
            if (in_array($statusAtual, $listaStatus)) {
                return Transacao::ID_CANCELADO;
            }

        case Transacao::COMPLETO:
            $listaStatus = array(
                Transacao::ID_PROCESSING,
                Transacao::ID_AGUARDANDO_PAGAMENTO,
                Transacao::ID_EM_ANALISE,
                Transacao::ID_APROVADO,
            );                

            if (in_array($statusAtual, $listaStatus)) {
                return Transacao::ID_COMPLETO;
            } else {
                return false;
            }            

        case Transacao::DEVOLVIDO:
            $listaStatus = array(
                Transacao::ID_APROVADO,
                Transacao::ID_COMPLETO
            );
            
            if (in_array($statusAtual, $listaStatus)) {
                return Transacao::ID_DEVOLVIDO;                    
            } else {
                return false;
            }            
            
        default:
            return false;
    	}
	}
}
?>
