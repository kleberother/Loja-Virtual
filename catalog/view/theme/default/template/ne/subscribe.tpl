<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<div class="box">
	<div class="box-heading"><?php echo $subscribe_title; ?></div>
	<div class="box-content">
		<div id="ne_subscribe<?php echo $module; ?>" class="ne_subscribe">
			<p><?php echo $subscribe_text; ?></p>
			<?php if ($this->config->get('ne_unloginned_subscribe_fields') == 2 || $this->config->get('ne_unloginned_subscribe_fields') == 3) { ?>
			<label>
				<?php echo $this->config->get('ne_unloginned_subscribe_fields') == 2 ? $entry_name : $entry_firstname; ?><br/>
				<input type="text" name="name" />
			</label>
			<?php } ?>
			<?php if ($this->config->get('ne_unloginned_subscribe_fields') == 3) { ?>
			<label>
				<?php echo $entry_lastname; ?><br/>
				<input type="text" name="lastname" />
			</label>
			<?php } ?>
			<label>
				<?php echo $entry_email; ?><br/>
				<input type="text" name="email" />
			</label>
			<?php if ($list_data) { ?>
			<p><?php echo $subscribe_text_list; ?></p>
			<div class="ne_list_data">
				<?php if($list_data) foreach ($list_data as $key => $list) { ?>
					<label>
						<input class="ne_subscribe_list" name="list[]" type="checkbox" value="<?php echo $key; ?>"/><?php echo $list[$this->config->get('config_language_id')]; ?>
					</label>
				<?php } ?>
			</div>
			<?php } else { ?>
			<br/>
			<?php } ?>
			<a href="#" class="button"><span><?php echo $subscribe; ?></span></a>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
$('#ne_subscribe<?php echo $module; ?> a').click(function(e){
	e.preventDefault();

	var list = $('#ne_subscribe<?php echo $module; ?> .ne_subscribe_list:checked').map(function(i,n) {
        return $(n).val();
    }).get();

	$.post("<?php echo $subscribe_link; ?>", { email: $('#ne_subscribe<?php echo $module; ?> input[name="email"]').val(), <?php if ($this->config->get('ne_unloginned_subscribe_fields') == 2 || $this->config->get('ne_unloginned_subscribe_fields') == 3) { ?>name: $('#ne_subscribe<?php echo $module; ?> input[name="name"]').val(), <?php } ?><?php if ($this->config->get('ne_unloginned_subscribe_fields') == 3) { ?>lastname: $('#ne_subscribe<?php echo $module; ?> input[name="lastname"]').val(), <?php } ?>'list[]': list }, function(data) {
		if (data) {
			if (data.type == 'success') {
				$('#ne_subscribe<?php echo $module; ?> input[type="text"]').val('');
				$('#ne_subscribe<?php echo $module; ?> .ne_subscribe_list').removeAttr('checked');
			}
			$('#ne_subscribe<?php echo $module; ?>').prepend('<div class="' + data.type + '">' + data.message + '</div>');
			$("#ne_subscribe<?php echo $module; ?> div." + data.type).delay(3000).slideUp(400, function(){$(this).remove();});
		} else {
			$('#ne_subscribe<?php echo $module; ?> input[type="text"]:first').focus();
		}
	}, "json");
});
//--></script>