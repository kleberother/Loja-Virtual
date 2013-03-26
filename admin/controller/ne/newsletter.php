<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeNewsletter extends Controller {
	private $error = array();
	 
	public function index() {

		if (isset($this->request->get['id']) && $this->request->server['REQUEST_METHOD'] != 'POST') {
                    $this->load->model('ne/draft');
                    $this->request->post = $this->model_ne_draft->detail($this->request->get['id']);

                    if (!$this->request->post) {
                        $this->redirect($this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL'));
                    }
		}

		$this->load->language('sale/contact');
		$this->load->language('ne/newsletter');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_template'] = $this->language->get('entry_template');
		$this->data['entry_yes'] = $this->language->get('entry_yes');
		$this->data['entry_no'] = $this->language->get('entry_no');
		$this->data['entry_defined'] = $this->language->get('entry_defined');
		$this->data['entry_latest'] = $this->language->get('entry_latest');
		$this->data['entry_popular'] = $this->language->get('entry_popular');
		$this->data['entry_special'] = $this->language->get('entry_special');
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_attachments'] = $this->language->get('entry_attachments');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_language'] = $this->language->get('entry_language');
		$this->data['entry_to'] = $this->language->get('entry_to');
		$this->data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$this->data['entry_customer'] = $this->language->get('entry_customer');
		$this->data['entry_affiliate'] = $this->language->get('entry_affiliate');
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_subject'] = $this->language->get('entry_subject');
		$this->data['entry_message'] = $this->language->get('entry_message');
		$this->data['entry_marketing'] = $this->language->get('entry_marketing');
		$this->data['entry_defined_categories'] = $this->language->get('entry_defined_categories');
		$this->data['entry_section_name'] = $this->language->get('entry_section_name');

		$this->data['button_add_file'] = $this->language->get('button_add_file');
		$this->data['button_add_defined_section'] = $this->language->get('button_add_defined_section');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_send'] = $this->language->get('button_send');
		$this->data['button_reset'] = $this->language->get('button_reset');
		$this->data['button_back'] = $this->language->get('button_back');
		$this->data['button_update'] = $this->language->get('button_update');
		$this->data['button_preview'] = $this->language->get('button_preview');
		$this->data['button_check'] = $this->language->get('button_check');

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
		$this->data['text_loading'] = $this->language->get('text_loading');	

		if (isset($this->request->post['marketing_list']) && is_array($this->request->post['marketing_list'])) {
			$this->data['marketing_list'] = $this->request->post['marketing_list'];
		} else {
			$this->data['marketing_list'] = array();
		}
		
		$this->load->model('catalog/product');

		$this->data['defined_products'] = array();

		if (isset($this->request->post['defined_product']) && is_array($this->request->post['defined_product'])) {
			foreach ($this->request->post['defined_product'] as $product_id) {
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

		if (isset($this->request->post['defined_product_more']) && is_array($this->request->post['defined_product_more'])) {
			foreach ($this->request->post['defined_product_more'] as $dpm) {
				if (!isset($dpm['products'])) {
					$dpm['products'] = array();
				}
				if (!isset($dpm['text'])) {
					$dpm['text'] = '';
				}
				$defined_products_more = array('text' => $dpm['text'], 'products' => array());
				foreach ($dpm['products'] as $product_id) {
					$product_info = $this->model_catalog_product->getProduct($product_id);

					if ($product_info) {
						$defined_products_more['products'][] = array(
							'product_id' => $product_info['product_id'],
							'name'       => $product_info['name']
						);
					}
				}
				$this->data['defined_products_more'][] = $defined_products_more;
			}
			unset($defined_products_more);
			unset($product_info);
			unset($product_id);
		}

		$this->load->model('catalog/category');

		$this->data['categories'] = $this->model_catalog_category->getCategories(0);

		if (isset($this->request->get['id']) || isset($this->request->post['id'])) {
			$this->data['id'] = (isset($this->request->get['id']) ?$this->request->get['id'] : $this->request->post['id']);
		} else {
			$this->data['id'] = false;
		}

		if (isset($this->request->post['defined'])) {
			$this->data['defined'] = $this->request->post['defined'];
		} else {
			$this->data['defined'] = false;
		}

		if (isset($this->request->post['defined_categories'])) {
			$this->data['defined_categories'] = $this->request->post['defined_categories'];
		} else {
			$this->data['defined_categories'] = false;
		}

		if (isset($this->request->post['defined_category'])) {
			$this->data['defined_category'] = $this->request->post['defined_category'];
		} else {
			$this->data['defined_category'] = array();
		}

		if (isset($this->request->post['special'])) {
			$this->data['special'] = $this->request->post['special'];
		} else {
			$this->data['special'] = false;
		}

		if (isset($this->request->post['latest'])) {
			$this->data['latest'] = $this->request->post['latest'];
		} else {
			$this->data['latest'] = false;
		}

		if (isset($this->request->post['popular'])) {
			$this->data['popular'] = $this->request->post['popular'];
		} else {
			$this->data['popular'] = false;
		}

		if (isset($this->request->post['attachments'])) {
			$this->data['attachments'] = $this->request->post['attachments'];
		} else {
			$this->data['attachments'] = false;
		}
 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/customer');
		
		$this->load->model('sale/customer_group');
		
		$this->load->model('sale/affiliate');

		$this->load->model('ne/newsletter');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			set_time_limit(0);
			
			$emails = array();

			if (isset($this->request->post['spam_check']) && $this->request->post['spam_check']) {
				$emails['check@isnotspam.com'] = array(
					'firstname' => 'John',
					'lastname' => 'Doe'
				);
			} else {
				switch ($this->request->post['to']) {
					case 'marketing':
							$marketing_data = array(
								'filter_subscribed' => 1,
								'filter_list' => isset($this->request->post['marketing_list']) ? $this->request->post['marketing_list'] : array(),
								'filter_store' => $this->request->post['store_id']
							);

							$this->load->model('ne/marketing');
							$results = $this->model_ne_marketing->getList($marketing_data);

							foreach ($results as $result) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
							break;
					case 'marketing_all':
							$marketing_data = array(
								'filter_list' => isset($this->request->post['marketing_list']) ? $this->request->post['marketing_list'] : array(),
								'filter_store' => $this->request->post['store_id']
							);

							$this->load->model('ne/marketing');
							$results = $this->model_ne_marketing->getList($marketing_data);

							foreach ($results as $result) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
							break;
					case 'subscriber':
						$marketing_data = array(
							'filter_subscribed' => 1,
							'filter_list' => isset($this->request->post['marketing_list']) ? $this->request->post['marketing_list'] : array(),
							'filter_store' => $this->request->post['store_id']
						);

						$this->load->model('ne/marketing');
						$results = $this->model_ne_marketing->getList($marketing_data);

						foreach ($results as $result) {
							$emails[$result['email']] = array(
								'firstname' => $result['firstname'],
								'lastname' => $result['lastname']
							);
						}

						$results = $this->model_sale_customer->getCustomersByNewsletter();

						foreach ($results as $result) {
							if ($result['store_id'] == $this->request->post['store_id']) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
						}
						break;
					case 'all':
						$marketing_data = array(
							'filter_list' => isset($this->request->post['marketing_list']) ? $this->request->post['marketing_list'] : array(),
							'filter_store' => $this->request->post['store_id']
						);

						$this->load->model('ne/marketing');
						$results = $this->model_ne_marketing->getList($marketing_data);

						foreach ($results as $result) {
							$emails[$result['email']] = array(
								'firstname' => $result['firstname'],
								'lastname' => $result['lastname']
							);
						}

						$results = $this->model_sale_customer->getCustomers();

						foreach ($results as $result) {
							if ($result['store_id'] == $this->request->post['store_id']) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
						}
						break;
					case 'newsletter':
						$results = $this->model_sale_customer->getCustomersByNewsletter();

						foreach ($results as $result) {
							if ($result['store_id'] == $this->request->post['store_id']) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
						}
						break;
					case 'customer_all':
						$results = $this->model_sale_customer->getCustomers();

						foreach ($results as $result) {
							if ($result['store_id'] == $this->request->post['store_id']) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
						}
						break;
					case 'customer_group':
						$results = $this->model_sale_customer->getCustomersByCustomerGroupId($this->request->post['customer_group_id']);

						foreach ($results as $result) {
							if ($result['store_id'] == $this->request->post['store_id']) {
								$emails[$result['email']] = array(
									'firstname' => $result['firstname'],
									'lastname' => $result['lastname']
								);
							}
						}
						break;
					case 'customer':
						if (isset($this->request->post['customer'])) {
							foreach ($this->request->post['customer'] as $customer_id) {
								$customer_info = $this->model_sale_customer->getCustomer($customer_id);

								if ($customer_info) {
									$emails[$customer_info['email']] = array(
										'firstname' => $customer_info['firstname'],
										'lastname' => $customer_info['lastname']
									);
								}
							}
						}
						break;
					case 'affiliate_all':
						$results = $this->model_sale_affiliate->getAffiliates();

						foreach ($results as $result) {
							$emails[$result['email']] = array(
								'firstname' => $result['firstname'],
								'lastname' => $result['lastname']
							);
						}
						break;
					case 'affiliate':
						if (isset($this->request->post['affiliate']) && !empty($this->request->post['affiliate'])) {
							foreach ($this->request->post['affiliate'] as $affiliate_id) {
								$affiliate_info = $this->model_sale_affiliate->getAffiliate($affiliate_id);

								if ($affiliate_info) {
									$emails[$affiliate_info['email']] = array(
										'firstname' => $affiliate_info['firstname'],
										'lastname' => $affiliate_info['lastname']
									);
								}
							}
						}
						break;
					case 'product':
						if (isset($this->request->post['product']) && $this->request->post['product']) {
							$results = $this->model_ne_newsletter->getEmailsByProductsOrdered($this->request->post['product']);

							foreach ($results as $result) {
								if ($result['store_id'] == $this->request->post['store_id']) {
									$emails[$result['email']] = array(
										'firstname' => $result['firstname'],
										'lastname' => $result['lastname']
									);
								}
							}
						}
						break;
				}
			}
			
			if ($emails){
                            
                                $itens      = 1;
                                $all_emails = array_reverse($emails ,true);
                                $pages = array_chunk($all_emails,$itens,true);                       
                                
                                if(!isset($this->session->data['ne_page_emails'])){
                                    $this->session->data['ne_page_emails'] = 0;
									

                                    $this->session->data['ne_history_id'] = $this->model_ne_newsletter->addHistory(array(
                                            'to' => $this->request->post['to'],
                                            'subject' => $this->request->post['subject'],
                                            'message' => $this->request->post['message'],
                                            'store_id' => $this->request->post['store_id'],
                                            'template_id' => $this->request->post['template_id'],
                                            'language_id' => $language['language_id'],
                                            'queue' => ($this->config->get('ne_throttle') && (count($all_emails) > $this->config->get('ne_throttle_count'))) ? 0 : count($all_emails),
                                            'recipients' => count($all_emails)
                                    ));
									
									
                                }elseif($this->session->data['ne_page_emails'] == (count($pages)-1)){
                                        unset($this->session->data['ne_history_id']);
                                        unset($this->session->data['ne_page_emails']);
                                }else
                                    $this->session->data['ne_page_emails']++;
                                
                                $sent_emails = (($this->session->data['ne_page_emails'] + 1) * $itens);
                                $sent_emails = $sent_emails >= count($all_emails) ? count($all_emails) : $sent_emails ;
                                
                                
                                if(isset($this->session->data['ne_page_emails'])){
                                
                                    $emails = $pages[$this->session->data['ne_page_emails']];
                                    
                                    $this->load->model('localisation/language');
                                    $language = $this->model_localisation_language->getLanguage((isset($this->request->post['language_id']) ? $this->request->post['language_id'] : $this->config->get('config_language_id')));

                                    $data = array(
                                        'emails' => $emails,
                                        'to' => $this->request->post['to'],
                                        'subject' => $this->request->post['subject'],
                                        'message' => $this->request->post['message'],
                                        'store_id' => $this->request->post['store_id'],
                                        'template_id' => $this->request->post['template_id'],
                                        'language_id' => $language['language_id'],
                                        'attachments_count' => $this->request->post['attachments_count'],
                                        'attachments_upload' => $this->request->files,
                                        'attachments' => false,
                                        'language_code' => $language['code']
                                    );

                                    $this->model_ne_newsletter->send($data);
                                    
                                    echo "{'sent':" . $sent_emails . ",'all':" . count($all_emails) . "}";
                                    exit();
                                }else{
                                    
                                    echo "redirect";
                                    exit();   
                                }
                                
			}
                        
		}
		
		$this->data['token'] = $this->session->data['token'];
		
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

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
				
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
				
		$this->data['action'] = $this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL');
		if (isset($this->session->data['ne_back'])) {
			$this->data['back'] = $this->url->link('ne/draft', 'token=' . $this->session->data['token'] . $this->session->data['ne_back'], 'SSL');
			unset($this->session->data['ne_back']);
			$this->data['reset'] = false;
		} else {
			$this->data['reset'] = $this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['back'] = false;
		}
    	$this->data['save'] = $this->url->link('ne/newsletter/save', 'token=' . $this->session->data['token'], 'SSL');

    	if (isset($this->request->post['template_id'])) {
			$this->data['template_id'] = $this->request->post['template_id'];
		} else {
			$this->data['template_id'] = '';
		}

		$this->load->model('ne/template');
		$this->data['templates'] = $this->model_ne_template->getList();
		
		if (isset($this->request->post['store_id'])) {
			$this->data['store_id'] = $this->request->post['store_id'];
		} else {
			$this->data['store_id'] = '';
		}
		
		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		if (isset($this->request->post['language_id'])) {
			$this->data['language_id'] = $this->request->post['language_id'];
		} else {
			$this->data['language_id'] = '';
		}

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['to'])) {
			$this->data['to'] = $this->request->post['to'];
		} else {
			$this->data['to'] = '';
		}
				
		if (isset($this->request->post['customer_group_id'])) {
			$this->data['customer_group_id'] = $this->request->post['customer_group_id'];
		} else {
			$this->data['customer_group_id'] = '';
		}
				
		$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups(0);
				
		$this->data['customers'] = array();
		
		if (isset($this->request->post['customer']) && is_array($this->request->post['customer'])) {					
			foreach ($this->request->post['customer'] as $customer_id) {
				$customer_info = $this->model_sale_customer->getCustomer($customer_id);
			
				if ($customer_info) {	
					$this->data['customers'][] = array(
						'customer_id' => $customer_info['customer_id'],
						'name'        => $customer_info['firstname'] . ' ' . $customer_info['lastname']
					);
				}
			}
		}

		$this->data['affiliates'] = array();
		
		if (isset($this->request->post['affiliate']) && is_array($this->request->post['affiliate'])) {					
			foreach ($this->request->post['affiliate'] as $affiliate_id) {
				$affiliate_info = $this->model_sale_affiliate->getAffiliate($affiliate_id);
					
				if ($affiliate_info) {
					$this->data['affiliates'][] = array(
						'affiliate_id' => $affiliate_info['affiliate_id'],
						'name'         => $affiliate_info['firstname'] . ' ' . $affiliate_info['lastname']
					);
				}
			}
		}
		
		$this->load->model('catalog/product');

		$this->data['products'] = array();
		
		if (isset($this->request->post['product']) && is_array($this->request->post['product'])) {					
			foreach ($this->request->post['product'] as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
					
				if ($product_info) {
					$this->data['products'][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name']
					);
				}
			}
		}

		$this->data['list_data'] = $this->config->get('ne_marketing_list');
				
		if (isset($this->request->post['subject'])) {
			$this->data['subject'] = $this->request->post['subject'];
		} else {
			$this->data['subject'] = '';
		}
		
		if (isset($this->request->post['message'])) {
			$this->data['message'] = $this->request->post['message'];
		} else {
			$this->data['message'] = '';
		}

		$this->template = 'ne/newsletter.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	public function save() {
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->load->model('ne/draft');
			$this->load->language('ne/newsletter');
			$this->model_ne_draft->save($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_save');
		}
		$this->redirect($this->url->link('ne/draft', 'token=' . $this->session->data['token'], 'SSL'));
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
					$url = rtrim($store['url'], '/') . '/index.php?route=ne/template/json';
				} else {
					$url = $store_url . 'index.php?route=ne/template/json';
				}
			} else {
				$url = $store_url . 'index.php?route=ne/template/json';
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
			$this->redirect($this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function preview() {
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
					$url = rtrim($store['url'], '/') . '/index.php?route=ne/template/json';
				} else {
					$url = $store_url . 'index.php?route=ne/template/json';
				}
			} else {
				$url = $store_url . 'index.php?route=ne/template/json';
			}

			$result = $this->do_request(array(
				'url' => $url,
				'header' => array('Content-type: application/x-www-form-urlencoded', "Content-Length: ". strlen($post), "X-Requested-With: XMLHttpRequest"),
				'method' => 'POST',
				'content' => $post
			));

			$response = $result['response'];

			if ($response && $response = json_decode($response)) {
				$response->body = html_entity_decode($response->body, ENT_QUOTES, 'UTF-8');

				$response->subject = str_replace(array('{name}', '{lastname}', '{email}'), array('John', 'Doe', 'john.doe@mail.com'), $response->subject);
				$response->body = str_replace(array('{name}', '{lastname}', '{email}'), array('John', 'Doe', 'john.doe@mail.com'), $response->body);
				$response->body = str_replace(array('{uid}', '%7Buid%7D'), 0, $response->body);
				$response->body = str_replace(array('{key}', '%7Bkey%7D'), 0, $response->body);

				$this->response->addHeader('Content-type: application/json');
				$this->response->setOutput(json_encode($response));
			}
		} else {
			$this->redirect($this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function get_defined_text() {
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['template_id']) && isset($this->request->post['language_id'])) {
			$this->load->model('ne/template');
			$template_info = $this->model_ne_template->get((int)$this->request->post['template_id']);
			$this->response->addHeader('Content-type: application/json');
			$this->response->setOutput(json_encode(array('text' => isset($template_info['defined_text'][(int)$this->request->post['language_id']]) ? $template_info['defined_text'][(int)$this->request->post['language_id']] : '')));
		} else {
			$this->redirect($this->url->link('ne/newsletter', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'ne/newsletter')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
				
		if (!$this->request->post['subject']) {
			$this->error['subject'] = $this->language->get('error_subject');
		}

		if (!$this->request->post['message']) {
			$this->error['message'] = $this->language->get('error_message');
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