<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<div style="display:none;">
<div id="ne_modal<?php echo $module; ?>" class="ne_modal">
	<h2><?php echo $subscribe_title; ?></h2>
	<p><?php echo $subscribe_text; ?></p>
	<hr/>
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
	<div class="ne_actions">
		<a href="#" class="button"><span><?php echo $subscribe; ?></span></a>
		<?php if ((int)$this->config->get('ne_modal_timeout')) { ?>
			<span id="ne_timer<?php echo $module; ?>"><?php echo $timer_text ?></span>
		<?php } else { ?>
			<a href="#" class="close"><?php echo $close; ?></a>
		<?php } ?>
	</div>
</div>
</div>
<script type="text/javascript"><!--
jQuery(function ($) {

	if ($.cookie('ne_subscribed') == null) {
		var ts = (new Date()).getTime() + <?php echo (int)$this->config->get('ne_modal_timeout'); ?>*1000,
			timer = $('#ne_timer<?php echo $module; ?> pre:first');
		
		$('#ne_modal<?php echo $module; ?>').modal({
			close: false, 
			autoResize: true,
			onShow: function() {
				$('#ne_timer<?php echo $module; ?>').countdown({
					timestamp: ts,
					callback: function(days, hours, minutes, seconds){
						var message = "";
						message += (minutes < 10 ? '0' : '') + minutes + ':';
						message += (seconds < 10 ? '0' : '') + seconds;
						timer.text(message);
						if (!minutes && !seconds && !days && !hours && <?php echo (int)$this->config->get('ne_modal_timeout'); ?> > 0) {
							$.modal.close();
						}
					}
				});
			}
		});
	}

	$('#ne_modal<?php echo $module; ?> a.button').click(function(e){
		e.preventDefault();

		var list = $('#ne_modal<?php echo $module; ?> .ne_subscribe_list:checked').map(function(i,n) {
			return $(n).val();
		}).get();

		$.post("<?php echo $subscribe_link; ?>", { email: $('#ne_modal<?php echo $module; ?> input[name="email"]').val(), <?php if ($this->config->get('ne_unloginned_subscribe_fields') == 2 || $this->config->get('ne_unloginned_subscribe_fields') == 3) { ?>name: $('#ne_modal<?php echo $module; ?> input[name="name"]').val(), <?php } ?><?php if ($this->config->get('ne_unloginned_subscribe_fields') == 3) { ?>lastname: $('#ne_modal<?php echo $module; ?> input[name="lastname"]').val(), <?php } ?>'list[]': list }, function(data) {
			if (data) {
				if (data.type == 'success') {
					$.cookie('ne_subscribed', true, {expires: 365, path: '/'});
					$('#ne_modal<?php echo $module; ?> input[type="text"]').val('');
					$('#ne_modal<?php echo $module; ?> .ne_subscribe_list').removeAttr('checked');
				}
				$("#ne_modal<?php echo $module; ?> div." + data.type).remove();
				$('#ne_modal<?php echo $module; ?>').prepend('<div class="' + data.type + '">' + data.message + '</div>');
				$("#ne_modal<?php echo $module; ?> div." + data.type).delay(3000).slideUp(400, function(){if(data.type == 'success'){$.modal.close();} $(this).remove();});
			} else {
				$('#ne_modal<?php echo $module; ?> input[type="text"]:first').focus();
			}
		}, "json");
	});

	$('#ne_modal<?php echo $module; ?> a.close').click(function(e){
		e.preventDefault();
		$.modal.close();
	});

});
//--></script>