<?php
class ControllerModuleQuickCheckOut extends Controller {
	private $error = array(); 

	public function index() {  
		$this->load->language('module/quickcheckout');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('quickcheckout', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_address_2'] = $this->language->get('entry_address_2');
		$this->data['entry_fax'] = $this->language->get('entry_fax');
		$this->data['entry_city'] = $this->language->get('entry_city');
		$this->data['entry_zone'] = $this->language->get('entry_zone');
		$this->data['entry_postcode'] = $this->language->get('entry_postcode');
		$this->data['entry_country'] = $this->language->get('entry_country');
		$this->data['entry_survey'] = $this->language->get('entry_survey');
		$this->data['entry_shipping'] = $this->language->get('entry_shipping');
		$this->data['entry_payment'] = $this->language->get('entry_payment');
		$this->data['entry_newsletter'] = $this->language->get('entry_newsletter');
		
		$this->data['text_radio'] = $this->language->get('text_radio');
		$this->data['text_select'] = $this->language->get('text_select');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->data['token'] = $this->session->data['token'];
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false

   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		
		if (isset($this->request->post['quickcheckout_status'])) {
			$this->data['quickcheckout_status'] = $this->request->post['quickcheckout_status'];
		} else {
			$this->data['quickcheckout_status'] = $this->config->get('quickcheckout_status');
		}
		
		if (isset($this->request->post['quickcheckout_company'])) {
			$this->data['quickcheckout_company'] = $this->request->post['quickcheckout_company'];
		} else {
			$this->data['quickcheckout_company'] = $this->config->get('quickcheckout_company');
		}
		
		if (isset($this->request->post['quickcheckout_address_2'])) {
			$this->data['quickcheckout_address_2'] = $this->request->post['quickcheckout_address_2'];
		} else {
			$this->data['quickcheckout_address_2'] = $this->config->get('quickcheckout_address_2');
		}
		
		if (isset($this->request->post['quickcheckout_fax'])) {
			$this->data['quickcheckout_fax'] = $this->request->post['quickcheckout_fax'];
		} else {
			$this->data['quickcheckout_fax'] = $this->config->get('quickcheckout_fax');
		}
		
		if (isset($this->request->post['quickcheckout_city'])) {
			$this->data['quickcheckout_city'] = $this->request->post['quickcheckout_city'];
		} else {
			$this->data['quickcheckout_city'] = $this->config->get('quickcheckout_city');
		}
		
		if (isset($this->request->post['quickcheckout_postcode'])) {
			$this->data['quickcheckout_postcode'] = $this->request->post['quickcheckout_postcode'];
		} else {
			$this->data['quickcheckout_postcode'] = $this->config->get('quickcheckout_postcode');
		}
		
		if (isset($this->request->post['quickcheckout_country'])) {
			$this->data['quickcheckout_country'] = $this->request->post['quickcheckout_country'];
		} else {
			$this->data['quickcheckout_country'] = $this->config->get('quickcheckout_country');
		}
		
		if (isset($this->request->post['quickcheckout_zone'])) {
			$this->data['quickcheckout_zone'] = $this->request->post['quickcheckout_zone'];
		} else {
			$this->data['quickcheckout_zone'] = $this->config->get('quickcheckout_zone');
		}
		
		if (isset($this->request->post['quickcheckout_survey'])) {
			$this->data['quickcheckout_survey'] = $this->request->post['quickcheckout_survey'];
		} else {
			$this->data['quickcheckout_survey'] = $this->config->get('quickcheckout_survey');
		}
		
		if (isset($this->request->post['quickcheckout_shipping'])) {
			$this->data['quickcheckout_shipping'] = $this->request->post['quickcheckout_shipping'];
		} else {
			$this->data['quickcheckout_shipping'] = $this->config->get('quickcheckout_shipping');
		}
		
		if (isset($this->request->post['quickcheckout_payment'])) {
			$this->data['quickcheckout_payment'] = $this->request->post['quickcheckout_payment'];
		} else {
			$this->data['quickcheckout_payment'] = $this->config->get('quickcheckout_payment');
		}
		
		if (isset($this->request->post['quickcheckout_newsletter'])) {
			$this->data['quickcheckout_newsletter'] = $this->request->post['quickcheckout_newsletter'];
		} else {
			$this->data['quickcheckout_newsletter'] = $this->config->get('quickcheckout_newsletter');
		}

		$this->data['action'] = $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'module/quickcheckout.tpl';

		$this->children = array(
			'common/header',
			'common/footer',
		);	
		
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/quickcheckout')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function getlayoutid(){
		$this->load->model('design/layout');
		$layouts = $this->model_design_layout->getLayouts();
		foreach($layouts as $layout){
			if($layout['name']=='Quick Checkout'){
				return $layout['layout_id'];
			}
		}
		
		return false;
	}
	
	public function install(){
		$layoutid = $this->getlayoutid();
		
		if(!$layoutid){
			$layoutdata = array();
			$layoutdata['name'] = 'Quick Checkout';
			$layoutdata['layout_route'][1] = array(
				'store_id'	=> '0',
				'route'		=> 'quickcheckout/'
			);
			
			$this->load->model('design/layout');
			$this->model_design_layout->addLayout($layoutdata);
		}
	}
	
	public function uninstall(){		
		$layoutid = $this->getlayoutid();
		
		if($layoutid){
			$this->load->model('design/layout');
			$this->model_design_layout->deleteLayout($layoutid);
		}
	}
}

?>