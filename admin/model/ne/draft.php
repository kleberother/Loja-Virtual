<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ModelNeDraft extends Model {
	
	public function getTotal($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "ne_draft` WHERE 1=1";
		
		if (isset($data['filter_date']) && !is_null($data['filter_date'])) {
			$sql .= " AND DATE(datetime) = DATE('" . $this->db->escape($data['filter_date']) . "')";
		}
		
		if (isset($data['filter_subject']) && !is_null($data['filter_subject'])) {
			$sql .= " AND LCASE(subject) LIKE '" . $this->db->escape(mb_strtolower($data['filter_subject'], 'UTF-8')) . "%'";
		}

		if (isset($data['filter_to']) && !is_null($data['filter_to'])) {
			$sql .= " AND `to` = '" . $this->db->escape($data['filter_to']) . "'";
		}

		if (isset($data['filter_store']) && !is_null($data['filter_store'])) {
			$sql .= " AND `store_id` = '" . (int)$data['filter_store'] . "'";
		}
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}

	public function getList($data = array()) {
		if ($data) {
			$sql = "SELECT `draft_id`, `subject`, `datetime`, `to`, `store_id` FROM " . DB_PREFIX . "ne_draft WHERE 1=1"; 
			
			if (isset($data['filter_date']) && !is_null($data['filter_date'])) {
				$sql .= " AND DATE(datetime) = DATE('" . $this->db->escape($data['filter_date']) . "')";
			}

			if (isset($data['filter_subject']) && !is_null($data['filter_subject'])) {
				$sql .= " AND LCASE(subject) LIKE '" . $this->db->escape(mb_strtolower($data['filter_subject'], 'UTF-8')) . "%'";
			}

			if (isset($data['filter_to']) && !is_null($data['filter_to'])) {
				$sql .= " AND `to` = '" . $this->db->escape($data['filter_to']) . "'";
			}

			if (isset($data['filter_store']) && !is_null($data['filter_store'])) {
				$sql .= " AND `store_id` = '" . (int)$data['filter_store'] . "'";
			}
			
			$sort_data = array(
				'draft_id',
				'subject',
				'datetime',
				'to',
				'store_id'
			);
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY `" . $data['sort'] . "`";	
			} else {
				$sql .= " ORDER BY datetime";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'ASC')) {
				$sql .= " ASC";
			} else {
				$sql .= " DESC";
			}
		
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}			

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	
			
			$query = $this->db->query($sql);
			
			$results = $query->rows;
			
			return $results;
		} else {
			return false;
		}
	}

	public function detail($draft_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ne_draft WHERE draft_id = '" . (int)$draft_id . "'"); 
		$data = $query->row;

		if ($data) {
			$path = dirname(DIR_DOWNLOAD) . DIRECTORY_SEPARATOR . 'attachments' . DIRECTORY_SEPARATOR . 'draft_' . $data['draft_id'];
			if (file_exists($path) && is_dir($path)) {
				$data['attachments'] = $this->attachments($path);
			} else {
				$data['attachments'] = array();
			}
		}

		$data['customer'] = unserialize($data['customer']);
		$data['affiliate'] = unserialize($data['affiliate']);
		$data['product'] = unserialize($data['product']);
		$data['defined_product'] = unserialize($data['defined_products']);
		$data['defined_product_more'] = unserialize($data['defined_products_more']);
		$data['defined_category'] = unserialize($data['defined_categories']);
		$data['marketing_list'] = unserialize($data['marketing_list']);

		return $data;
	}

	public function save($data) {
		if (isset($data['id']) && $data['id']) {
			$this->db->query("UPDATE " . DB_PREFIX . "ne_draft SET `to` = '" . $this->db->escape($data['to']) . "', store_id = '" . (int)$data['store_id'] . "', template_id = '" . (int)$data['template_id'] . "', language_id = '" . (int)$data['language_id'] . "', subject = '" . $this->db->escape($data['subject']) . "', message = '" . $this->db->escape($data['message']) . "', `marketing_list` = '" . $this->db->escape(isset($data['marketing_list']) ? serialize($data['marketing_list']) : '') . "', `defined_products` = '" . $this->db->escape(isset($data['defined_product']) ? serialize($data['defined_product']) : '') . "', `defined_products_more` = '" . $this->db->escape(isset($data['defined_product_more']) ? serialize($data['defined_product_more']) : '') . "', `defined_categories` = '" . $this->db->escape(isset($data['defined_category']) ? serialize($data['defined_category']) : '') . "', `customer` = '" . $this->db->escape((isset($data['customer']) && $data['to'] == 'customer') ? serialize($data['customer']) : '') . "', `affiliate` = '" . $this->db->escape((isset($data['affiliate']) && $data['to'] == 'affiliate') ? serialize($data['affiliate']) : '') . "', `product` = '" . $this->db->escape((isset($data['product']) && $data['to'] == 'product') ? serialize($data['product']) : '') . "', `customer_group_id` = '" . (int)$data['customer_group_id'] . "', defined = '" . $this->db->escape($data['defined']) . "', categories = '" . $this->db->escape($data['defined_categories']) . "', latest = '" . $this->db->escape($data['latest']) . "', popular = '" . $this->db->escape($data['popular']) . "', special = '" . $this->db->escape($data['special']) . "' WHERE draft_id = '" . (int)$data['id'] ."'");
		} else {
			$this->db->query("INSERT INTO " . DB_PREFIX . "ne_draft SET `to` = '" . $this->db->escape($data['to']) . "', store_id = '" . (int)$data['store_id'] . "', template_id = '" . (int)$data['template_id'] . "', language_id = '" . (int)$data['language_id'] . "', subject = '" . $this->db->escape($data['subject']) . "', message = '" . $this->db->escape($data['message']) . "', `marketing_list` = '" . $this->db->escape(isset($data['marketing_list']) ? serialize($data['marketing_list']) : '') . "', `defined_products` = '" . $this->db->escape(isset($data['defined_product']) ? serialize($data['defined_product']) : '') . "', `defined_products_more` = '" . $this->db->escape(isset($data['defined_product_more']) ? serialize($data['defined_product_more']) : '') . "', `defined_categories` = '" . $this->db->escape(isset($data['defined_category']) ? serialize($data['defined_category']) : '') . "', `customer` = '" . $this->db->escape((isset($data['customer']) && $data['to'] == 'customer') ? serialize($data['customer']) : '') . "', `affiliate` = '" . $this->db->escape((isset($data['affiliate']) && $data['to'] == 'affiliate') ? serialize($data['affiliate']) : '') . "', `product` = '" . $this->db->escape((isset($data['product']) && $data['to'] == 'product') ? serialize($data['product']) : '') . "', `customer_group_id` = '" . (int)$data['customer_group_id'] . "', defined = '" . $this->db->escape($data['defined']) . "', categories = '" . $this->db->escape($data['defined_categories']) . "', latest = '" . $this->db->escape($data['latest']) . "', popular = '" . $this->db->escape($data['popular']) . "', special = '" . $this->db->escape($data['special']) . "'");
			$data['id'] = $this->db->getLastId();
		}
		return $data['id'];
	}

	public function delete($draft_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "ne_draft WHERE draft_id = '" . (int)$draft_id . "'");

		$path = dirname(DIR_DOWNLOAD) . DIRECTORY_SEPARATOR . 'attachments' . DIRECTORY_SEPARATOR . 'draft_' . $draft_id;
		if (file_exists($path) && is_dir($path)) {
			$this->rrmdir($path);
		}
	}

	private function rrmdir($dir) {
		foreach(glob($dir . '/*') as $file) {
			if(is_dir($file)) {
				$this->rrmdir($file);
			} else {
				unlink($file);
			}
		}
		rmdir($dir);
	}

	private function attachments($dir) {
		$attachments = array();

		$files = (array) glob($dir);
		if (!empty($files))
			foreach ($files as $file) {
				$attachments[] = array(
					'filename' => basename($file),
					'path'     => $file
				);
			}

		return $attachments;
	}
}

?>