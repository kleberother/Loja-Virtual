<?php 
/** 
 * Akatus model class
 * 
 * Created by Kleber Oliveira / Omdi Ltda
 
 */
class ModelAkatusAkatus extends Model 
{    
    
    public function install(){
        
        $this->log->write('Akatus --> Starting install');

		$query = $this->db->query("SELECT COUNT( * ) AS `Registros` , `language_id` FROM `" . DB_PREFIX. "order_status` GROUP BY `language_id` ORDER BY `language_id`");

		foreach ($query->rows as $reg) {
    		$this->db->query("INSERT IGNORE INTO `" . DB_PREFIX . "order_status` (`order_status_id`, `language_id`, `name`) VALUES
    		(10200, " . $reg['language_id'] . ", 'Aguardando Pagamento'),
    		(10201, " . $reg['language_id'] . ", 'Em Analise'),
		    (10202, " . $reg['language_id'] . ", 'Aprovado'),
		    (10203, " . $reg['language_id'] . ", 'Cancelado'),
		    (10204, " . $reg['language_id'] . ", 'Completo'),
		    (10205, " . $reg['language_id'] . ", 'Devolvido'),
		    (10206, " . $reg['language_id'] . ", 'Desconhecido');");
		}
        
        $this->log->write('Akatus --> Altered '.DB_PREFIX.'order_status table');
        
        $this->log->write('Akatus --> Completed install');        
        
    }
    
    public function uninstall(){
        
        $this->log->write('Akatus --> Starting uninstall');

            $this->db->query("DELETE FROM `" . DB_PREFIX . "order_status` WHERE 
            `order_status_id` = 10200 OR 
            `order_status_id` = 10201 OR 
            `order_status_id` = 10202 OR 
            `order_status_id` = 10203 OR 
            `order_status_id` = 10204 OR 
            `order_status_id` = 10205 OR 
            `order_status_id` = 10206");
        
        $this->log->write('Akatus --> Altered '.DB_PREFIX.'order_status table');
        
        $this->log->write('Akatus --> Completed uninstall');
    }
}
?>