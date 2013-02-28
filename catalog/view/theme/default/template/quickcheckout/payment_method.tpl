<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<p><?php echo $text_payment_method; ?></p>
<?php if ($this->config->get('quickcheckout_payment')) { ?>
<table class="radio">
  <?php foreach ($payment_methods as $payment_method) { ?>
  <tr class="highlight">
    <td><?php if ($payment_method['code'] == $code || !$code) {?>
	<?php $hasPagSeguro = $payment_method['title']=="PagSeguro"?true:false; ?>
      <?php $code = $payment_method['code']; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
  </tr>
  <?php } ?>
  <?php if($hasPagSeguro){ ?>
  <tr>
  	<td></td>
    <td>	<label for="pagseguro" style="height:auto"><img alt='Logotipos de meios de pagamento do PagSeguro' src='/catalog/view/theme/default/image/banner_pagseguro.jpeg' title='Este site aceita pagamentos com Oi Paggo, Bradesco, Itaú, Banco do Brasil, Banrisul, Banco HSBC, saldo em conta PagSeguro e boleto.' border='0'></label></td>
  </tr>
<?php } ?>
</table>

<?php } else { ?>
  <select name="payment_method">
  <?php foreach ($payment_methods as $payment_method) { ?>
	<?php $hasPagSeguro = $payment_method['title']=="PagSeguro"?true:false; ?>
	<?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $code = $payment_method['code']; ?>
      <option value="<?php echo $payment_method['code']; ?>" selected="selected">
      <?php } else { ?>
      <option value="<?php echo $payment_method['code']; ?>">
      <?php } ?>
    <?php echo $payment_method['title']; ?></option>
  <?php } ?>
  </select><br />
<?php if($hasPagSeguro){ ?>
	<img alt='Logotipos de meios de pagamento do PagSeguro' src='/catalog/view/theme/default/image/banner_pagseguro.jpeg' title='Este site aceita pagamentos com Oi Paggo, Bradesco, Itaú, Banco do Brasil, Banrisul, Banco HSBC, saldo em conta PagSeguro e boleto.' border='0'>
<?php }?>  
<?php } ?>
<br />
<?php } ?>
<?php if ($this->config->get('quickcheckout_survey')) { ?>
<b><?php echo $text_survey; ?></b><br />
<textarea name="survey" style="width: 98%;" rows="1"><?php echo $survey; ?></textarea><br /><br />
<?php } else { ?>
<textarea name="survey" style="display:none;" rows="1"><?php echo $survey; ?></textarea>
<?php } ?>
<b><?php echo $text_comments; ?></b>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>