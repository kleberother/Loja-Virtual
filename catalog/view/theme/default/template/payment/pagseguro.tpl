<?php if ($text_information) { ?>
<div class="information"><?php echo $text_information; ?></div>
<?php } ?>
<div class="buttons" style="border:2px solid #005b3a; border-radius:6px; height: 64px; background:white;">
  <div class="right"><a id="button-confirm" class="button" style="background:#005b3a;"><span><?php echo $button_confirm; ?></span></a></div>   
  <div class="left"><img src="/catalog/view/theme/default/image/btn_pagseguro.jpg"></div>  
  <br clear="left" />
</div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
	$.ajax({
		type: 'GET',
		url: 'index.php?route=payment/pagseguro/confirm',
		beforeSend: function() {
			$('#button-confirm').attr('disabled', true);
			
			$('#payment').before('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		success: function() {
                    <?php if($pagseguro_gateway_status) { ?>
			location = '<?php echo $url; ?>';
                    <?php }else{ ?>
                        location = 'index.php?route=checkout/success';
                    <?php } ?>
		}
	});
});
//--></script>