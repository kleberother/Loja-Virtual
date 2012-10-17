<?php 
class ControllerQuickCheckoutShippingMethod extends Controller {
  	public function index() {
		$this->language->load('quickcheckout/checkout');
		
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		
		$this->session->data['guest']['shipping']['country'] = '';	
		$this->session->data['guest']['shipping']['iso_code_2'] = '';
		$this->session->data['guest']['shipping']['iso_code_3'] = '';
		$this->session->data['guest']['shipping']['address_format'] = '';
		$this->session->data['guest']['shipping']['zone'] = '';
		$this->session->data['guest']['shipping']['zone_code'] = '';
		
		if ($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {					
			$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);		
		} elseif (isset($this->session->data['guest']['shipping'])) {
			$shipping_address = $this->session->data['guest']['shipping'];
		} else {
			if (isset($this->request->get['country_id']) && isset($this->request->get['zone_id'])){
				$shipping_address['country_id'] = $this->request->get['country_id'];			
				$shipping_address['zone_id'] = $this->request->get['zone_id'];
				$shipping_address['city'] = $this->request->get['city'];
				$shipping_address['postcode'] = $this->request->get['postcode'];
				
				$this->session->data['guest']['shipping']['country_id'] = $this->request->get['country_id'];
				$this->session->data['guest']['shipping']['zone_id'] = $this->request->get['zone_id'];
				$this->session->data['guest']['shipping']['city'] = $this->request->get['city'];
				$this->session->data['guest']['shipping']['postcode'] = $this->request->get['postcode'];	
			}
		}
		
		if (isset($this->request->get['isset']) && $this->request->get['isset']) {
			$shipping_address['country_id'] = $this->request->get['country_id'];			
			$shipping_address['zone_id'] = $this->request->get['zone_id'];
			$shipping_address['city'] = $this->request->get['city'];
			$shipping_address['postcode'] = $this->request->get['postcode'];
			
			$this->session->data['guest']['shipping']['country_id'] = $this->request->get['country_id'];
			$this->session->data['guest']['shipping']['zone_id'] = $this->request->get['zone_id'];
			$this->session->data['guest']['shipping']['city'] = $this->request->get['city'];
			$this->session->data['guest']['shipping']['postcode'] = $this->request->get['postcode'];
			
			$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
			
			if ($country_info) {
				$this->session->data['guest']['shipping']['country'] = $country_info['name'];	
				$this->session->data['guest']['shipping']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['guest']['shipping']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['guest']['shipping']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['guest']['shipping']['country'] = '';	
				$this->session->data['guest']['shipping']['iso_code_2'] = '';
				$this->session->data['guest']['shipping']['iso_code_3'] = '';
				$this->session->data['guest']['shipping']['address_format'] = '';
			}
			
			$this->load->model('localisation/zone');
							
			$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
		
			if ($zone_info) {
				$this->session->data['guest']['shipping']['zone'] = $zone_info['name'];
				$this->session->data['guest']['shipping']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['guest']['shipping']['zone'] = '';
				$this->session->data['guest']['shipping']['zone_code'] = '';
			}
			
			$this->session->data['shipping_country_id'] = $this->request->get['country_id'];
			$this->session->data['shipping_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['shipping_postcode'] = $this->request->get['postcode'];
		}

		if (isset($this->request->get['address_id']) && $this->request->get['address_id']) {
			$shipping_address = $this->model_account_address->getAddress($this->request->get['address_id']);
			
			$this->session->data['shipping_address_id'] = $this->request->get['address_id'];
			
			unset($this->session->data['guest']['shipping']['country_id']);
			unset($this->session->data['guest']['shipping']['zone_id']);
		}
		
		if (!empty($shipping_address)) {
			// Shipping Methods
			$quote_data = array();
			
			$this->load->model('setting/extension');
			
			$results = $this->model_setting_extension->getExtensions('shipping');
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);
					
					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($shipping_address); 
		
					if ($quote) {
						$quote_data[$result['code']] = array( 
							'title'      => $quote['title'],
							'quote'      => $quote['quote'], 
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
						);
					}
				}
			}
	
			$sort_order = array();
		  
			foreach ($quote_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $quote_data);
			
			$this->session->data['shipping_methods'] = $quote_data;
		}
					
		$this->data['text_shipping_method'] = $this->language->get('text_shipping_method');
		$this->data['text_comments'] = $this->language->get('text_comments');
	
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		if (empty($this->session->data['shipping_methods'])) {
			$this->data['error_warning'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
		} else {
			$this->data['error_warning'] = '';
		}	
					
		if (isset($this->session->data['shipping_methods'])) {
			$this->data['shipping_methods'] = $this->session->data['shipping_methods']; 
		} else {
			$this->data['shipping_methods'] = array();
		}
		
		if (isset($this->session->data['shipping_method']['code'])) {
			$this->data['code'] = $this->session->data['shipping_method']['code'];
		} else {
			$this->data['code'] = '';
		}
		
		if (isset($this->session->data['comment'])) {
			$this->data['comment'] = $this->session->data['comment'];
		} else {
			$this->data['comment'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/quickcheckout/shipping_method.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/quickcheckout/shipping_method.tpl';
		} else {
			$this->template = 'default/template/quickcheckout/shipping_method.tpl';
		}
		
		$this->response->setOutput($this->render());
  	}
	
	public function validate() {
		$this->language->load('quickcheckout/checkout');
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		
		if ($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {	
			$shipping_address = $this->model_account_address->getAddress(intval($this->session->data['shipping_address_id']));		
		} elseif (isset($this->session->data['guest']['shipping'])) {
			$shipping_address = $this->session->data['guest']['shipping'];
		} else {
			if (isset($this->request->get['country_id']) && isset($this->request->get['zone_id'])){
				$shipping_address['country_id'] = $this->request->get['country_id'];			
				$shipping_address['zone_id'] = $this->request->get['zone_id'];
				$shipping_address['city'] = $this->request->get['city'];
				$shipping_address['postcode'] = $this->request->get['postcode'];
				
				$this->session->data['guest']['shipping']['country_id'] = $this->request->get['country_id'];
				$this->session->data['guest']['shipping']['zone_id'] = $this->request->get['zone_id'];
				$this->session->data['guest']['shipping']['city'] = $this->request->get['city'];
				$this->session->data['guest']['shipping']['postcode'] = $this->request->get['postcode'];	
			}
		}
		
		if (isset($this->request->get['isset']) && $this->request->get['isset']) {
			$shipping_address['country_id'] = $this->request->get['country_id'];			
			$shipping_address['zone_id'] = $this->request->get['zone_id'];
			$shipping_address['city'] = $this->request->get['city'];
			$shipping_address['postcode'] = $this->request->get['postcode'];
			
			$this->session->data['guest']['shipping']['country_id'] = $this->request->get['country_id'];
			$this->session->data['guest']['shipping']['zone_id'] = $this->request->get['zone_id'];
			$this->session->data['guest']['shipping']['city'] = $this->request->get['city'];
			$this->session->data['guest']['shipping']['postcode'] = $this->request->get['postcode'];
			
			$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
			
			if ($country_info) {
				$this->session->data['guest']['shipping']['country'] = $country_info['name'];	
				$this->session->data['guest']['shipping']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['guest']['shipping']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['guest']['shipping']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['guest']['shipping']['country'] = '';	
				$this->session->data['guest']['shipping']['iso_code_2'] = '';
				$this->session->data['guest']['shipping']['iso_code_3'] = '';
				$this->session->data['guest']['shipping']['address_format'] = '';
			}
			
			$this->load->model('localisation/zone');
							
			$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
		
			if ($zone_info) {
				$this->session->data['guest']['shipping']['zone'] = $zone_info['name'];
				$this->session->data['guest']['shipping']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['guest']['shipping']['zone'] = '';
				$this->session->data['guest']['shipping']['zone_code'] = '';
			}
			
			$this->session->data['shipping_country_id'] = $this->request->get['country_id'];
			$this->session->data['shipping_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['shipping_postcode'] = $this->request->get['postcode'];
		}
		
		if (isset($this->request->get['address_id']) && $this->request->get['address_id']) {
			$shipping_address = $this->model_account_address->getAddress($this->request->get['address_id']);
			
			$this->session->data['shipping_address_id'] = $this->request->get['address_id'];
			
			unset($this->session->data['guest']['shipping']['country_id']);
			unset($this->session->data['guest']['shipping']['zone_id']);
		}
		
		if (!isset($this->session->data['shipping_methods'])) {
			// Shipping Methods
			$quote_data = array();
			
			$this->load->model('setting/extension');
			
			$results = $this->model_setting_extension->getExtensions('shipping');
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);
					
					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($shipping_address); 
		
					if ($quote) {
						$quote_data[$result['code']] = array( 
							'title'      => $quote['title'],
							'quote'      => $quote['quote'], 
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
						);
					}
				}
			}
	
			$sort_order = array();
		  
			foreach ($quote_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $quote_data);
			
			$this->session->data['shipping_methods'] = $quote_data;
		}
		
		$json = array();		
		
		// Validate if shipping is required. If not the customer should not have reached this page.
		if (!$this->cart->hasShipping()) {
			$json['redirect'] = $this->url->link('quickcheckout/checkout', '', 'SSL');
		}
		
		// Validate if shipping address has been set.		
		if ($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {					
			$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);		
		} elseif (isset($this->session->data['guest'])) {
			$shipping_address = $this->session->data['guest']['shipping'];
		}
		
		if (empty($shipping_address)) {								
			$json['redirect'] = $this->url->link('quickcheckout/checkout', '', 'SSL');
		}
		
		// Validate cart has products and has stock.	
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');				
		}	
		
		// Validate minimum quantity requirments.			
		$products = $this->cart->getProducts();
				
		foreach ($products as $product) {
			$product_total = 0;
				
			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}		
			
			if ($product['minimum'] > $product_total) {
				$json['redirect'] = $this->url->link('checkout/cart');
				
				break;
			}				
		}
				
		if (!$json) {
			if (!isset($this->request->post['shipping_method'])) {
				$json['error']['warning'] = $this->language->get('error_shipping');
			} else {
				$shipping = explode('.', $this->request->post['shipping_method']);
					
				if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {			
					$json['error']['warning'] = $this->language->get('error_shipping');
				}
			}
			
			if (!$json) {
				$shipping = explode('.', $this->request->post['shipping_method']);
					
				$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
				
				$this->session->data['comment'] = strip_tags($this->request->post['comment']);
			}							
		}

		$this->response->setOutput(json_encode($json));	
	}
}
?>