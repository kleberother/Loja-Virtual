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

        <div id="tab-status">
            <?php echo $module_installed; ?>
        </div>
        
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<?php echo $footer; ?>