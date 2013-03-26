<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeSchedule extends Controller {
	private $error = array();
	 
	public function index() {
		$this->load->language('sale/contact');
		$this->load->language('ne/schedule');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/schedule');
		
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['filter_active'])) {
			$filter_active = $this->request->get['filter_active'];
		} else {
			$filter_active = null;
		}
		
		if (isset($this->request->get['filter_recurrent'])) {
			$filter_recurrent = $this->request->get['filter_recurrent'];
		} else {
			$filter_recurrent = null;
		}

		if (isset($this->request->get['filter_to'])) {
			$filter_to = $this->request->get['filter_to'];
		} else {
			$filter_to = null;
		}

		if (isset($this->request->get['filter_store'])) {
			$filter_store = $this->request->get['filter_store'];
		} else {
			$filter_store = null;
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'schedule_id';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		if (isset($this->request->get['filter_active'])) {
			$url .= '&filter_active=' . $this->request->get['filter_active'];
		}
		
		if (isset($this->request->get['filter_recurrent'])) {
			$url .= '&filter_recurrent=' . $this->request->get['filter_recurrent'];
		}

		if (isset($this->request->get['filter_to'])) {
			$url .= '&filter_to=' . $this->request->get['filter_to'];
		}

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/schedule', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['insert'] = $this->url->link('ne/schedule/insert', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('ne/schedule/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$data = array(
			'filter_name'		=> $filter_name,
			'filter_active'		=> $filter_active,
			'filter_recurrent'	=> $filter_recurrent,
			'filter_to'			=> $filter_to,
			'filter_store'		=> $filter_store,
			'sort'				=> $sort,
			'order'				=> $order,
			'start'				=> ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'				=> $this->config->get('config_admin_limit')
		);
		
		$total = $this->model_ne_schedule->getTotal($data);
		
		$this->data['schedule'] = array();
		
		$results = $this->model_ne_schedule->getList($data);
		
		foreach ($results as $result) {
			$this->data['schedule'][] = array_merge($result, array(
				'selected' => isset($this->request->post['selected']) && is_array($this->request->post['selected']) && in_array($result['schedule_id'], $this->request->post['selected'])
			));
		}
		unset($result);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_active'] = $this->language->get('column_active');
		$this->data['column_recurrent'] = $this->language->get('column_recurrent');
		$this->data['column_to'] = $this->language->get('column_to');
		$this->data['column_actions'] = $this->language->get('column_actions');
		$this->data['column_store'] = $this->language->get('column_store');
		
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');
		$this->data['button_insert'] = $this->language->get('button_insert');

		$this->data['text_marketing'] = $this->language->get('text_marketing');
		$this->data['text_marketing_all'] = $this->language->get('text_marketing_all');
		$this->data['text_subscriber_all'] = $this->language->get('text_subscriber_all');
		$this->data['text_all'] = $this->language->get('text_all');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		$this->data['text_customer_all'] = $this->language->get('text_customer_all');	
		$this->data['text_customer'] = $this->language->get('text_customer');	
		$this->data['text_customer_group'] = $this->language->get('text_customer_group');
		$this->data['text_affiliate_all'] = $this->language->get('text_affiliate_all');	
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');	
		$this->data['text_product'] = $this->language->get('text_product');	
		$this->data['text_edit'] = $this->language->get('text_edit');	
		$this->data['text_default'] = $this->language->get('text_default');	
		
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
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
											
		if (isset($this->request->get['filter_active'])) {
			$url .= '&filter_active=' . $this->request->get['filter_active'];
		}
											
		if (isset($this->request->get['filter_recurrent'])) {
			$url .= '&filter_recurrent=' . $this->request->get['filter_recurrent'];
		}

		if (isset($this->request->get['filter_to'])) {
			$url .= '&filter_to=' . $this->request->get['filter_to'];
		}

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		
		if ($order == 'ASC') {
			$url .= '&order=' .  'DESC';
		} else {
			$url .= '&order=' .  'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_active'] = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . '&sort=active' . $url, 'SSL');
		$this->data['sort_recurrent'] = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . '&sort=recurrent' . $url, 'SSL');
		$this->data['sort_to'] = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . '&sort=to' . $url, 'SSL');
		$this->data['sort_store'] = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . '&sort=store_id' . $url, 'SSL');
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_active'])) {
			$url .= '&filter_active=' . $this->request->get['filter_active'];
		}
		
		if (isset($this->request->get['filter_recurrent'])) {
			$url .= '&filter_recurrent=' . $this->request->get['filter_recurrent'];
		}

		if (isset($this->request->get['filter_to'])) {
			$url .= '&filter_to=' . $this->request->get['filter_to'];
		}

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		$this->data['update'] = $this->url->link('ne/schedule/update', 'token=' . $this->session->data['token'] . $url . '&id=', 'SSL');
		
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();

		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_active'] = $filter_active;
		$this->data['filter_recurrent'] = $filter_recurrent;
		$this->data['filter_to'] = $filter_to;
		$this->data['filter_store'] = $filter_store;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'ne/schedule.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function update() {
		$this->load->language('sale/contact');
		$this->load->language('ne/newsletter');
		$this->load->language('ne/schedule');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/schedule');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() && $this->validateForm()) {
			if (isset($this->request->post['recurrent']) && $this->request->post['recurrent'] == '1') {
				if (strtotime($this->request->post['date_next'] . ' ' . (strlen($this->request->post['time']) == 1 ? '0' . $this->request->post['time'] : $this->request->post['time']) . ':00:00') < strtotime(date('Y-m-d') . ' ' . (strlen($this->request->post['time']) == 1 ? '0' . $this->request->post['time'] : $this->request->post['time']) . ':00:00')) {
					$this->request->post['date_next'] = '0';
				}
			}
			$this->model_ne_schedule->save(array_merge($this->request->post, array('id' => $this->request->get['id'])));
			$this->session->data['success'] = $this->language->get('text_success_save');

			$this->redirect($this->url->link('ne/schedule', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->form();
	}

	public function insert() {
		$this->load->language('sale/contact');
		$this->load->language('ne/newsletter');
		$this->load->language('ne/schedule');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/schedule');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() && $this->validateForm()) {
			$this->model_ne_schedule->save($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_save');

			$this->redirect($this->url->link('ne/schedule', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->form();
	}

	private function form() {
		if (isset($this->request->get['id'])) {
			$schedule_id = $this->request->get['id'];
			$schedule_info = $this->model_ne_schedule->get($schedule_id);
		} else {
			$schedule_info = array();
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_template'] = $this->language->get('entry_template');
		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');
		$this->data['entry_recurrent'] = $this->language->get('entry_recurrent');
		$this->data['entry_random'] = $this->language->get('entry_random');
		$this->data['entry_defined'] = $this->language->get('entry_defined');
		$this->data['entry_latest'] = $this->language->get('entry_latest');
		$this->data['entry_popular'] = $this->language->get('entry_popular');
		$this->data['entry_special'] = $this->language->get('entry_special');
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_language'] = $this->language->get('entry_language');
		$this->data['entry_to'] = $this->language->get('entry_to');
		$this->data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$this->data['entry_customer'] = $this->language->get('entry_customer');
		$this->data['entry_affiliate'] = $this->language->get('entry_affiliate');
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_subject'] = $this->language->get('entry_subject');
		$this->data['entry_message'] = $this->language->get('entry_message');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_datetime'] = $this->language->get('entry_datetime');
		$this->data['entry_frequency'] = $this->language->get('entry_frequency');
		$this->data['entry_daytime'] = $this->language->get('entry_daytime');
		$this->data['entry_active'] = $this->language->get('entry_active');
		$this->data['entry_random_count'] = $this->language->get('entry_random_count');
		$this->data['entry_marketing'] = $this->language->get('entry_marketing');
		$this->data['entry_defined_categories'] = $this->language->get('entry_defined_categories');
		$this->data['entry_section_name'] = $this->language->get('entry_section_name');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_preview'] = $this->language->get('button_preview');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_add_defined_section'] = $this->language->get('button_add_defined_section');

		$this->data['text_marketing'] = $this->language->get('text_marketing');
		$this->data['text_marketing_all'] = $this->language->get('text_marketing_all');
		$this->data['text_subscriber_all'] = $this->language->get('text_subscriber_all');
		$this->data['text_all'] = $this->language->get('text_all');
		$this->data['text_clear_warning'] = $this->language->get('text_clear_warning');
		$this->data['text_message_info'] = $this->language->get('text_message_info');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		$this->data['text_customer_all'] = $this->language->get('text_customer_all');	
		$this->data['text_customer'] = $this->language->get('text_customer');	
		$this->data['text_customer_group'] = $this->language->get('text_customer_group');
		$this->data['text_affiliate_all'] = $this->language->get('text_affiliate_all');	
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');	
		$this->data['text_product'] = $this->language->get('text_product');
		$this->data['text_current_server_time'] = sprintf($this->language->get('text_current_server_time'), date('Y-m-d H:i'));

		$this->data['text_at'] = $this->language->get('text_at');
		$this->data['text_daily'] = $this->language->get('text_daily');
		$this->data['text_weekly'] = $this->language->get('text_weekly');
		$this->data['text_monthly'] = $this->language->get('text_monthly');
		$this->data['text_monday'] = $this->language->get('text_monday');
		$this->data['text_tuesday'] = $this->language->get('text_tuesday');
		$this->data['text_wednesday'] = $this->language->get('text_wednesday');
		$this->data['text_thursday'] = $this->language->get('text_thursday');
		$this->data['text_friday'] = $this->language->get('text_friday');
		$this->data['text_saturday'] = $this->language->get('text_saturday');
		$this->data['text_sunday'] = $this->language->get('text_sunday');
		$this->data['text_loading'] = $this->language->get('text_loading');	

		if (isset($this->request->post['active'])) {
			$this->data['active'] = $this->request->post['active'];
		} elseif (!empty($schedule_info)) {
			$this->data['active'] = $schedule_info['active'];
		} else {
			$this->data['active'] = '';
		}

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($schedule_info)) {
			$this->data['name'] = $schedule_info['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['to'])) {
			$this->data['to'] = $this->request->post['to'];
		} elseif (!empty($schedule_info)) {
			$this->data['to'] = $schedule_info['to'];
		} else {
			$this->data['to'] = '';
		}

		if (isset($this->request->post['date'])) {
			$this->data['date'] = $this->request->post['date'];
		} elseif (!empty($schedule_info)) {
			$this->data['date'] = $schedule_info['date'];
		} else {
			$this->data['date'] = date('Y-m-d');
		}

		if (isset($this->request->post['date_next'])) {
			$this->data['date_next'] = $this->request->post['date_next'];
		} elseif (!empty($schedule_info)) {
			$this->data['date_next'] = $schedule_info['date_next'];
		} else {
			$this->data['date_next'] = '0';
		}

		if (isset($this->request->post['time'])) {
			$this->data['time'] = $this->request->post['time'];
		} elseif (!empty($schedule_info)) {
			$this->data['time'] = $schedule_info['time'];
		} else {
			$this->data['time'] = '0';
		}

		if (isset($this->request->post['rtime'])) {
			$this->data['rtime'] = $this->request->post['rtime'];
		} elseif (!empty($schedule_info)) {
			$this->data['rtime'] = $schedule_info['time'];
		} else {
			$this->data['rtime'] = '0';
		}

		if (isset($this->request->post['day'])) {
			$this->data['day'] = $this->request->post['day'];
		} elseif (!empty($schedule_info)) {
			$this->data['day'] = $schedule_info['day'];
		} else {
			$this->data['day'] = '1';
		}

		if (isset($this->request->post['frequency'])) {
			$this->data['frequency'] = $this->request->post['frequency'];
		} elseif (!empty($schedule_info)) {
			$this->data['frequency'] = $schedule_info['frequency'];
		} else {
			$this->data['frequency'] = '1';
		}

		if (isset($this->request->post['template_id'])) {
			$this->data['template_id'] = $this->request->post['template_id'];
		} elseif (!empty($schedule_info)) {
			$this->data['template_id'] = $schedule_info['template_id'];
		} else {
			$this->data['template_id'] = '';
		}

		if (isset($this->request->post['language_id'])) {
			$this->data['language_id'] = $this->request->post['language_id'];
		} elseif (!empty($schedule_info)) {
			$this->data['language_id'] = $schedule_info['language_id'];
		} else {
			$this->data['language_id'] = '';
		}

		if (isset($this->request->post['store_id'])) {
			$this->data['store_id'] = $this->request->post['store_id'];
		} elseif (!empty($schedule_info)) {
			$this->data['store_id'] = $schedule_info['store_id'];
		} else {
			$this->data['store_id'] = '';
		}

		if (isset($this->request->post['random'])) {
			$this->data['random'] = $this->request->post['random'];
		} elseif (!empty($schedule_info)) {
			$this->data['random'] = $schedule_info['random'];
		} else {
			$this->data['random'] = false;
		}

		if (isset($this->request->post['random_count'])) {
			$this->data['random_count'] = $this->request->post['random_count'];
		} elseif (!empty($schedule_info)) {
			$this->data['random_count'] = $schedule_info['random_count'];
		} else {
			$this->data['random_count'] = false;
		}

		if (isset($this->request->post['special'])) {
			$this->data['special'] = $this->request->post['special'];
		} elseif (!empty($schedule_info)) {
			$this->data['special'] = $schedule_info['special'];
		} else {
			$this->data['special'] = false;
		}

		if (isset($this->request->post['latest'])) {
			$this->data['latest'] = $this->request->post['latest'];
		} elseif (!empty($schedule_info)) {
			$this->data['latest'] = $schedule_info['latest'];
		} else {
			$this->data['latest'] = false;
		}

		if (isset($this->request->post['popular'])) {
			$this->data['popular'] = $this->request->post['popular'];
		} elseif (!empty($schedule_info)) {
			$this->data['popular'] = $schedule_info['popular'];
		} else {
			$this->data['popular'] = false;
		}

		if (isset($this->request->post['recurrent'])) {
			$this->data['recurrent'] = $this->request->post['recurrent'];
		} elseif (!empty($schedule_info)) {
			$this->data['recurrent'] = $schedule_info['recurrent'];
		} else {
			$this->data['recurrent'] = false;
		}

		$this->load->model('catalog/category');

		$this->data['categories'] = $this->model_catalog_category->getCategories(0);

		if (isset($this->request->post['defined_categories'])) {
			$this->data['defined_categories'] = $this->request->post['defined_categories'];
		} elseif (!empty($schedule_info)) {
			$this->data['defined_categories'] = $schedule_info['categories'];
		} else {
			$this->data['defined_categories'] = false;
		}

		if (isset($this->request->post['defined_category'])) {
			$this->data['defined_category'] = $this->request->post['defined_category'];
		} elseif (!empty($schedule_info)) {
			$this->data['defined_category'] = unserialize($schedule_info['defined_categories']);
		} else {
			$this->data['defined_category'] = array();
		}

		if (isset($this->request->post['subject'])) {
			$this->data['subject'] = $this->request->post['subject'];
		} elseif (!empty($schedule_info)) {
			$this->data['subject'] = $schedule_info['subject'];
		} else {
			$this->data['subject'] = '';
		}

		if (isset($this->request->post['message'])) {
			$this->data['message'] = $this->request->post['message'];
		} elseif (!empty($schedule_info)) {
			$this->data['message'] = $schedule_info['message'];
		} else {
			$this->data['message'] = '';
		}

		if (isset($this->request->post['customer_group_id'])) {
			$this->data['customer_group_id'] = $this->request->post['customer_group_id'];
		} elseif (!empty($schedule_info)) {
			$this->data['customer_group_id'] = $schedule_info['customer_group_id'];
		} else {
			$this->data['customer_group_id'] = '';
		}

		if (isset($this->request->post['marketing_list'])) {
			$this->data['marketing_list'] = $this->request->post['marketing_list'];
		} elseif (!empty($schedule_info)) {
			$this->data['marketing_list'] = unserialize($schedule_info['marketing_list']);
		} else {
			$this->data['marketing_list'] = array();
		}

		$this->load->model('catalog/product');

		$this->data['defined_products'] = array();

		if (isset($this->request->post['defined_product'])) {
			$defined_products = $this->request->post['defined_product'];
		} elseif (!empty($schedule_info)) {
			$defined_products = unserialize($schedule_info['defined_products']);
		} else {
			$defined_products = array();
		}

		if ($defined_products) {
			foreach ($defined_products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					$this->data['defined_products'][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name']
					);
				}
			}
			unset($product_info);
			unset($product_id);
		}

		$this->data['defined_products_more'] = array();

		if (isset($this->request->post['defined_product_more'])) {
			$defined_products_more = $this->request->post['defined_product_more'];
		} elseif (!empty($schedule_info)) {
			$defined_products_more = unserialize($schedule_info['defined_products_more']);
		} else {
			$defined_products_more = array();
		}

		if ($defined_products_more) {
			foreach ($defined_products_more as $dpm) {
				if (!isset($dpm['products'])) {
					$dpm['products'] = array();
				}
				if (!isset($dpm['text'])) {
					$dpm['text'] = '';
				}
				$dp_more = array('text' => $dpm['text'], 'products' => array());
				foreach ($dpm['products'] as $product_id) {
					$product_info = $this->model_catalog_product->getProduct($product_id);

					if ($product_info) {
						$dp_more['products'][] = array(
							'product_id' => $product_info['product_id'],
							'name'       => $product_info['name']
						);
					}
				}
				$this->data['defined_products_more'][] = $dp_more;
			}
			unset($defined_products_more);
			unset($dp_more);
			unset($product_info);
			unset($product_id);
		}

		if (isset($this->request->post['defined'])) {
			$this->data['defined'] = $this->request->post['defined'];
		} elseif (!empty($schedule_info)) {
			$this->data['defined'] = $schedule_info['defined'];
		} else {
			$this->data['defined'] = '';
		}
		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/schedule', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		if (!isset($schedule_id)) {
			$this->data['action'] = $this->url->link('ne/schedule/insert', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['action'] = $this->url->link('ne/schedule/update', 'token=' . $this->session->data['token'] . '&id=' . $schedule_id, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('ne/schedule', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];
    	
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();

		$this->load->model('sale/customer_group');

		$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups(0);

		$this->load->model('sale/customer');

		$this->data['customers'] = array();
		$customers = array();

		if (isset($this->request->post['customer'])) {
			$customers = $this->request->post['customer'];
		} elseif (!empty($schedule_info)) {
			$customers = unserialize($schedule_info['customer']);
		}
		
		if ($customers)					
		foreach ($customers as $customer_id) {
			$customer_info = $this->model_sale_customer->getCustomer($customer_id);
		
			if ($customer_info) {	
				$this->data['customers'][] = array(
					'customer_id' => $customer_info['customer_id'],
					'name'        => $customer_info['firstname'] . ' ' . $customer_info['lastname']
				);
			}
		}

		$this->load->model('sale/affiliate');

		$this->data['affiliates'] = array();
		$affiliates = array();

		if (isset($this->request->post['affiliate'])) {
			$affiliates = $this->request->post['affiliate'];
		} elseif (!empty($schedule_info)) {
			$affiliates = unserialize($schedule_info['affiliate']);
		}
		
		if ($affiliates)		
		foreach ($affiliates as $affiliate_id) {
			$affiliate_info = $this->model_sale_affiliate->getAffiliate($affiliate_id);
				
			if ($affiliate_info) {
				$this->data['affiliates'][] = array(
					'affiliate_id' => $affiliate_info['affiliate_id'],
					'name'         => $affiliate_info['firstname'] . ' ' . $affiliate_info['lastname']
				);
			}
		}
		
		$this->load->model('catalog/product');

		$this->data['products'] = array();
		$products = array();

		if (isset($this->request->post['product'])) {
			$products = $this->request->post['product'];
		} elseif (!empty($schedule_info)) {
			$products = unserialize($schedule_info['product']);
		}
		
		if ($products)
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
				
			if ($product_info) {
				$this->data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}

		$this->data['list_data'] = $this->config->get('ne_marketing_list');

		$this->load->model('ne/template');

		$this->data['templates'] = $this->model_ne_template->getList();

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
 		if (isset($this->error['subject'])) {
			$this->data['error_subject'] = $this->error['subject'];
		} else {
			$this->data['error_subject'] = '';
		}
	 	
		if (isset($this->error['message'])) {
			$this->data['error_message'] = $this->error['message'];
		} else {
			$this->data['error_message'] = '';
		}

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

		$this->template = 'ne/schedule_detail.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function delete() {
		$this->load->language('ne/schedule');
		$this->load->model('ne/schedule');
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_recurrent'])) {
			$url .= '&filter_recurrent=' . $this->request->get['filter_recurrent'];
		}

		if (isset($this->request->get['filter_to'])) {
			$url .= '&filter_to=' . $this->request->get['filter_to'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (isset($this->request->post['selected']) && $this->validate()) {
			foreach ($this->request->post['selected'] as $schedule_id) {
				$this->model_ne_schedule->delete($schedule_id);
			}
			$this->session->data['success'] = $this->language->get('text_success');
		}
		
		$this->redirect($this->url->link('ne/schedule', 'token=' . $this->session->data['token'] . $url, 'SSL'));
	}

	public function template() {
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$post = http_build_query($this->request->post, '', '&');

			if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
				$store_url = (defined('HTTPS_CATALOG') ? HTTPS_CATALOG : HTTP_CATALOG);
			} else {
				$store_url = HTTP_CATALOG;
			}

			if (isset($this->request->post['store_id'])) {
				$this->load->model('setting/store');
				$store = $this->model_setting_store->getStore($this->request->post['store_id']);
				if ($store) {
					$url = rtrim($store['url'], '/') . '/index.php?route=ne/template/json_raw';
				} else {
					$url = $store_url . 'index.php?route=ne/template/json_raw';
				}
			} else {
				$url = $store_url . 'index.php?route=ne/template/json_raw';
			}
			
			$result = $this->do_request(array(
				'url' => $url,
				'header' => array('Content-type: application/x-www-form-urlencoded', "Content-Length: ". strlen($post), "X-Requested-With: XMLHttpRequest"),
				'method' => 'POST',
				'content' => $post
			));

			$response = $result['response'];

			$this->response->addHeader('Content-type: application/json');
			$this->response->setOutput($response);
		} else {
			$this->redirect($this->url->link('ne/schedule', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'ne/schedule')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
						
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateForm() {				
		if (!$this->request->post['subject']) {
			$this->error['subject'] = $this->language->get('error_subject');
		}

		if (!$this->request->post['message']) {
			$this->error['message'] = $this->language->get('error_message');
		}

		if (!$this->request->post['name']) {
			$this->error['name'] = $this->language->get('error_name');
		}
						
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function do_request($options) {
		$options = $options + array(
			'method' => 'GET',
			'content' => false,
			'header' => false,
			'async' => false,
		);

		$ch = curl_init(); 
		curl_setopt($ch, CURLOPT_URL, $options['url']);
		curl_setopt($ch, CURLOPT_HEADER, 1); 
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 60);
		curl_setopt($ch, CURLOPT_USERAGENT, 'Newsletter Enhancements for Opencart');

		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

		if ($options['header']) {
			curl_setopt($ch, CURLOPT_HTTPHEADER, $options['header']);
		}

		if ($options['async']) {
			curl_setopt($ch, CURLOPT_TIMEOUT, 1);
		} else {
			curl_setopt($ch, CURLOPT_TIMEOUT, 0);
		}

		switch ($options['method']) {
			case 'HEAD':
				curl_setopt($ch, CURLOPT_NOBODY, 1);
				break;
			case 'POST':
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS, $options['content']);
				break;
			case 'PUT':
				curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
				curl_setopt($ch, CURLOPT_POSTFIELDS, $options['content']);
				break;
			default:
				curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $options['method']);
				if ($options['content'])
					curl_setopt($ch, CURLOPT_POSTFIELDS, $options['content']);
				break;
		}

		$result = curl_exec($ch);
		$info = curl_getinfo($ch);
		$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

		curl_close($ch);

		return array(
			'header' => substr($result, 0, $info['header_size']), 
			'response' => substr($result, $info['header_size']),
			'status' => $status,
			'info' => $info
		);
	}
}
?>