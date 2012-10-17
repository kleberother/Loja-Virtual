<?php echo $header; ?> 

<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
        
        <?php if (!empty($error)) { ?>
            <div class="warning"><?php echo $error; ?></div> 
        <?php } ?>
            
        <?php if (!empty($success)) { ?>
            <div class="success"><?php echo $success; ?></div> 
        <?php } ?>
        
        <div id="tabs" class="htabs"> 
            <a href="#tab-status"><?php echo $tab_status; ?></a>
            <a href="#tab-export"><?php echo $tab_export; ?></a>
            <a href="#tab-import"><?php echo $tab_import; ?></a>
        </div>
        
            <div id="tab-status">
                <?php echo $module_installed; ?>
            </div>
            <div id="tab-export">
                <?php echo $module_export_txt; ?>
                <table  width="100%" cellspacing="0" cellpadding="2" border="0" class="adminlist">
                    <tr>
                        <td width="200"><?php echo $label_export; ?><span class="help"><?php echo $help_export; ?></span></td>
                        <td><a onclick="location = '<?php echo $export; ?>';" class="button"><?php echo $button_export; ?></a></td>
                    </tr>
                </table>
            </div>
            <div id="tab-import">
                <form action="<?php echo $import; ?>" method="post" enctype="multipart/form-data">
                    <table  width="100%" cellspacing="0" cellpadding="2" border="0" class="adminlist">
                        <tr>
                            <td width="200"><?php echo $label_import; ?><span class="help"><?php echo $help_import; ?></span></td>
                            <td><input type="file" name="uploadFile" id="importFile" /></td>
                        </tr>
                        <tr>
                            <td colspan="2"><input type="submit" class="button" style="margin-top:20px;" value="<?php echo $button_import; ?>" /></td>
                        </tr>
                    </table>
                </form>
            </div>
        
        
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<?php echo $footer; ?>