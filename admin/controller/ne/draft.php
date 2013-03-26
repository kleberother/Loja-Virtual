<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeDraft extends Controller {
	private $error = array();
	 
	public function index() {
		$this->load->language('sale/contact');
		$this->load->language('ne/draft');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/draft');
		
		if (isset($this->request->get['filter_date'])) {
			$filter_date = $this->request->get['filter_date'];
		} else {
			$filter_date = null;
		}
		
		if (isset($this->request->get['filter_subject'])) {
			$filter_subject = $this->request->get['filter_subject'];
		} else {
			$filter_subject = null;
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
			$sort = 'draft_id';
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
		
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		}
		
		if (isset($this->request->get['filter_subject'])) {
			$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
			'href'      => $this->url->link('ne/draft', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['delete'] = $this->url->link('ne/draft/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$data = array(
			'filter_date'		=> $filter_date,
			'filter_subject'	=> $filter_subject,
			'filter_to'			=> $filter_to,
			'filter_store'		=> $filter_store,
			'sort'				=> $sort,
			'order'				=> $order,
			'start'				=> ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'				=> $this->config->get('config_admin_limit')
		);
		
		$total = $this->model_ne_draft->getTotal($data);
		
		$this->data['draft'] = array();
		
		$results = $this->model_ne_draft->getList($data);
		
		foreach ($results as $result) {
			$this->data['draft'][] = array_merge($result, array(
				'selected' => isset($this->request->post['selected']) && is_array($this->request->post['selected']) && in_array($result['draft_id'], $this->request->post['selected'])
			));
		}
		unset($result);
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_subject'] = $this->language->get('column_subject');
		$this->data['column_date'] = $this->language->get('column_date');
		$this->data['column_to'] = $this->language->get('column_to');
		$this->data['column_actions'] = $this->language->get('column_actions');
		$this->data['column_store'] = $this->language->get('column_store');
		
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');

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
		$this->data['text_view'] = $this->language->get('text_view');
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
		
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		}
											
		if (isset($this->request->get['filter_subject'])) {
			$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
		
		$this->data['sort_date'] = $this->url->link('ne/draft', 'token=' . $this->session->data['token'] . '&sort=datetime' . $url, 'SSL');
		$this->data['sort_subject'] = $this->url->link('ne/draft', 'token=' . $this->session->data['token'] . '&sort=subject' . $url, 'SSL');
		$this->data['sort_to'] = $this->url->link('ne/draft', 'token=' . $this->session->data['token'] . '&sort=to' . $url, 'SSL');
		$this->data['sort_store'] = $this->url->link('ne/draft', 'token=' . $this->session->data['token'] . '&sort=store_id' . $url, 'SSL');
		
		$url = '';
		
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		}
		
		if (isset($this->request->get['filter_subject'])) {
			$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
		
		$this->data['detail'] = $this->url->link('ne/draft/detail', 'token=' . $this->session->data['token'] . $url . '&id=', 'SSL');
		
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('ne/draft', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();

		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		$this->data['filter_date'] = $filter_date;
		$this->data['filter_subject'] = $filter_subject;
		$this->data['filter_to'] = $filter_to;
		$this->data['filter_store'] = $filter_store;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'ne/draft.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function detail() {
		if (isset($this->request->get['id'])) {

			$url = '';
		
			if (isset($this->request->get['filter_date'])) {
				$url .= '&filter_date=' . $this->request->get['filter_date'];
			}
			
			if (isset($this->request->get['filter_subject'])) {
				$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
			
			$this->session->data['ne_back'] = $url;

			$this->redirect($this->url->link('ne/newsletter', 'token=' . $this->session->data['token'] . '&id=' . (int)$this->request->get['id'], 'SSL'));
		} else {
			$this->redirect($this->url->link('ne/draft', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function delete() {
		$this->load->language('ne/draft');
		$this->load->model('ne/draft');
		
		$url = '';
		
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		}
		
		if (isset($this->request->get['filter_subject'])) {
			$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
			foreach ($this->request->post['selected'] as $draft_id) {
				$this->model_ne_draft->delete($draft_id);
			}
			$this->session->data['success'] = $this->language->get('text_success');
		}
		
		$this->redirect($this->url->link('ne/draft', 'token=' . $this->session->data['token'] . $url, 'SSL'));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'ne/draft')) {
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