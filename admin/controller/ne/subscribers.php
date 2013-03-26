<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeSubscribers extends Controller {
	private $error = array();
	 
	public function index() {
		$this->load->language('ne/subscribers');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/subscribers');
		
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}
		
		if (isset($this->request->get['filter_email'])) {
			$filter_email = $this->request->get['filter_email'];
		} else {
			$filter_email = null;
		}

		if (isset($this->request->get['filter_customer_group_id'])) {
			$filter_customer_group_id = $this->request->get['filter_customer_group_id'];
		} else {
			$filter_customer_group_id = null;
		}
		
		if (isset($this->request->get['filter_newsletter'])) {
			$filter_newsletter = $this->request->get['filter_newsletter'];
		} else {
			$filter_newsletter = null;
		}

		if (isset($this->request->get['filter_store'])) {
			$filter_store = $this->request->get['filter_store'];
		} else {
			$filter_store = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
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
		
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_customer_group_id'])) {
			$url .= '&filter_customer_group_id=' . $this->request->get['filter_customer_group_id'];
		}

		if (isset($this->request->get['filter_newsletter'])) {
			$url .= '&filter_newsletter=' . $this->request->get['filter_newsletter'];
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
			'href'      => $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['subscribe'] = $this->url->link('ne/subscribers/subscribe', 'token=' . $this->session->data['token'] . $url . '&id=', 'SSL');
		$this->data['unsubscribe'] = $this->url->link('ne/subscribers/unsubscribe', 'token=' . $this->session->data['token'] . $url . '&id=', 'SSL');

		$this->load->model('sale/customer_group');
		
    	$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		
		$data = array(
			'filter_name'		=> $filter_name,
			'filter_email'		=> $filter_email,
			'filter_customer_group_id' => $filter_customer_group_id, 
			'filter_newsletter'	=> $filter_newsletter,
			'filter_store'		=> $filter_store,
			'sort'				=> $sort,
			'order'				=> $order,
			'start'				=> ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'				=> $this->config->get('config_admin_limit')
		);
		
		$customers_total = $this->model_ne_subscribers->getTotal($data);
		
		$this->data['customers'] = array();
		
		$results = $this->model_ne_subscribers->getList($data);
		$this->data['customers'] = $results;
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_default'] = $this->language->get('text_default');	

		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_email'] = $this->language->get('column_email');
		$this->data['column_customer_group'] = $this->language->get('column_customer_group');
		$this->data['column_newsletter'] = $this->language->get('column_newsletter');
		$this->data['column_actions'] = $this->language->get('column_actions');
		$this->data['column_store'] = $this->language->get('column_store');
		
		$this->data['button_subscribe'] = $this->language->get('button_subscribe');
		$this->data['button_unsubscribe'] = $this->language->get('button_unsubscribe');
		$this->data['button_filter'] = $this->language->get('button_filter');
		
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
											
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_customer_group_id'])) {
			$url .= '&filter_customer_group_id=' . $this->request->get['filter_customer_group_id'];
		}

		if (isset($this->request->get['filter_newsletter'])) {
			$url .= '&filter_newsletter=' . $this->request->get['filter_newsletter'];
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
		
		$this->data['sort_name'] = $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_email'] = $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . '&sort=c.email' . $url, 'SSL');
		$this->data['sort_customer_group'] = $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . '&sort=customer_group' . $url, 'SSL');
		$this->data['sort_newsletter'] = $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . '&sort=c.newsletter' . $url, 'SSL');
		$this->data['sort_store'] = $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . '&sort=store_id' . $url, 'SSL');
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_customer_group_id'])) {
			$url .= '&filter_customer_group_id=' . $this->request->get['filter_customer_group_id'];
		}

		if (isset($this->request->get['filter_newsletter'])) {
			$url .= '&filter_newsletter=' . $this->request->get['filter_newsletter'];
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
		
		$pagination = new Pagination();
		$pagination->total = $customers_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();

		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_email'] = $filter_email;
		$this->data['filter_customer_group_id'] = $filter_customer_group_id;
		$this->data['filter_newsletter'] = $filter_newsletter;
		$this->data['filter_store'] = $filter_store;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'ne/subscribers.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function subscribe() {

		$this->load->model('ne/subscribers');

		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_newsletter'])) {
			$url .= '&filter_newsletter=' . $this->request->get['filter_newsletter'];
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

		$this->model_ne_subscribers->subscribe($this->request->get['id']);

		$this->redirect($this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
	}

	public function unsubscribe() {

		$this->load->model('ne/subscribers');

		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_newsletter'])) {
			$url .= '&filter_newsletter=' . $this->request->get['filter_newsletter'];
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

		$this->model_ne_subscribers->unsubscribe($this->request->get['id']);

		$this->redirect($this->url->link('ne/subscribers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
	}
}

?>