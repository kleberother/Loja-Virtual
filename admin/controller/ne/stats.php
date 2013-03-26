<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeStats extends Controller {
	private $error = array();
	 
	public function index() {
		$this->load->language('ne/stats');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('ne/stats');

		$this->load->model('ne/newsletter');
		$this->model_ne_newsletter->checkBounced();
		
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

		if (isset($this->request->get['filter_store'])) {
			$filter_store = $this->request->get['filter_store'];
		} else {
			$filter_store = null;
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'stats_id';
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
			'href'      => $this->url->link('ne/stats', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['detail'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=', 'SSL');
		$this->data['delete'] = $this->url->link('ne/stats/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$data = array(
			'filter_date'		=> $filter_date,
			'filter_subject'	=> $filter_subject,
			'filter_store'		=> $filter_store,
			'sort'				=> $sort,
			'order'				=> $order,
			'start'				=> ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'				=> $this->config->get('config_admin_limit')
		);
		
		$total = $this->model_ne_stats->getTotal($data);
		
		$this->data['stats'] = array();
		
		$results = $this->model_ne_stats->getList($data);
		
		foreach ($results as $result) {
			$this->data['stats'][] = array_merge($result, array(
				'selected' => isset($this->request->post['selected']) && is_array($this->request->post['selected']) && in_array($result['stats_id'], $this->request->post['selected']),
				'queue' => ($result['queue'] == $result['recipients']) ? $result['recipients'] : sprintf($this->language->get('entry_text_queued'), $result['queue'], $result['recipients'])
			));
		}
		unset($result);
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_default'] = $this->language->get('text_default');	
		
		$this->data['column_date'] = $this->language->get('column_date');
		$this->data['column_subject'] = $this->language->get('column_subject');
		$this->data['column_recipients'] = $this->language->get('column_recipients');
		$this->data['column_views'] = $this->language->get('column_views');
		$this->data['column_actions'] = $this->language->get('column_actions');
		$this->data['column_store'] = $this->language->get('column_store');
		
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');
		$this->data['button_details'] = $this->language->get('button_details');
		
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
		
		$this->data['sort_date'] = $this->url->link('ne/stats', 'token=' . $this->session->data['token'] . '&sort=datetime' . $url, 'SSL');
		$this->data['sort_subject'] = $this->url->link('ne/stats', 'token=' . $this->session->data['token'] . '&sort=subject' . $url, 'SSL');
		$this->data['sort_recipients'] = $this->url->link('ne/stats', 'token=' . $this->session->data['token'] . '&sort=recipients' . $url, 'SSL');
		$this->data['sort_views'] = $this->url->link('ne/stats', 'token=' . $this->session->data['token'] . '&sort=views' . $url, 'SSL');
		$this->data['sort_store'] = $this->url->link('ne/stats', 'token=' . $this->session->data['token'] . '&sort=store_id' . $url, 'SSL');
		
		$url = '';
		
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		}
		
		if (isset($this->request->get['filter_subject'])) {
			$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
		
		$this->data['view_url'] =  'index.php?route=ne/show&id=';
		
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('ne/stats', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();

		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['store_url'] = (defined('HTTPS_CATALOG') ? HTTPS_CATALOG : HTTP_CATALOG);
		} else {
			$this->data['store_url'] = HTTP_CATALOG;
		}
		
		$this->data['filter_date'] = $filter_date;
		$this->data['filter_subject'] = $filter_subject;
		$this->data['filter_store'] = $filter_store;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		
		$this->template = 'ne/stats.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function detail() {
		if (isset($this->request->get['id'])) {
			$stats_id = $this->request->get['id'];
		} else {
			$this->redirect($this->url->link('ne/stats', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->language('ne/stats');

		$this->document->addStyle('view/stylesheet/ne.css');
		$this->document->addScript('https://www.google.com/jsapi');

		$this->load->model('ne/stats');

		$this->load->model('ne/newsletter');
		$this->model_ne_newsletter->checkBounced();

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

		if (isset($this->request->get['filter_success'])) {
			$filter_success = $this->request->get['filter_success'];
		} else {
			$filter_success = null;
		}

		if (isset($this->request->get['filter_bounced'])) {
			$filter_bounced = $this->request->get['filter_bounced'];
		} else {
			$filter_bounced = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
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
		
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_success'])) {
			$url .= '&filter_success=' . $this->request->get['filter_success'];
		}

		if (isset($this->request->get['filter_bounced'])) {
			$url .= '&filter_bounced=' . $this->request->get['filter_bounced'];
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

		$this->data['detail_link'] = $this->url->link('ne/stats/detail_recipient', 'token=' . $this->session->data['token'] . $url . '&id=', 'SSL');

		$detail = $this->model_ne_stats->detail($stats_id);
		$this->data['detail'] = $detail;

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/stats', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => sprintf($this->language->get('entry_heading'), $detail['subject']),
			'href'      => $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . (int)$stats_id, 'SSL'),
			'separator' => ' :: '
		);

		$this->document->setTitle($this->language->get('heading_title'));
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_recipients'] = $this->language->get('entry_recipients');
		$this->data['entry_total_recipients'] = $this->language->get('entry_total_recipients');
		$this->data['entry_total_failed'] = $this->language->get('entry_total_failed');
		$this->data['entry_total_bounced'] = $this->language->get('entry_total_bounced');
		$this->data['entry_total_views'] = $this->language->get('entry_total_views');
		$this->data['entry_sent'] = $this->language->get('entry_sent');
		$this->data['entry_read'] = $this->language->get('entry_read');
		$this->data['entry_unsubscribe_clicks'] = $this->language->get('entry_unsubscribe_clicks');
		$this->data['entry_attachements'] = $this->language->get('entry_attachements');
		$this->data['entry_timeline'] = $this->language->get('entry_timeline');
		$this->data['entry_url'] = $this->language->get('entry_url');
		$this->data['entry_clicks'] = $this->language->get('entry_clicks');
		$this->data['entry_heading'] = sprintf($this->language->get('entry_heading'), $detail['subject']);
		$this->data['entry_track'] = $this->language->get('entry_track');
		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_sent'] = $this->language->get('text_sent');
		$this->data['text_time'] = $this->language->get('text_time');
		$this->data['text_views'] = $this->language->get('text_views');

		$this->data['button_details'] = $this->language->get('button_details');
		$this->data['button_hide_details'] = $this->language->get('button_hide_details');
		$this->data['button_filter'] = $this->language->get('button_filter');

		$this->data['column_actions'] = $this->language->get('column_actions');
		$this->data['column_email'] = $this->language->get('column_email');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_views'] = $this->language->get('column_views');
		$this->data['column_clicks'] = $this->language->get('column_clicks');
		$this->data['column_success'] = $this->language->get('column_success');
		$this->data['column_bounced'] = $this->language->get('column_bounced');

		$this->data['attachements'] = $this->model_ne_stats->getAttachements($detail['history_id']);

		$this->data['recipients'] = array();

		$data = array(
			'history_id'		=> $detail['history_id']
		);

		if ($detail['to'] == 'marketing' || $detail['to'] == 'marketing_all') {
			$recipients_total = $this->model_ne_stats->getRecipientsMarketingTotal($data);
		} elseif ($detail['to'] == 'subscriber' || $detail['to'] == 'all') {
			$recipients_total = $this->model_ne_stats->getRecipientsMarketingTotal($data) + $this->model_ne_stats->getRecipientsTotal($data);
		} else {
			$recipients_total = $this->model_ne_stats->getRecipientsTotal($data);
		}

		$this->data['recipients_total'] = $recipients_total;
		$this->data['failed_total'] = $this->model_ne_stats->getFailedTotal($detail['history_id']);
		$this->data['bounced_total'] = $this->model_ne_stats->getBouncedTotal($detail['history_id']);

		$data = array(
			'history_id'		=> $detail['history_id'],
			'filter_name'		=> $filter_name,
			'filter_email'		=> $filter_email,
			'filter_success'	=> $filter_success,
			'filter_bounced'	=> $filter_bounced,
			'sort'				=> $sort,
			'order'				=> $order,
			'start'				=> ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'				=> $this->config->get('config_admin_limit')
		);

		if ($detail['to'] == 'marketing' || $detail['to'] == 'marketing_all') {
			$recipients_total = $this->model_ne_stats->getRecipientsMarketingTotal($data);
			$results = $this->model_ne_stats->getRecipientsMarketingList($data);
		} elseif ($detail['to'] == 'subscriber' || $detail['to'] == 'all') {
			$recipients_total = $this->model_ne_stats->getRecipientsMarketingTotal($data) + $this->model_ne_stats->getRecipientsTotal($data);
			$results = $this->model_ne_stats->getRecipientsAllList($data);
		} else {
			$recipients_total = $this->model_ne_stats->getRecipientsTotal($data);
			$results = $this->model_ne_stats->getRecipientsList($data);
		}

		$this->data['recipients'] = $results;
		$this->data['views_total'] = $detail['views'];

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

		if (isset($this->request->get['filter_success'])) {
			$url .= '&filter_success=' . $this->request->get['filter_success'];
		}

		if (isset($this->request->get['filter_bounced'])) {
			$url .= '&filter_bounced=' . $this->request->get['filter_bounced'];
		}
		
		if ($order == 'ASC') {
			$url .= '&order=' .  'DESC';
		} else {
			$url .= '&order=' .  'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . '&sort=name' . $url, 'SSL');
		$this->data['sort_email'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . '&sort=c.email' . $url, 'SSL');
		$this->data['sort_views'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . '&sort=s.views' . $url, 'SSL');
		$this->data['sort_clicks'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . '&sort=clicks' . $url, 'SSL');
		$this->data['sort_success'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . '&sort=success' . $url, 'SSL');
		$this->data['sort_bounced'] = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . '&sort=bounced' . $url, 'SSL');
		
		$url = '';
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_email'])) {
			$url .= '&filter_email=' . $this->request->get['filter_email'];
		}

		if (isset($this->request->get['filter_success'])) {
			$url .= '&filter_success=' . $this->request->get['filter_success'];
		}

		if (isset($this->request->get['filter_bounced'])) {
			$url .= '&filter_bounced=' . $this->request->get['filter_bounced'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $recipients_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('ne/stats/detail', 'token=' . $this->session->data['token'] . '&id=' . $stats_id . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['store_url'] = (defined('HTTPS_CATALOG') ? HTTPS_CATALOG : HTTP_CATALOG);
		} else {
			$this->data['store_url'] = HTTP_CATALOG;
		}
		
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_email'] = $filter_email;
		$this->data['filter_success'] = $filter_success;
		$this->data['filter_bounced'] = $filter_bounced;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'ne/stats_detail.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}

	public function detail_recipient() {
		if(empty($this->request->server['HTTP_X_REQUESTED_WITH']) || strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest') {
			$this->redirect($this->url->link('ne/stats', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		if (isset($this->request->get['id'])) {
			$stats_recipient_id = $this->request->get['id'];
		} else {
			$this->redirect($this->url->link('ne/stats', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->language('ne/stats');
		$this->data['entry_url'] = $this->language->get('entry_url');
		$this->data['entry_clicks'] = $this->language->get('entry_clicks');
		$this->data['entry_track'] = $this->language->get('entry_track');

		$this->data['text_no_data'] = $this->language->get('text_no_data');

		$this->load->model('ne/stats');

		$this->data['tracks'] = $this->model_ne_stats->getClicks($stats_recipient_id);

		$this->template = 'ne/stats_detail_recipient.tpl';
		$this->response->setOutput($this->render());
	}

	public function delete() {
		$this->load->language('ne/stats');
		$this->load->model('ne/stats');
		
		$url = '';
		
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
		}
		
		if (isset($this->request->get['filter_subject'])) {
			$url .= '&filter_subject=' . $this->request->get['filter_subject'];
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
			foreach ($this->request->post['selected'] as $stats_id) {
				$this->model_ne_stats->delete($stats_id);
			}
			$this->session->data['success'] = $this->language->get('text_success');
		}
		
		$this->redirect($this->url->link('ne/stats', 'token=' . $this->session->data['token'] . $url, 'SSL'));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'ne/stats')) {
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