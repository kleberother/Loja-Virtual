<?php 
/** 
 * Wholesaleview model class
 * 
 * Created by Kleber Oliveira / Omdi Ltda
 
 */
class ModelWholesaleviewWholesaleview extends Model 
{    
    
    public function install(){
        
        $this->log->write('WHOLESALEVIEW --> Starting install');
        
        $this->db->query("ALTER TABLE `".DB_PREFIX."category` ADD `wholesaleview` TINYINT( 1 ) NOT NULL");
        
        $this->log->write('WHOLESALEVIEW --> Altered '.DB_PREFIX.'category table');
        
        $this->log->write('WHOLESALEVIEW --> Completed install');
    }
    
    public function uninstall(){
        
        $this->log->write('WHOLESALEVIEW --> Starting uninstall');
        
        $query = $this->db->query("ALTER TABLE `".DB_PREFIX."category` DROP `wholesaleview`");
        $this->log->write('WHOLESALEVIEW --> Altered '.DB_PREFIX.'category table');
        
        $this->log->write('WHOLESALEVIEW --> Completed uninstall');
    }
}
?>