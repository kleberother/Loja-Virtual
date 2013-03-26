<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1><img src="view/image/ne/templates.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="location = '<?php echo $refresh; ?>';" class="button"><span><?php echo $button_check; ?></span></a></div>
		</div>
		<div class="content">
			<h2 style="text-align:center;"><?php echo $content; ?></h2>
		</div>
	</div>
</div>
<?php echo $footer; ?>