<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ModelNeAccount extends Model {

	public function subscribe($data) {
		$query = $this->db->query("SELECT history_id, stats_personal_id FROM `" . DB_PREFIX . "ne_stats_personal` WHERE stats_personal_id = '" . (int)$data['uid'] . "' AND email = '" . $this->db->escape($data['email']) . "'");
		if (!$query->row) {
			return false;
		}

		$email = $data['email'];

		$query = $this->db->query("SELECT customer_id FROM " . DB_PREFIX . "customer WHERE email = '" . $this->db->escape($email) . "'");
		$info = $query->row;

		if (!$info) {
			$query = $this->db->query("SELECT marketing_id FROM " . DB_PREFIX . "ne_marketing WHERE email = '" . $this->db->escape($email) . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
			$info = $query->row;
			if ($info) {
				$this->db->query("UPDATE " . DB_PREFIX . "ne_marketing SET `subscribed` = '1' WHERE marketing_id = '" . (int)$info['marketing_id'] . "'");
				return true;
			}
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET `newsletter` = '1' WHERE customer_id = '" . (int)$info['customer_id'] . "'");
			return true;
		}
		
		return false;
	}

	public function unsubscribe($data) {
		$query = $this->db->query("SELECT history_id, stats_personal_id FROM `" . DB_PREFIX . "ne_stats_personal` WHERE stats_personal_id = '" . (int)$data['uid'] . "' AND email = '" . $this->db->escape($data['email']) . "'");
		if (!$query->row) {
			return false;
		}

		$email = $data['email'];

		$query = $this->db->query("SELECT customer_id FROM " . DB_PREFIX . "customer WHERE email = '" . $this->db->escape($email) . "'");
		$info = $query->row;

		if (!$info) {
			$query = $this->db->query("SELECT marketing_id FROM " . DB_PREFIX . "ne_marketing WHERE email = '" . $this->db->escape($email) . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
			$info = $query->row;
			if ($info) {
				$this->db->query("UPDATE " . DB_PREFIX . "ne_marketing SET `subscribed` = '0' WHERE marketing_id = '" . (int)$info['marketing_id'] . "'");
				return true;
			}
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET `newsletter` = '0' WHERE customer_id = '" . (int)$info['customer_id'] . "'");
			return true;
		}
		
		return false;
	}
	
}

?>