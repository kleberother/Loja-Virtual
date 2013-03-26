<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeTemplate extends Controller {
	private $error = array();
	 
	public function index() {
		$this->load->language('ne/template');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/template');
		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['edit'] = $this->url->link('ne/template/update', 'token=' . $this->session->data['token'] . '&id=', 'SSL');
		$this->data['insert'] = $this->url->link('ne/template/insert', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('ne/template/delete', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['copy'] = $this->url->link('ne/template/copy', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['copy_default'] = $this->url->link('ne/template/copy_default', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['templates'] = array();
		
		$results = $this->model_ne_template->getList();
		
		foreach ($results as $result) {
			$this->data['templates'][] = array_merge($result, array(
				'selected' => isset($this->request->post['selected']) && is_array($this->request->post['selected']) && in_array($result['template_id'], $this->request->post['selected'])
			));
		}
		unset($result);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_last_change'] = $this->language->get('column_last_change');
		$this->data['column_actions'] = $this->language->get('column_actions');
		
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_copy'] = $this->language->get('button_copy');
		$this->data['button_copy_default'] = $this->language->get('button_copy_default');
		$this->data['button_edit'] = $this->language->get('button_edit');
		
		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->template = 'ne/template.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function update() {
		$this->load->language('ne/template');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/template');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_ne_template->save(array_merge($this->request->post, array('id' => $this->request->get['id'])));
			$this->session->data['success'] = $this->language->get('text_success_save');

			$this->redirect($this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->form();
	}

	public function insert() {
		$this->load->language('ne/template');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/template');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_ne_template->save($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_save');

			$this->redirect($this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->form();
	}

	private function form() {
		if (isset($this->request->get['id'])) {
			$template_id = $this->request->get['id'];
			$template_info = $this->model_ne_template->get($template_id);
		} else {
			$template_info = array();
		}
		
		$this->document->addScript('view/javascript/colorpicker/js/colorpicker.js');
		$this->document->addStyle('view/javascript/colorpicker/css/colorpicker.css');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_show_prices'] = $this->language->get('entry_show_prices');
		$this->data['entry_description_length'] = $this->language->get('entry_description_length');
		$this->data['entry_image_size'] = $this->language->get('entry_image_size');
		$this->data['entry_columns'] = $this->language->get('entry_columns');
		$this->data['entry_specials_count'] = $this->language->get('entry_specials_count');
		$this->data['entry_latest_count'] = $this->language->get('entry_latest_count');
		$this->data['entry_popular_count'] = $this->language->get('entry_popular_count');
		$this->data['entry_heading_color'] = $this->language->get('entry_heading_color');
		$this->data['entry_heading_style'] = $this->language->get('entry_heading_style');
		$this->data['entry_name_color'] = $this->language->get('entry_name_color');
		$this->data['entry_name_style'] = $this->language->get('entry_name_style');
		$this->data['entry_model_color'] = $this->language->get('entry_model_color');
		$this->data['entry_model_style'] = $this->language->get('entry_model_style');
		$this->data['entry_price_color'] = $this->language->get('entry_price_color');
		$this->data['entry_price_style'] = $this->language->get('entry_price_style');
		$this->data['entry_price_color_special'] = $this->language->get('entry_price_color_special');
		$this->data['entry_price_style_special'] = $this->language->get('entry_price_style_special');
		$this->data['entry_price_color_when_special'] = $this->language->get('entry_price_color_when_special');
		$this->data['entry_price_style_when_special'] = $this->language->get('entry_price_style_when_special');
		$this->data['entry_description_color'] = $this->language->get('entry_description_color');
		$this->data['entry_description_style'] = $this->language->get('entry_description_style');
		$this->data['entry_template_body'] = $this->language->get('entry_template_body');
		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');
		$this->data['entry_subject'] = $this->language->get('entry_subject');
		$this->data['entry_defined_text'] = $this->language->get('entry_defined_text');
		$this->data['entry_special_text'] = $this->language->get('entry_special_text');
		$this->data['entry_latest_text'] = $this->language->get('entry_latest_text');
		$this->data['entry_popular_text'] = $this->language->get('entry_popular_text');
		$this->data['entry_categories_text'] = $this->language->get('entry_categories_text');
		$this->data['entry_product_template'] = $this->language->get('entry_product_template');

		$this->data['text_settings'] = $this->language->get('text_settings');
		$this->data['text_styles'] = $this->language->get('text_styles');
		$this->data['text_template'] = $this->language->get('text_template');
		$this->data['text_message_info'] = $this->language->get('text_message_info');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $template_info ? $template_info['name'] : $this->language->get('text_new_template'),
			'href'      => $template_info ? $this->url->link('ne/template/update', 'token=' . $this->session->data['token'] . '&id=' . (int)$template_id, 'SSL') : $this->url->link('ne/template/insert', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		if (isset($this->request->post['name'])) {
      		$this->data['name'] = $this->request->post['name'];
    	} elseif (!empty($template_info)) {
			$this->data['name'] = $template_info['name'];
		} else {
      		$this->data['name'] = '';
    	}

    	if (isset($this->request->post['uri'])) {
      		$this->data['uri'] = $this->request->post['uri'];
    	} elseif (!empty($template_info)) {
			$this->data['uri'] = $template_info['uri'];
		} else {
      		$this->data['uri'] = 'default';
    	}

   		if (isset($this->request->post['product_image_width'])) {
      		$this->data['product_image_width'] = $this->request->post['product_image_width'];
    	} elseif (!empty($template_info)) {
			$this->data['product_image_width'] = $template_info['product_image_width'];
		} else {
      		$this->data['product_image_width'] = '140';
    	}

    	if (isset($this->request->post['product_image_height'])) {
      		$this->data['product_image_height'] = $this->request->post['product_image_height'];
    	} elseif (!empty($template_info)) {
			$this->data['product_image_height'] = $template_info['product_image_height'];
		} else {
      		$this->data['product_image_height'] = '140';
    	}

    	if (isset($this->request->post['product_show_prices'])) {
      		$this->data['product_show_prices'] = $this->request->post['product_show_prices'];
    	} elseif (!empty($template_info)) {
			$this->data['product_show_prices'] = $template_info['product_show_prices'];
		} else {
      		$this->data['product_show_prices'] = '1';
    	}

    	if (isset($this->request->post['product_description_length'])) {
      		$this->data['product_description_length'] = $this->request->post['product_description_length'];
    	} elseif (!empty($template_info)) {
			$this->data['product_description_length'] = $template_info['product_description_length'];
		} else {
      		$this->data['product_description_length'] = '100';
    	}

    	if (isset($this->request->post['product_cols'])) {
      		$this->data['product_cols'] = $this->request->post['product_cols'];
    	} elseif (!empty($template_info)) {
			$this->data['product_cols'] = $template_info['product_cols'];
		} else {
      		$this->data['product_cols'] = '4';
    	}

    	if (isset($this->request->post['specials_count'])) {
      		$this->data['specials_count'] = $this->request->post['specials_count'];
    	} elseif (!empty($template_info)) {
			$this->data['specials_count'] = $template_info['specials_count'];
		} else {
      		$this->data['specials_count'] = '8';
    	}

    	if (isset($this->request->post['latest_count'])) {
      		$this->data['latest_count'] = $this->request->post['latest_count'];
    	} elseif (!empty($template_info)) {
			$this->data['latest_count'] = $template_info['latest_count'];
		} else {
      		$this->data['latest_count'] = '8';
    	}

		if (isset($this->request->post['popular_count'])) {
      		$this->data['popular_count'] = $this->request->post['popular_count'];
    	} elseif (!empty($template_info)) {
			$this->data['popular_count'] = $template_info['popular_count'];
		} else {
      		$this->data['popular_count'] = '8';
    	}

    	if (isset($this->request->post['heading_color'])) {
      		$this->data['heading_color'] = $this->request->post['heading_color'];
    	} elseif (!empty($template_info)) {
			$this->data['heading_color'] = $template_info['heading_color'];
		} else {
      		$this->data['heading_color'] = '#222222';
    	}

		if (isset($this->request->post['heading_style'])) {
      		$this->data['heading_style'] = $this->request->post['heading_style'];
    	} elseif (!empty($template_info)) {
			$this->data['heading_style'] = $template_info['heading_style'];
		} else {
      		$this->data['heading_style'] = '';
    	}

		if (isset($this->request->post['product_name_color'])) {
      		$this->data['product_name_color'] = $this->request->post['product_name_color'];
    	} elseif (!empty($template_info)) {
			$this->data['product_name_color'] = $template_info['product_name_color'];
		} else {
      		$this->data['product_name_color'] = '#222222';
    	}

		if (isset($this->request->post['product_name_style'])) {
      		$this->data['product_name_style'] = $this->request->post['product_name_style'];
    	} elseif (!empty($template_info)) {
			$this->data['product_name_style'] = $template_info['product_name_style'];
		} else {
      		$this->data['product_name_style'] = '';
    	}
    	
		if (isset($this->request->post['product_model_color'])) {
      		$this->data['product_model_color'] = $this->request->post['product_model_color'];
    	} elseif (!empty($template_info)) {
			$this->data['product_model_color'] = $template_info['product_model_color'];
		} else {
      		$this->data['product_model_color'] = '#999999';
    	}
    	
		if (isset($this->request->post['product_model_style'])) {
      		$this->data['product_model_style'] = $this->request->post['product_model_style'];
    	} elseif (!empty($template_info)) {
			$this->data['product_model_style'] = $template_info['product_model_style'];
		} else {
      		$this->data['product_model_style'] = '';
    	}
    	
		if (isset($this->request->post['product_price_color'])) {
      		$this->data['product_price_color'] = $this->request->post['product_price_color'];
    	} elseif (!empty($template_info)) {
			$this->data['product_price_color'] = $template_info['product_price_color'];
		} else {
      		$this->data['product_price_color'] = '#990000';
    	}
    	
		if (isset($this->request->post['product_price_style'])) {
      		$this->data['product_price_style'] = $this->request->post['product_price_style'];
    	} elseif (!empty($template_info)) {
			$this->data['product_price_style'] = $template_info['product_price_style'];
		} else {
      		$this->data['product_price_style'] = '';
    	}
    	
		if (isset($this->request->post['product_price_color_special'])) {
      		$this->data['product_price_color_special'] = $this->request->post['product_price_color_special'];
    	} elseif (!empty($template_info)) {
			$this->data['product_price_color_special'] = $template_info['product_price_color_special'];
		} else {
      		$this->data['product_price_color_special'] = '#990000';
    	}
    	
		if (isset($this->request->post['product_price_style_special'])) {
      		$this->data['product_price_style_special'] = $this->request->post['product_price_style_special'];
    	} elseif (!empty($template_info)) {
			$this->data['product_price_style_special'] = $template_info['product_price_style_special'];
		} else {
      		$this->data['product_price_style_special'] = '';
    	}
    	
		if (isset($this->request->post['product_price_color_when_special'])) {
      		$this->data['product_price_color_when_special'] = $this->request->post['product_price_color_when_special'];
    	} elseif (!empty($template_info)) {
			$this->data['product_price_color_when_special'] = $template_info['product_price_color_when_special'];
		} else {
      		$this->data['product_price_color_when_special'] = '#999999';
    	}
    	
		if (isset($this->request->post['product_price_style_when_special'])) {
      		$this->data['product_price_style_when_special'] = $this->request->post['product_price_style_when_special'];
    	} elseif (!empty($template_info)) {
			$this->data['product_price_style_when_special'] = $template_info['product_price_style_when_special'];
		} else {
      		$this->data['product_price_style_when_special'] = '';
    	}
    	
		if (isset($this->request->post['product_description_color'])) {
      		$this->data['product_description_color'] = $this->request->post['product_description_color'];
    	} elseif (!empty($template_info)) {
			$this->data['product_description_color'] = $template_info['product_description_color'];
		} else {
      		$this->data['product_description_color'] = '#999999';
    	}
    	
		if (isset($this->request->post['product_description_style'])) {
      		$this->data['product_description_style'] = $this->request->post['product_description_style'];
    	} elseif (!empty($template_info)) {
			$this->data['product_description_style'] = $template_info['product_description_style'];
		} else {
      		$this->data['product_description_style'] = '';
    	}

    	if (isset($this->request->post['subject'])) {
      		$this->data['subject'] = $this->request->post['subject'];
    	} elseif (!empty($template_info)) {
			$this->data['subject'] = $template_info['subject'];
		} else {
      		$this->data['subject'] = array();
    	}

    	if (isset($this->request->post['defined_text'])) {
      		$this->data['defined_text'] = $this->request->post['defined_text'];
    	} elseif (!empty($template_info)) {
			$this->data['defined_text'] = $template_info['defined_text'];
		} else {
      		$this->data['defined_text'] = array();
    	}

    	if (isset($this->request->post['special_text'])) {
      		$this->data['special_text'] = $this->request->post['special_text'];
    	} elseif (!empty($template_info)) {
			$this->data['special_text'] = $template_info['special_text'];
		} else {
      		$this->data['special_text'] = array();
    	}

    	if (isset($this->request->post['latest_text'])) {
      		$this->data['latest_text'] = $this->request->post['latest_text'];
    	} elseif (!empty($template_info)) {
			$this->data['latest_text'] = $template_info['latest_text'];
		} else {
      		$this->data['latest_text'] = array();
    	}

    	if (isset($this->request->post['popular_text'])) {
      		$this->data['popular_text'] = $this->request->post['popular_text'];
    	} elseif (!empty($template_info)) {
			$this->data['popular_text'] = $template_info['popular_text'];
		} else {
      		$this->data['popular_text'] = array();
    	}

		if (isset($this->request->post['categories_text'])) {
			$this->data['categories_text'] = $this->request->post['categories_text'];
		} elseif (!empty($template_info)) {
			$this->data['categories_text'] = $template_info['categories_text'];
		} else {
			$this->data['categories_text'] = array();
		}

    	if (isset($this->request->post['uri'])) {
      		$this->data['uri'] = $this->request->post['uri'];
    	} elseif (!empty($template_info)) {
			$this->data['uri'] = $template_info['uri'];
		} else {
      		$this->data['uri'] = '';
    	}
    	
		if (isset($this->request->post['body'])) {
      		$this->data['body'] = $this->request->post['body'];
    	} elseif (!empty($template_info)) {
			$this->data['body'] = $template_info['body'];
		} else {
      		$this->data['body'] = array();
    	}

    	if (file_exists(DIR_CATALOG . 'view/theme/' . $this->config->get('config_template') . '/template/ne/templates')) {
    		$parts = (array)glob(DIR_CATALOG . 'view/theme/' . $this->config->get('config_template') . '/template/ne/templates/*');
		} else {
			$parts = (array)glob(DIR_CATALOG . 'view/theme/default/template/ne/templates/*');
		}

		$this->data['parts'] = array();

		if ($parts) {
			foreach ($parts as $part) {
				$this->data['parts'][basename($part)] = ucwords(basename($part));
			}
		}

		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (!isset($template_id)) {
			$this->data['action'] = $this->url->link('ne/template/insert', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['action'] = $this->url->link('ne/template/update', 'token=' . $this->session->data['token'] . '&id=' . $template_id, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->template = 'ne/template_detail.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function delete() {
		$this->load->language('ne/template');
		$this->load->model('ne/template');
		
		if (isset($this->request->post['selected']) && $this->validate()) {
			foreach ($this->request->post['selected'] as $template_id) {
				if (!$this->model_ne_template->delete($template_id)) {
					$this->error['warning'] = $this->language->get('error_delete');
				}
			}
			if (isset($this->error['warning'])) {
				$this->session->data['success'] = $this->error['warning'];
			} else {
				$this->session->data['success'] = $this->language->get('text_success');	
			}
		}
		
		$this->redirect($this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function copy() {
		$this->load->language('ne/template');
		$this->load->model('ne/template');
		
		if (isset($this->request->post['selected']) && $this->validate()) {
			foreach ($this->request->post['selected'] as $template_id) {
				if (!$this->model_ne_template->copy($template_id)) {
					$this->error['warning'] = $this->language->get('error_copy');
				}
			}
			if (isset($this->error['warning'])) {
				$this->session->data['success'] = $this->error['warning'];
			} else {
				$this->session->data['success'] = $this->language->get('text_success_copy');	
			}
		}
		
		$this->redirect($this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function copy_default() {
		$this->load->language('ne/template');
		$this->load->model('ne/template');
		
		if (!$this->model_ne_template->copy(1)) {
			$this->session->data['success'] = $this->language->get('error_copy');
		} else {
			$this->session->data['success'] = $this->language->get('text_success_copy');
		}
		
		$this->redirect($this->url->link('ne/template', 'token=' . $this->session->data['token'], 'SSL'));
	}

	private function validateForm() { 
    	if (!$this->user->hasPermission('modify', 'ne/template')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
					
    	if (!$this->error) {
			return true;
    	} else {
      		return false;
    	}
  	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'ne/template')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
						
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
?>