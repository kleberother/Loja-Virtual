<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeSubscribe extends Controller {

	public function index() {
		if (isset($this->request->get['uid']) && $this->request->get['uid'] && isset($this->request->get['key']) && $this->request->get['key']) {
			$uid = base64_decode(urldecode($this->request->get['uid']));
			$test = explode('|', $uid);

			if (count($test) == 2) {
				$email = $test[0];
				$uid = $test[1];

				$key = md5($this->config->get('ne_key') . $email);

				if ($key == $this->request->get['key']) {
					$this->load->model('ne/account');
					if ($this->model_ne_account->subscribe(array('uid' => $uid, 'email' => $email))) {
						$this->load->language('ne/account');
						$this->session->data['success'] = $this->language->get('text_subscribe_success');
					}
				}
			}
		}

		$this->response->redirect($this->url->link('account/account'));
	}
}

?>