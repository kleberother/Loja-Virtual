<?php
class ControllerModulefbconnect extends Controller {
	protected function index($setting) {

		$this->language->load('module/fbconnect'); 
		$this->data['heading_title'] = $this->language->get('heading_title');

		if(!$this->customer->isLogged()){

			if(!isset($this->fbconnect)){			
				require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');
				$this->fbconnect = new Facebook(array(
					'appId'  => $this->config->get('fbconnect_apikey'),
					'secret' => $this->config->get('fbconnect_apisecret'),
				));
			}

			$this->data['fbconnect_url'] = $this->fbconnect->getLoginUrl(
				array(
					'scope' => 'email,user_birthday,user_location,user_hometown',
					'redirect_uri'  => $this->url->link('account/fbconnect', '', 'SSL')
				)
			);

			if($this->config->get('fbconnect_button_' . $this->config->get('config_language_id'))){
				$this->data['fbconnect_button'] = html_entity_decode($this->config->get('fbconnect_button_' . $this->config->get('config_language_id')));
			}
			else $this->data['fbconnect_button'] = $this->language->get('heading_title');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/fbconnect.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/fbconnect.tpl';
			} else {
				$this->template = 'default/template/module/fbconnect.tpl';
			}

			$this->render();
		}				

	}
}
?>