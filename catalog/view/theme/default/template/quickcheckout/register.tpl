<br />
<div class="left">
  <span class="required">*</span> <?php echo $entry_password; ?><br />
  <input type="password" name="password" value="" class="large-field" /><br />
</div>
<div class="right">
  <span class="required">*</span> <?php echo $entry_confirm; ?> <br />
  <input type="password" name="confirm" value="" class="large-field" /><br />
</div>

<div style="clear: both; padding-bottom: 15px; border-bottom: 1px solid #EEEEEE; margin-bottom:15px;">
<?php if($this->config->get('quickcheckout_newsletter')) { ?>
  <input type="checkbox" name="newsletter" value="1" id="newsletter" checked="checked" />
<?php } else { ?>
  <input type="checkbox" name="newsletter" value="1" id="newsletter" />
<?php } ?>
  <label for="newsletter"><?php echo $entry_newsletter; ?></label><br />
  <?php if ($text_agree) { ?>
    <input type="checkbox" name="agree" value="1" id="agree-reg" />
	<label for="agree-reg"><?php echo $text_agree; ?></label>
  <?php } ?>
</div>

<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 