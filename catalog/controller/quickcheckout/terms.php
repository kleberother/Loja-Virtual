<?php  
class ControllerQuickCheckoutTerms extends Controller {
  	public function index() {
		$this->language->load('quickcheckout/checkout');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
			
			if ($information_info) {
				$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_checkout_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$this->data['text_agree'] = '';
			}
		} else {
			$this->data['text_agree'] = '';
		}
		
		if (isset($this->session->data['agree'])) { 
			$this->data['agree'] = $this->session->data['agree'];
		} else {
			$this->data['agree'] = '';
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/quickcheckout/terms.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/quickcheckout/terms.tpl';
		} else {
			$this->template = 'default/template/quickcheckout/terms.tpl';
		}
		
		$this->response->setOutput($this->render());
	}
	
	public function validate() {
		$this->language->load('quickcheckout/checkout');
		
		$json = array();
		
		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');
				
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
				
			if ($information_info && !isset($this->request->post['agree'])) {
				$json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>