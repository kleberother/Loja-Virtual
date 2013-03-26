<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerModuleNe extends Controller {
	
	private $error = array();
	
	private $_name = 'ne';
	
	public function install() {
		$this->load->model('module/' . $this->_name);
		$this->model_module_ne->install();

		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		$months = array();
		$weekdays = array();

		$this->load->language('module/' . $this->_name);

		foreach ($languages as $language) {
			$months[$language['language_id']][0] = $this->language->get('entry_january');
			$months[$language['language_id']][1] = $this->language->get('entry_february');
			$months[$language['language_id']][2] = $this->language->get('entry_march');
			$months[$language['language_id']][3] = $this->language->get('entry_april');
			$months[$language['language_id']][4] = $this->language->get('entry_may');
			$months[$language['language_id']][5] = $this->language->get('entry_june');
			$months[$language['language_id']][6] = $this->language->get('entry_july');
			$months[$language['language_id']][7] = $this->language->get('entry_august');
			$months[$language['language_id']][8] = $this->language->get('entry_september');
			$months[$language['language_id']][9] = $this->language->get('entry_october');
			$months[$language['language_id']][10] = $this->language->get('entry_november');
			$months[$language['language_id']][11] = $this->language->get('entry_december');

			$weekdays[$language['language_id']][0] = $this->language->get('entry_sunday');
			$weekdays[$language['language_id']][1] = $this->language->get('entry_monday');
			$weekdays[$language['language_id']][2] = $this->language->get('entry_tuesday');
			$weekdays[$language['language_id']][3] = $this->language->get('entry_wednesday');
			$weekdays[$language['language_id']][4] = $this->language->get('entry_thursday');
			$weekdays[$language['language_id']][5] = $this->language->get('entry_friday');
			$weekdays[$language['language_id']][6] = $this->language->get('entry_saturday');
		}
		
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting($this->_name, array(
			$this->_name . '_throttle' => 0,
			$this->_name . '_embedded_images' => 0,
			$this->_name . '_throttle_count' => 100,
			$this->_name . '_throttle_time' => 3600,
			$this->_name . '_sent_retries' => 3,
			$this->_name . '_show_unloginned_subscribe' => 0,
			$this->_name . '_unloginned_subscribe_fields' => 1,
			$this->_name . '_modal_timeout' => 120,
			$this->_name . '_months' => $months,
			$this->_name . '_weekdays' => $weekdays,
			$this->_name . '_marketing_list' => array(),
			$this->_name . '_bounce' => false,
			$this->_name . '_bounce_email' => '',
			$this->_name . '_bounce_pop3_server' => '',
			$this->_name . '_bounce_pop3_user' => '',
			$this->_name . '_bounce_pop3_password' => '',
			$this->_name . '_bounce_pop3_port' => '',
			$this->_name . '_bounce_delete' => '',
			$this->_name . '_smtp' => array(),
			$this->_name . '_use_smtp' => ''
		));
	}
	
	public function uninstall() {
		$this->load->model('module/' . $this->_name);
		$this->model_module_ne->uninstall();
	}
	
	public function index() {
		$this->load->language('module/' . $this->_name);
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		$this->init();
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting($this->_name, array_merge($this->request->post, array($this->_name . '_key' => $this->config->get($this->_name . '_key'))));
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_help'] = $this->language->get('text_help');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_module_settings'] = $this->language->get('text_module_settings');
		$this->data['text_module_localization'] = $this->language->get('text_module_localization');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_general_settings'] = $this->language->get('text_general_settings');
		$this->data['text_bounce_settings'] = $this->language->get('text_bounce_settings');
		$this->data['text_throttle_settings'] = $this->language->get('text_throttle_settings');
		
		$this->data['entry_use_throttle'] = $this->language->get('entry_use_throttle');
		$this->data['entry_use_embedded_images'] = $this->language->get('entry_use_embedded_images');
		$this->data['entry_throttle_emails'] = $this->language->get('entry_throttle_emails');
		$this->data['entry_throttle_time'] = $this->language->get('entry_throttle_time');
		$this->data['entry_sent_retries'] = $this->language->get('entry_sent_retries');
		$this->data['entry_show_unloginned_subscribe'] = $this->language->get('entry_show_unloginned_subscribe');
		$this->data['entry_show_unloginned_modal'] = $this->language->get('entry_show_unloginned_modal');
		$this->data['entry_modal_timeout'] = $this->language->get('entry_modal_timeout');
		$this->data['entry_unloginned_subscribe_fields'] = $this->language->get('entry_unloginned_subscribe_fields');
		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');
		$this->data['entry_cron_code'] = $this->language->get('entry_cron_code');
		$this->data['entry_cron_help'] = $this->language->get('entry_cron_help');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_list'] = $this->language->get('entry_list');
		$this->data['entry_subscribe_email'] = $this->language->get('entry_subscribe_email');
		$this->data['entry_subscribe_email_name'] = $this->language->get('entry_subscribe_email_name');
		$this->data['entry_subscribe_email_name_lastname'] = $this->language->get('entry_subscribe_email_name_lastname');

		$this->data['entry_use_bounce_check'] = $this->language->get('entry_use_bounce_check');
		$this->data['entry_bounce_email'] = $this->language->get('entry_bounce_email');
		$this->data['entry_bounce_pop3_server'] = $this->language->get('entry_bounce_pop3_server');
		$this->data['entry_bounce_pop3_user'] = $this->language->get('entry_bounce_pop3_user');
		$this->data['entry_bounce_pop3_password'] = $this->language->get('entry_bounce_pop3_password');
		$this->data['entry_bounce_pop3_port'] = $this->language->get('entry_bounce_pop3_port');
		$this->data['entry_bounce_delete'] = $this->language->get('entry_bounce_delete');

		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['entry_months'] = $this->language->get('entry_months');
		$this->data['entry_january'] = $this->language->get('entry_january');
		$this->data['entry_february'] = $this->language->get('entry_february');
		$this->data['entry_march'] = $this->language->get('entry_march');
		$this->data['entry_april'] = $this->language->get('entry_april');
		$this->data['entry_may'] = $this->language->get('entry_may');
		$this->data['entry_june'] = $this->language->get('entry_june');
		$this->data['entry_july'] = $this->language->get('entry_july');
		$this->data['entry_august'] = $this->language->get('entry_august');
		$this->data['entry_september'] = $this->language->get('entry_september');
		$this->data['entry_october'] = $this->language->get('entry_october');
		$this->data['entry_november'] = $this->language->get('entry_november');
		$this->data['entry_december'] = $this->language->get('entry_december');

		$this->data['entry_weekdays'] = $this->language->get('entry_weekdays');
		$this->data['entry_sunday'] = $this->language->get('entry_sunday');
		$this->data['entry_monday'] = $this->language->get('entry_monday');
		$this->data['entry_tuesday'] = $this->language->get('entry_tuesday');
		$this->data['entry_wednesday'] = $this->language->get('entry_wednesday');
		$this->data['entry_thursday'] = $this->language->get('entry_thursday');
		$this->data['entry_friday'] = $this->language->get('entry_friday');
		$this->data['entry_saturday'] = $this->language->get('entry_saturday');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_add_list'] = $this->language->get('button_add_list');

		$this->data['text_smtp_settings'] = $this->language->get('text_smtp_settings');
		$this->data['entry_use_smtp'] = $this->language->get('entry_use_smtp');
		$this->data['entry_mail_protocol'] = $this->language->get('entry_mail_protocol');
		$this->data['text_mail'] = $this->language->get('text_mail');
		$this->data['text_smtp'] = $this->language->get('text_smtp');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_mail_parameter'] = $this->language->get('entry_mail_parameter');
		$this->data['entry_smtp_host'] = $this->language->get('entry_smtp_host');
		$this->data['entry_smtp_username'] = $this->language->get('entry_smtp_username');
		$this->data['entry_smtp_password'] = $this->language->get('entry_smtp_password');
		$this->data['entry_smtp_port'] = $this->language->get('entry_smtp_port');
		$this->data['entry_smtp_timeout'] = $this->language->get('entry_smtp_timeout');
		$this->data['entry_stores'] = $this->language->get('entry_stores');
		$this->data['entry_all'] = $this->language->get('entry_all');
		$this->data['entry_guests'] = $this->language->get('entry_guests');
		$this->data['entry_nobody'] = $this->language->get('entry_nobody');
		
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
			'href'      => $this->url->link('module/' . $this->_name, 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('module/' . $this->_name, 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->post[$this->_name . '_bounce'])) {
			$this->data[$this->_name . '_bounce'] = $this->request->post[$this->_name . '_bounce'];
		} else {
			$this->data[$this->_name . '_bounce'] = $this->config->get($this->_name . '_bounce');
		}

		if (isset($this->request->post[$this->_name . '_bounce_email'])) {
			$this->data[$this->_name . '_bounce_email'] = $this->request->post[$this->_name . '_bounce_email'];
		} else {
			$this->data[$this->_name . '_bounce_email'] = $this->config->get($this->_name . '_bounce_email');
		}

		if (isset($this->request->post[$this->_name . '_bounce_pop3_server'])) {
			$this->data[$this->_name . '_bounce_pop3_server'] = $this->request->post[$this->_name . '_bounce_pop3_server'];
		} else {
			$this->data[$this->_name . '_bounce_pop3_server'] = $this->config->get($this->_name . '_bounce_pop3_server');
		}

		if (isset($this->request->post[$this->_name . '_bounce_pop3_user'])) {
			$this->data[$this->_name . '_bounce_pop3_user'] = $this->request->post[$this->_name . '_bounce_pop3_user'];
		} else {
			$this->data[$this->_name . '_bounce_pop3_user'] = $this->config->get($this->_name . '_bounce_pop3_user');
		}

		if (isset($this->request->post[$this->_name . '_bounce_pop3_password'])) {
			$this->data[$this->_name . '_bounce_pop3_password'] = $this->request->post[$this->_name . '_bounce_pop3_password'];
		} else {
			$this->data[$this->_name . '_bounce_pop3_password'] = $this->config->get($this->_name . '_bounce_pop3_password');
		}

		if (isset($this->request->post[$this->_name . '_bounce_pop3_port'])) {
			$this->data[$this->_name . '_bounce_pop3_port'] = $this->request->post[$this->_name . '_bounce_pop3_port'];
		} else {
			$this->data[$this->_name . '_bounce_pop3_port'] = $this->config->get($this->_name . '_bounce_pop3_port');
		}

		if (isset($this->request->post[$this->_name . '_bounce_delete'])) {
			$this->data[$this->_name . '_bounce_delete'] = $this->request->post[$this->_name . '_bounce_delete'];
		} else {
			$this->data[$this->_name . '_bounce_delete'] = $this->config->get($this->_name . '_bounce_delete');
		}

		if (isset($this->request->post[$this->_name . '_throttle'])) {
			$this->data[$this->_name . '_throttle'] = $this->request->post[$this->_name . '_throttle'];
		} else {
			$this->data[$this->_name . '_throttle'] = $this->config->get($this->_name . '_throttle');
		}

		if (isset($this->request->post[$this->_name . '_use_smtp'])) {
			$this->data[$this->_name . '_use_smtp'] = $this->request->post[$this->_name . '_use_smtp'];
		} else {
			$this->data[$this->_name . '_use_smtp'] = $this->config->get($this->_name . '_use_smtp');
		}

		if (isset($this->request->post[$this->_name . '_embedded_images'])) {
			$this->data[$this->_name . '_embedded_images'] = $this->request->post[$this->_name . '_embedded_images'];
		} else {
			$this->data[$this->_name . '_embedded_images'] = $this->config->get($this->_name . '_embedded_images');
		}

		if (isset($this->request->post[$this->_name . '_throttle_count'])) {
			$this->data[$this->_name . '_throttle_count'] = $this->request->post[$this->_name . '_throttle_count'];
		} else {
			$this->data[$this->_name . '_throttle_count'] = $this->config->get($this->_name . '_throttle_count');
		}

		if (isset($this->request->post[$this->_name . '_throttle_time'])) {
			$this->data[$this->_name . '_throttle_time'] = $this->request->post[$this->_name . '_throttle_time'];
		} else {
			$this->data[$this->_name . '_throttle_time'] = $this->config->get($this->_name . '_throttle_time');
		}

		if (isset($this->request->post[$this->_name . '_sent_retries'])) {
			$this->data[$this->_name . '_sent_retries'] = $this->request->post[$this->_name . '_sent_retries'];
		} else {
			$this->data[$this->_name . '_sent_retries'] = $this->config->get($this->_name . '_sent_retries');
		}

		if (isset($this->request->post[$this->_name . '_show_unloginned_subscribe'])) {
			$this->data[$this->_name . '_show_unloginned_subscribe'] = $this->request->post[$this->_name . '_show_unloginned_subscribe'];
		} else {
			$this->data[$this->_name . '_show_unloginned_subscribe'] = $this->config->get($this->_name . '_show_unloginned_subscribe');
		}

		if (isset($this->request->post[$this->_name . '_modal_timeout'])) {
			$this->data[$this->_name . '_modal_timeout'] = (int)$this->request->post[$this->_name . '_modal_timeout'];
		} else {
			$this->data[$this->_name . '_modal_timeout'] = (int)$this->config->get($this->_name . '_modal_timeout');
		}

		if (isset($this->request->post[$this->_name . '_unloginned_subscribe_fields'])) {
			$this->data[$this->_name . '_unloginned_subscribe_fields'] = $this->request->post[$this->_name . '_unloginned_subscribe_fields'];
		} else {
			$this->data[$this->_name . '_unloginned_subscribe_fields'] = $this->config->get($this->_name . '_unloginned_subscribe_fields');
		}

		if (isset($this->request->post[$this->_name . '_marketing_list'])) {
			$this->data['list_data'] = $this->request->post[$this->_name . '_marketing_list'];
		} else {
			$this->data['list_data'] = $this->config->get($this->_name . '_marketing_list');
		}

		if (isset($this->request->post[$this->_name . '_smtp'])) {
			$this->data[$this->_name . '_smtp'] = $this->request->post[$this->_name . '_smtp'];
		} else {
			$this->data[$this->_name . '_smtp'] = $this->config->get($this->_name . '_smtp');
		}

		if (isset($this->request->post[$this->_name . '_months'])) {
			$this->data[$this->_name . '_months'] = $this->request->post[$this->_name . '_months'];
		} else {
			$this->data[$this->_name . '_months'] = $this->config->get($this->_name . '_months');
		}

		if (isset($this->request->post[$this->_name . '_weekdays'])) {
			$this->data[$this->_name . '_weekdays'] = $this->request->post[$this->_name . '_weekdays'];
		} else {
			$this->data[$this->_name . '_weekdays'] = $this->config->get($this->_name . '_weekdays');
		}

		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$store_url = (defined('HTTPS_CATALOG') ? HTTPS_CATALOG : HTTP_CATALOG);
		} else {
			$store_url = HTTP_CATALOG;
		}

		$cron_url = $this->url->link('ne/cron', 'key=' . md5($this->config->get($this->_name . '_key')));
		$cron_url = str_replace(array(HTTP_SERVER, HTTPS_SERVER), $store_url, $cron_url);
		$this->data['cron_url'] = sprintf($this->language->get('text_cron_command'), $cron_url);

		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();

		$this->data['modules'] = array();
		
		if (isset($this->request->post[$this->_name . '_module'])) {
			$this->data['modules'] = $this->request->post[$this->_name . '_module'];
		} elseif ($this->config->get($this->_name . '_module')) { 
			$this->data['modules'] = $this->config->get($this->_name . '_module');
		}
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->template = 'module/' . $this->_name . '.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/' . $this->_name)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}

	private function genRandomString() {
		$length = 32;
		$characters = '0123456789abcdefghijklmnopqrstuvwxyz';
		$string = '';
		for ($p = 0; $p < $length; $p++) {
			$string .= $characters[mt_rand(0, strlen($characters) - 1)];
		}
		return $string;
	}

	private function init() {
		eval(base64_decode('aWYgKCEkdGhpcy0+Y29uZmlnLT5nZXQoJHRoaXMtPl9uYW1lIC4gJ19rZXknKSkgewoJaWYgKCR0aGlzLT5yZXF1ZXN0LT5zZXJ2ZXJbJ1JFUVVFU1RfTUVUSE9EJ10gPT0gJ1BPU1QnICYmIGlzc2V0KCR0aGlzLT5yZXF1ZXN0LT5wb3N0Wyd0cmFuc2FjdGlvbl9pZCddKSAmJiAkdGhpcy0+cmVxdWVzdC0+cG9zdFsndHJhbnNhY3Rpb25faWQnXSAmJiBpc3NldCgkdGhpcy0+cmVxdWVzdC0+cG9zdFsnZW1haWwnXSkgJiYgZmlsdGVyX3ZhcigkdGhpcy0+cmVxdWVzdC0+cG9zdFsnZW1haWwnXSwgRklMVEVSX1ZBTElEQVRFX0VNQUlMKSkgewoKCQkkc3RvcmVfaW5mbyA9ICR0aGlzLT5tb2RlbF9zZXR0aW5nX3NldHRpbmctPmdldFNldHRpbmcoJ2NvbmZpZycsIDApOwoKCQkkaGVhZGVycyAgPSAnTUlNRS1WZXJzaW9uOiAxLjAnIC4gIlxyXG4iOwoJCSRoZWFkZXJzIC49ICdDb250ZW50LXR5cGU6IHRleHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xJyAuICJcclxuIjsKCgkJJGhlYWRlcnMgLj0gJ1RvOiBORSBMaWNlbnNvciA8bmV3c2xldHRlcmxpY2Vuc2VAZ21haWwuY29tPicgLiAiXHJcbiI7CgkJJGhlYWRlcnMgLj0gJ0Zyb206ICcgLiAkc3RvcmVfaW5mb1snY29uZmlnX25hbWUnXSAuICcgPCcgLiAkc3RvcmVfaW5mb1snY29uZmlnX2VtYWlsJ10gLiAnPicgLiAiXHJcbiI7CgoJCSRzZXJ2ZXIgPSBleHBsb2RlKCcvJywgcnRyaW0oSFRUUF9TRVJWRVIsICcvJykpOwoJCWFycmF5X3BvcCgkc2VydmVyKTsKCQkkc2VydmVyID0gaW1wbG9kZSgnLycsICRzZXJ2ZXIpOwoKCQlAbWFpbCgnbmV3c2xldHRlcmxpY2Vuc2VAZ21haWwuY29tJywgJ05ldyBSZWdpc3RyYXRpb24gJyAuICRzZXJ2ZXIsICJUaGUgJHNlcnZlciB3aXRoIG9yZGVyOiAiIC4gJHRoaXMtPnJlcXVlc3QtPnBvc3RbJ3RyYW5zYWN0aW9uX2lkJ10gLiAiIGFuZCBlLW1haWw6ICIgLiAkdGhpcy0+cmVxdWVzdC0+cG9zdFsnZW1haWwnXSAuICIgaGFzIGFjdGl2YXRlZCBhIG5ldyBsaWNlbmNlLiIsICRoZWFkZXJzKTsJCgoJCSR0aGlzLT5sb2FkLT5tb2RlbCgnc2V0dGluZy9zZXR0aW5nJyk7CgkJJGN1cnJlbnRfc2V0dGluZyA9ICR0aGlzLT5tb2RlbF9zZXR0aW5nX3NldHRpbmctPmdldFNldHRpbmcoJHRoaXMtPl9uYW1lKTsKCQlpZiAoISRjdXJyZW50X3NldHRpbmcpIHsKCQkJJGN1cnJlbnRfc2V0dGluZyA9IGFycmF5KCk7CgkJfQoJCSRuZXcgPSBhcnJheV9tZXJnZSgkY3VycmVudF9zZXR0aW5nLCBhcnJheSgkdGhpcy0+X25hbWUgLiAnX2tleScgPT4gJHRoaXMtPmdlblJhbmRvbVN0cmluZygpKSk7CgkJJHRoaXMtPm1vZGVsX3NldHRpbmdfc2V0dGluZy0+ZWRpdFNldHRpbmcoJHRoaXMtPl9uYW1lLCAkbmV3KTsKCgkJJHRoaXMtPnJlZGlyZWN0KCR0aGlzLT51cmwtPmxpbmsoJ21vZHVsZS9uZScsICd0b2tlbj0nIC4gJHRoaXMtPnNlc3Npb24tPmRhdGFbJ3Rva2VuJ10sICdTU0wnKSk7Cgl9CgoJJHRoaXMtPmRhdGFbJ3RleHRfbGljZW5jZV9pbmZvJ10gPSAkdGhpcy0+bGFuZ3VhZ2UtPmdldCgndGV4dF9saWNlbmNlX2luZm8nKTsKCSR0aGlzLT5kYXRhWydlbnRyeV90cmFuc2FjdGlvbl9pZCddID0gJHRoaXMtPmxhbmd1YWdlLT5nZXQoJ2VudHJ5X3RyYW5zYWN0aW9uX2lkJyk7CgkkdGhpcy0+ZGF0YVsnZW50cnlfdHJhbnNhY3Rpb25fZW1haWwnXSA9ICR0aGlzLT5sYW5ndWFnZS0+Z2V0KCdlbnRyeV90cmFuc2FjdGlvbl9lbWFpbCcpOwoJJHRoaXMtPmRhdGFbJ2xpY2Vuc29yJ10gPSB0cnVlOwoJCgkkdGhpcy0+dGVtcGxhdGUgPSAnbW9kdWxlLycgLiAkdGhpcy0+X25hbWUgLiAnLnRwbCc7CgkkdGhpcy0+Y2hpbGRyZW4gPSBhcnJheSgKCQknY29tbW9uL2hlYWRlcicsCgkJJ2NvbW1vbi9mb290ZXInLAoJKTsJCQkKCSR0aGlzLT5yZXNwb25zZS0+c2V0T3V0cHV0KCR0aGlzLT5yZW5kZXIoKSk7Cn0='));
	}
}
?>