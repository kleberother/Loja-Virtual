<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerModuleNe extends Controller {

	private $_name = 'ne';

	protected function index($setting) {
		static $module = 0;
		
		if (($this->config->get($this->_name . '_show_unloginned_subscribe') == '1' && !$this->customer->isLogged()) || $this->config->get($this->_name . '_show_unloginned_subscribe') == '2') {
			$this->load->language('module/' . $this->_name);

			$is_modal = $setting['is_modal'];

			if ($is_modal) {
				$this->data['subscribe_title'] = $this->language->get('subscribe_modal_title');
				$this->data['subscribe_text'] = $this->language->get('subscribe_modal_text');
				$this->data['subscribe_text_list'] = $this->language->get('subscribe_modal_text_list');
				$this->data['subscribe'] = $this->language->get('subscribe_modal');
				$this->data['close'] = $this->language->get('close');
				$this->data['timer_text'] = $this->language->get('timer_text');
			} else {
				$this->data['subscribe_title'] = $this->language->get('subscribe_title');
				$this->data['subscribe_text'] = $this->language->get('subscribe_text');
				$this->data['subscribe_text_list'] = $this->language->get('subscribe_text_list');
				$this->data['subscribe'] = $this->language->get('subscribe');	
			}

			$this->data['entry_name'] = $this->language->get('entry_name');
			$this->data['entry_firstname'] = $this->language->get('entry_firstname');
			$this->data['entry_lastname'] = $this->language->get('entry_lastname');
			$this->data['entry_email'] = $this->language->get('entry_email');

			if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
				$this->data['subscribe_link'] = $this->url->link('module/ne/subscribe', '', 'SSL');
			} else {
				$this->data['subscribe_link'] = $this->url->link('module/ne/subscribe');
			}

			$list_data = $this->config->get('ne_marketing_list');
			$this->data['list_data'] = isset($list_data[$this->config->get('config_store_id')]) ? $list_data[$this->config->get('config_store_id')] : array();

			$this->data['module'] = $module++;

			if ($is_modal) {
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/ne/modal.css')) {
					$this->document->addStyle(basename(DIR_APPLICATION) . '/view/theme/' . $this->config->get('config_template') . '/stylesheet/ne/modal.css');
				} else {
					$this->document->addStyle(basename(DIR_APPLICATION) . '/view/theme/default/stylesheet/ne/modal.css');
				}

				$this->document->addScript(basename(DIR_APPLICATION) . '/view/javascript/ne/jquery.simplemodal.js');
				$this->document->addScript(basename(DIR_APPLICATION) . '/view/javascript/ne/jquery.countdown.js');
				$this->document->addScript(basename(DIR_APPLICATION) . '/view/javascript/ne/jquery.cookie.js');

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->_name . '/modal.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/' . $this->_name . '/modal.tpl';
				} else {
					$this->template = 'default/template/' . $this->_name . '/modal.tpl';
				}
			} else {
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/ne/subscribe.css')) {
					$this->document->addStyle(basename(DIR_APPLICATION) . '/view/theme/' . $this->config->get('config_template') . '/stylesheet/ne/subscribe.css');
				} else {
					$this->document->addStyle(basename(DIR_APPLICATION) . '/view/theme/default/stylesheet/ne/subscribe.css');
				}

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->_name . '/subscribe.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/' . $this->_name . '/subscribe.tpl';
				} else {
					$this->template = 'default/template/' . $this->_name . '/subscribe.tpl';
				}
			}

			$this->render();
		}
	}

	public function subscribe() {
		if (($this->config->get($this->_name . '_show_unloginned_subscribe') == '1' && !$this->customer->isLogged()) || $this->config->get($this->_name . '_show_unloginned_subscribe') == '2') {
			$this->load->model('module/' . $this->_name);
			$this->load->language('module/' . $this->_name);

			$out = array('message' => $this->language->get('text_subscribe_no_list'), 'type' => 'warning');
			$list_data = $this->config->get('ne_marketing_list');
			if ((isset($this->request->post['list']) && is_array($this->request->post['list']) && count($this->request->post['list'])) || empty($list_data)) {
				if ($this->config->get('ne_unloginned_subscribe_fields') == 2 || $this->config->get('ne_unloginned_subscribe_fields') == 3) {
					$out = array('message' => $this->language->get('text_subscribe_not_valid_data'), 'type' => 'warning');
				} else {
					$out = array('message' => $this->language->get('text_subscribe_not_valid_email'), 'type' => 'warning');
				}

				$result = $this->model_module_ne->subscribe($this->request->post, $this->config->get($this->_name . '_key'), isset($this->request->post['list']) ? $this->request->post['list'] : array());
				if ($result === true) {
					$out = array('message' => $this->language->get('text_subscribe_success'), 'type' => 'success');
				} elseif ($result === null) {
					$out = array('message' => $this->language->get('text_subscribe_exists'), 'type' => 'warning');
				}
			}

			$this->response->addHeader('Content-type: application/json');
			$this->response->setOutput($out ? json_encode($out) : '');
		}
	}
	
}
?>