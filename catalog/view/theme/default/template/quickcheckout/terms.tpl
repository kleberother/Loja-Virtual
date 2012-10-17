<?php if ($text_agree) { ?>
		<?php echo $text_agree; ?>
		<?php if ($agree) { ?>
			<input type="checkbox" name="agree" value="1" checked="checked" />
		<?php } else { ?>
			<input type="checkbox" name="agree" value="1" />
		<?php } ?>
		<input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" />
<?php } else { ?>
	<input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" class="button" />
<?php } ?>

<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script>   