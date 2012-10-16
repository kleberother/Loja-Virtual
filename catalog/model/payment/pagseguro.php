<?php 
class ModelPaymentPagseguro extends Model {
  	public function getMethod($address, $total) {
		$this->load->language('payment/pagseguro');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('pagseguro_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
		
		if ($this->config->get('pagseguro_total') > $total) {
			$status = false;
		} elseif (!$this->config->get('pagseguro_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}	
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'       => 'pagseguro',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('pagseguro_sort_order')
      		);
    	}
   
    	return $method_data;
  	}
}
?>