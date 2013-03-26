<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeCheckUpdate extends Controller {
	private $error = array();
	private $current = '3.5.0';

	public function index() {
		$this->load->language('ne/check_update');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/check_update', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$server_version = @file_get_contents("http://www.codersroom.com/updates/ne.version");
		if (!ctype_digit(trim(str_replace('.', '', $server_version)))) {
			$server_version = $this->current;
		}

		$this->data['refresh'] = $this->url->link('ne/check_update', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['content'] = (($server_version == $this->current) ? sprintf($this->language->get('text_update_latest'), $server_version) : sprintf($this->language->get('text_update_available'), $server_version));
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_check'] = $this->language->get('button_check');
		$this->data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		$this->template = 'ne/check_update.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

}
?>