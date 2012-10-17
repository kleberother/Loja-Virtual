<div id="login">
  <div style="width: 33%; float: left;"><b><?php echo $entry_email; ?></b><input type="text" name="email" value="" /></div>
  <div style="width: 33%; text-align: center; float: left;"><b><?php echo $entry_password; ?></b><input type="password" name="password" value="" /></div>
  <div style="width: 33%; float: left; text-align: right;"><input type="button" value="<?php echo $button_login; ?>" id="button-login" class="button" /></div>
</div>

<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-login').click();
	}
});
//--></script>   