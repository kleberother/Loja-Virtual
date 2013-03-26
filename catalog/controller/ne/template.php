<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ControllerNeTemplate extends Controller {
	private $error = array();
	 
	private function template() {
		$this->load->model('ne/template');
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = HTTPS_IMAGE;
		} else {
			$server = HTTP_IMAGE;
		}

		$data = array(
			'template_id' => $this->request->post['template_id'],
			'language_id' => (int)(isset($this->request->post['language_id']) ? $this->request->post['language_id'] : $this->config->get('config_language_id'))
		);
		$template = $this->model_ne_template->getTemplate($data);
		unset($data);
		
		if ($template) {

			if (!$template['uri'] || (!file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/') && !file_exists(DIR_TEMPLATE . 'default/template/ne/templates/' . $template['uri'] . '/'))) {
				$template['uri'] = 'default';
			}

			$clear = (isset($this->request->post['clear']) && $this->request->post['clear']);

			$subject = (((isset($this->request->post['subject']) && $this->request->post['subject']) && !$clear) ? html_entity_decode($this->request->post['subject'], ENT_QUOTES, 'UTF-8') : $template['subject']);
			
			$body = (((isset($this->request->post['message']) && $this->request->post['message']) && !$clear) ? html_entity_decode($this->request->post['message'], ENT_QUOTES, 'UTF-8') : $template['body']);

			$subject = html_entity_decode($subject, ENT_QUOTES, 'UTF-8');
			$body = html_entity_decode($body, ENT_QUOTES, 'UTF-8');

			if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
				$body = str_replace('{logo}', '<!--//logo//--><a href="' . $this->url->link('common/home') . '" target="_blank"><img src="' . $server . $this->config->get('config_logo') . '" alt=""/></a><!--//end logo//-->', $body);
				$body = $this->replaceTags('<!--//logo//-->', '<!--//end logo//-->', '<a href="' . $this->url->link('common/home') . '" target="_blank"><img src="' . $server . $this->config->get('config_logo') . '" alt=""/></a>', $body);
			} else {
				$body = str_replace('{logo}', '<!--//logo//--><!--//end logo//-->', $body);
				$body = $this->replaceTags('<!--//logo//-->', '<!--//end logo//-->', '', $body);
			}

			if (strpos($body, '{date}') !== false) {
				$localisation_months = $this->config->get('ne_months');
				$localisation_weekdays = $this->config->get('ne_weekdays');
				$body = str_replace('{date}', ($localisation_weekdays[$template['language_id']][(int)date('w')] . ', ' . date('j') . ' ' . $localisation_months[$template['language_id']][(int)date('m') - 1] . ' ' . date('Y')), $body);
			}

			$body = str_replace(
				array(
					'{store_url}', 
					'{show_url}', 
					'{unsubscribe_url}', 
					'{subscribe_url}'
				), 
				array(
					$this->url->link('common/home'), 
					$this->url->link('ne/show', 'uid={uid}'), 
					$this->url->link('ne/unsubscribe', 'uid={uid}&key={key}'), 
					$this->url->link('ne/subscribe', 'uid={uid}&key={key}')
				), 
				$body
			);

			$body = str_replace(
				array(
					'{defined}', 
					'{special}', 
					'{latest}', 
					'{popular}',
					'{categories}'
				), 
				array(
					'<!--//defined//--><!--//end defined//-->', 
					'<!--//special//--><!--//end special//-->', 
					'<!--//latest//--><!--//end latest//-->', 
					'<!--//popular//--><!--//end popular//-->',
					'<!--//defined_categories//--><!--//end defined_categories//-->'
				), 
				$body
			);

			$this->data['columns_count'] = $template['product_cols'];

			$this->data['heading_color'] = $template['heading_color'];
			$this->data['heading_style'] = $template['heading_style'];

			$this->data['name_color'] = $template['product_name_color'];
			$this->data['name_style'] = $template['product_name_style'];

			$this->data['model_color'] = $template['product_model_color'];
			$this->data['model_style'] = $template['product_model_style'];

			$this->data['show_price'] = $template['product_show_prices'];
			
			$this->data['price_color'] = $template['product_price_color'];
			$this->data['price_style'] = $template['product_price_style'];

			$this->data['special_color'] = $template['product_price_color_special'];
			$this->data['special_style'] = $template['product_price_style_special'];

			$this->data['old_price_color'] = $template['product_price_color_when_special'];
			$this->data['old_price_style'] = $template['product_price_style_when_special'];

			$this->data['description_color'] = $template['product_description_color'];
			$this->data['description_style'] = $template['product_description_style'];

			$this->data['image_width'] = $template['product_image_width'];
			$this->data['image_height'] = $template['product_image_height'];

			$this->data['heading'] = '';
			$this->data['products'] = array();

			$data_setting = array(
				'language_id' => (int)(isset($this->request->post['language_id']) ? $this->request->post['language_id'] : $this->config->get('config_language_id')),
				'customer_group_id' => (int)((isset($this->request->post['customer_group_id']) && $this->request->post['customer_group_id']) ? $this->request->post['customer_group_id'] : $this->config->get('config_customer_group_id')),
				'store_id' => (int)(isset($this->request->post['store_id']) ? $this->request->post['store_id'] : $this->config->get('config_store_id'))
			);

			$this->data['products'] = array();
			
			if (((isset($this->request->post['defined']) && $this->request->post['defined']) || (isset($this->request->post['defined_more']) && $this->request->post['defined_more'])) && (!isset($this->request->post['recurrent']) || (isset($this->request->post['recurrent']) && !$this->request->post['recurrent'])))
			{
				$this->data['heading'] = (isset($this->request->post['defined_text']) && $this->request->post['defined_text']) ? $this->request->post['defined_text'] : $template['defined'];

				if (!isset($this->request->post['defined']) || !$this->request->post['defined']) {
					$this->request->post['defined'] = array();
				}

				$this->load->model('tool/image');
				
				foreach ($this->request->post['defined'] as $product_id) {
					$data = array_merge(array('product_id' => (int)$product_id), $data_setting);
					$result = $this->model_ne_template->getProduct($data);
					
					if (!$result) {
						continue;
					}
					
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
					} else {
						$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
					}
					
					$image = str_replace(' ', '%20', $image);
					
					if ($template['product_show_prices']) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}

					if ($template['product_show_prices'] && (float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					$this->data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'   	  => $image,
						'name'    	  => $result['name'],
						'price'    	  => str_replace('$', ':usd', $price),
						'special'     => str_replace('$', ':usd', $special),
						'model'       => (isset($result['model']) ? $result['model'] : ''),
						'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
						'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
				unset($result);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/defined.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/defined.tpl';
				} else {
					$this->template = 'default/template/ne/templates/' . $template['uri'] . '/defined.tpl';
				}

				$defined = $this->render();

				if (!isset($this->request->post['defined_more']) || !$this->request->post['defined_more']) {
					$this->request->post['defined_more'] = array();
				}

				foreach ($this->request->post['defined_more'] as $defined_more) {
					if (!isset($defined_more['products']) || !$defined_more['products']) {
						continue;
					}

					$this->data['heading'] = isset($defined_more['text']) ? $defined_more['text'] : '';

					$this->data['products'] = array();

					foreach ($defined_more['products'] as $product_id) {
						$data = array_merge(array('product_id' => (int)$product_id), $data_setting);
						$result = $this->model_ne_template->getProduct($data);

						if (!$result) {
							continue;
						}

						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
						} else {
							$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
						}

						$image = str_replace(' ', '%20', $image);

						if ($template['product_show_prices']) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}

						if ($template['product_show_prices'] && (float)$result['special']) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}

						$this->data['products'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'   	  => $image,
							'name'    	  => $result['name'],
							'price'    	  => str_replace('$', ':usd', $price),
							'special'     => str_replace('$', ':usd', $special),
							'model'       => (isset($result['model']) ? $result['model'] : ''),
							'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
							'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
						);
					}
					unset($result);

					$defined .= $this->render();
				}

				$body = $this->replaceTags('<!--//defined//-->', '<!--//end defined//-->', $defined, $body);
			} else {
				$body = $this->replaceTags('<!--//defined//-->', '<!--//end defined//-->', '', $body);
			}

			$this->data['products'] = array();

			if (isset($this->request->post['defined_categories']) && $this->request->post['defined_categories'])
			{
				$this->load->model('tool/image');

				$defined_categories = '';

				foreach ($this->request->post['defined_categories'] as $category_id) {

					$this->data['heading'] = sprintf($template['categories'], $this->model_ne_template->getPath($category_id, $data_setting['language_id']));

					$this->data['products'] = array();
					$products = $this->model_ne_template->getProductsByCategoryId($category_id);

					foreach ($products as $product) {
						$data = array_merge(array('product_id' => (int)$product['product_id']), $data_setting);
						$result = $this->model_ne_template->getProduct($data);

						if (!$result) {
							continue;
						}

						if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
						} else {
							$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
						}

						$image = str_replace(' ', '%20', $image);

						if ($template['product_show_prices']) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}

						if ($template['product_show_prices'] && (float)$result['special']) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}

						$this->data['products'][] = array(
							'product_id'  => $result['product_id'],
							'thumb'   	  => $image,
							'name'    	  => $result['name'],
							'price'    	  => str_replace('$', ':usd', $price),
							'special'     => str_replace('$', ':usd', $special),
							'model'       => (isset($result['model']) ? $result['model'] : ''),
							'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
							'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
						);
					}
					unset($result);

					if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/categories.tpl')) {
						$this->template = $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/categories.tpl';
					} else {
						$this->template = 'default/template/ne/templates/' . $template['uri'] . '/categories.tpl';
					}

					$defined_categories .= $this->render();
				}

				$body = $this->replaceTags('<!--//defined_categories//-->', '<!--//end defined_categories//-->', $defined_categories, $body);
			} else {
				$body = $this->replaceTags('<!--//defined_categories//-->', '<!--//end defined_categories//-->', '', $body);
			}

			$this->data['products'] = array();
			
			if (isset($this->request->post['special']) && $this->request->post['special'])
			{
				$this->data['heading'] = $template['special'];

				$this->load->model('tool/image');
				
				$data = array_merge(array(
					'sort'  => 'p.sort_order',
					'order' => 'ASC',
					'start' => 0,
					'limit' => (int)$template['specials_count']
				), $data_setting);
				
				$product_total = $this->model_ne_template->getTotalProductSpecials($data);
				
				if (!$data['limit'])
				{
					$data['limit'] = $product_total;
				}
				
				$results = $this->model_ne_template->getProductSpecials($data);
				
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
					} else {
						$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
					}
					
					$image = str_replace(' ', '%20', $image);
					
					if ($template['product_show_prices']) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
					
					if ($template['product_show_prices'] && (float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					$this->data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'   	  => $image,
						'name'    	  => $result['name'],
						'price'    	  => str_replace('$', ':usd', $price),
						'special'     => str_replace('$', ':usd', $special),
						'model'       => (isset($result['model']) ? $result['model'] : ''),
						'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
						'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
				unset($result);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/special.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/special.tpl';
				} else {
					$this->template = 'default/template/ne/templates/' . $template['uri'] . '/special.tpl';
				}

				$special = $this->render();
				$body = $this->replaceTags('<!--//special//-->', '<!--//end special//-->', $special, $body);
			} else {
				$body = $this->replaceTags('<!--//special//-->', '<!--//end special//-->', '', $body);
			}

			$this->data['products'] = array();
			
			if (isset($this->request->post['latest']) && $this->request->post['latest'])
			{
				$this->data['heading'] = $template['latest'];

				$this->load->model('tool/image');
				
				$data = array_merge(array(
					'sort'  => 'p.date_added',
					'order' => 'DESC',
					'start' => 0,
					'limit' => (int)$template['latest_count']
				), $data_setting);
				
				$results = $this->model_ne_template->getProducts($data);
				
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
					} else {
						$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
					}
					
					$image = str_replace(' ', '%20', $image);
					
					if ($template['product_show_prices']) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
					
					if ($template['product_show_prices'] && (float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					$this->data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'   	  => $image,
						'name'    	  => $result['name'],
						'price'    	  => str_replace('$', ':usd', $price),
						'special'     => str_replace('$', ':usd', $special),
						'model'       => (isset($result['model']) ? $result['model'] : ''),
						'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
						'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
				unset($result);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/latest.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/latest.tpl';
				} else {
					$this->template = 'default/template/ne/templates/' . $template['uri'] . '/latest.tpl';
				}

				$latest = $this->render();
				$body = $this->replaceTags('<!--//latest//-->', '<!--//end latest//-->', $latest, $body);
			} else {
				$body = $this->replaceTags('<!--//latest//-->', '<!--//end latest//-->', '', $body);
			}

			$this->data['products'] = array();
			
			if (isset($this->request->post['popular']) && $this->request->post['popular'])
			{
				$this->data['heading'] = $template['popular'];

				$this->load->model('tool/image');

				$data = array_merge(array(
					'limit' => (int)$template['popular_count']
				), $data_setting);
				
				$results = $this->model_ne_template->getBestSellerProducts($data);
				
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
					} else {
						$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
					}
					
					$image = str_replace(' ', '%20', $image);
					
					if ($template['product_show_prices']) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
					
					if ($template['product_show_prices'] && (float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					$this->data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'   	  => $image,
						'name'    	  => $result['name'],
						'price'    	  => str_replace('$', ':usd', $price),
						'special'     => str_replace('$', ':usd', $special),
						'model'       => (isset($result['model']) ? $result['model'] : ''),
						'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
						'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
				unset($result);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/popular.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/popular.tpl';
				} else {
					$this->template = 'default/template/ne/templates/' . $template['uri'] . '/popular.tpl';
				}

				$popular = $this->render();
				$body = $this->replaceTags('<!--//popular//-->', '<!--//end popular//-->', $popular, $body);
			} else {
				$body = $this->replaceTags('<!--//popular//-->', '<!--//end popular//-->', '', $body);
			}

			$this->data['products'] = array();

			if (isset($this->request->post['recurrent']) && $this->request->post['recurrent'] && isset($this->request->post['random']) && $this->request->post['random'])
			{
				$this->data['heading'] = $template['defined'];

				$this->load->model('tool/image');
				
				$data = array_merge(array(
					'sort'  => 'RAND()',
					'order' => 'DESC',
					'start' => 0,
					'limit' => (int)$this->request->post['random_count']
				), $data_setting);
				
				$results = $this->model_ne_template->getProducts($data);
				
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $template['product_image_width'], $template['product_image_height']);
					} else {
						$image = $this->model_tool_image->resize('no_image.jpg', $template['product_image_width'], $template['product_image_height']);
					}
					
					$image = str_replace(' ', '%20', $image);
					
					if ($template['product_show_prices']) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
					
					if ($template['product_show_prices'] && (float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					$this->data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'   	  => $image,
						'name'    	  => $result['name'],
						'price'    	  => str_replace('$', ':usd', $price),
						'special'     => str_replace('$', ':usd', $special),
						'model'       => (isset($result['model']) ? $result['model'] : ''),
						'description' => ((int)$template['product_description_length'] ? mb_substr(trim(preg_replace("/\s\s+/u", ' ', strip_tags(html_entity_decode(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8')))), 0, (int)$template['product_description_length'], 'UTF-8') . '..' : ''),
						'href'    	  => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
				unset($result);

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/defined.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/ne/templates/' . $template['uri'] . '/defined.tpl';
				} else {
					$this->template = 'default/template/ne/templates/' . $template['uri'] . '/defined.tpl';
				}

				$latest = $this->render();
				$body = $this->replaceTags('<!--//defined//-->', '<!--//end defined//-->', $latest, $body);
			}

			$body = str_replace(':usd', '$', $body);
		} else {
			$body = '';
			$subject = '';
		}

		return array('subject' => $subject, 'body' => $body);
	}

	public function json() {
		if(empty($this->request->server['HTTP_X_REQUESTED_WITH']) || strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest') {
			$this->redirect($this->url->link('common/home'));
		}

		$json = (object)$this->template();
		$this->response->addHeader('Content-type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function json_raw() {
		if(empty($this->request->server['HTTP_X_REQUESTED_WITH']) || strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest') {
			$this->redirect($this->url->link('common/home'));
		}

		$this->load->model('ne/template');

		$data = array(
			'template_id' => $this->request->post['template_id'],
			'language_id' => (int)(isset($this->request->post['language_id']) ? $this->request->post['language_id'] : $this->config->get('config_language_id'))
		);
		$template = $this->model_ne_template->getTemplate($data);
		unset($data);

		if ($template) {
			$body = $template['body'];
			$subject = $template['subject'];

			$subject = html_entity_decode($subject, ENT_QUOTES, 'UTF-8');
			$body = html_entity_decode($body, ENT_QUOTES, 'UTF-8');
		} else {
			$body = '';
			$subject = '';
		}

		$json = (object)array('subject' => $subject, 'body' => $body);
		$this->response->addHeader('Content-type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function replaceTags($start, $end, $text, $source) {
		return preg_replace('#('.preg_quote($start).')(.*)('.preg_quote($end).')#si', '$1'.$text.'$3', $source);
	}

}
?>